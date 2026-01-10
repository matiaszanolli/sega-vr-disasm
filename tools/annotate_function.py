#!/usr/bin/env python3
"""
Selective function annotation tool.

Takes a function address and converts it from dc.w to proper assembly instructions.
Maintains PERFECT MATCH by using the existing m68k_disasm.py decoder.

Usage:
    python3 annotate_function.py 0x4998          # Annotate WaitForVBlank
    python3 annotate_function.py WaitForVBlank   # Annotate by name
"""

import sys
import re
from pathlib import Path

# Import the disassembler
sys.path.insert(0, str(Path(__file__).parent))
from m68k_disasm import M68KDisassembler

# Import function database from inject_labels
from inject_labels import FUNCTION_DATABASE


def find_function_bounds(rom_data, start_offset):
    """
    Find the end of a function by looking for RTS/RTE or next function.

    Returns: end_offset (exclusive)
    """
    disasm = M68KDisassembler(rom_data, start_offset, base_address=0x00880000)
    disasm.offset = start_offset

    # Track all function starts for boundary detection
    all_function_offsets = sorted(FUNCTION_DATABASE.keys())
    next_function = None
    for offset in all_function_offsets:
        if offset > start_offset:
            next_function = offset
            break

    max_search = 0x1000  # Don't search more than 4KB
    search_limit = start_offset + max_search
    if next_function:
        search_limit = min(search_limit, next_function)

    # Scan for RTS/RTE
    current = start_offset
    while current < search_limit and current < len(rom_data):
        try:
            opcode = (rom_data[current] << 8) | rom_data[current + 1]

            # Check for RTS (0x4E75) or RTE (0x4E73)
            if opcode == 0x4E75 or opcode == 0x4E73:
                return current + 2  # Include the RTS/RTE

            # Simple instruction size estimation (advance by 2 bytes minimum)
            # This is crude but works for finding RTS
            current += 2

        except IndexError:
            break

    # If no RTS found, use next function boundary or max search
    if next_function:
        return next_function
    return min(start_offset + max_search, len(rom_data))


def disassemble_function(rom_data, start_offset, end_offset):
    """
    Disassemble a function and return assembly lines.

    Returns: list of (address, instruction_text) tuples
    """
    disasm = M68KDisassembler(rom_data, start_offset, base_address=0x00880000)

    instructions = []

    while disasm.offset < end_offset:
        file_offset = disasm.offset

        try:
            # Use the built-in disassemble_instruction method
            # It returns formatted string with address and instruction
            line = disasm.disassemble_instruction()

            # Parse the line to extract just the instruction part
            # Format: "00XXXXXX  BBBB BBBB ...    INSTRUCTION"
            parts = line.split()
            if len(parts) >= 3:
                # Find where instruction starts (after hex bytes)
                # Look for the first part that doesn't look like hex
                instr_start_idx = 1
                for i in range(1, len(parts)):
                    # Check if this looks like a hex value (4 chars, all hex)
                    if len(parts[i]) != 4 or not all(c in '0123456789ABCDEFabcdef' for c in parts[i]):
                        instr_start_idx = i
                        break

                # Reconstruct instruction
                instruction = ' '.join(parts[instr_start_idx:])

                # Format with proper indentation
                instructions.append((file_offset, f"        {instruction}"))
            else:
                # Fallback
                word = (rom_data[file_offset] << 8) | rom_data[file_offset + 1]
                instructions.append((file_offset, f"        dc.w    ${word:04X}"))
                disasm.offset += 2

        except Exception as e:
            # If decoding fails, fall back to dc.w
            word = (rom_data[file_offset] << 8) | rom_data[file_offset + 1]
            instructions.append((file_offset, f"        dc.w    ${word:04X}"))
            disasm.offset += 2

    return instructions


