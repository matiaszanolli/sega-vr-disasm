"""Source-derived image/state checks; not a substitute for actual-core tests."""

import unittest
from pathlib import Path

import q028_image_domains as domains
from q028_image_state import ImageState, ImageStateError, CommState, IdleState


class ImageDomainTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.rom = Path(__file__).resolve().parents[2]/"build/vr_rebuild.32x"
        cls.rows, cls.manifest, _ = domains.auxiliary_rows(cls.rom.read_bytes())

    def test_builtin_images_have_source_bound_sizes_and_digests(self):
        images, _ = domains.builtin_bios()
        self.assertEqual({k: (len(v), domains.sha(v)) for k, v in images.items()}, {
            "m68k": (256, "c00b10bd29bbe6911dd43ea3c69ff49124c6e548f7e1154f026e8d1cdf5e90d4"),
            "master": (2048, "8dd02aa314aa5c296f7429047c49c7119c001790f81f942a600ed6286d1dcd04"),
            "slave": (1024, "ee6a22643504e3cc5ba2c14b5da122a2e2e87abf3b7c7a31a2d45b189d41904d")})

    def test_finite_raw_islands_tile_and_extensions_are_not_starts(self):
        for start, end in domains.M68K_ISLANDS:
            rows = domains.decode_m68k(self.rom, start, end)
            self.assertEqual(sum(len(row["bytes"]) for row in rows), end-start)
        self.assertEqual(domains.decode_m68k(self.rom, 0x169C, 0x16A0)[0]["bytes"], bytes.fromhex("227b0014"))
        with self.assertRaises(domains.ImageError):
            domains.decode_m68k(self.rom, 0x169C, 0x169E)

    def test_array_recipe_does_not_evaluate_arbitrary_expressions(self):
        with self.assertRaises(domains.ImageError):
            domains.u16_array("static const u16 bad[] = { function() };", "bad", 1)

    def test_all_reviewed_finite_spans_and_exclusions(self):
        raw = self.rom.read_bytes()
        inventory = domains.finite_inventory(raw)
        verified = (raw, domains.decoder_identity())
        expected = {int(row["file_pc"],16):bytes.fromhex(row["bytes"]) for row in inventory["rows"]}
        actual = {}
        for span in inventory["spans"]:
            for row in domains.decode_m68k(self.rom,int(span["start"],16),int(span["end"],16),verified=verified):
                self.assertNotIn(row["file_pc"],actual)
                actual[row["file_pc"]] = row["bytes"]
        self.assertEqual(actual,expected)
        self.assertEqual(len(actual),321)
        self.assertEqual(len(inventory["spans"]),120)
        for start,end in inventory["data_exclusions"]+inventory["extension_exclusions"]:
            self.assertFalse(any(int(start,16)<=pc<int(end,16) for pc in actual))
        for pc in (0x9F14,0xC7E6,0x8200): self.assertNotIn(pc,actual)
        for pc in (0x9F16,0xC7E8,0x81FC): self.assertIn(pc,actual)

    def install_wram(self,state,view):
        image=state.wram.copies[view]
        for offset in range(0,image["copy_size"],image["copy_width"]):
            width=image["copy_width"]
            pc=image["copy_pcs"][offset//width] if view==5 else image["copy_pcs"][0]
            value=int.from_bytes(image["data"][offset:offset+width],"big")
            state.data(0,pc,image["source"]+offset,width,value,False)
            state.data(0,pc,0xFF0000+offset,width,value,True)

    def test_wram_views_mutable_fields_and_boot_data(self):
        state=ImageState(self.manifest)
        self.install_wram(state,5)
        for offset in (0,6,12,18):
            state.fetch(0,0xFF0000+offset,int.from_bytes(state.wram.bytes[offset:offset+2],"big"),5)
        for offset in range(20,32,2):
            with self.assertRaises(ImageStateError): state.fetch(0,0xFF0000+offset,int.from_bytes(state.wram.bytes[offset:offset+2],"big"),5)
        self.install_wram(state,6)
        state.fetch(0,0xFF0014,0x66F6,6)
        state.data(0,0x880C38,0xFF0002,4,0x881234,True)
        state.data(0,0x881234,0xFF0008,1,0xAB,True)
        state.data(0,0x881234,0xFF0009,1,0xCD,True)
        self.assertEqual(state.wram.bytes[2:6].hex(),"00881234")
        self.assertEqual(state.wram.bytes[8:10].hex(),"abcd")
        state.fetch(0,0xFF0000,0x4EB9,6)
        self.install_wram(state,7)
        state.fetch(0,0xFF0000,0x4EB9,7)
        with self.assertRaises(ImageStateError): state.fetch(0,0xFF0000,0x4EB9,6)
        state.data(0,0x881234,0xFF0008,2,0,True)
        with self.assertRaises(ImageStateError): state.fetch(0,0xFF0000,0x4EB9,7)

    def test_wram_wrong_copy_and_mask(self):
        state=ImageState(self.manifest)
        with self.assertRaises(ImageStateError): state.data(0,0x880FDE,0x880F92,2,0,False)
        state=ImageState(self.manifest); self.install_wram(state,6)
        row=next(row for row in self.rows if row.get("view")==6 and row["pc"]==0xFF0000)
        import hashlib
        site={"opcode":row["bytes"].hex(),"immutable_mask":row["immutable_mask"],
              "opcode_identity_kind":row["opcode_identity_kind"],
              "opcode_hash32":int.from_bytes(hashlib.sha256(row["identity_bytes"]).digest()[:4],"little")}
        state.fetch(0,0xFF0000,0x4EB9,6,site)
        site["immutable_mask"]="ff"*6
        with self.assertRaises(ImageStateError): state.fetch(0,0xFF0000,0x4EB9,6,site)

    def test_all_source_idle_aliases_restore_and_boundary(self):
        import hashlib
        for real in domains.IDLE_REAL_WORDS:
            for fake in domains.idle_words(real):
                state=ImageState(self.manifest)
                source={"cpu":"m68k","pc":"0x00881234","site_kind":"fetch",
                        "opcode":f"{real:04x}","image_view":0,"opcode_identity_kind":"exact-bytes"}
                idle=IdleState(state,[source])
                row=(0,11,360,0,0x881234,real,fake,"install","fame-idle-detector-after-write")
                previous=(10,360,0x881234,real,0,True)
                with self.assertRaises(ImageStateError): idle.apply(row,(9,360,0x881234,real,0,True),360)
                with self.assertRaises(ImageStateError): idle.apply(row,(10,360,0x881234,real,0,False),360)
                idle.apply(row,previous,360)
                derived={"opcode_identity_kind":"engine-idle-rewrite","base_view":0,
                    "real_opcode":real,"image_view":16,"opcode":f"{fake:04x}","immutable_mask":"ffff",
                    "opcode_hash32":int.from_bytes(hashlib.sha256(fake.to_bytes(2,"big")).digest()[:4],"little")}
                idle.fetch(0x881234,fake,derived)
                with self.assertRaises(ImageStateError): idle.apply(row,previous,360)
                with self.assertRaises(ImageStateError): idle.fetch(0x881234,real,source)
                restore=(1,12,361,0,0x881234,fake,real,"restore","sek-finish-idle-after-expression")
                with self.assertRaises(ImageStateError): idle.apply(restore,(11,360,0x881234,fake,0,True),362,terminal=True)
                idle.apply(restore,(11,360,0x881234,fake,0,True),361,terminal=True)
                idle.fetch(0x881234,real,source)
                with self.assertRaises(ImageStateError): idle.fetch(0x881234,fake,derived)

    def test_wram_rewrite_reinstall_drops_stale_identity(self):
        state=ImageState(self.manifest); self.install_wram(state,6)
        source={"cpu":"m68k","pc":"0x00FF0014","site_kind":"fetch","opcode":"66f6",
                "image_view":6,"opcode_identity_kind":"exact-bytes"}
        idle=IdleState(state,[source])
        idle.apply((0,11,360,0,0xFF0014,0x66F6,0x73F6,"install","fame-idle-detector-after-write"),
                   (10,360,0xFF0014,0x66F6,0,True),360)
        self.assertEqual(state.wram.bytes[20:22].hex(),"73f6")
        state.data(0,0x880FDE,0x880F92,2,0x4EB9,False); idle.after_data()
        self.assertFalse(idle.active)

    def reset(self, state, cpu):
        state.reset_read(cpu, 0, 0, 4, 0x204, 0, False)
        state.reset_read(cpu, 0, 4, 4, 0x06040000 if cpu == 1 else 0x0603F800, 1, False)
        state.fetch(cpu, 0x204, 0xD406 if cpu == 1 else 0xD106, 1)

    def install(self, state, cpu, view):
        image = state.copies[view]
        for offset in range(0, image["size"], 4):
            value = int.from_bytes(image["data"][offset:offset+4], "big")
            state.data(cpu, image["read_pc"], image["source"]+offset, 4, value, False)
            state.data(cpu, image["write_pc"], image["destination"]+offset, 4, value, True)

    def test_reset_exact_order_and_no_later_synthetic_phase(self):
        state = ImageState(self.manifest)
        with self.assertRaises(ImageStateError): state.reset_read(1, 0, 4, 4, 0x06040000, 0, False)
        self.reset(state, 1)
        with self.assertRaises(ImageStateError): state.reset_read(1, 0, 0, 4, 0x204, 0, False)
        with self.assertRaises(ImageStateError): state.fetch(2, 0x204, 0xD106, 1)

    def test_sram_install_is_cpu_local_and_interior_write_invalidates(self):
        state = ImageState(self.manifest)
        self.reset(state, 1); self.reset(state, 2)
        self.install(state, 1, 2)
        word = int.from_bytes(state.copies[2]["data"][:2], "big")
        state.fetch(1, 0xC0000000, word, 2)
        with self.assertRaises(ImageStateError): state.fetch(2, 0xC0000000, word, 2)
        state.data(1, 0x1234, 0xC0000770, 4, 0, True)
        state.fetch(1, 0xC0000000, word, 2)
        state.data(1, 0x1234, 0xC0000001, 1, 0, True)
        with self.assertRaises(ImageStateError): state.fetch(1, 0xC0000000, word, 2)
        self.install(state, 1, 2)
        state.fetch(1, 0xC0000000, word, 2)

    def test_copy_value_and_overlapping_view_collisions_fail_closed(self):
        state = ImageState(self.manifest); self.reset(state, 1)
        image = state.copies[2]
        with self.assertRaises(ImageStateError):
            state.data(1, image["read_pc"], image["source"], 4, 0, False)
        state = ImageState(self.manifest); self.reset(state, 1)
        self.install(state, 1, 2)
        self.assertEqual(state.copies[2]["data"][:2], state.copies[4]["data"][:2])
        with self.assertRaises(ImageStateError):
            state.fetch(1, 0xC0000000, int.from_bytes(image["data"][:2], "big"), 4)

    def test_passive_comm_preserves_widths_boot_and_pending_terminal(self):
        comm = CommState()
        self.assertEqual(comm.event(1, 3, 1, 0x218, 0x20004020, 4, 0x4D5F4F4B, True)[8], 0)
        comm.event(2, 3, 0, 0x880808, 0xA15120, 4, 0x4D5F4F4B, False)
        comm.event(3, 3, 0, 0x880810, 0xA15124, 4, 0x535F4F4B, False)
        self.assertEqual(comm.event(4, 3, 0, 0x88081A, 0xA15120, 4, 0, True)[7], 0)
        row = comm.event(5, 4, 0, 0x881234, 0xA15120, 2, 0x0102, True)
        self.assertEqual(row[7:], (1, 18, 3))
        comm.event(6, 4, 1, 0x06004464, 0x20004023, 1, 2, True)
        self.assertEqual(comm.summary()["counts"], [0, 1, 1, 0, 1])
        self.assertEqual(comm.summary()["lanes"][:4], [1, 2, 0, 2])
        # An overlapping longword retains precisely the covered two lanes.
        self.assertEqual(comm.event(7, 4, 1, 0x1234, 0x2000401E, 4, 0xFFFF0000, True)[9], 3)


if __name__ == "__main__":
    unittest.main()
