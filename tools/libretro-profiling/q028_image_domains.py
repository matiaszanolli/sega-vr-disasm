"""Source-bound Q028 observer image recipes, not runtime-PC allowlists.

All offsets are half-open file/CPU byte ranges.  These describe attribution
candidates, never a global ownership, executability, or immutability proof.
"""

from __future__ import annotations

import hashlib
import json
import re
import subprocess
import tarfile
from pathlib import Path


HERE = Path(__file__).resolve().parent
PACK_SHA256 = "745cfa19aaca095412fa33e3b402bc471ba70fbe7185328a322325dd06b85c18"
M68K_DECODER = Path("/usr/bin/m68k-linux-gnu-objdump")
M68K_DECODER_SHA256 = "2730ece3e51380fdada3b9a9221f30a1123248843656481a43b008c9bcf62fd7"
M68K_ISLANDS = ((0x414, 0x418), (0x169C, 0x16A0), (0x19AC, 0x19B0),
               (0x19B4, 0x19B8), (0x30000, 0x30200), (0x30248, 0x3024A),
               (0x30296, 0x30298), (0x30402, 0x30404))
M68K_SOUND = (0x30200, 0x31688)
FINITE_INVENTORY = HERE.parents[1] / "analysis/evidence/vr60-q028-renderer-descriptor-probe/diagnostics/r2-full-raw-scan/q028-m68k-finite-inventory.json"
FINITE_INVENTORY_SHA256 = "a09955793f72928a4c9133672aa9c7d2319c6e21d4933981a138afffb70edee8"
# Byte-identical presentation changes explicitly covered by amendment d230ca49.
PRESENTATION_POSTIMAGES = {
    "disasm/modules/68k/game/race/race_start_countdown_sequence.asm": "8420ab8928a9f4703be476e97d91388254933c9a0d06710a1d4389bc15261092",
    "disasm/modules/68k/game/track/track_graphics_and_sound_loader.asm": "ea903d958d94b97043aaddeb4c17349abb52ab77cfb7954730c47a01c6b76caa",
    "disasm/modules/68k/game/state/display_state_timer_flag_update.asm": "04d01c094276ed57a3286e6de8ece969e49dfd9e29907f4e93c079d9b0aa5630",
}
BIOS_CODE = {"m68k": ((0xC0, 0x100),),
             "master": ((0x140, 0x220), (0x22C, 0x264)),
             "slave": ((0x200, 0x220), (0x22C, 0x23C))}
SRAM_PAYLOADS = (
    (0x2254C, 1748, 0x2252C, "e57a4941316923bd1ef94cf3a566dabdd4e856c34484761cdade00b498f37b4b"),
    (0x23368, 1608, 0x23348, "fb54b63faa6a69e87df6e4c1d1e5c3ef09be232d0c8816c3017578e4082f17e6"),
    (0x23A70, 580, 0x23A52, "53969eba802b7627b6e7b524330867ce5a8a6b86afdb2837794824aaad130bb7"),
)
WRAM_TEMPLATES = (
    (5, 0x4C0, 32, 20, 0x4C0, 4, (0,6,12,18), (),
     "1b7c0001510141f9000006bcd1fc008800004ed00404303c076c00000000ff00"),
    (6, 0xF92, 24, 24, 0x880F92, 2, (0,6,12,16,20,22), ((2,6),(8,10)),
     "4eb90089426231fc0004c87a4e7223004a78c87a66f660e8"),
    (7, 0xFAA, 20, 20, 0x880FAA, 2, (0,6,12,16,18), ((2,6),),
     "4eb900884cbc08f80000c8054a38c80566fa60ec"),
)
IDLE_REAL_WORDS=(0x66FA,0x66F8,0x66F6,0x66F2,0x67FA,0x67F8,0x67F6,0x67F2,0x60FE,0x60FC)


def idle_words(real):
    if real not in IDLE_REAL_WORDS:
        raise ImageError("unregistered idle-detector opcode")
    fake=(real&0xFE)|0x7100
    if real&0x0100: fake|=0x400
    if not real&0x0F00: fake|=0xC00
    return fake,fake|0x200