def get_section_file_for_offset(offset):
    """Get the section file path for a given file offset."""
    # Header section
    if offset < 0x200:
        return Path("disasm/sections/header.asm")

    # Code sections (8KB boundaries starting at $200)
    section_start = ((offset - 0x200) // 0x2000) * 0x2000 + 0x200
    section_name = f"code_{section_start:x}.asm"
    return Path("disasm/sections") / section_name


def annotate_function_in_file(section_file, start_offset, end_offset, instructions, label_name):
    """
    Replace dc.w lines with assembly instructions in the section file.
    """
    if not section_file.exists():
        print(f"Error: Section file not found: {section_file}")
        return False

    content = section_file.read_text()
    lines = content.split('\n')

    # Find the label line
    label_line_idx = None
    for i, line in enumerate(lines):
        if f"{label_name}:" in line:
            label_line_idx = i
            break

    if label_line_idx is None:
        print(f"Error: Label '{label_name}:' not found in {section_file.name}")
        return False

    # Build new content:
    # 1. Keep everything before the label
    # 2. Keep the label line
    # 3. Replace dc.w lines in range with instructions
    # 4. Keep everything after the function

    new_lines = []
    in_function = False
    first_function_line = label_line_idx + 1

    for i, line in enumerate(lines):
        # Before label: keep as-is
        if i <= label_line_idx:
            new_lines.append(line)
            if i == label_line_idx:
                # After label, insert annotated instructions
                for instr_offset, instr_text in instructions:
                    new_lines.append(f"{instr_text}        ; ${instr_offset:06X}")
                in_function = True
            continue

        # Check if this line is within our function range
        match = re.search(r';\s*\$([0-9A-Fa-f]{6})\b', line)
        if match:
            file_offset = int(match.group(1), 16)

            # If we're past the function, start copying again
            if file_offset >= end_offset:
                in_function = False
                new_lines.append(line)
            elif in_function:
                # Skip dc.w lines within function (already replaced)
                pass
            else:
                new_lines.append(line)
        else:
            # Non-dc.w lines (comments, labels, etc.)
            # Check if it's a new label - this means we're past the function
            if ':' in line and not line.strip().startswith(';'):
                in_function = False
            new_lines.append(line)

    # Write updated content
    section_file.write_text('\n'.join(new_lines))
    return True


def annotate_function(function_spec, rom_path="Virtua Racing Deluxe (USA).32x"):
    """
    Annotate a function by address or name.
    """
    # Read ROM
    with open(rom_path, 'rb') as f:
        rom_data = f.read()

    # Resolve function spec to offset
    if isinstance(function_spec, str):
        if function_spec.startswith('0x'):
            # Hex address
            file_offset = int(function_spec, 16)
            # Check if this is in database
            if file_offset in FUNCTION_DATABASE:
                label_name, description = FUNCTION_DATABASE[file_offset]
            else:
                print(f"Warning: Address {function_spec} not in function database")
                label_name = f"func_{file_offset:04X}"
                description = "Unknown function"
        else:
            # Function name - search database
            file_offset = None
            for offset, (name, desc) in FUNCTION_DATABASE.items():
                if name == function_spec:
                    file_offset = offset
                    label_name = name
                    description = desc
                    break

            if file_offset is None:
                print(f"Error: Function '{function_spec}' not found in database")
                return False
    else:
        file_offset = function_spec
        if file_offset in FUNCTION_DATABASE:
            label_name, description = FUNCTION_DATABASE[file_offset]
        else:
            label_name = f"func_{file_offset:04X}"
            description = "Unknown function"

    print(f"Annotating {label_name} at ${file_offset:06X}")
    print(f"Description: {description}")

    # Find function bounds
    end_offset = find_function_bounds(rom_data, file_offset)
    size = end_offset - file_offset
    print(f"Function size: {size} bytes (${file_offset:06X} - ${end_offset:06X})")

    # Disassemble function
    print("Disassembling...")
    instructions = disassemble_function(rom_data, file_offset, end_offset)
    print(f"Generated {len(instructions)} instructions")

    # Get section file
    section_file = get_section_file_for_offset(file_offset)
    print(f"Section file: {section_file}")

    # Annotate in file
    print("Updating section file...")
    success = annotate_function_in_file(section_file, file_offset, end_offset,
                                       instructions, label_name)

    if success:
        print(f"✓ Successfully annotated {label_name}")
        print("\nNext steps:")
        print("  1. Run: make all")
        print("  2. Run: make compare")
        return True
    else:
        print(f"✗ Failed to annotate {label_name}")
        return False


def main():
    if len(sys.argv) < 2:
        print("Usage: annotate_function.py <address|function_name>")
        print("\nExamples:")
        print("  python3 annotate_function.py 0x4998")
        print("  python3 annotate_function.py WaitForVBlank")
        print("\nAvailable functions:")

        # Show first 10 functions from database
        for i, (offset, (name, desc)) in enumerate(sorted(FUNCTION_DATABASE.items())[:10]):
            print(f"  ${offset:06X}  {name:30s}  {desc}")
        print(f"  ... and {len(FUNCTION_DATABASE) - 10} more")
        sys.exit(1)

    function_spec = sys.argv[1]
    success = annotate_function(function_spec)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
