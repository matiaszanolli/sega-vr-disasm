# Modules Directory - Feature-Wise Organization

This directory contains the refactored, feature-organized version of the VRD 32X disassembly.

## Structure

- **68k/** - Motorola 68000 CPU code organized by subsystem
- **sh2/** - Hitachi SH2 CPU code (Master & Slave)
- **shared/** - Common definitions, constants, and macros

## Build System

Use `make modular` to build from this directory structure.
Use `make all` to build from the original sections/ directory.

Both should produce byte-identical ROMs.

**Status**: Phase 1 - Infrastructure setup in progress
