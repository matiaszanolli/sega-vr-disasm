# Interim Release Notes for Accolade's Sega Development System

**Hardware Revision:** B1
**ROM Monitor:** 3.2
**Debugger:** XDB Debugger 4/16/93
**Author:** Russell Bornsch+
**Date:** 4/19/93

---

## Overview

You should now have in your hot little hands a new Sega Development system. The software and firmware (ROM Monitor 3.2 and XDB Debugger) are *not* finished. For the most part, the development system behaves similarly to the old development system with version 1.6 to 2.0 ROM and SDB. The final Monitor and Debugger will be substantially different.

---

## New Hardware Features

- **16-megabit cartridge RAM** standard for ROM emulation, with 22-, 28-, and 32-megabit configurations optional (2, 2.75, 3.5, and 4 Mbytes).
- **192Kbyte expansion RAM** usable as cartridge-ROM expansion or 8- or 16-bit save-game-EEPROM emulation.
- **64Kbyte system RAM** for use by the ROM monitor. The older development board used cartridge RAM to hold monitor code and data, reducing the memory available to a developer.
- **2 8-bit parallel ports** for PC communication. With a standard PC parallel port, data transfers from the PC to the Sega have been clocked at over 50Kbytes per second. A 8-megabit game can be completely downloaded in under 30 seconds via the primary port.
- **Battery backup** for the cartridge RAM. The system can be completely powered off without losing the cart RAM data. A switch on the board disables the monitor completely, allowing a game to be run in true ROM-emulation without connecting to the PC at all and without interference from the monitor/debugger.
- **On-board MIDI interface.** Musicians will be able to use the development system as a MIDI synthesizer module, allowing them to compose music more quickly and accurately.

---

## Board Layout

The development board includes the following physical features:

- **Extension RAM configuration jumpers**: When EMULS is 0, expansion RAM is 16-bit; when 1, expansion RAM is 8-bit, at odd byte addresses. When SAVE/EXP is 0, expansion RAM is write-protected while a program is running (like cartridge RAM); when 1, expansion RAM is unprotected (like save game EEPROM).
- **MIDI IN/OUT interface connectors**
- **Battery backup** (top of board)
- **Auxiliary parallel port**
- **Main parallel port**: Connect the supplied cable between this connector and a parallel port on the PC. XDB can run on any parallel port, but the default is to use the port at I/O base address $378, which is usually LPT1.
- **PC/Cart mode switch**: When set to PC, the monitor and debugger function normally. When set to Cart, the target program currently loaded in RAM runs immediately, just as if it were an actual game cartridge, and the monitor and debugger do not function.
- **Cartridge edge connector**: Plug this end into the Sega Genesis base unit. Chips should face the front of the base unit.

---

## Setup Instructions

1. Plug the board into a Sega Genesis base unit, with the chips facing the front.
2. Connect the supplied parallel cable from the main parallel port (in the lower right-hand corner of the board) to a free parallel port on your PC. If you have a port with a base address of 378 (usually LPT1), use it; if not, use another.
3. Make sure the PC/Cart switch on the development board is set to PC.
4. The settings of the expansion RAM configuration jumpers doesn't matter at this point.
5. That's all the hardware setup required.

### Verifying Monitor ROM

Switch on the Genesis base unit. If its display is working properly, it should show a colored screen, grayish-green or whatever color is named on the label on the monitor ROM chip. The "produced by or under license..." message may also appear. The colored background indicates that the monitor ROM is working properly.

### Starting XDB

Run XDB from your PC. If necessary, use the /P option to set the base address of the port to use (see the SDB manual). If communication is established between the PC and the Sega, the message "IN MONITOR" will appear at the bottom of the XDB display. From this point, XDB should behave almost exactly like SDB, with the following differences:

- Communication will be much, much faster -- roughly five times as fast as SDB and the old development system. Communication may also be more reliable, with XDB able to recover from "I/O ERROR - SEGA NOT RESPONDING" conditions.
- The battery backup system allows the base unit to be switched off without losing the contents of cartridge RAM.

---

## Known Problems

As noted above, this is an interim release, intended to allow the gee-whiz features of the new system to be used. There will be major modifications made to the monitor and debugger over the next few months to make the system more powerful and reliable. As it stands now, there are known problems with the system, some of which may have been present in the old SDB.

### Breakpoint Handling

Breakpoint handling is imperfect. Temporary breakpoints (set by right-clicking the mouse in the CPU window) may not go away if control is regained through an exception trap or another breakpoint. This may cause program execution to stop unexpectedly later when the temporary breakpoint is hit. This is not usually a serious problem. To help recognize when this happens, the breakpoint list in XDB now shows breakpoint 0, the temporary breakpoint. The command "BD A" (Breakpoint Disable All) erases BP 0. BP 0 still cannot be set or cleared individually.

### VBlank Communication Disruption

Since communication between the monitor and the debugger occurs periodically during vertical blank time when the target program is running, a program which shuts off vertical blank interrupts will disrupt communication between the monitor and the debugger. XDB may print a "SEGA NOT RESPONDING" when this happens. When an exception occurs, a breakpoint is hit, or VBlanks are re-enabled, XDB should be able to regain contact.

### Break Command Issue

The "B" command (Break to monitor) in XDB prints "IN MONITOR" regardless of whether or not it actually succeeded. If communication between the monitor and debugger is disrupted, the "B" command will not actually work, and a "SEGA NOT RESPONDING" message is likely to follow.

---

Please do not hesitate to report any other problems you find. We're here to help. Really.