def idle_rows(instructions):
    """Finite source handler aliases; fake words are never 68000-decoded."""
    result=[]
    for row in instructions:
        real=int.from_bytes(row["bytes"],"big")
        if row["cpu"]!="M68K" or len(row["bytes"])!=2 or real not in IDLE_REAL_WORDS:
            continue
        for fake in idle_words(real):
            encoded=fake.to_bytes(2,"big")
            result.append({**row,"bytes":encoded,"identity_bytes":encoded,
                "image_id":row.get("image_id","ordinary")+"-engine-idle-rewrite",
                "view":row.get("view",0)+16,"base_view":row.get("view",0),
                "real_opcode":real,"opcode_identity_kind":"engine-idle-rewrite",
                "immutable_mask":"ffff","classification":"engine-idle-rewrite",
                "source":row["source"]+"; source-bound-FAME-handler-alias"})
    return result
DISASM_LINE = re.compile(r"^\s*([0-9a-f]+):\s*([0-9a-f ]+)\t(.+)$")


class ImageError(RuntimeError):
    pass


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def decoder_identity() -> dict:
    actual = sha(M68K_DECODER.read_bytes())
    if actual != M68K_DECODER_SHA256:
        raise ImageError("unreviewed M68000 decoder binary")
    version = subprocess.check_output([str(M68K_DECODER), "--version"], text=True)
    if version.splitlines()[0] != "GNU objdump (GNU Binutils for Ubuntu) 2.46":
        raise ImageError("unreviewed M68000 decoder version")
    return {"path": str(M68K_DECODER), "sha256": actual, "version": version,
            "architecture": "m68k:68000"}


def finite_inventory(rom: bytes) -> dict:
    """Join the immutable reviewed attachment, current source and exact ROM."""
    raw = FINITE_INVENTORY.read_bytes()
    if sha(raw) != FINITE_INVENTORY_SHA256:
        raise ImageError("finite instruction inventory identity")
    inventory = json.loads(raw)
    if sha(rom) != inventory["rom_sha256"]:
        raise ImageError("finite instruction inventory ROM identity")
    if inventory["decoder"]["sha256"] != M68K_DECODER_SHA256:
        raise ImageError("finite instruction inventory decoder identity")
    for name, expected in PRESENTATION_POSTIMAGES.items():
        if sha((HERE.parents[1] / name).read_bytes()) != expected:
            raise ImageError("instruction presentation postimage identity: " + name)
    for source in inventory["sources"]:
        expected = PRESENTATION_POSTIMAGES.get(source["path"], source["sha256"])
        if sha((HERE.parents[1] / source["path"]).read_bytes()) != expected:
            raise ImageError("finite instruction inventory source identity: " + source["path"])
    for span in inventory["spans"] + inventory["exclusion_bytes"]:
        start, end = int(span["start"], 16), int(span["end"], 16)
        if start >= end or sha(rom[start:end]) != span["sha256"]:
            raise ImageError("finite instruction span/exclusion identity")
    for row in inventory["rows"]:
        start, end = int(row["file_pc"], 16), int(row["end"], 16)
        encoded = bytes.fromhex(row["bytes"])
        if (end != start + len(encoded) or rom[start:end] != encoded
                or sha(encoded) != row["instruction_sha256"]):
            raise ImageError("finite instruction row identity")
    return inventory


def decode_m68k(path: Path, start: int, end: int, *, verified: tuple[bytes, dict] | None = None) -> list[dict]:
    """Decode one reviewed contiguous range, rejecting gaps/extensions/truncation."""
    # The caller may reuse a per-invocation verified immutable input; never a
    # persistent cache that survives changes to the executable or linked ROM.
    raw, identity = verified if verified is not None else (path.read_bytes(), decoder_identity())
    if identity["sha256"] != M68K_DECODER_SHA256:
        raise ImageError("M68000 decoder invocation identity")
    output = subprocess.check_output([str(M68K_DECODER), "-D", "-b", "binary",
        "-m", "m68k:68000", "-z", "--insn-width=10", f"--start-address={start}",
        f"--stop-address={min(end+10, len(raw))}", str(path)], text=True)
    rows = []
    position = start
    for line in output.splitlines():
        match = DISASM_LINE.match(line)
        if not match:
            continue
        pc = int(match[1], 16)
        if pc >= end:
            break
        encoded = bytes.fromhex(match[2])
        text = match[3].strip()
        if (pc != position or len(encoded) not in (2, 4, 6, 8, 10)
                or pc + len(encoded) > end or text.startswith((".word", ".short"))
                or raw[pc:pc + len(encoded)] != encoded):
            raise ImageError(f"invalid M68000 instruction boundary at {pc:08x}")
        rows.append({"file_pc": pc, "pc": pc, "bytes": encoded,
                     "text": text, "cpu": "M68K"})
        position += len(encoded)
    if position != end:
        raise ImageError(f"M68000 range does not tile: {start:08x}..{end:08x}")
    return rows


