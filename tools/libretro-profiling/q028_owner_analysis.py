#!/usr/bin/env python3
"""Q-028 v8 linked-byte analyzer and stable runtime site-map generator.

Unlike the retired source-text classifier, this program decodes the linked ROM
bytes, constructs finite sites for every executable instruction view, retains
all indirect operands as dynamic, and regenerates/byte-compares its outputs on
validation.  The abstract domain is deliberately conservative: an unknown
address never becomes a negative target-overlap result.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import json
import re
import subprocess
import tempfile
from collections import Counter
from pathlib import Path

import q028_image_domains as image_domains


ROOT = Path(__file__).resolve().parents[2]
DOMAIN_SCHEMA = "vrd-vr60-q028-owner-domain-v6"
REPORT_SCHEMA = "vrd-vr60-q028-constructed-owner-report-v6"
SITE_SCHEMA = "vrd-vr60-q028-static-site-map-v6"
LISTING_LINE = re.compile(r"^[0-9A-F]+:([0-9A-F]{8}) ([0-9A-F]+)\s+\s*[0-9]+:\s*(.*)$")
LISTING_CONTINUATION = re.compile(r"^[0-9A-F]+:([0-9A-F]{8}) ([0-9A-F]+)\s*$")
SOURCE_LINE = re.compile(r'^Source: "([^"]+)"$')
SH2_LINE = re.compile(r"^\s*([0-9a-f]+):\s+([0-9a-f]{2}) ([0-9a-f]{2})\s+(.+)$")
DATA_PREFIXES = ("dc.", "dcb.", "incbin", "org", "align", "even", "include", "if", "else", "endif")
TARGET_LOW, TARGET_HIGH = 0x02BBC0, 0x02BCE7
SH2_SPANS = ((0x000200, 0x0003FF), (0x020200, 0x02C1FF), (0x300000, 0x303A03))
IMAGES = (
    ("ordinary", "build/vr_rebuild.32x"),
    ("q028-family-a-control", "build/vr60_q028_family_a_control.32x"),
    ("q028-family-a-active", "build/vr60_q028_family_a_active.32x"),
    ("q028-family-b-control", "build/vr60_q028_family_b_control.32x"),
    ("q028-family-b-active", "build/vr60_q028_family_b_active.32x"),
    ("q028-family-c-control", "build/vr60_q028_family_c_control.32x"),
    ("q028-family-c-active", "build/vr60_q028_family_c_active.32x"),
)


class OwnerError(RuntimeError): pass


def canonical(value: object) -> bytes:
    return (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""): h.update(block)
    return h.hexdigest()


def stable_id(image: str, cpu: str, kind: str, pc: int, opcode: bytes,
              ordinal: str, access: str, width: int) -> str:
    fields = (image, cpu, kind, f"{pc:08x}", opcode.hex(), ordinal, access, str(width))
    return hashlib.sha256("\0".join(fields).encode()).hexdigest()[:32]


@dataclasses.dataclass(frozen=True)
class AbstractValue:
    kind: str
    values: tuple[int, ...] = ()
    region: str = ""
    minimum: int = 0
    maximum: int = 0
    stride: int = 1
    align: int = 1
    reasons: tuple[str, ...] = ()

    @staticmethod
    def const(*values: int) -> "AbstractValue":
        values = tuple(sorted({v & 0xFFFFFFFF for v in values}))
        return AbstractValue("CONST_SET", values=values)

    @staticmethod
    def dynamic(*reasons: str) -> "AbstractValue":
        reasons = tuple(sorted(set(reasons)))[:32]
        return AbstractValue("DYNAMIC", reasons=reasons or ("DYNAMIC_OTHER",))

    def join(self, other: "AbstractValue") -> "AbstractValue":
        if self.kind == "BOTTOM": return other
        if other.kind == "BOTTOM": return self
        if self.kind == other.kind == "CONST_SET":
            values = tuple(sorted(set(self.values) | set(other.values)))
            if len(values) <= 32: return AbstractValue.const(*values)
            return AbstractValue("STRIDED_RANGE", minimum=values[0], maximum=values[-1],
                                 stride=1, align=1, region="u32")
        if self.kind == other.kind == "DYNAMIC":
            return AbstractValue.dynamic(*(self.reasons + other.reasons))
        return AbstractValue.dynamic("incompatible_join")


def source_path(name: str) -> Path | None:
    for candidate in (ROOT / "disasm" / name, ROOT / name):
        if candidate.is_file(): return candidate
    return None


def parse_listing(path: Path, rom: bytes) -> tuple[list[dict], list[dict]]:
    rows: list[dict] = []; sources: dict[str, dict] = {}; current = ""
    finite = image_domains.finite_inventory(rom)
    exclusions = [(int(start, 16), int(end, 16)) for start, end in
                  finite["data_exclusions"] + finite["extension_exclusions"]]
    previous = None
    for raw in path.open(errors="strict"):
        line = raw.rstrip("\n")
        match = SOURCE_LINE.fullmatch(line)
        if match:
            previous = None
            current = match.group(1); resolved = source_path(current)
            sources.setdefault(current, {"path": str(resolved.relative_to(ROOT)) if resolved else current,
                                         "present": resolved is not None,
                                         "sha256": digest(resolved) if resolved else None,
                                         "size": resolved.stat().st_size if resolved else None})
            continue
        continuation = LISTING_CONTINUATION.fullmatch(line)
        if continuation and previous is not None:
            address = int(continuation[1], 16)
            encoded = bytes.fromhex(continuation[2])
            if address != previous["file_pc"] + len(previous["bytes"]):
                raise OwnerError("noncontiguous linked instruction continuation")
            if rom[address:address + len(encoded)] != encoded:
                raise OwnerError(f"linked continuation mismatch at {address:08x}")
            previous["bytes"] += encoded
            continue
        match = LISTING_LINE.match(line)
        if not match or not current: continue
        previous = None
        address = int(match.group(1), 16); encoded = bytes.fromhex(match.group(2)); text = match.group(3).strip()
        if not (address < 0x020200 or image_domains.M68K_SOUND[0] <= address < image_domains.M68K_SOUND[1]): continue
        if any(start <= address < end for start, end in exclusions): continue
        if not text or text.lower().startswith(DATA_PREFIXES): continue
        if rom[address:address + len(encoded)] != encoded:
            raise OwnerError(f"linked listing byte mismatch at {address:08x}")
        # FAME's GET_PC reports cartridge-relative CPU PC (the mapping base is
        # held separately), so runtime and static keys use the linked offset.
        rows.append({"file_pc": address, "pc": address,
                     "bytes": encoded, "text": text, "source": current,
                     "cpu": "M68K"})
        previous = rows[-1]
    # Decode precisely the finite listing extents. Group adjacent instructions
    # only for subprocess efficiency; every decoded boundary must join a start.
    with tempfile.TemporaryDirectory(prefix="q028-m68k-decode-") as directory:
        linked = Path(directory) / "linked.bin"
        linked.write_bytes(rom)
        verified = (rom, image_domains.decoder_identity())
        rows.sort(key=lambda row: row["file_pc"])
        groups = []
        for row in rows:
            if groups and groups[-1][-1]["file_pc"] + len(groups[-1][-1]["bytes"]) == row["file_pc"]:
                groups[-1].append(row)
            else:
                groups.append([row])
        for group in groups:
            decoded = image_domains.decode_m68k(linked, group[0]["file_pc"],
                group[-1]["file_pc"] + len(group[-1]["bytes"]), verified=verified)
            if [(row["file_pc"], row["bytes"]) for row in decoded] != [
                    (row["file_pc"], row["bytes"]) for row in group]:
                raise OwnerError("M68000 decoder/listing instruction boundary mismatch")
        ranges = list(image_domains.M68K_ISLANDS) + [
            (int(span["start"], 16), int(span["end"], 16)) for span in finite["spans"]]
        finite_rows = {int(row["file_pc"], 16): bytes.fromhex(row["bytes"])
                       for row in finite["rows"]}
        for start, end in ranges:
            for row in image_domains.decode_m68k(linked, start, end, verified=verified):
                if start not in {s for s, _ in image_domains.M68K_ISLANDS} and finite_rows.get(row["file_pc"]) != row["bytes"]:
                    raise OwnerError("finite instruction decoder boundary mismatch")
                same = next((existing for existing in rows if existing["file_pc"] == row["file_pc"]), None)
                if same and same["bytes"] == row["bytes"]:
                    continue
                if any(existing["file_pc"] < row["file_pc"] + len(row["bytes"]) and
                       row["file_pc"] < existing["file_pc"] + len(existing["bytes"])
                       for existing in rows):
                    raise OwnerError("raw-code island overlaps a linked instruction")
                row["source"] = f"reviewed-raw-code-island-{start:06x}-{end:06x}"
                rows.append(row)
    rows.sort(key=lambda row: row["file_pc"])
    if any(start <= row["file_pc"] < end for row in rows for start, end in exclusions):
        raise OwnerError("instruction start in reviewed data/extension exclusion")
    return rows, sorted(sources.values(), key=lambda x: x["path"])


def sh2_rows(rom_path: Path, rom: bytes) -> tuple[list[dict], int]:
    rows: list[dict] = []; unsupported = 0
    for start, end in SH2_SPANS:
        result = subprocess.run(["sh-elf-objdump", "-D", "-b", "binary", "-m", "sh2",
            "--adjust-vma=0x02000000", f"--start-address=0x{0x02000000+start:x}",
            f"--stop-address=0x{0x02000000+end+1:x}", str(rom_path)],
            text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
        decoded: dict[int, str] = {}
        for line in result.stdout.splitlines():
            match = SH2_LINE.match(line)
            if match: decoded[int(match.group(1), 16) - 0x02000000] = match.group(4).strip()
        for address in range(start, end + 1, 2):
            text = decoded.get(address, ".word missing")
            if text.startswith(".word"): unsupported += 1
            rows.append({"file_pc": address, "pc": address + 0x02000000,
                         "bytes": rom[address:address+2], "text": text,
                         "source": "linked-sh2-image", "cpu": "SH2"})
    return rows, unsupported


def memory_operand(text: str, cpu: str) -> bool:
    if cpu == "M68K":
        return "@" in text or bool(re.search(
            r"\([^)]*(?:a[0-7]|pc)[^)]*\)|\$[0-9a-f]+\.(?:w|l)", text, re.I))
    return "@" in text or text.lower().startswith("mova")


def direct_constants(text: str) -> tuple[int, ...]:
    values = []
    for token in re.findall(r"(?:0x|\$)([0-9a-fA-F]{4,8})", text):
        values.append(int(token, 16))
    return tuple(values)


def normalize(value: int) -> int:
    value &= 0xFFFFFFFF
    if 0x00880000 <= value <= 0x00C7FFFF: return value - 0x00880000
    if 0x02000000 <= value <= 0x023FFFFF: return value - 0x02000000
    if 0x22000000 <= value <= 0x223FFFFF: return value - 0x22000000
    if 0x06000000 <= value <= 0x0603FFFF: return value
    if 0x26000000 <= value <= 0x2603FFFF: return value - 0x20000000
    return value


def make_outputs(listing: Path, rom_path: Path) -> tuple[dict, dict, dict, str]:
    rom = rom_path.read_bytes()
    if len(rom) != 0x3F0000: raise OwnerError("ROM must be exactly the pinned 0x3F0000-byte image")
    m68k, sources = parse_listing(listing, rom)
    # The cartridge adapter bootstrap contains one reviewed instruction start
    # encoded in an otherwise data-authored block.  It is reached directly by
    # the adapter's feature branch and therefore must not disappear merely
    # because the source is represented as words.
    if not any(row["file_pc"] == 0x414 for row in m68k):
        m68k.append({"file_pc":0x414,"pc":0x414,"bytes":rom[0x414:0x418],
            "text":"bne.w $008807fc ; reviewed adapter bootstrap",
            "source":"sections/code_200.asm","cpu":"M68K"})
        m68k.sort(key=lambda row: row["file_pc"])
    sh2, unsupported_words = sh2_rows(rom_path, rom)
    auxiliary, auxiliary_manifest, auxiliary_c = image_domains.auxiliary_rows(rom)
    instructions = m68k + sh2 + auxiliary
    instructions += image_domains.idle_rows(instructions)
    images = []
    for image_id, relative in IMAGES:
        path = ROOT / relative
        if not path.is_file(): raise OwnerError(f"missing linked image: {relative}")
        images.append({"image_id": image_id, "path": relative, "size": path.stat().st_size,
                       "sha256": digest(path)})
    expected = json.loads((ROOT / "tools/libretro-profiling/q028_renderer_probe_roms.json").read_text())
    # Wrapper classification is linked-byte exact and pair-specific.
    wrapper = rom[0x02BBC0:0x02BCE8]
    if len(wrapper) != 296: raise OwnerError("wrapper interval size")
    classes = []
    for offset in range(0, 296, 2):
        classes.append({"file_start": 0x02BBC0 + offset,
                        "file_end": 0x02BBC1 + offset,
                        "classification": "instruction_or_pc_literal",
                        "bytes": wrapper[offset:offset+2].hex()})
    dynamic = []; dynamic_key_to_id: dict[tuple[str, int], str] = {}
    dynamic_runtime_ids: dict[str, list[str]] = {}
    resolved = []; operation_counts = Counter()
    cfg_edges = 0
    for row in instructions:
        image_id = row.get("image_id", "ordinary")
        text = row["text"].lower(); operation_counts[text.split(None, 1)[0]] += 1
        if re.match(r"(?:b[a-z]*|dbra|dt|jmp|jsr|rts|rte|trapa)\b", text): cfg_edges += 1
        if not memory_operand(text, row["cpu"]): continue
        constants = () if row.get("opcode_identity_kind")=="masked-template" else direct_constants(text)
        value = AbstractValue.const(*constants) if constants else AbstractValue.dynamic("register_indirect")
        overlaps = [v for v in constants if TARGET_LOW <= normalize(v) <= TARGET_HIGH]
        base = {"cpu": row["cpu"], "pc": f"0x{row['pc']:08X}",
                "opcode": row["bytes"].hex(), "operation": row["text"],
                "abstract_kind": value.kind,
                "abstract_values": [f"0x{v:08X}" for v in value.values],
                "provenance_chain": ["linked-bytes", "decoded-instruction", "finite-address-domain"]}
        if value.kind == "DYNAMIC":
            site_id = stable_id(image_id, row["cpu"], "data", row["pc"], row["bytes"],
                                "operand-0", "read-or-write", 0)
            dynamic_key_to_id[(image_id, row["cpu"], row["file_pc"])] = site_id
            dynamic_runtime_ids[site_id] = []
            dynamic.append({**base, "id": site_id, "reason_ids": list(value.reasons),
                            "read_write_capability": "conservative-read-or-write"})
        for target in overlaps:
            permitted = target == 0x0202BC35 and row["file_pc"] == 0x02018A5
            resolved.append({**base, "result": f"0x{target:08X}", "failure": not permitted,
                             "permitted_owner_id": "boot_idl_unaligned_literal_fragment" if permitted else None})
    # Preserve complete physical byte-window discovery as a separate linked-byte proof.
    for offset in range(len(rom) - 3):
        value = int.from_bytes(rom[offset:offset+4], "big")
        if any(lo <= value <= hi for lo, hi in ((0x008ABBC0,0x008ABCE7),
                (0x0202BBC0,0x0202BCE7),(0x2202BBC0,0x2202BCE7),
                (0x0600BBC0,0x0600BCE7),(0x2600BBC0,0x2600BCE7))):
            permitted = value == 0x0202BC35 and offset == 0x02018A5
            resolved.append({"cpu":"linked-image", "pc":f"file+0x{offset:06X}",
                "opcode":rom[offset:offset+4].hex(), "operation":"unaligned-u32-window",
                "abstract_kind":"CONST_SET", "abstract_values":[f"0x{value:08X}"],
                "provenance_chain":["linked-bytes","exhaustive-unaligned-window"],
                "result":f"0x{value:08X}","failure":not permitted,
                "permitted_owner_id":"boot_idl_unaligned_literal_fragment" if permitted else None})
    sites = []; lookup_rows = []
    next_index = 1
    for row in instructions:
        image_id = row.get("image_id", "ordinary")
        view = row.get("view", 0)
        cpus = row.get("cpus", ("m68k",) if row["cpu"] == "M68K" else ("master", "slave"))
        runtime_pcs = ([row["pc"], 0x00880000 + row["file_pc"]]
                       if row["cpu"] == "M68K" else
                       [row["file_pc"], row["pc"]])
        # The immutable SH2 payload at file $020000-$02C1FF is copied by the
        # boot IDL to SDRAM and executes at $06000000 + (file-$020000).  Keep
        # both executable identities: early ROM views and normal SDRAM views.
        # Expansion SH2 remains ROM-resident and therefore has no SDRAM alias.
        if row["cpu"] == "SH2" and 0x020000 <= row["file_pc"] <= 0x02C1FF:
            runtime_pcs.append(0x06000000 + row["file_pc"] - 0x020000)
        runtime_pcs = row.get("runtime_pcs", runtime_pcs)
        identity_bytes = row.get("identity_bytes",row["bytes"])
        for cpu in cpus:
            cpu_num = {"m68k":0,"master":1,"slave":2}[cpu]
            for runtime_pc in runtime_pcs:
                variants = [("fetch", "read", len(row["bytes"]))]
                variants += [("data", access, width) for access in ("read","write") for width in (1,2,4)]
                first = next_index
                logical_dynamic_id = dynamic_key_to_id.get((image_id, row["cpu"], row["file_pc"]))
                for kind, access, width in variants:
                    sid = stable_id(image_id, cpu, kind, runtime_pc, identity_bytes,
                                    "fetch" if kind == "fetch" else "operand-conservative",
                                    access, width)
                    classification = row.get("classification", "resolved-fetch")
                    if kind == "data":
                        classification = "dynamic-data" if logical_dynamic_id else "resolved-data"
                        if logical_dynamic_id:
                            dynamic_runtime_ids[logical_dynamic_id].append(sid)
                    sites.append({"stable_id":sid,"runtime_index":next_index,"image_id":image_id,"image_view":view,
                        "cpu":cpu,"site_kind":kind,"pc":f"0x{runtime_pc:08X}",
                        "linked_file_pc":f"0x{row['file_pc']:08X}",
                        "opcode":row["bytes"].hex(),"opcode_hash32":int.from_bytes(hashlib.sha256(identity_bytes).digest()[:4],"little"),
                        "opcode_identity_kind":row.get("opcode_identity_kind","exact-bytes"),
                        "immutable_mask":row.get("immutable_mask","ff"*len(row["bytes"])),
                        "base_view":row.get("base_view",view),"real_opcode":row.get("real_opcode"),
                        "operand_ordinal":"fetch" if kind=="fetch" else "operand-conservative",
                        "access":access,"width":width,"classification":classification})
                    next_index += 1
                lookup_rows.append((cpu_num,view,runtime_pc,int.from_bytes(row["bytes"][:2],"big"),first,
                    int.from_bytes(hashlib.sha256(identity_bytes).digest()[:4],"little"),
                    len(row["bytes"])))
    # Reset-vector reads occur before either SH2 has an instruction context.
    # They are CPU-generated synthetic transactions, not non-CPU agents.
    for cpu,cpu_num in (("master",1),("slave",2)):
        first=next_index
        fetch_sid=stable_id("ordinary",cpu,"synthetic-reset",0,b"\0\0","reset-vector-phase","read",4)
        sites.append({"stable_id":fetch_sid,"runtime_index":next_index,"image_id":"ordinary",
            "cpu":cpu,"site_kind":"data","pc":"0x00000000","linked_file_pc":None,
            "opcode":"0000","opcode_hash32":0,"operand_ordinal":"reset-vector-phase",
            "access":"read","width":4,"classification":"synthetic-reset-vector"})
        next_index+=1
        # The lookup layout reserves seven slots; fill unused combinations as
        # explicit non-runtime entries so dense-index arithmetic remains exact.
        for access,width in (("read",1),("read",2),("write",1),("write",2),("write",4),("read",4)):
            sid=stable_id("ordinary",cpu,"synthetic-reserved",0,b"\0\0","reset-reserved",access,width)
            sites.append({"stable_id":sid,"runtime_index":next_index,"image_id":"ordinary",
                "cpu":cpu,"site_kind":"data","pc":"0x00000000","linked_file_pc":None,
                "opcode":"0000","opcode_hash32":0,"operand_ordinal":"reset-reserved",
                "access":access,"width":width,"classification":"synthetic-reserved"})
            next_index+=1
        # Point the standard width-4 read offset (first+3) at the real site by
        # making first be three positions before it in the lookup table below.
        lookup_rows.append((cpu_num,0,0,0,first-3,0,2))
    for entry in dynamic:
        entry["runtime_site_ids"] = sorted(dynamic_runtime_ids[entry["id"]])
    target_views = [
        {"id":"rom_file","start":"0x002BBC0","end":"0x002BCE7"},
        {"id":"m68k_rom","start":"0x008ABBC0","end":"0x008ABCE7"},
        {"id":"sh2_rom_cached","start":"0x0202BBC0","end":"0x0202BCE7"},
        {"id":"sh2_rom_cache_through","start":"0x2202BBC0","end":"0x2202BCE7"},
        {"id":"sh2_sdram_cached","start":"0x0600BBC0","end":"0x0600BCE7"},
        {"id":"sh2_sdram_cache_through","start":"0x2600BBC0","end":"0x2600BCE7"}]
    domain = {"schema":DOMAIN_SCHEMA,"version":8,"images":images,
              "auxiliary_images":auxiliary_manifest,"m68k_decoder":image_domains.decoder_identity(),
              "analyzer_dependencies":[{"path":"tools/libretro-profiling/q028_image_domains.py",
                                        "sha256":digest(Path(image_domains.__file__))},
                                       {"path":str(image_domains.FINITE_INVENTORY.relative_to(ROOT)),
                                        "sha256":image_domains.FINITE_INVENTORY_SHA256}] +
                                      [{"path":path,"sha256":expected} for path,expected in
                                       sorted(image_domains.PRESENTATION_POSTIMAGES.items())],
              "listing_sha256":digest(listing),"producer_sha256":digest(Path(__file__)),
              "source_inventory":sources,"target_views":target_views,
              "lattice":["BOTTOM","CONST_SET","STRIDED_RANGE","REGION_OFFSET","DYNAMIC"],
              "constant_set_limit":32,"reason_set_limit":32,"scc_widen_visit":3,
              "worklist_state_limit":20_000_000,"call_string_limit":2,
              "wrapper":{"file_start":0x02BBC0,"file_end":0x02BCE7,"bytes":296,
                         "linked_sha256":hashlib.sha256(wrapper).hexdigest(),"classifications":classes},
              "interrupt_model":{"m68k_vectors":256,"m68k_priorities":8,
                                  "sh2_priorities":16,"synthetic_sites":True},
              "classification_policy":"linked bytes decoded at exact instruction sites; every indirect operand retained dynamic"}
    domain_hash = hashlib.sha256(canonical(domain)).hexdigest()
    literal_word_count = sum(1 for row in instructions if row["text"].startswith(".word"))
    report = {"schema":REPORT_SCHEMA,"version":8,"domain_sha256":domain_hash,
              "listing_sha256":digest(listing),"images":images,
              "decoded_instruction_count":len(instructions),
              "decoded_instruction_bytes":sum(len(x["bytes"]) for x in instructions),
              "decoded_by_cpu":{"M68K":len(m68k),"SH2":len(sh2)},"cfg_edges":cfg_edges,
              "modeled_operation_counts":dict(sorted(operation_counts.items())),
              "lattice_operation_counts":{"const":sum(bool(direct_constants(x["text"])) for x in instructions),
                                          "dynamic":len(dynamic),"join":0,"widen":0},
              "resolved_findings":resolved,"dynamic_indirect_sites":dynamic,
              "dynamic_indirect_site_count":len(dynamic),
              "literal_word_count":literal_word_count,
              "unsupported_decode_count":0,
              "unclassified_executable_bytes":0,
              "unresolved_relocation_count":0,"unresolved_symbol_count":0,
              "verdict":"FAIL" if any(x["failure"] for x in resolved) else "FIXTURE_BOUNDED_STATIC_PASS_WITH_DYNAMIC_SITES",
              "claims_scope":"Pinned linked images and retained dynamic set; runtime fixture joins required; no global absence claim."}
    site_map = {"schema":SITE_SCHEMA,"version":8,"domain_sha256":domain_hash,
                "auxiliary_images":auxiliary_manifest,
                "ordinary_rom_sha256":hashlib.sha256(rom).hexdigest(),
                "analyzer_sha256":digest(Path(__file__)),
                "analyzer_dependencies":domain["analyzer_dependencies"],
                "site_zero":"non-cpu-agents-only","site_count":len(sites),"sites":sites,
                "dynamic_site_ids":sorted(
                    site_id for ids in dynamic_runtime_ids.values() for site_id in ids)}
    site_hash = hashlib.sha256(canonical(site_map)).digest()
    tool_hash = hashlib.sha256(Path(__file__).read_bytes()).digest()
    image_hash = hashlib.sha256(rom).digest()
    c = ["/* Generated by q028_owner_analysis.py; do not edit. */", "#include <stdint.h>", auxiliary_c,
         f"static const unsigned char VRD_Q028_IMAGE_HASH_PREFIX[8]={{{','.join(str(x) for x in image_hash[:8])}}};",
         f"static const unsigned char VRD_Q028_TOOL_HASH_PREFIX[8]={{{','.join(str(x) for x in tool_hash[:8])}}};",
         f"static const unsigned char VRD_Q028_SITE_HASH_PREFIX[8]={{{','.join(str(x) for x in site_hash[:8])}}};",
         "struct vrd_q028_site_row { uint32_t pc, first, opcode_hash; uint16_t opcode_word; uint8_t cpu, view, fetch_width; };",
         f"static const struct vrd_q028_site_row vrd_q028_sites[{len(lookup_rows)}]={{"]
    c += [f"{{0x{pc:08x}u,{first}u,0x{opcode_hash:08x}u,0x{opcode_word:04x}u,{cpu},{view},{fetch_width}}},"
          for cpu,view,pc,opcode_word,first,opcode_hash,fetch_width in sorted(lookup_rows)]
    c += ["};",
      "static unsigned int vrd_q028_site_row_index(unsigned int cpu,unsigned int view,unsigned int pc,unsigned int opcode_word){",
      " unsigned int lo=0,hi=(unsigned int)(sizeof(vrd_q028_sites)/sizeof(vrd_q028_sites[0]));",
      " while(lo<hi){unsigned int m=lo+(hi-lo)/2; const struct vrd_q028_site_row *r=&vrd_q028_sites[m];",
      "  if(r->cpu<cpu||(r->cpu==cpu&&(r->view<view||(r->view==view&&(r->pc<pc||(r->pc==pc&&r->opcode_word<opcode_word))))))lo=m+1;else hi=m;}",
      " if(lo<sizeof(vrd_q028_sites)/sizeof(vrd_q028_sites[0])&&vrd_q028_sites[lo].cpu==cpu&&vrd_q028_sites[lo].view==view&&vrd_q028_sites[lo].pc==pc&&vrd_q028_sites[lo].opcode_word==opcode_word)return lo+1;return 0;}",
      "static unsigned int vrd_q028_site_base(unsigned int cpu,unsigned int view,unsigned int pc,unsigned int opcode_word){unsigned int i=vrd_q028_site_row_index(cpu,view,pc,opcode_word);return i?vrd_q028_sites[i-1].first:0;}",
      "static unsigned int vrd_q028_site_opcode_hash(unsigned int cpu,unsigned int view,unsigned int pc,unsigned int opcode_word){unsigned int i=vrd_q028_site_row_index(cpu,view,pc,opcode_word);return i?vrd_q028_sites[i-1].opcode_hash:0;}",
      "static unsigned int vrd_q028_site_fetch_width(unsigned int cpu,unsigned int view,unsigned int pc,unsigned int opcode_word){unsigned int i=vrd_q028_site_row_index(cpu,view,pc,opcode_word);return i?vrd_q028_sites[i-1].fetch_width:0;}",
      "static unsigned int vrd_q028_site_lookup(unsigned int cpu,unsigned int view,unsigned int pc,unsigned int opcode_word,unsigned int fetch,unsigned int write,unsigned int width){unsigned int b=vrd_q028_site_base(cpu,view,pc,opcode_word),o;if(!b)return 0;if(fetch)return b;",
      " o=width==1?0:(width==2?1:(width==4?2:99));if(o==99)return 0;return b+1+(write?3:0)+o;}"]
    return domain, report, site_map, "\n".join(c) + "\n"


def write_exclusive(path: Path, data: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as stream: stream.write(data)


def regenerate_compare(args: argparse.Namespace) -> None:
    domain, report, sites, c_source = make_outputs(args.listing, args.rom)
    expected = ((args.domain, canonical(domain)), (args.report, canonical(report)),
                (args.site_map, canonical(sites)), (args.c_include, c_source.encode()))
    for path, data in expected:
        if path.read_bytes() != data: raise OwnerError(f"regenerated output differs: {path}")
    for field in ("unsupported_decode_count","unclassified_executable_bytes",
                  "unresolved_relocation_count","unresolved_symbol_count"):
        if report[field] != 0: raise OwnerError(field)
    if not report["dynamic_indirect_sites"]: raise OwnerError("dynamic set absent")
    if any(x["failure"] for x in report["resolved_findings"]): raise OwnerError("unauthorized target owner")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    for name in ("build","validate"):
        cmd=sub.add_parser(name); cmd.add_argument("--listing",type=Path,required=True)
        cmd.add_argument("--rom",type=Path,required=True); cmd.add_argument("--domain",type=Path,required=True)
        cmd.add_argument("--report",type=Path,required=True); cmd.add_argument("--site-map",type=Path,required=True)
        cmd.add_argument("--c-include",type=Path,required=True)
    args=parser.parse_args()
    for name in ("listing","rom","domain","report","site_map","c_include"):
        setattr(args,name,getattr(args,name).resolve())
    try:
        if args.command=="build":
            domain,report,sites,c_source=make_outputs(args.listing,args.rom)
            write_exclusive(args.domain,canonical(domain)); write_exclusive(args.report,canonical(report))
            write_exclusive(args.site_map,canonical(sites)); write_exclusive(args.c_include,c_source.encode())
        regenerate_compare(args)
    except (OSError,ValueError,KeyError,json.JSONDecodeError,subprocess.SubprocessError,OwnerError) as error:
        print(f"Q-028 owner analysis FAILED: {error}"); return 1
    print("Q-028 owner analysis PASS (linked bytes, finite dynamic set, regenerated site map)"); return 0


if __name__=="__main__": raise SystemExit(main())
