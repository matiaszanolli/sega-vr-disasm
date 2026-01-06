# Frame Counter Implementation Plan

**Date:** 2026-01-06
**Purpose:** Add on-screen FPS counter to measure optimization impact
**Priority:** HIGH - Critical for validating optimizations

---

## Why We Need This

Since GDB profiling is blocked by Gens emulator bugs, we need a simple, reliable way to measure performance improvements. An on-screen frame counter gives us:

1. **Direct FPS measurement** - See exact frame rate during gameplay
2. **No emulator dependency** - Works on any emulator or real hardware
3. **Real-time feedback** - Instant validation of optimizations
4. **Simple implementation** - Can be added with minimal code injection

---

## Implementation Strategy

### Approach: VBlank Counter + On-Screen Display

**Basic Concept:**
1. Increment a counter on every VBlank
2. Every 60 VBlanks (1 second), calculate FPS
3. Display FPS value in frame buffer corner

### Memory Requirements

- **4 bytes** - Frame counter (increments every VBlank)
- **4 bytes** - Last second timestamp
- **4 bytes** - Current FPS value
- **~100 bytes** - Display routine code

**Total:** ~112 bytes

### Where to Inject Code

From our interrupt analysis, we know:
- **VBlank polling happens** at multiple locations (0x243E2, 0x2441E, 0x2443A, 0x024482)
- **No VBlank interrupt handler exists** - IRQ vectors are NULL
- **Main loop location** - Can insert counter increment

---

## Implementation Steps

### Step 1: Allocate Counter Variables in RAM

**Location:** Use SDRAM (0x22000000-0x2203FFFF range, cache-through)

```asm
; Frame counter variables (in SDRAM)
frame_counter:      .long   0    ; 0x22000100 - counts every frame
last_second_frame:  .long   0    ; 0x22000104 - frame count 1 second ago
current_fps:        .long   0    ; 0x22000108 - calculated FPS
```

### Step 2: Increment Counter on VBlank

**Injection Point:** Right after VBlank polling loop completes

**Original code at 0x243E2:**
```asm
022243E2  8515     MOV.B   R0,@($5,R5)
022243E4  C802     TST     #$02,R0         ; Check VBlank status bit
022243E6  8BFC     BF      $022243E2       ; Loop until VBlank
022243E8  000B     RTS
```

**Modified code:**
```asm
022243E2  8515     MOV.B   R0,@($5,R5)
022243E4  C802     TST     #$02,R0         ; Check VBlank status bit
022243E6  8BFC     BF      $022243E2       ; Loop until VBlank
; NEW CODE - Increment frame counter
022243E8  D1XX     MOV.L   @(frame_counter_addr,PC),R1
022243EA  6012     MOV.L   @R1,R0
022243EC  7001     ADD     #1,R0
022243EE  2102     MOV.L   R0,@R1
; Check if 60 frames passed (1 second at 60 FPS)
022243F0  D1XX     MOV.L   @(last_second_addr,PC),R1
022243F2  6112     MOV.L   @R1,R1
022243F4  3014     SUB     R1,R0           ; frames_elapsed = current - last
022243F6  883C     CMP/GE  #60,R0          ; >= 60 frames?
022243F8  8B0X     BF      skip_fps_calc
; Calculate FPS (frames passed in last second)
022243FA  D1XX     MOV.L   @(current_fps_addr,PC),R1
022243FC  2102     MOV.L   R0,@R1          ; Store FPS
022243FE  D1XX     MOV.L   @(frame_counter_addr,PC),R1
02224400  6012     MOV.L   @R1,R0
02224402  D1XX     MOV.L   @(last_second_addr,PC),R1
02224404  2102     MOV.L   R0,@R1          ; Update last_second
skip_fps_calc:
02224406  000B     RTS
```

### Step 3: Display FPS on Screen

**Approach:** Draw simple digits in frame buffer corner

**Font Data:**
- Use 8×8 pixel digit bitmaps (0-9)
- White pixels for visibility
- Top-left corner (less likely to be overwritten)

**Display Routine:**
```asm
DisplayFPS:
    ; Load current FPS value
    MOV.L   @(current_fps_addr,PC),R1
    MOV.L   @R1,R0              ; R0 = FPS value (0-99)

    ; Extract tens digit
    MOV     R0,R2
    MOV     #10,R1
    ; Division by 10 (no DIV instruction on SH2 - use lookup or shift)
    ; For simplicity, use lookup table for 0-99

    ; Get digit bitmaps
    MOV.L   @(digit_font_table,PC),R3
    ; ... draw tens digit at (4,4)
    ; ... draw ones digit at (12,4)

    RTS
    NOP

digit_font_table:
    ; 8x8 bitmaps for digits 0-9
    ; Each digit is 8 bytes (8 rows, 1 byte per row)
    .byte   0x3C,0x66,0x6E,0x76,0x66,0x66,0x3C,0x00  ; 0
    .byte   0x18,0x38,0x18,0x18,0x18,0x18,0x7E,0x00  ; 1
    .byte   0x3C,0x66,0x06,0x0C,0x18,0x30,0x7E,0x00  ; 2
    ; ... digits 3-9
```