def pinned_sources() -> tuple[dict[str, bytes], list[dict]]:
    pack = HERE / "q028_picodrive_source_pack_v9.tar.gz"
    if sha(pack.read_bytes()) != PACK_SHA256:
        raise ImageError("bootstrap recipe source-pack identity")
    closure = json.loads((HERE / "q028_picodrive_git_closure_v9.json").read_bytes())
    wanted = {"pico/32x/memory.c", "pico/32x/32x.c", "pico/pico_int.h",
              "cpu/fame/famec_opcodes.h", "cpu/fame/famec.c", "pico/sek.c",
              "cpu/sh2/mame/sh2.c", "cpu/sh2/mame/sh2pico.c"}
    leaves = {row["final_relative_path"]: row for row in closure["leaves"]
              if row["final_relative_path"] in wanted}
    result, inventory = {}, []
    with tarfile.open(pack, "r:gz") as archive:
        for name in sorted(wanted):
            member = archive.getmember("picodrive-source/" + name)
            if not member.isfile():
                raise ImageError("bootstrap source is not regular")
            data = archive.extractfile(member).read()
            if sha(data) != leaves[name]["sha256"] or len(data) != leaves[name]["byte_size"]:
                raise ImageError("bootstrap source/closure mismatch")
            result[name] = data
            inventory.append({"path": name, "sha256": sha(data), "bytes": len(data)})
    return result, inventory


def u16_array(source: str, name: str, count: int) -> bytes:
    matches = re.findall(r"static const u16 " + name + r"\[\] = \{(.*?)\};", source, re.S)
    if len(matches) != 1:
        raise ImageError(f"bootstrap array cardinality: {name}")
    body = re.sub(r"//[^\n]*", "", matches[0])
    values = []
    for token in body.split(","):
        token = token.strip()
        if not token:
            continue
        if re.fullmatch(r"0x[0-9a-fA-F]{1,4}", token):
            value = int(token, 16)
        else:
            pair = re.fullmatch(r"\('([A-Z_])'<<8\)\|'([A-Z_])'", token)
            if not pair:
                raise ImageError(f"unsupported bootstrap array expression: {token}")
            value = ord(pair[1]) * 256 + ord(pair[2])
        values.append(value)
    if len(values) != count:
        raise ImageError(f"bootstrap array length: {name}")
    return b"".join(value.to_bytes(2, "big") for value in values)


