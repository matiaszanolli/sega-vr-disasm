# Setup Guide

This guide walks you through setting up the Virtua Racing Deluxe disassembly project from scratch.

## Prerequisites

### 1. System Tools

**Linux/WSL:**
```bash
sudo apt-get update
sudo apt-get install build-essential python3 wget
```

**macOS:**
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Python 3 should be pre-installed
# If not, install via Homebrew:
brew install python3
```

### 2. Obtain the ROM

**⚠️ IMPORTANT**: You must legally own Virtua Racing Deluxe for Sega 32X.

You need to create a ROM dump from your legitimate cartridge:
- File name: `Virtua Racing Deluxe (USA).32x`
- Expected size: 3,145,728 bytes
- Expected MD5: `72b1ad0f949f68da7d0a6339ecd51a3f`

**Verify your ROM:**
```bash
md5sum "Virtua Racing Deluxe (USA).32x"
# Should output: 72b1ad0f949f68da7d0a6339ecd51a3f
```

If the MD5 doesn't match, you have the wrong version or a corrupted dump.

## Installation Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd 32x-playground
```

### 2. Add Your ROM

Place your ROM file in the root directory:
```bash
# Copy your ROM to the project directory
cp /path/to/your/rom/Virtua\ Racing\ Deluxe\ \(USA\).32x .

# Verify it's correct
md5sum "Virtua Racing Deluxe (USA).32x"
```

### 3. Build the Assembler

The project needs vasm (Motorola 68000 assembler). Build it from source:

```bash
make tools
```

This will:
- Download vasm source code
- Compile it for M68K CPU with Motorola syntax
- Install the binary to `tools/vasmm68k_mot`

**Expected output:**
```
==> Building vasm assembler...
[compilation messages...]
✓ vasm built successfully
```

### 4. Generate the Binary Blob

Extract the remainder of the ROM (everything after the header):

```bash
dd if="Virtua Racing Deluxe (USA).32x" of=disasm/rom_data_remainder.bin bs=1 skip=512
```

**Expected output:**
```
3145216+0 records in
3145216+0 records out
3145216 bytes (3.1 MB, 3.0 MiB) copied, X.XX s, XX.X MB/s
```

### 5. Build the ROM

```bash
make all
```

**Expected output:**
```
==> Assembling 68000 code...
==> Build complete: build/vr_rebuild.32x
-rw-rw-r-- 1 user user 3.0M <date> build/vr_rebuild.32x
```

### 6. Verify the Build

Check that the rebuilt ROM matches the original:

```bash
make compare
```

Or manually verify:
```bash
md5sum "Virtua Racing Deluxe (USA).32x" build/vr_rebuild.32x
```

Both should show: `72b1ad0f949f68da7d0a6339ecd51a3f`

**✅ If they match, you're done! The ROM builds perfectly.**

## Troubleshooting

### "ROM file not found"
- Make sure the ROM is named exactly: `Virtua Racing Deluxe (USA).32x`
- Check it's in the root directory of the project
- Verify with: `ls -lh "Virtua Racing Deluxe (USA).32x"`

### "MD5 mismatch"
- You may have a different version (PAL, Japan, or modified)
- This project specifically targets the USA version
- Check the file size: should be exactly 3,145,728 bytes

### "vasm not found" or build errors
- Run `make tools` to rebuild the assembler
- Make sure you have GCC installed: `gcc --version`
- Check build output for specific errors

### "Permission denied" when building
- Make sure you have write permissions in the project directory
- The project does NOT require sudo for any operations

### "Binary blob not found"
- Run the dd command from step 4 again
- Make sure the `disasm/` directory exists
- Check: `ls -lh disasm/rom_data_remainder.bin`

## Project Structure After Setup

```
32x-playground/
├── Virtua Racing Deluxe (USA).32x  ← Your ROM (not in git)
├── disasm/
│   ├── m68k_header.asm
│   └── rom_data_remainder.bin      ← Generated (not in git)
├── tools/
│   └── vasmm68k_mot                ← Built (not in git)
└── build/
    └── vr_rebuild.32x              ← Output (not in git)
```

## Next Steps

Once setup is complete:

1. **Explore the disassembly:**
   ```bash
   cat disasm/m68k_header.asm
   ```

2. **Try the analysis tools:**
   ```bash
   make analyze        # Analyze ROM structure
   make disasm         # Disassemble sections
   ```

3. **Read the documentation:**
   - [PROGRESS.md](PROGRESS.md) - What's been accomplished
   - [docs/](docs/) - 32X hardware documentation
   - [analysis/](analysis/) - ROM structure analysis

## Common Commands

```bash
make all          # Build ROM
make clean        # Clean build artifacts
make compare      # Verify ROM matches
make tools        # Rebuild assembler
make help         # Show all targets
```

## Getting Help

If you encounter issues:

1. Check this troubleshooting section
2. Review the [README.md](README.md)
3. Examine build output for specific error messages
4. Ensure all prerequisites are installed

## Legal Notes

- This project is for educational and preservation purposes
- No copyrighted game code is included in this repository
- You must own a legal copy of the game
- Creating ROM dumps for personal backup is generally legal
- Distribution of ROM files is NOT legal

---

**Happy disassembling!** 🎮
