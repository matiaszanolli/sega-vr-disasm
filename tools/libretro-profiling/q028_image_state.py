"""Independent raw-stream byte-provenance reconstruction for Q028 images."""

from __future__ import annotations


class ImageStateError(RuntimeError):
    pass


class IdleState:
    """Source-bound host writes merged at exact original raw boundaries."""
    def __init__(self,state,sites):
        self.state=state
        self.original={(int(row["pc"],16),row.get("image_view",0)):row for row in sites
                       if row["cpu"]=="m68k" and row["site_kind"]=="fetch"
                       and row.get("opcode_identity_kind")!="engine-idle-rewrite"}
        self.active={}; self.count=0; self.last_boundary=0; self.last_frame=0

    def apply(self,row,previous,next_frame,terminal=False):
        from q028_image_domains import idle_words
        ordinal,boundary,frame,cpu,pc,old,new,operation,source=row
        if (ordinal!=self.count or boundary<self.last_boundary or frame<self.last_frame
                or cpu!=0 or frame>next_frame or frame<(previous[1] if previous else 0)):
            raise ImageStateError("host rewrite ordinal/frame/boundary")
        view=self.state.wram.active if 0xFF0000<=pc<0xFF0020 else 0
        original=self.original.get((pc,view))
        if not original or len(original["opcode"])!=4:
            raise ImageStateError("host rewrite unregistered source/image PC")
        real=int(original["opcode"],16)
        if operation=="install":
            if (source!="fame-idle-detector-after-write" or old!=real or new not in idle_words(real)
                    or pc in self.active or previous!=(boundary-1,frame,pc,old,0,True)):
                raise ImageStateError("host install lacks immediately preceding real branch fetch")
            self.active[pc]=(view,real,new)
        elif operation=="restore":
            if (source!="sek-finish-idle-after-expression" or self.active.get(pc)!=(view,new,old)
                    or new!=real or old not in idle_words(real) or (terminal and frame!=next_frame)):
                raise ImageStateError("host restore source/current-image transition")
            del self.active[pc]
        else: raise ImageStateError("host rewrite operation")
        if view:
            offset=pc-0xFF0000
            if int.from_bytes(self.state.wram.bytes[offset:offset+2],"big")!=old:
                raise ImageStateError("host WRAM rewrite stale current bytes")
            self.state.wram.bytes[offset:offset+2]=new.to_bytes(2,"big")
        self.count+=1; self.last_boundary=boundary; self.last_frame=frame

    def fetch(self,pc,word,row):
        import hashlib
        active=self.active.get(pc)
        if row.get("opcode_identity_kind")=="engine-idle-rewrite":
            if (active is None or active!=(row["base_view"],row["real_opcode"],word)
                    or row["image_view"]!=row["base_view"]+16
                    or row["opcode"]!=word.to_bytes(2,"big").hex()
                    or row["immutable_mask"]!="ffff"
                    or row["opcode_hash32"]!=int.from_bytes(hashlib.sha256(word.to_bytes(2,"big")).digest()[:4],"little")):
                raise ImageStateError("fake opcode lacks current host-write provenance")
            self.state.fetch(0,pc,word,row["base_view"])
        else:
            if active: raise ImageStateError("original fetch while host rewrite remains active")
            self.state.fetch(0,pc,word,row.get("image_view",0),row)

    def before_data(self,cpu,raw,width,write):
        if cpu==0 and write:
            raw &= 0xFFFFFF
            for pc in list(self.active):
                if raw<pc+2 and raw+width>pc: del self.active[pc]

    def after_data(self):
        if not self.state.wram.active:
            for pc in list(self.active):
                if 0xFF0000<=pc<0xFF0020: del self.active[pc]

    def summary(self):
        return {"count":self.count,"last_boundary":self.last_boundary}