def builtin_bios() -> tuple[dict[str, bytes], dict]:
    """Independently reproduce pinned get_bios(), in CPU byte order."""
    sources, inventory = pinned_sources()
    source = sources["pico/32x/memory.c"].decode()
    m68k, master, slave = bytearray(256), bytearray(2048), bytearray(1024)
    for i in range(1, 0xC0 // 4):
        m68k[i*4:i*4+4] = (0x880200 + (i-1)*6).to_bytes(4, "big")
    m68k[0x70:0x74] = bytes(4)
    m68k[0xC0:] = bytes.fromhex("4e71") * 32
    m68k[0xC8:0xCA] = bytes.fromhex("1280")
    m68k[0xCA:0xD2] = u16_array(source, "andb", 4)
    m68k[0xD2:0xD4] = bytes.fromhex("4e75")
    m68k[0xD4:0xF4] = u16_array(source, "p_d4", 16)
    m68k[0xFE:0x100] = bytes.fromhex("4e75")
    for data, vectors, stack in ((master, 80, 0x06040000), (slave, 128, 0x0603F800)):
        data[:vectors*4] = bytes.fromhex("00000200") * vectors
        data[:8] = bytes.fromhex("00000204") + stack.to_bytes(4, "big")
        data[8:16] = data[:8]
    master[0x140:0x1FC] = bytes.fromhex("0009") * ((0x1FC-0x140)//2)
    master[0x1FC:0x200] = bytes.fromhex("a0020009")
    master[0x200:0x270] = u16_array(source, "msh2_code", 56)
    slave[0x200:0x240] = u16_array(source, "ssh2_code", 32)
    images = {"m68k": bytes(m68k), "master": bytes(master), "slave": bytes(slave)}
    if [len(images[cpu]) for cpu in images] != [256, 2048, 1024]:
        raise ImageError("bootstrap image size")
    return images, {"source_pack_sha256": PACK_SHA256, "sources": inventory,
        "images": {cpu: {"image_id": "generated-bios-" + cpu, "bytes": data.hex(),
                         "sha256": sha(data), "code_ranges": BIOS_CODE[cpu]}
                   for cpu, data in images.items()}}


def auxiliary_rows(rom: bytes) -> tuple[list[dict], dict, str]:
    """Return finite BIOS/SRAM candidates and their source-copy metadata."""
    import tempfile
    images, manifest = builtin_bios()
    rows, arrays, copies, wram = [], [], [], []
    with tempfile.TemporaryDirectory(prefix="q028-images-") as directory:
        root = Path(directory)
        for view,start,size,code_size,source,width,starts,mutable,encoded in WRAM_TEMPLATES:
            data=bytes.fromhex(encoded)
            if len(data)!=size or rom[start:start+size]!=data:
                raise ImageError("WRAM source template identity")
            path=root/f"wram-{view}.bin"; path.write_bytes(data)
            decoded=decode_m68k(path,0,code_size)
            if tuple(row["pc"] for row in decoded)!=starts:
                raise ImageError("WRAM source template boundaries")
            mask=bytearray([255]*size)
            for low,high in mutable: mask[low:high]=bytes(high-low)
            copy_pcs=list(range(0x4A8,0x4B8,2)) if view==5 else [0x880FDE]
            for i,pc in enumerate(copy_pcs):
                offset=pc if view==5 else pc-0x880000
                if rom[offset:offset+2]!=bytes.fromhex("22d8" if width==4 else "32d8"):
                    raise ImageError("WRAM copy instruction identity")
            for row in decoded:
                offset=row["pc"]; immutable=bytes(mask[offset:offset+len(row["bytes"])])
                row.update(file_pc=start+offset,pc=0xFF0000+offset,
                    runtime_pcs=[0xFF0000+offset],image_id=f"copied-wram-{start:06x}",
                    view=view,cpus=["m68k"],source=f"linked-wram-template-{start:06x}",
                    opcode_identity_kind="masked-template" if 0 in immutable else "exact-bytes",
                    immutable_mask=immutable.hex(),
                    identity_bytes=bytes(a&b for a,b in zip(row["bytes"],immutable)))
                rows.append(row)
            wram.append({"view":view,"file_start":start,"source":source,"destination":0xFF0000,
                "copy_size":size,"code_size":code_size,"copy_width":width,"copy_pcs":copy_pcs,
                "starts":starts,"mutable_ranges":mutable,"mask":bytes(mask).hex(),
                "bytes":encoded,"sha256":sha(data)})
            arrays.append(f"static const unsigned char vrd_q028_wram_{view}[]={{"+','.join(map(str,data))+"};")
            arrays.append(f"static const unsigned char vrd_q028_wram_mask_{view}[]={{"+','.join(map(str,mask))+"};")
        for cpu, data in images.items():
            path = root / (cpu + ".bin")
            path.write_bytes(data)
            if cpu == "m68k":
                decoded = decode_m68k(path, 0xC0, 0x100)
            else:
                decoded = decode_sh2(path, data, BIOS_CODE[cpu])
            for row in decoded:
                row.update(image_id="generated-bios-" + cpu, view=1,
                           runtime_pcs=[row["pc"]], cpus=[cpu],
                           source="pinned-get_bios-recipe")
                rows.append(row)
            arrays.append("static const unsigned char vrd_q028_bios_" + cpu +
                          "[]={" + ",".join(str(x) for x in data) + "};")
        for index, (start, size, loop, expected) in enumerate(SRAM_PAYLOADS, 2):
            data = rom[start:start+size]
            if sha(data) != expected:
                raise ImageError("reviewed SRAM payload identity")
            # Decode the literal references of the exact three reviewed loops.
            # MOV.L @(disp,PC),Rn uses ((PC+4)&~3)+disp*4; MOV.W uses PC+4+disp*2.
            words = [int.from_bytes(rom[p:p+2], "big") for p in range(loop, loop+16, 2)]
            if words[3:8] != [0x6206, 0x2122, 0x4710, 0x8FFB, 0x7104]:
                raise ImageError("SRAM copy-loop opcodes")
            literals = []
            for j, base in enumerate((0xD100, 0xD000, 0x9700)):
                if words[j] & 0xFF00 != base:
                    raise ImageError("SRAM copy-loop literal opcode")
                pc = loop+j*2
                address = (((pc+4)&~3) + (words[j]&255)*4 if j < 2
                           else pc+4+(words[j]&255)*2)
                literals.append(int.from_bytes(rom[address:address+(4 if j < 2 else 2)], "big"))
            if literals != [0xC0000000, 0x06000000+start-0x20000, size//4]:
                raise ImageError("SRAM copy-loop bounds/literals")
            path = root / f"sram-{index}.bin"
            path.write_bytes(data)
            for row in decode_sh2(path, data, ((0, size),)):
                if row["text"].startswith(".word"):
                    continue
                offset = row["pc"]
                row.update(file_pc=start+offset, pc=0xC0000000+offset,
                    image_id=f"copied-sram-{start:06x}", view=index,
                    runtime_pcs=[0xC0000000+offset], cpus=["master", "slave"],
                    source=f"linked-copy-loop-{loop:06x}",
                    classification="conservative-copied-byte-fetch")
                rows.append(row)
            copies.append({"view": index, "file_start": start, "bytes": data.hex(),
                "sha256": expected, "size": size, "destination": 0xC0000000,
                "source": literals[1], "read_pc": 0x06000000+loop+6-0x20000,
                "write_pc": 0x06000000+loop+8-0x20000,
                "dt_pc": 0x06000000+loop+10-0x20000,
                "dt_opcode": words[5], "dt_address_mask": 0xC7FFFFFF,
                "dt_read_source": "cpu/sh2/mame/sh2.c:DT:BUSY_LOOP_HACKS",
                "loop_bytes": rom[loop:start].hex()})
            arrays.append(f"static const unsigned char vrd_q028_sram_{index}[]={{" +
                          ",".join(str(x) for x in data) + "};")
    manifest["sram_copies"] = copies
    manifest["wram_copies"] = wram
    arrays.append("struct vrd_q028_wram_image { unsigned int view, source, size, code_size, width; const unsigned char *bytes, *mask; };")
    arrays.append("static const struct vrd_q028_wram_image vrd_q028_wram_images[]={")
    for copy in wram:
        view=copy["view"]
        arrays.append(f"{{{view}u,0x{copy['source']:x}u,{copy['copy_size']}u,{copy['code_size']}u,{copy['copy_width']}u,vrd_q028_wram_{view},vrd_q028_wram_mask_{view}}},")
    arrays.append("};")
    arrays.append("struct vrd_q028_sram_image { unsigned int view, source, size, read_pc, write_pc, dt_pc, dt_opcode, dt_mask; const unsigned char *bytes; };")
    arrays.append("static const struct vrd_q028_sram_image vrd_q028_sram_images[]={")
    for copy in copies:
        arrays.append("{%du,0x%xu,%du,0x%xu,0x%xu,0x%xu,0x%xu,0x%xu,vrd_q028_sram_%d}," % (
            copy["view"], copy["source"], copy["size"], copy["read_pc"], copy["write_pc"],
            copy["dt_pc"],copy["dt_opcode"],copy["dt_address_mask"],copy["view"]))
    arrays.append("};")
    return rows, manifest, "\n".join(arrays)


def decode_sh2(path: Path, raw: bytes, spans: tuple) -> list[dict]:
    result = []
    for start, end in spans:
        output = subprocess.check_output(["sh-elf-objdump", "-D", "-z", "-b", "binary",
            "-m", "sh2", f"--start-address={start}", f"--stop-address={end}", str(path)], text=True)
        decoded = {}
        for line in output.splitlines():
            match = DISASM_LINE.match(line)
            if match:
                pc = int(match[1], 16)
                encoded = bytes.fromhex(match[2])
                if len(encoded) != 2 or raw[pc:pc+2] != encoded:
                    raise ImageError("SH2 decoder byte identity")
                decoded[pc] = match[3].strip()
        if set(decoded) != set(range(start, end, 2)):
            raise ImageError("SH2 decoder range coverage")
        result.extend({"file_pc": pc, "pc": pc, "bytes": raw[pc:pc+2],
                       "text": decoded[pc], "cpu": "SH2"} for pc in range(start, end, 2))
    return result
