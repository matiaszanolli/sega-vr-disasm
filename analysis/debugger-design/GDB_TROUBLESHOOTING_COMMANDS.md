# GDB Troubleshooting Commands

## Check Current Execution State

```gdb
# Where is the CPU right now?
(gdb) info registers pc
(gdb) print $pc

# What's the current instruction?
(gdb) x/5i $pc

# Check if code is executing in ROM area (should be 0x020xxxxx)
# If PC is around 0x00900000 or 0x14000000, something's wrong
```

## Verify Breakpoint Addresses

```gdb
# List all breakpoints
(gdb) info breakpoints

# Check if addresses are valid
(gdb) x/10i 0x020243e2
(gdb) x/10i 0x0202441e
(gdb) x/10i 0x0202443a
(gdb) x/10i 0x02024482
```

## Test with Known Function

Instead of VDP polling (which might not be called yet), try func_065 which we know is called frequently:

```gdb
# Clear old breakpoints
(gdb) delete

# Set breakpoint at func_065
(gdb) break *0x02223F2E

# Let it run
(gdb) continue
```

If func_065 breakpoint hits, the addresses are correct and game is running.
If not, the ROM might be loaded at a different address.

## Find Where Code Actually Is

```gdb
# Search for a known instruction pattern
# func_065 starts with: SHLL8 R0 (opcode 4018)
(gdb) find /h 0x02000000, 0x02400000, 0x4018

# Or search for the ROM header
(gdb) x/s 0x02000100
```

## Check if Game is Running

```gdb
# Continue and let game run for 5 seconds
(gdb) continue
# Wait 5 seconds, then Ctrl+C

# Check PC again
(gdb) print $pc

# If PC keeps changing between 0x020xxxxx addresses, game is running
```

## If Nothing Works

The addresses might be from a different analysis. Try profiling with the general approach:

```gdb
# Sample PC every second
(gdb) continue
# Ctrl+C after 1 second
(gdb) print $pc
(gdb) x/10i $pc
# Repeat several times to see execution patterns
```

Save the PC values you see - we can analyze them to find the actual polling loops.
