# 68K Modules Directory

821 modularized 68K functions organized by subsystem across 17 categories and 15 game subcategories.

## Structure

- **68k/** — Motorola 68000 CPU code organized by subsystem (821 module files)
- **shared/** — Common definitions, constants, and macros ([definitions.asm](shared/definitions.asm))

## Translation Status (v6.0.0)

| Metric | Value |
|--------|-------|
| Total module files | 821 |
| Fully translated (no dc.w) | 530 (64.6%) |
| dc.w lines converted | 5,504 of 8,226 (66.9%) |
| Remaining dc.w | 2,722 (data tables + unlabeled targets) |

Translation tool: `python3 tools/translate_68k_modules.py --phase2 --batch disasm/modules/68k/`

## Categories

| Category | Purpose |
|----------|---------|
| boot | Initialization, adapter init |
| display | Display list, screen rendering |
| frame | Frame management |
| game | Game logic (15 subcategories, see below) |
| graphics | Graphics primitives |
| hardware-regs | Hardware register access |
| input | Controller I/O |
| main-loop | V-INT handler, main loop |
| math | Trigonometry, fixed-point arithmetic |
| memory | Memory management |
| object | Object system |
| optimization | FPS counter, performance hooks |
| sh2 | SH2 communication (command submission) |
| sound | Sound driver interface |
| util | Utility functions |
| vdp | VDP register access |
| vint | V-INT sub-handlers |

### Game Subcategories (`68k/game/`)

| Subcategory | Count | Purpose |
|-------------|-------|---------|
| ai | 25 | AI behavior, steering, opponent logic |
| camera | 29 | Camera setup, positioning, scrolling |
| collision | 23 | Collision detection, proximity checks |
| data | 16 | Decompression, lookup tables |
| entity | 34 | Entity/object management, spawning |
| hud | 28 | HUD, score display, digit rendering |
| menu | 115 | Menu, name entry, mode selection, UI |
| physics | 50 | Speed, acceleration, braking, tilt |
| race | 50 | Race state, lap tracking, sound triggers |
| render | 80 | Visibility, depth sort, VDP, DMA, sprites |
| scene | 52 | Scene init, SH2 communication, transitions |
| sound | 67 | FM/PSG sound driver functions |
| state | 101 | State dispatchers, counters, flags, timers |
| track | 4 | Track data, segment operations |

## Build System

All modules are included via section files in `disasm/sections/`. Build with `make all`.
