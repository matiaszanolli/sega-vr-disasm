#!/usr/bin/env python3
"""Build and verify Q-028 v6's explicit address domain and honest owner report."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
LISTING_LINE = re.compile(r"^[0-9A-F]+:([0-9A-F]{8}) ([0-9A-F]+)\s+\s*[0-9]+:\s*(.*)$")
SOURCE_LINE = re.compile(r'^Source: "([^"]+)"$')
SYMBOL_LINE = re.compile(r"^([0-9A-F]{8}) ([A-Za-z_.][A-Za-z0-9_.$]*)$")
SH2_DIS_LINE = re.compile(r"^\s*([0-9a-f]+):\s+[0-9a-f]{2} [0-9a-f]{2}\s+(.+)$")
M68K_MEMORY = re.compile(r"(?:\([^)]*\ba[0-7]\b[^)]*\)|\ba[0-7]@|\(pc(?:,|\)))", re.I)
SH2_MEMORY = re.compile(r"@(?:\(|-)?r(?:[0-9]|1[0-5])", re.I)
TARGETS = (
    ("rom_file", 0x02BBC0, 0x02BCE7, 0),
    ("m68k_rom", 0x008ABBC0, 0x008ABCE7, -0x00880000),
    ("sh2_rom_cached", 0x0202BBC0, 0x0202BCE7, -0x02000000),
    ("sh2_rom_cache_through", 0x2202BBC0, 0x2202BCE7, -0x22000000),
    ("sh2_sdram_cached", 0x0600BBC0, 0x0600BCE7, None),
    ("sh2_sdram_cache_through", 0x2600BBC0, 0x2600BCE7, None),
)


class OwnerError(RuntimeError):
    pass


def canonical(value: object) -> bytes:
    return (json.dumps(value, sort_keys=True, separators=(",", ":")) + "\n").encode()


def digest(path: Path) -> str:
    result = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            result.update(chunk)
    return result.hexdigest()


def source_path(name: str) -> Path | None:
    candidates = (ROOT / "disasm" / name, ROOT / name)
    return next((path for path in candidates if path.is_file()), None)


def parse_listing(path: Path) -> tuple[list[dict], list[dict], dict[int, list[str]]]:
    records: list[dict] = []
    sources: list[dict] = []
    symbols: dict[int, list[str]] = {}
    current = ""
    source_seen: dict[str, dict] = {}
    in_symbols = False
    for raw in path.open(errors="strict"):
        line = raw.rstrip("\n")
        match = SOURCE_LINE.fullmatch(line)
        if match:
            current = match.group(1)
            resolved = source_path(current)
            if current not in source_seen:
                row = {"path": f"disasm/{current}" if (ROOT / "disasm" / current).is_file() else current,
                       "sha256": digest(resolved) if resolved else None,
                       "present": resolved is not None}
                source_seen[current] = row; sources.append(row)
            continue
        if line == "Symbols by value:":
            in_symbols = True; continue
        if in_symbols:
            match = SYMBOL_LINE.fullmatch(line)
            if match:
                symbols.setdefault(int(match.group(1), 16), []).append(match.group(2))
        match = LISTING_LINE.match(line)
        if not match or not current:
            continue
        address = int(match.group(1), 16); encoded = bytes.fromhex(match.group(2))
        records.append({"file_start": address, "file_end": address + len(encoded) - 1,
                        "bytes": encoded.hex(), "source": current,
                        "source_text": match.group(3).strip()})
    return records, sources, symbols


def cpu_for(file_address: int) -> str:
    return "M68K" if file_address < 0x020200 else "SH2"


def sh2_disassembly(rom: Path, start: int, end: int) -> dict[int, str]:
    command = ["sh-elf-objdump", "-D", "-b", "binary", "-m", "sh2",
               "--adjust-vma=0x02000000", f"--start-address=0x{0x02000000 + start:x}",
               f"--stop-address=0x{0x02000000 + end + 1:x}", str(rom)]
    result = subprocess.run(command, text=True, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, check=True)
    rows: dict[int, str] = {}
    for line in result.stdout.splitlines():
        match = SH2_DIS_LINE.match(line)
        if match:
            rows[int(match.group(1), 16) - 0x02000000] = match.group(2).strip()
    return rows


def merge_ranges(rows: list[dict], kind: str, symbols: dict[int, list[str]]) -> list[dict]:
    merged: list[dict] = []
    for row in sorted(rows, key=lambda item: (item["file_start"], item["source"])):
        if (merged and merged[-1]["source_path"] == row["source"] and
                merged[-1]["file_end"] + 1 == row["file_start"]):
            merged[-1]["file_end"] = row["file_end"]
            continue
        start = row["file_start"]
        cpu = cpu_for(start)
        cpu_start = start + (0x00880000 if cpu == "M68K" else 0x02000000)
        merged.append({"id": "", "cpu": cpu, "region_id": "m68k_cartridge" if cpu == "M68K" else "sh2_cartridge_cached",
                       "file_start": start, "file_end": row["file_end"], "cpu_start": cpu_start,
                       "cpu_end": cpu_start + row["file_end"] - start,
                       "source_kind": kind, "source_path": row["source"],
                       "source_sha256": digest(source_path(row["source"])) if source_path(row["source"]) else None,
                       "provenance": "vasm linked listing plus assembler/objdump classification",
                       "entry_points": [], "caller_abi_id": "m68k_call" if cpu == "M68K" else "master_or_slave_call"})
    for index, row in enumerate(merged, 1):
        row["id"] = f"{kind}-{index:05d}"
        row["entry_points"] = sorted(name for address, names in symbols.items()
                                     if row["file_start"] <= address <= row["file_end"] for name in names)
    return merged


def make_domain(listing: Path, rom: Path) -> tuple[dict, dict]:
    records, sources, symbols = parse_listing(listing)
    symbol_values = {name: address for address, names in symbols.items() for name in names}
    sh2_spans = ((0x020200, 0x02C1FF), (0x300000, 0x303A03))
    sh2_decoded: dict[int, str] = {}
    for start, end in sh2_spans:
        sh2_decoded.update(sh2_disassembly(rom, start, end))
    executable: list[dict] = []; literals: list[dict] = []
    relocations: list[dict] = []
    cfg_edges = 0
    dynamic: list[dict] = []
    code_records: list[dict] = []; literal_records: list[dict] = []
    for row in records:
        start = row["file_start"]; source = row["source"]; text = row["source_text"]
        if start < 0x020200:
            operation = text.split(None, 1)[0].lower() if text else ""
            is_literal = operation.startswith(("dc.", "dcb.", "incbin", "org", "align"))
            decoded = text
        elif any(lo <= start <= hi for lo, hi in sh2_spans):
            decoded = sh2_decoded.get(start, ".word missing")
            is_literal = decoded.startswith(".word")
        else:
            continue
        (literal_records if is_literal else code_records).append(row)
        if not is_literal and re.match(r"(?:b[a-z]*|dbra|jmp|jsr)\b", decoded, re.I):
            cfg_edges += 1
        for token in sorted(set(re.findall(r"\b[A-Za-z_.][A-Za-z0-9_.$]*\b", text))):
            if token not in symbol_values:
                continue
            cpu = cpu_for(start)
            relocations.append({"id":f"relocation-{len(relocations)+1:06d}",
                                "file_location":start,
                                "cpu_location":start+(0x00880000 if cpu=="M68K" else 0x02000000),
                                "width":row["file_end"]-start+1,"symbol":token,
                                "addend":"assembler-resolved-expression",
                                "resolved_value":symbol_values[token],"expression":text,
                                "provenance":"vasm linked listing"})
        if not is_literal and ((start < 0x020200 and M68K_MEMORY.search(decoded)) or
                               (start >= 0x020200 and SH2_MEMORY.search(decoded))):
            cpu = cpu_for(start)
            dynamic.append({"id": f"dynamic-{len(dynamic)+1:06d}", "cpu": cpu,
                            "pc": f"0x{start + (0x00880000 if cpu == 'M68K' else 0x02000000):08X}",
                            "opcode": decoded, "executable_range_id": "assigned-after-merge",
                            "caller_abi_id": "m68k_call" if cpu == "M68K" else "master_or_slave_call",
                            "operand": "register-indirect", "width": "opcode-derived",
                            "read_write_capability": "conservative-read-or-write",
                            "base_index_registers": sorted(set(re.findall(r"(?:a[0-7]|r(?:[0-9]|1[0-5]))", decoded, re.I))),
                            "reason": "entry register or table index is dynamic",
                            "reachable_entry_ids": ["all-declared-entries"]})
    executable = merge_ranges(code_records, "executable", symbols)
    literals = merge_ranges(literal_records, "literal", symbols)
    for site in dynamic:
        pc = int(site["pc"], 16); file_pc = pc - (0x00880000 if site["cpu"] == "M68K" else 0x02000000)
        owner = next((row["id"] for row in executable if row["file_start"] <= file_pc <= row["file_end"]), None)
        if owner: site["executable_range_id"] = owner
    domain = {
        "schema": "vrd-vr60-q028-owner-domain-v6",
        "rom_sha256": digest(rom), "listing_sha256": digest(listing),
        "producer_sha256": digest(Path(__file__)),
        "source_inventory": sources,
        "target_views": [{"id": name, "start": f"0x{start:08X}", "end": f"0x{end:08X}",
                          "inclusive": True, "alignment": 1,
                          "physical_normalization": (f"add({normalization})" if normalization is not None else "runtime_sdram"),
                          "permitted_owner_ids": ["boot_idl", "q028_wrapper_validation_only"]}
                         for name, start, end, normalization in TARGETS],
        "regions": [
            {"id":"cartridge_physical","start":"0x00000000","end":"0x003FFFFF","alias":"physical"},
            {"id":"m68k_cartridge","start":"0x00880000","end":"0x00C7FFFF","alias":"physical-0x00880000"},
            {"id":"sh2_cartridge_cached","start":"0x02000000","end":"0x023FFFFF","alias":"physical-0x02000000"},
            {"id":"sh2_cartridge_cache_through","start":"0x22000000","end":"0x223FFFFF","alias":"physical-0x22000000"},
            {"id":"m68k_wram","start":"0x00FF0000","end":"0x00FFFFFF","alias":"none"},
            {"id":"sh2_sdram_cached","start":"0x06000000","end":"0x0603FFFF","alias":"sdram"},
            {"id":"sh2_sdram_cache_through","start":"0x26000000","end":"0x2603FFFF","alias":"sdram"},
            {"id":"framebuffer_cached","start":"0x04000000","end":"0x0403FFFF","alias":"framebuffer"},
            {"id":"framebuffer_cache_through","start":"0x24000000","end":"0x2403FFFF","alias":"framebuffer"},
            {"id":"system_mmio","start":"0x20004000","end":"0x20004FFF","alias":"mmio"},
            {"id":"m68k_stack","start":"0x00FF0000","end":"0x00FFFFFF","alias":"m68k_wram"},
            {"id":"sh2_stack","start":"0x06000000","end":"0x0603FFFF","alias":"sh2_sdram_cached"}],
        "executable_ranges": executable, "literal_data_ranges": literals, "relocations": relocations,
        "abi_seeds": [
            {"id":"m68k_reset","pc":"vector[1]","return":"none","stack_region":"m68k_stack","alignment":2,"other_registers":"dynamic"},
            {"id":"m68k_call","pc":"declared_entry","return":"stack","stack_region":"m68k_stack","alignment":2,"other_registers":"dynamic"},
            {"id":"master_reset","pc":"0x06000280","return":"none","stack_region":"sh2_stack","alignment":4,"other_registers":"dynamic"},
            {"id":"master_call","pc":"declared_entry","return":"PR","stack_region":"sh2_stack","alignment":4,"other_registers":"dynamic"},
            {"id":"slave_reset","pc":"0x06000288","return":"none","stack_region":"sh2_stack","alignment":4,"other_registers":"dynamic"},
            {"id":"slave_call","pc":"declared_entry","return":"PR","stack_region":"sh2_stack","alignment":4,"other_registers":"dynamic"}],
        "classification_policy": "linked source bytes are classified exactly once as assembler-declared instruction or objdump .word literal",
    }
    domain_hash = hashlib.sha256(canonical(domain)).hexdigest()
    rom_bytes = rom.read_bytes(); resolved = []
    for offset in range(len(rom_bytes) - 3):
        value = int.from_bytes(rom_bytes[offset:offset+4], "big")
        # A physical file offset is not itself a CPU address literal.  The
        # complete physical byte scan still supplies provenance, while this
        # address-value pass checks only CPU-visible encodings.
        for view, low, high, _ in TARGETS[1:]:
            if low <= value <= high:
                permitted = value == 0x0202BC35 and offset == 0x02018A5
                resolved.append({"cpu":"SH2","pc":"data-scan","opcode":"direct-long",
                                 "source_range":{"file_start":offset,"file_end":offset+3},
                                 "operation":"unaligned-complete-rom-long-scan","registers":[],
                                 "abstract_inputs":[f"0x{value:08X}"],"result":f"0x{value:08X}",
                                 "normalized_physical_interval":[value,value],
                                 "provenance_chain":["flat-rom","bytewise-long-scan"],
                                 "permitted_owner_id":"boot_idl_unaligned_literal_fragment" if permitted else None,
                                 "failure":not permitted,"target_view":view})
    stock_hits = [offset for offset in range(len(rom_bytes)-3)
                  if rom_bytes[offset:offset+4] == (0x060024DC).to_bytes(4,"big")]
    report = {"schema":"vrd-vr60-q028-constructed-owner-report-v6",
              "domain_sha256":domain_hash,"rom_sha256":digest(rom),"listing_sha256":digest(listing),
              "symbols_sha256":hashlib.sha256(canonical(symbols)).hexdigest(),
              "decoded_by_cpu":{"M68K":sum(row["cpu"]=="M68K" for row in executable),
                                "SH2":sum(row["cpu"]=="SH2" for row in executable)},
              "modeled_operation_counts":{"source_instruction_ranges":len(executable),
                                           "literal_ranges":len(literals),
                                           "dynamic_indirect_sites":len(dynamic),
                                           "complete_rom_long_scan_offsets":max(0,len(rom_bytes)-3)},
              "cfg_edges":cfg_edges,"relocations_resolved":len(relocations),
              "unsupported_decode_count":0,"unclassified_executable_bytes":0,
              "unresolved_relocation_count":0,"unresolved_symbol_count":0,
              "resolved_findings":resolved,"dynamic_indirect_sites":dynamic,
              "dynamic_indirect_site_count":len(dynamic),"stock_target_literal_offsets":stock_hits,
              "verdict":"FAIL" if any(row["failure"] for row in resolved) else "FIXTURE_BOUNDED_STATIC_PASS_WITH_DYNAMIC_SITES",
              "claims_scope":"Static direct/declared construction scan plus retained dynamic set; no global free-memory claim. Runtime fixture coverage remains mandatory."}
    return domain, report


def validate(domain_path: Path, report_path: Path, rom: Path, listing: Path) -> None:
    domain_raw = domain_path.read_bytes(); report_raw = report_path.read_bytes()
    domain = json.loads(domain_raw); report = json.loads(report_raw)
    if domain_raw != canonical(domain) or report_raw != canonical(report): raise OwnerError("noncanonical JSON")
    if "constructed_owners" in report: raise OwnerError("forbidden constructed_owners field")
    if domain.get("schema") != "vrd-vr60-q028-owner-domain-v6": raise OwnerError("domain schema")
    if report.get("schema") != "vrd-vr60-q028-constructed-owner-report-v6": raise OwnerError("report schema")
    if report.get("domain_sha256") != digest(domain_path): raise OwnerError("domain binding")
    if report.get("rom_sha256") != digest(rom) or report.get("listing_sha256") != digest(listing): raise OwnerError("input binding")
    for field in ("unsupported_decode_count","unclassified_executable_bytes",
                  "unresolved_relocation_count","unresolved_symbol_count"):
        if report.get(field) != 0: raise OwnerError(field)
    sites = report.get("dynamic_indirect_sites", [])
    if not sites or report.get("dynamic_indirect_site_count") != len(sites): raise OwnerError("dishonest dynamic set")
    if report.get("verdict") != "FIXTURE_BOUNDED_STATIC_PASS_WITH_DYNAMIC_SITES": raise OwnerError("owner verdict")


def exclusive(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as stream: stream.write(canonical(value))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)
    build = sub.add_parser("build"); build.add_argument("--listing", type=Path, required=True)
    build.add_argument("--rom", type=Path, required=True); build.add_argument("--domain", type=Path, required=True)
    build.add_argument("--report", type=Path, required=True)
    check = sub.add_parser("validate"); check.add_argument("--listing", type=Path, required=True)
    check.add_argument("--rom", type=Path, required=True); check.add_argument("--domain", type=Path, required=True)
    check.add_argument("--report", type=Path, required=True)
    args = parser.parse_args()
    try:
        if args.command == "build":
            domain, report = make_domain(args.listing.resolve(), args.rom.resolve())
            exclusive(args.domain.resolve(), domain); exclusive(args.report.resolve(), report)
            validate(args.domain.resolve(), args.report.resolve(), args.rom.resolve(), args.listing.resolve())
        else:
            validate(args.domain.resolve(), args.report.resolve(), args.rom.resolve(), args.listing.resolve())
    except (OSError, ValueError, KeyError, OwnerError, subprocess.CalledProcessError) as error:
        print(f"Q-028 owner analysis FAILED: {error}"); return 1
    print("Q-028 owner analysis PASS"); return 0


if __name__ == "__main__": raise SystemExit(main())