### Step 4: Integrate Display Call

**Injection Point:** Right after frame buffer swap

Call DisplayFPS after the frame is ready to be drawn to, so the counter appears on screen.

---

## Alternative: Simpler Approach

If font rendering is too complex, we can use **color-coded performance bars**:

**Visual FPS Indicator:**
```
Green bar (full width) = 60 FPS
Yellow bar (75% width) = 45 FPS
Orange bar (50% width) = 30 FPS
Red bar (40% width)    = 24 FPS
```

**Code:**
```asm
DisplayFPSBar:
    MOV.L   @(current_fps_addr,PC),R1
    MOV.L   @R1,R0              ; R0 = FPS

    ; Calculate bar width: width = FPS * 4 (max 240 pixels at 60 FPS)
    SHLL2   R0                  ; width = FPS * 4
    MOV     R0,R2               ; R2 = bar width

    ; Set color based on FPS
    CMP/GT  #50,R0
    BT      green_bar           ; >= 50 FPS = green
    CMP/GT  #35,R0
    BT      yellow_bar          ; >= 35 FPS = yellow
    CMP/GT  #25,R0
    BT      orange_bar          ; >= 25 FPS = orange
    ; else red
red_bar:
    MOV.W   #0x001F,R3          ; Red (RGB 5:5:5 format)
    BRA     draw_bar
    NOP
yellow_bar:
    MOV.W   #0x03E0,R3          ; Yellow
    BRA     draw_bar
    NOP
green_bar:
    MOV.W   #0x03E0,R3          ; Green

draw_bar:
    ; Draw horizontal bar at top of screen
    MOV.L   #0x24000000,R4      ; Frame buffer start
    MOV     #240,R5             ; Screen width

draw_loop:
    MOV.W   R3,@R4              ; Write color pixel
    ADD     #2,R4               ; Next pixel (2 bytes in RGB mode)
    DT      R2                  ; Decrement width counter
    BF      draw_loop           ; Loop until width = 0

    RTS
    NOP
```

---

## Testing Plan

### Step 1: Baseline Measurement
1. Add frame counter to **unmodified** VR ROM
2. Run game for 30 seconds
3. Record FPS (should be ~24 FPS)

### Step 2: Test Optimizations
1. Apply optimization patch (VDP interrupt, Slave CPU, etc.)
2. Run patched ROM for 30 seconds
3. Record FPS (target: 60 FPS)
4. Calculate improvement: (new_fps / old_fps) × 100%

### Step 3: Validation
- FPS should be stable (not fluctuating wildly)
- Higher FPS = smoother gameplay
- Compare against emulator's built-in FPS counter if available

---

## Implementation Priority

**Phase 1 (Immediate):**
- ✅ Add frame counter increment
- ✅ Add simple color bar FPS indicator
- Test on Gens emulator

**Phase 2 (If needed):**
- Add digit font rendering for exact FPS number
- Add average/min/max FPS tracking
- Add frame time graph

**Phase 3 (Nice to have):**
- Add CPU usage bars (Master SH2, Slave SH2, 68K)
- Add VDP wait time indicator
- Add memory usage stats

---

## Code Injection Tool

We'll create a Python tool to inject the frame counter code:

**Tool:** `tools/add_frame_counter.py`

**Usage:**
```bash
python3 tools/add_frame_counter.py \
    "Virtua Racing Deluxe (USA).32x" \
    "Virtua Racing Deluxe (USA) - FPS Counter.32x"
```

**What it does:**
1. Read original ROM
2. Find VBlank polling loop
3. Inject frame counter code
4. Inject display routine
5. Write modified ROM

---

## Expected Results

**Before Optimization:**
- FPS: ~24 (current performance)
- Bar: Red/Orange

**After VDP Interrupt Optimization:**
- FPS: ~40-50 (estimate)
- Bar: Yellow/Green

**After Full Optimization (VDP + Slave CPU + 68K sync):**
- FPS: ~60 (target)
- Bar: Full green

---

## Next Steps

1. Create `tools/add_frame_counter.py` injection tool
2. Test frame counter on unmodified ROM
3. Validate FPS reading matches expected 24 FPS
4. Use as baseline for measuring optimization improvements

---

**Status:** Ready to implement
**Estimated Time:** 1-2 hours to write injection tool
**Risk:** Low - simple code injection, non-destructive