class WramState:
    """Main-68K-only ordered installs and byte-wise mutable operand state."""
    def __init__(self, manifest):
        self.copies={row["view"]:{**row,"data":bytes.fromhex(row["bytes"]),
                                "mask_bytes":bytes.fromhex(row["mask"])}
                     for row in manifest["wram_copies"]}
        self.active=0; self.installing=None; self.bytes=bytearray(32); self.installs=0

    def data(self, cpu, pc, raw, width, value, write):
        if cpu!=0: return
        raw &= 0xFFFFFF
        state=self.installing
        if state is None and not write:
            for image in self.copies.values():
                if raw==image["source"] and pc==image["copy_pcs"][0]:
                    state=self.installing=[image["view"],0,False]
                    self.active=0
                    break
        if state is not None:
            view,offset,pending=state; image=self.copies[view]
            expected_pc=image["copy_pcs"][offset//width] if view==5 and width==4 else image["copy_pcs"][0]
            if (width!=image["copy_width"] or write!=pending or pc!=expected_pc
                    or raw!=(image["destination"] if write else image["source"])+offset
                    or value!=int.from_bytes(image["data"][offset:offset+width],"big")):
                raise ImageStateError("WRAM source-copy transaction/order/value")
            if not write: state[2]=True
            else:
                self.bytes[offset:offset+width]=value.to_bytes(width,"big")
                state[1]+=width; state[2]=False
                if state[1]==image["copy_size"]:
                    self.active=view; self.installing=None; self.installs+=1
        elif write and self.active:
            image=self.copies[self.active]
            for i in range(width):
                offset=raw+i-0xFF0000
                if 0<=offset<image["copy_size"]:
                    if image["mask_bytes"][offset]:
                        self.active=0
                        return
                    self.bytes[offset]=(value>>((width-1-i)*8))&255

    def fetch(self, pc, word, view, row=None):
        image=self.copies.get(self.active); offset=pc-0xFF0000
        if (not image or view!=self.active or offset not in image["starts"]
                or word!=int.from_bytes(self.bytes[offset:offset+2],"big")):
            raise ImageStateError("WRAM fetch lacks complete current template provenance")
        if row is not None:
            import hashlib
            size=len(bytes.fromhex(row["opcode"]))
            mask=image["mask_bytes"][offset:offset+size]
            initial=image["data"][offset:offset+size]
            identity=bytes(a&b for a,b in zip(initial,mask))
            kind="masked-template" if 0 in mask else "exact-bytes"
            if (row["immutable_mask"]!=mask.hex() or row["opcode_identity_kind"]!=kind
                    or row["opcode"]!=initial.hex()
                    or row["opcode_hash32"]!=int.from_bytes(hashlib.sha256(identity).digest()[:4],"little")):
                raise ImageStateError("WRAM template mask/identity join")


class ImageState:
    def __init__(self, manifest: dict):
        self.copies = {row["view"]: {**row, "data": bytes.fromhex(row["bytes"])}
                       for row in manifest["sram_copies"]}
        self.active = [0, 0, 0]
        self.installing = [None, None, None]
        self.reset = [3, 0, 0]
        self.installs = [0, 0, 0]
        self.wram = WramState(manifest)

    def fetch(self, cpu: int, pc: int, opcode_word: int, view: int, row=None) -> None:
        if cpu==0 and 0xFF0000<=pc<0xFF0020:
            self.wram.fetch(pc,opcode_word,view,row)
            return
        if cpu and self.reset[cpu] < 3:
            if self.reset[cpu] != 2 or pc != 0x204:
                raise ImageStateError("first SH2 fetch must follow both reset vectors")
            self.reset[cpu] = 3
        expected_view = 0
        if pc < (256 if cpu == 0 else 2048 if cpu == 1 else 1024):
            expected_view = 1
        if cpu and 0xC0000000 <= pc < 0xC0001000:
            expected_view = self.active[cpu]
            image = self.copies.get(expected_view)
            offset = pc - 0xC0000000
            if (not image or offset % 2 or offset+2 > image["size"]
                    or opcode_word != int.from_bytes(image["data"][offset:offset+2], "big")):
                raise ImageStateError("SRAM fetch lacks complete current byte-provenance install")
        if view != expected_view:
            raise ImageStateError("CPU fetch image-view identity")

    def reset_read(self, cpu: int, pc: int, raw: int, width: int,
                   value: int, slot: int, write: bool) -> None:
        phase = self.reset[cpu]
        expected = 0x204 if phase == 0 else (0x06040000 if cpu == 1 else 0x0603F800)
        if (cpu not in (1, 2) or phase not in (0, 1) or pc != 0 or raw != phase*4
                or width != 4 or write or value != expected or slot != phase):
            raise ImageStateError("boot reset PC/SP phase transaction")
        self.reset[cpu] += 1

    def data(self, cpu: int, pc: int, raw: int, width: int, value: int, write: bool) -> None:
        if cpu == 0:
            self.wram.data(cpu,pc,raw,width,value,write)
            return
        state = self.installing[cpu]
        if state is None and any(pc==image["dt_pc"] for image in self.copies.values()):
            raise ImageStateError("SRAM DT reread outside installation")
        if state is None and not write and width == 4:
            for image in self.copies.values():
                if pc == image["read_pc"] and raw == image["source"]:
                    state = self.installing[cpu] = [image["view"], 0, 0]
                    self.active[cpu] = 0
                    break
        if state is not None:
            view, offset, pending = state
            image = self.copies[view]
            if pending==2:
                if (write or width!=2 or pc!=image["dt_pc"]
                        or raw!=(image["dt_pc"]&image["dt_address_mask"])
                        or value!=image["dt_opcode"]):
                    raise ImageStateError("SRAM exact DT reread phase")
                if offset==image["size"]:
                    self.active[cpu]=view
                    self.installing[cpu]=None
                    self.installs[cpu]+=1
                else: state[2]=0
                return
            if (width != 4 or write != pending
                    or pc != image["write_pc" if write else "read_pc"]
                    or raw != (image["destination"] if write else image["source"]) + offset
                    or value != int.from_bytes(image["data"][offset:offset+4], "big")):
                raise ImageStateError("SRAM source-copy transaction/order/value")
            if not write:
                state[2] = 1
            else:
                state[1] += 4
                state[2] = 2
        elif write and self.active[cpu]:
            image = self.copies[self.active[cpu]]
            if raw < image["destination"] + image["size"] and raw+width > image["destination"]:
                self.active[cpu] = 0

    def finish(self):
        if any(state is not None for state in self.installing[1:]):
            raise ImageStateError("incomplete SRAM installation at EOF")
        if self.wram.installing is not None:
            raise ImageStateError("incomplete WRAM installation at EOF")


class CommState:
    """Passive COMM0..3 byte-lane facts, not a submit/ack state machine.

    Tags in lexical order: busy_clear, command_lane_write, signal_write,
    trigger_restore, trigger_write. Counts have no required cross-route equality.
    """
    def __init__(self):
        self.game = 0
        self.boot_reads = 0
        self.boot_route = 0
        self.counts = [0]*5
        self.lanes = [0]*8
        self.last = [0]*8
        self.writes = 0

    def event(self, seq, frame, cpu, pc, raw, width, value, write):
        base = 0xA15120 if cpu == 0 else 0x4020
        address = raw & (0xFFFFFF if cpu == 0 else 0xDFFFFFFF)
        if cpu > 2 or address+width <= base or address >= base+8:
            return None
        offset = address-base
        linked_pc = pc-0x880000 if cpu == 0 and 0x880000 <= pc < 0xC80000 else pc
        if not write:
            if not self.game and cpu == 0 and width == 4:
                if linked_pc in (0x808, 0x8D0) and offset == 0 and value == 0x4D5F4F4B:
                    route = 1 if linked_pc == 0x808 else 2
                    if self.boot_route and self.boot_route != route:
                        raise ImageStateError("mixed bootstrap read routes")
                    self.boot_route = route
                    self.boot_reads |= 1
                if linked_pc in (0x810, 0x8D8) and offset == 4 and value == 0x535F4F4B:
                    if self.boot_route != (1 if linked_pc == 0x810 else 2):
                        raise ImageStateError("mixed bootstrap read routes/order")
                    self.boot_reads |= 2
            return None
        tags, mask = 0, 0
        for i in range(width):
            lane = offset+i
            if not 0 <= lane < 8:
                continue
            byte = (value >> ((width-1-i)*8)) & 255
            mask |= 1 << lane
            self.lanes[lane], self.last[lane] = byte, seq
            if self.game:
                if lane == 0 and cpu == 1 and byte == 0: tags |= 1
                if lane == 1: tags |= 2
                if lane == 3: tags |= 4
                if lane == 0 and cpu == 1 and byte == 1: tags |= 8
                if lane == 0 and cpu == 0 and byte == 1: tags |= 16
        for i in range(5):
            if tags & (1 << i): self.counts[i] += 1
        self.writes += 1
        row = (seq, frame, cpu, pc, raw, width, value, self.game, tags, mask)
        if (not self.game and cpu == 0 and linked_pc in (0x81A, 0x8E2)
                and offset == 0 and width == 4 and value == 0):
            if self.boot_reads != 3 or self.boot_route != (1 if linked_pc == 0x81A else 2):
                raise ImageStateError("bootstrap clear lacks source-route BIOS reads")
            self.game = 1
        return row

    def summary(self):
        return {"boot_reads": self.boot_reads, "boot_route":self.boot_route, "counts": self.counts, "game": self.game,
                "lanes": self.lanes, "last": self.last, "writes": self.writes}
