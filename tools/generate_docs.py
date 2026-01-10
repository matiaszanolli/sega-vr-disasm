#!/usr/bin/env python3
"""
Automatic documentation generator for 68K assembly functions.
Creates comprehensive function headers with:
- Purpose and overview
- Parameters and return values
- RAM/register usage
- Called by / calls analysis
- Technical notes
"""

import re
import json
from pathlib import Path
from typing import Dict, List, Optional, Set
from collections import defaultdict

# Function metadata database
FUNCTION_DATABASE = {
    "SendDREQCommand": {
        "address": 0xFB36,
        "calls": 17,
        "category": "DMA/Communication",
        "purpose": "Send DMA request to SH2 CPU",
        "parameters": "D0-D7 contain DMA config, A0-A5 hold addresses",
        "returns": "SH2 acknowledgment in $A15120",
        "uses_ram": ["$C87A", "$C964"],
        "uses_hardware": ["$00A15120", "$00A15107", "$00A15110"],
        "notes": ["Waits for SH2 ready", "Polls DREQ completion", "Used by graphics operations"]
    },
    "ControllerRead": {
        "address": 0x179E,
        "calls": 16,
        "category": "Input/Controller",
        "purpose": "Read controller state from SH2 ports",
        "parameters": "A0 base address, D0-D7 temp registers",
        "returns": "Controller data in $C822-$C823",
        "uses_ram": ["$C810", "$C811", "$C86C", "$C86E"],
        "uses_hardware": ["$00A10003", "$00A10005"],
        "notes": ["Handles 3 and 6-button pads", "Works with MapButtonBits"]
    },
    "TableLookup": {
        "address": 0x14BE,
        "calls": 12,
        "category": "Utilities",
        "purpose": "Perform indexed table lookup",
        "parameters": "D0 contains index, A0 points to table base",
        "returns": "D3 contains table entry",
        "uses_ram": [],
        "uses_hardware": [],
        "notes": ["Generic utility", "Called by graphics and data routines"]
    },
    "WaitForVBlank": {
        "address": 0x4998,
        "calls": 21,
        "category": "Timing/Synchronization",
        "purpose": "Synchronize with V-INT vertical blank",
        "parameters": "Sets up V-INT state flag",
        "returns": "Returns when V-INT cleared flag",
        "uses_ram": ["$C87A"],
        "uses_hardware": [],
        "notes": ["Enables interrupts", "Loops until V-INT completes", "Frame-sync primitive"]
    },
}

class DocumentationGenerator:
    """Generate function documentation headers"""

    def __init__(self, functions_db: Dict = None):
        self.functions_db = functions_db or FUNCTION_DATABASE
        self.call_graph = defaultdict(set)

    def generate_header(self, func_name: str, custom_notes: List[str] = None) -> str:
        """Generate documentation header for function"""
        if func_name not in self.functions_db:
            return self._generate_default_header(func_name)

        info = self.functions_db[func_name]
        lines = [
            "; " + "=" * 76,
            f"; {func_name} - {info['purpose']}",
            "; " + "=" * 76,
            ";",
        ]

        # Overview
        lines.append(f"; {info['purpose'].capitalize()}.")
        lines.append(f"; Called {info['calls']} times in ROM")
        lines.append(";")

        # Parameters
        if info.get('parameters'):
            lines.append("; Parameters:")
            for param in info['parameters'].split('\n'):
                lines.append(f";   {param}")
            lines.append(";")

        # Returns
        if info.get('returns'):
            lines.append("; Returns:")
            lines.append(f";   {info['returns']}")
            lines.append(";")

        # RAM Usage
        if info.get('uses_ram'):
            lines.append("; RAM Locations:")
            for ram_addr in info['uses_ram']:
                lines.append(f";   {ram_addr}")
            lines.append(";")

        # Hardware Registers
        if info.get('uses_hardware'):
            lines.append("; Hardware Registers:")
            for reg in info['uses_hardware']:
                lines.append(f";   {reg}")
            lines.append(";")

        # Notes
        notes = custom_notes or info.get('notes', [])
        if notes:
            lines.append("; Notes:")
            for note in notes:
                lines.append(f";   - {note}")
            lines.append(";")

        lines.append("; " + "=" * 76)
        return '\n'.join(lines)

    def _generate_default_header(self, func_name: str) -> str:
        """Generate generic header when function not in database"""
        return f"""; ============================================================================
; {func_name} - [Needs documentation]
; ============================================================================
; [TODO: Add function description]
;
; Called by: [TODO]
; Parameters: [TODO]
; Returns: [TODO]
; RAM Usage: [TODO]
;
; ============================================================================"""

    def analyze_function_calls(self, asm_file: Path) -> Dict[str, Set[str]]:
        """Analyze which functions call which other functions"""
        calls = defaultdict(set)
        content = asm_file.read_text()

        # Find BSR (branch to subroutine) and JSR (jump to subroutine) calls
        bsr_pattern = r'bsr[.w|.s|.l]?\s+(\w+)'
        jsr_pattern = r'jsr\s+\((.+?)\)'

        for match in re.finditer(bsr_pattern, content, re.IGNORECASE):
            target = match.group(1)
            calls[target].add('(unknown)')

        return calls

    def extract_ram_usage(self, lines: List[str]) -> Set[str]:
        """Extract RAM location references from assembly"""
        ram_addrs = set()

        # Match patterns like ($XXXX).w or $XXXX(A5)
        patterns = [
            r'\(\$([0-9A-F]+)\)[.wlb]',  # ($XXXX).w
            r'\$([0-9A-F]+)\(',            # $XXXX(
        ]

        for line in lines:
            for pattern in patterns:
                matches = re.findall(pattern, line, re.IGNORECASE)
                for match in matches:
                    ram_addrs.add(f"${match}")

        return ram_addrs

    def batch_generate(self, output_file: Path) -> None:
        """Generate documentation for all known functions"""
        docs = {}

        for func_name, info in self.functions_db.items():
            docs[func_name] = {
                'address': hex(info['address']),
                'calls': info['calls'],
                'category': info['category'],
                'documentation': self.generate_header(func_name)
            }

        output_file.write_text(json.dumps(docs, indent=2))
        print(f"✓ Generated documentation for {len(docs)} functions")
        print(f"✓ Saved to {output_file}")


def main():
    import sys

    if len(sys.argv) < 2:
        print("Documentation Generator for 68K Assembly")
        print("\nUsage:")
        print("  python3 generate_docs.py <function_name>")
        print("  python3 generate_docs.py --batch <output.json>")
        print("\nExamples:")
        print("  python3 generate_docs.py SendDREQCommand")
        print("  python3 generate_docs.py --batch docs.json")
        sys.exit(1)

    if sys.argv[1] == '--batch':
        gen = DocumentationGenerator()
        output_file = Path(sys.argv[2]) if len(sys.argv) > 2 else Path('function_docs.json')
        gen.batch_generate(output_file)
    else:
        func_name = sys.argv[1]
        gen = DocumentationGenerator()
        header = gen.generate_header(func_name)
        print(header)


if __name__ == '__main__':
    main()
