# Master Function Reference
**Virtua Racing Deluxe — Complete 68K + SH2 Function Catalog**

> **Auto-generated** from module header comments via `tools/extract_function_docs.py`.
> Regenerate after adding/editing module headers: `python3 tools/extract_function_docs.py`
>
> **799 68K entries** extracted from `disasm/modules/68k/` headers.
> **SH2 functions** (92 total, all integrated): see [SH2_3D_FUNCTION_REFERENCE.md](sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md) — that document has pseudo-code, cycle estimates, and optimization notes not reproduced here. See also [SH2_TRANSLATION_INTEGRATION.md](sh2-analysis/SH2_TRANSLATION_INTEGRATION.md) for build integration details.
> **Frame execution context**: see [SYSTEM_EXECUTION_FLOW.md](SYSTEM_EXECUTION_FLOW.md) — when/why each subsystem runs.
> **Quick address lookup**: see [FUNCTION_QUICK_LOOKUP.md](FUNCTION_QUICK_LOOKUP.md) — flat sorted list, ctrl+F friendly.

---

## Table of Contents

- [Boot](#boot) (4 functions)
- [Display](#display) (12 functions)
- [Frame](#frame) (2 functions)
- [Game / Ai](#game--ai) (25 functions)
- [Game / Camera](#game--camera) (29 functions)
- [Game / Collision](#game--collision) (23 functions)
- [Game / Data](#game--data) (16 functions)
- [Game / Entity](#game--entity) (34 functions)
- [Game / Hud](#game--hud) (28 functions)
- [Game / Menu](#game--menu) (115 functions)
- [Game / Physics](#game--physics) (50 functions)
- [Game / Race](#game--race) (50 functions)
- [Game / Render](#game--render) (80 functions)
- [Game / Scene](#game--scene) (52 functions)
- [Game / Sound](#game--sound) (67 functions)
- [Game / State](#game--state) (101 functions)
- [Game / Track](#game--track) (4 functions)
- [Graphics](#graphics) (4 functions)
- [Hardware Regs](#hardware-regs) (2 functions)
- [Input](#input) (11 functions)
- [Main Loop](#main-loop) (1 functions)
- [Math](#math) (9 functions)
- [Memory](#memory) (7 functions)
- [Object](#object) (11 functions)
- [Optimization](#optimization) (4 functions)
- [Sh2](#sh2) (8 functions)
- [Sound](#sound) (27 functions)
- [Util](#util) (7 functions)
- [Vdp](#vdp) (15 functions)
- [Vint](#vint) (1 functions)

---

## Boot

### ROM Header and Exception Vector Table ($000000-$0001FF) ($000000–$0001FF, 511 bytes)

Contains 68000 exception vectors and SEGA standard header. Pure dc.w for byte-perfect ROM rebuild. Critical Vectors: $000000-$000003: Initial SSP (Stack Pointer) = $01000000 $000004-$000007: Reset Vector (Initial PC) = $000003F0 $000078-$00007B: V-INT Handler = $00001684 $000072-$000073: H-INT Handler = $0000170A ROM Header ($000100-$0001FF): Console: "SEGA 32X U" Title: "(C)SEGA 1994.SEP" Domestic: "V.R.DX" Overseas: "V.R.DX" Serial: "GM MK-84601-00" Region: "U" (USA) Dependencies: None (this is the entry point)

*Source: [rom_header.asm](disasm/modules/68k/boot/rom_header.asm)*

---

### 32X Adapter Initialization ($000838-$000C59) ($000838–$000C59, 1057 bytes)

Initializes the 32X adapter hardware after ROM entry point. This includes: - Setting up the adapter control register at $A15100 - Configuring VDP access mode - Establishing communication registers with SH2 processors - Setting up interrupt vectors for 32X mode $A15100 - Adapter control register (FM/CART enable, reset control) Bit 0: FM (enable 32X mode) Bit 1: CART (enable 32X ROM access) Bit 7: ADEN (adapter enable) $A15104 - Interrupt mask register $A1512C - COMM6 (SH2 ready/handshake flag) After adapter_init: $000000-$3FFFFF = Cartridge ROM (via 32X) $880000-$8FFFFF = Cartridge ROM (68K direct, same as $000000-$07FFFF) $A00000-$A0FFFF = Z80 area $A10000-$A1001F = I/O ports $A15100-$A1512F = 32X registers $C00000-$C0001F = VDP $FF0000-$FFFFFF = Work RAM 1. Check adapter presence (bit test at $A15101) 2. If not in 32X mode, loop waiting for FM enable 3. Configure VDP for 32X compatibility 4. Set up communication registers 5. Initialize interrupt vectors 6. Jump to main initialization Dependencies: None (first code to run after reset) Related: ROM header ($000100-$0001FF), entry_point ($000200) Format: Proper mnemonics with original bytes in comments for verification

- **Entry**: Called from entry_point ($000200) via JMP $00880838 (after 32X address remap)
*Source: [adapter_init.asm](disasm/modules/68k/boot/adapter_init.asm)*

---

### Init Sequence

*Source: [init_sequence.asm](disasm/modules/68k/boot/init_sequence.asm)*

---

### Ring Buffer Initialization ($TBD)

Initializes the async command queue ring buffer in SDRAM. Must be called during boot after SDRAM is available. RING BUFFER LAYOUT (Cache-Through SDRAM) $2203F000-$2203F1FF: Ring buffer entries (64 × 8 bytes = 512 bytes) $2203F200: Head pointer (32-bit, 68K write index) $2203F204: Tail pointer (32-bit, Master SH2 read index) Each entry format: [cmd:16][param1:16][param2:16][param3:16] = 8 bytes CALLING CONVENTION Called from: adapter_init (after SH2 ready signal) Parameters: None CRITICAL This MUST be called before any async command submission. Both CPUs rely on head/tail pointers being zero at startup. Related: sh2_send_cmd_async, cmdint_handler, queue_processor

- **Returns**: Nothing Clobbers: A0
*Source: [ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm)*

---

## Display

### Set Display Flag $01 ($00246C–$002472, 8 bytes)

Sets display mode flag at $8507 to $01.

- **Entry**: none
- **Modifies**: none
*Source: [set_flag_8507_01.asm](disasm/modules/68k/display/set_flag_8507_01.asm)*

---

### Set Display Flag $80 ($002474–$00247A, 8 bytes)

Sets display mode flag at $8507 to $80.

- **Entry**: none
- **Modifies**: none
*Source: [set_flag_8507_80.asm](disasm/modules/68k/display/set_flag_8507_80.asm)*

---

### VDP Operations and Synchronization ($0027F8-$002982) ($0027F8–$002982, 394 bytes)

Core VDP (Video Display Processor) functions for 32X frame buffer management, palette operations, and SH2 synchronization via COMM ports and FIFO. Functions: - VDPFill: Auto-fill 16 blocks using MARS VDP fill hardware - VDPPrep: Prepare VDP registers for fill operation - VDPOp4: Copy palette data to VDP palette RAM (32 iterations) - MemoryOp3: Copy data to COMM port area (8 iterations) - PaletteRAMCopy: V-INT state 6 palette RAM copy with COMM sync - VDPSyncSH2: Synchronize with SH2 via COMM ports, transfer data via FIFO Hardware Used: - MARS_VDP_FILLADR: VDP auto-fill start address register - MARS_VDP_FILLDATA: VDP auto-fill data register - MARS_DREQ_LEN: DMA request length - MARS_FIFO: FIFO data register for 68K<->SH2 transfer - MARS_SYS_BASE: 32X system register base - COMM ports: Communication with SH2 CPUs Dependencies: modules/shared/definitions.asm (hardware register equates) Originally at $0027F8-$002982 in sections/code_2200.asm

*Source: [vdp_operations.asm](disasm/modules/68k/display/vdp_operations.asm)*

---

### Camera Offset Check (2-Player) ($003116–$003124, 16 bytes)

In 2-player mode, adds $40 vertical offset to camera position.

- **Entry**: none
- **Modifies**: none (only modifies memory)
*Source: [camera_offset_check.asm](disasm/modules/68k/display/camera_offset_check.asm)*

---

### Scroll Update Animation ($004300–$00432E, 46 bytes)

Updates scroll animation on sprite at $FF6754. Increments scroll counter, updates sprite position/attributes, advances state when scroll reaches $100.

- **Entry**: none
- **Modifies**: D0, A2
*Source: [scroll_update.asm](disasm/modules/68k/display/scroll_update.asm)*

---

### Fade Subtract Array (Palette Fade-Out) ($00434A–$004384, 58 bytes)

Performs palette fade-out by subtracting 30 from 8 palette entries (spaced 16 bytes apart at $FF6802). Up to 10 steps. When done (step > 10), branches to advance_clear_timer (next function).

- **Entry**: none
- **Modifies**: D0, A2
*Source: [fade_subtract_array.asm](disasm/modules/68k/display/fade_subtract_array.asm)*

---

### Set Effect Flag and Clear Sprite ($004556–$004566, 16 bytes)

Sets effect code $AB and disables sprite at $FF6940.

- **Entry**: none
- **Modifies**: none
*Source: [set_flag_clear_sprite.asm](disasm/modules/68k/display/set_flag_clear_sprite.asm)*

---

### Scroll Limit Update (Sprite Y Clamp) ($00465C–$004682, 38 bytes)

Scrolls sprite upward by 10/frame, clamping at Y=230. Advances state when limit reached.

- **Entry**: A0 = entity
- **Modifies**: A2
*Source: [scroll_limit_update.asm](disasm/modules/68k/display/scroll_limit_update.asm)*

---

### Visibility Flag Set (Sprite Enable) ($004682–$004696, 20 bytes)

Sets sprite visibility at $FF69E0 based on bit 2 of $C8AB. If flag set: hidden (0). If clear: visible (7).

- **Entry**: none
- **Modifies**: D0
*Source: [visibility_flag_set.asm](disasm/modules/68k/display/visibility_flag_set.asm)*

---

### Scroll Variables & Display Parameters ($004998 - $004A30) ($004998–$004A30, 152 bytes)

Functions for managing scroll position variables, display limits, and V-blank synchronization. Used to reset/initialize viewport parameters between screens or race restarts. MEMORY | Address | Name         | Purpose                      | |---------|--------------|------------------------------| | $C86C   | SCROLL_VAR1  | Scroll variable 1 (word)     | | $C86E   | SCROLL_VAR2  | Scroll variable 2 (word)     | | $C87A   | VBLANK_FLAG  | V-blank wait flag (word)     | | $C970   | SCROLL_LIMIT1| Scroll limit 1 (long)        | | $C974   | SCROLL_LIMIT2| Scroll limit 2 (long)        | Dependencies: V-INT handler clears VBLANK_FLAG Related: camera.asm, vdp_operations.asm, vint_handler.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [scroll.asm](disasm/modules/68k/display/scroll.asm)*

---

### Counter Increment and Set Display Size ($005772–$005780, 14 bytes)

Advances sub-state counter by 4 and sets display viewport size.

- **Entry**: none
- **Modifies**: none
*Source: [counter_inc_display.asm](disasm/modules/68k/display/counter_inc_display.asm)*

---

### Palette Table Init ($00F88C–$00F8F6, 106 bytes)

Initializes palette table regions. Sets up A0=$84A2, A1=$84C2, A2=$84E2, clears 8 entries at $2000 offset, selects table by D0, reads index from ($A012), copies 8 entries from ROM table, wraps index.

- **Entry**: D0 = table selector (0=A, nonzero=B)
- **Modifies**: D0, D1, D2, A0-A3
*Source: [palette_table_init.asm](disasm/modules/68k/display/palette_table_init.asm)*

---

## Frame

### Frame Sync & Communication Utilities ($00203A - $00207E) ($00203A–$00207E, 68 bytes)

Functions for frame synchronization between 68K and SH2, plus related communication variable management. Used at frame boundaries. MEMORY MAP | Address    | Name              | Purpose                       | |------------|-------------------|-------------------------------| | $FFFFC822  | COMM_FLAG_LO      | Communication flag (low byte) | | $FFFFC823  | COMM_FLAG_HI      | Communication flag (high byte)| | $FFFFC8A2  | COMM_STATUS       | Communication status word     | | $FFFFC8A4  | COMM_DATA         | Communication data word/long  | | $FFFF8504  | SOUND_PORT_A      | Z80 sound port A              | | $FFFF8506  | SOUND_PORT_B      | Z80 sound port B              | Dependencies: V-INT handler, SH2 communication Related: sh2_communication.asm, vint_handler.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [frame_sync.asm](disasm/modules/68k/frame/frame_sync.asm)*

---

### Wait For V-Blank ($004998–$0049AA, 18 bytes)

Waits for V-blank by setting flag and spinning until V-INT clears it. Lowers interrupt priority to level 3 to allow V-INT.

- **Entry**: none
- **Modifies**: SR (temporarily set to $2300)
*Source: [wait_for_vblank.asm](disasm/modules/68k/frame/wait_for_vblank.asm)*

---

## Game / Ai

### steering_calc_reg_safe_wrapper ($006D8C–$006D9C, 16 bytes)

Steering Calculation Register-Safe Wrapper Saves all 15 registers (D0-D7/A0-A6) to stack, calls calc_steering at $006F98, then restores all registers. Allows steering calculation without clobbering caller's register state.

- **Entry**: A0 = entity base pointer (passed through to calc_steering)
- **Modifies**: (all preserved)
- **Confidence**: high
*Source: [steering_calc_reg_safe_wrapper.asm](disasm/modules/68k/game/ai/steering_calc_reg_safe_wrapper.asm)*

---

### AI Steering Angle Calc 026 ($008D62–$008DC0, 94 bytes)

Calculates steering angle from position delta + cosine lookup Calls ai_steering_calc, cosine_lookup, then computes final angle

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, D2, D3, A0
- **Calls**: $00A7A0: ai_steering_calc $008F4E: cosine_lookup $00A7A4: ai_angle_finalize Object fields (A0): +$30: x_position +$32: z_position +$34: y_position
- **RAM**: $C0BA: waypoint_x $C0BC: waypoint_z $C0BE: waypoint_y $C0C0: steering_angle $C0C2: angle_temp
- **Confidence**: medium
*Source: [ai_steering_angle_calc_026.asm](disasm/modules/68k/game/ai/ai_steering_angle_calc_026.asm)*

---

### AI Steering Calculation + Negate ($008EB6–$008ED6, 32 bytes)

Calculates relative angle between viewport and object position, subtracts quarter turn ($4000), negates result → stores as heading in $C0C2. Similar to calculate_relative_pos_negate but uses $C0BA/$C0BE viewport instead of direct obj fields.

- **Entry**: A0 = object pointer
- **Modifies**: D0, D1, D2, D3
- **Calls**: $00A7A0: ai_steering_calc (D0=refX, D1=refY, D2=objX, D3=objY → D0=angle)
- **RAM**: $C0BA: viewport X reference (word) $C0BE: viewport Y reference (word) $C0C2: calculated heading result (word)
- **Object fields**: +$30: x_position (word) +$34: y_position (word)
*Source: [ai_steering_calc_negate.asm](disasm/modules/68k/game/ai/ai_steering_calc_negate.asm)*

---

### AI Steering Angle + Distance Computation ($008EFC–$008F4E, 82 bytes)

Computes AI steering angle: loads target position ($C0BA/$C0BE), calls ai_steering_calc ($00A7A0) with object position (A0+$30/$34). Subtracts $4000 (90°) and negates for cosine angle, calls cosine_lookup ($008F4E). Computes forward distance ratio: (Y_diff × 256) / cosine, multiplied by VDP scale ($FF5000), stored to $C0C6.

- **Modifies**: D0, D1, D2, D3, A0
- **Calls**: $008F4E: cosine_lookup $00A7A0: ai_steering_calc Object (A0): +$30: x_position (word) +$34: y_position (word)
- **RAM**: $C0BA: target_x (word) $C0BE: target_y (word) $C0C6: forward_distance (word)
*Source: [ai_steering_angle_distance_calc.asm](disasm/modules/68k/game/ai/ai_steering_angle_distance_calc.asm)*

---

### Suspension Steering Damping ($009802–$00987E, 124 bytes)

Dispatches via 3-entry jump table indexed by race_substate_b. State 0 handler: applies steering damping based on lateral velocity ($004C field). If velocity and steering indicators are non-zero, uses ASR-based damping. Otherwise applies decay by subtracting 1/4 of current value, clamping to zero when small enough.

- **Entry**: A0 = object pointer (+$4C, +$62, +$88, +$92, +$94, +$96)
- **Modifies**: D0, D1, D4, A0, A1, A2
- **RAM**: $C8CC: race_substate_b (jump table index: 0/4/8)
*Source: [suspension_steering_damping.asm](disasm/modules/68k/game/ai/suspension_steering_damping.asm)*

---

### AI Opponent Select ($00A434–$00A46E, 60 bytes)

Conditionally activates AI opponent targeting based on game mode, entity speed class, game state, and cooldown timer. Sets a category flag based on whether the entity's speed index exceeds a high-speed threshold.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0 Fields accessed: A0+$04: Speed table index A0+$86: AI cooldown timer (set to 15 when triggered) A0+$BE: Opponent category flag (0=normal, 1=high-speed)
- **RAM**: ($C8C8).W: Mode flag (skip if == 1) ($C319).W: Game state byte (require == 4) ($C8A4).W: AI behavior trigger (set to $B7)
*Source: [ai_opponent_select.asm](disasm/modules/68k/game/ai/ai_opponent_select.asm)*

---

### AI Steering Calculation ($00A7A0–$00A7E0, 66 bytes)

Computes a steering angle from relative position deltas using an arctangent approximation. Returns a 16-bit angle in the range $0000-$FFFF (65536 = 360).

- **Entry**: D0 = entity Y position, D1 = entity X position D2 = target Y position, D3 = target X position
- **Returns**: D0 = steering angle
- **Modifies**: D0, D1, D2, D3, D6 (preserved via stack)
- **Calls**: atan2_lookup ($8FC8)
*Source: [ai_steering_calc.asm](disasm/modules/68k/game/ai/ai_steering_calc.asm)*

---

### ai_entity_main_update_orch ($00A972–$00AC3E, 716 bytes)

AI Entity Main Update Orchestrator Main per-frame update for AI entities. Handles spawn positioning with distance-based approach ramp, heading calculation via ai_steering_calc, speed convergence toward target, movement integration via position_update. Multiple entry points for different AI states: initial spawn, approach, active racing, and finish/retirement. Manages race table slots and mode flags.

- **Entry**: A0 = AI entity pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1
- **Calls**: $003C7E (player_table_setup), $006FDE (position_update), $009B12 (movement_calc), $00A1FC (race_state_read), $00A7A0 (ai_steering_calc), $00ACC0 (race_mode_flag_set)
- **Object fields**: +$02 flags, +$04 speed, +$06 display speed, +$14 timer, +$30 x_pos, +$34 y_pos, +$3C heading, +$40 target heading, +$46 turn rate, +$7A gear, +$8E steer vel, +$90 drift, +$AE slot index, +$B0 spawn timer, +$B8 trail, +$BC decel
- **Confidence**: high
*Source: [ai_entity_main_update_orch.asm](disasm/modules/68k/game/ai/ai_entity_main_update_orch.asm)*

---

### AI Target Check ($00ACD4–$00AD12, 62 bytes)

Checks entity conditions then calls a validation routine for two entity slots. If either slot check returns NE, falls through past RTS into the next function at $AD14 (conditional chaining).

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A1 Fields accessed: A0+$6A: Timer (must be 0) A0+$88: Cleared on entry A0+$8C: Lock flag (must be 0) A0+$A4: First entity slot index A0+$A6: Second entity slot index
- **Calls**: validation routine at $ADC4 (via JSR PC-relative) Note: BNE.S instructions at $ACFC and $AD10 chain past RTS into $AD14
- **RAM**: ($C02C).W: Counter (must be <= 0) ($9000).W: Entity table base (stride via LSL #8)
*Source: [ai_target_check.asm](disasm/modules/68k/game/ai/ai_target_check.asm)*

---

### AI Timer Increment (Dual Counter with Carry) ($00B0DE–$00B11A, 60 bytes)

Two entry points that share increment logic at $00B0F2: Entry 1 ($00B0DE): A0→$A9E7, D0 from $B4EE → BSR to shared, then falls into entry 2. Entry 2 ($00B0EA): A0→$A9E3, D0 from $C30E → falls into shared. Shared logic: if D0 bit 4 set and (A0) < $3C: increments 3-byte counter at (A0)+2, +1, +0 with carry chain. Each byte overflows at $00 → resets to $C4 and carries to next.

- **Modifies**: D0, A0
- **RAM**: $A9E3: timer block B (3 bytes) $A9E7: timer block A (3 bytes) $B4EE: input flags A (byte) $C30E: input flags B (byte, bit 4)
*Source: [ai_timer_inc.asm](disasm/modules/68k/game/ai/ai_timer_inc.asm)*

---

### AI Buffer Setup (4 Entry Points) ($00B11A–$00B15E, 68 bytes)

Four entry points that set up A1 (buffer), A2 (RAM pointer), and D3 (parameter), then branch to shared handler at $00B15E. Entry 1 ($00B11A): A1→$FF68D9, A2→$C806, D3=0 Entry 2 ($00B128): A1→$FF68D9, A2→$C806, D3=0 Entry 3 ($00B136): A1→$FF6959, A2→$C813, D3=0 Entry 4 ($00B144): A1→$FF68D9, A2→$C806, D3=($902C).w, but checks $C30E bits 0+5 first — if clear → continue, else RTS.

- **Modifies**: D0, D3, A1, A2
- **RAM**: $C806: AI control block A (via LEA) $C813: AI control block B (via LEA) $C30E: button/control flags (byte, bits 0/5) $902C: AI parameter (word)
*Source: [ai_buffer_setup.asm](disasm/modules/68k/game/ai/ai_buffer_setup.asm)*

---

### AI Digit Lookup + Best Lap ($00B1B8–$00B25E, 166 bytes)

Looks up 3 digit values from ROM tables and writes them to a per-racer display buffer at ($C200 + racer*4). If racer #5, checks for new best lap time and updates position marker.

- **Entry**: (none — reads racer index from $902C)
- **Modifies**: D0, D3, A1, A3
- **Calls**: $00B2EC, $00B422, $00B260 ROM tables: $00899884: digit_lookup_table (word entries, indexed by byte*2) $0089980C: digit_lookup_wide (word entries)
- **RAM**: $902C: racer_index (word) $C200: racer_display_buffer (4 bytes per racer) $C806: digit_index_0 (byte) $C807: digit_index_1 (byte) $C808: digit_index_2 (byte) $C210: best_lap_current (longword) $C254: best_lap_record (longword) $C307: position_marker_offset (byte) $C8A4: sound_trigger (byte)
*Source: [ai_digit_lookup_best_lap.asm](disasm/modules/68k/game/ai/ai_digit_lookup_best_lap.asm)*

---

### AI Table Lookup + Conditional Fall-through ($00B2D8–$00B2FC, 36 bytes)

Data prefix (12 bytes), then loads object+$2C index, computes table offset (index-1)*4 from AI table base ($C200). Tests if table entry < $60: if so, falls through to next function. Otherwise returns.

- **Entry**: A0 = object pointer | Exit: conditional | Uses: D0, D3, A0, A1
- **RAM**: $FFFFC200 = AI table base (address loaded into A1)
*Source: [ai_table_lookup_cond_fall_through.asm](disasm/modules/68k/game/ai/ai_table_lookup_cond_fall_through.asm)*

---

### AI Parameter Lookup + Threshold Check (Data Prefix) ($00B36E–$00B398, 42 bytes)

24-byte data table of 12 parameter words indexed by race_state, followed by lookup code: adds race_state ($C8A0) to entry D0, fetches parameter from table, compares byte at (A1) with $60, branches backward to $00B304 if less. D0 returns table value.

- **Entry**: D0 = base index (word offset), A1 = object pointer
- **Modifies**: D0, A0, A1
- **RAM**: $C8A0: race_state (word)
*Source: [ai_param_lookup_threshold_check_00b36e.asm](disasm/modules/68k/game/ai/ai_param_lookup_threshold_check_00b36e.asm)*

---

### AI Parameter Lookup + Threshold Check (Data Prefix, Variant B) ($00B398–$00B3CE, 54 bytes)

36-byte data table of 18 parameter words indexed by race_state, followed by lookup code: adds race_state ($C8A0) to entry D0, fetches parameter from table, compares byte at (A1) with $60, branches backward to $00B304 if less. D0 returns table value. Same structure as ai_param_lookup_threshold_check_00b36e but larger table (18 vs 12 entries).

- **Entry**: D0 = base index (word offset), A1 = object pointer
- **Modifies**: D0, A0, A1
- **RAM**: $C8A0: race_state (word)
*Source: [ai_param_lookup_threshold_check_00b398.asm](disasm/modules/68k/game/ai/ai_param_lookup_threshold_check_00b398.asm)*

---

### AI Data Load + Conditional Return on Flag ($00B598–$00B5AE, 22 bytes)

Loads shared memory pointer into A1, reads AI parameter from $9F2C, calls a sub-routine at $00B5B8, then tests bit 5 of the control flag at $C30E. Returns if set; falls through if clear.

- **Entry**: none | Exit: returns if flag set | Uses: D0, A1
- **RAM**: $FFFF9F2C = AI parameter (word, loaded into D0) $FFFFC30E = control flag (byte, bit 5 tested)
*Source: [ai_data_load_cond_return_on_flag.asm](disasm/modules/68k/game/ai/ai_data_load_cond_return_on_flag.asm)*

---

### AI Flag Setup at Object Array ($00B604–$00B632, 46 bytes)

Initializes AI control flags at $FF68D0+D0 offset. Clears flag byte, then conditionally sets to $02 based on bit 4 of $C967. Also sets $FF68B0 to $09 or $00 based on bit 5 of $C967.

- **Entry**: D0 = offset into $FF68D0 array
- **Modifies**: D0, A1
- **RAM**: $C967: AI configuration flags (byte) $FF68B0: AI mode byte $FF68D0: AI flag array base
*Source: [ai_flag_setup_at_object_array.asm](disasm/modules/68k/game/ai/ai_flag_setup_at_object_array.asm)*

---

### AI Timer Decrement + Conditional State Clear ($00B964–$00B97A, 22 bytes)

Calls sub at $00B990, clears AI active flag ($C31C), decrements the AI timer at $C303. If timer reaches zero, clears the AI mode at $C064.

- **Entry**: none | Exit: timer decremented | Uses: none
- **RAM**: $FFFFC31C = AI active flag (byte, cleared) $FFFFC303 = AI timer (byte, decremented) $FFFFC064 = AI mode (byte, conditionally cleared)
*Source: [ai_timer_dec_cond_state_clear.asm](disasm/modules/68k/game/ai/ai_timer_dec_cond_state_clear.asm)*

---

### AI Timer Decrement + State Clear + Reactivate ($00B97A–$00B990, 22 bytes)

Calls sub at $00B990, decrements the AI timer at $C303. If timer reaches zero, clears AI mode ($C064) and sets AI active flag ($C31C).

- **Entry**: none | Exit: timer decremented | Uses: none
- **RAM**: $FFFFC303 = AI timer (byte, decremented) $FFFFC064 = AI mode (byte, conditionally cleared) $FFFFC31C = AI active flag (byte, conditionally set to 1)
*Source: [ai_timer_dec_state_clear_reactivate.asm](disasm/modules/68k/game/ai/ai_timer_dec_state_clear_reactivate.asm)*

---

### AI Scene Interpolation (6 Components) ($00BD2A–$00BD9E, 116 bytes)

Interpolates 6 component values between two keyframes using scene_state as the interpolation factor. Source keyframe is at (A0)+2, target keyframe is found by scanning backwards through -$10 offsets skipping entries with type byte $0C. Each component is computed as: result = start + (end - start) × frame / total.

- **Entry**: A0 = keyframe data pointer (+$01 = total frames, +$02 = end values)
- **Modifies**: D0, D1, D2, A0, A1, A2
- **RAM**: $C054: interp_result_1 $C056: interp_result_2 $C086: interp_result_0 $C0AE: interp_result_3 $C0B0: interp_result_4 $C0B2: interp_result_5 $C8AA: scene_state (interpolation frame counter)
*Source: [ai_scene_interpolation.asm](disasm/modules/68k/game/ai/ai_scene_interpolation.asm)*

---

### AI Object Setup + Conditional Flag Set ($00BDD6–$00BDFE, 40 bytes)

Tests AI data word ($A0F0). If zero, returns. Otherwise sets up SH2 object at $FF6860 (command $0B at +$00, $0C at +$10). If $A0F0 >= 12, sets $FF60C8 to $FFFF and returns. If < 12, falls through to next function.

- **Entry**: none | Exit: object setup or fall-through | Uses: D1, A1
- **RAM**: $FFFFA0F0 = AI data word (tested) $00FF6860 = SH2 object base (byte at +$00 set to $0B, +$10 set to $0C) $00FF60C8 = SH2 flag (word, conditionally set to $FFFF)
*Source: [ai_object_setup_cond_flag_set.asm](disasm/modules/68k/game/ai/ai_object_setup_cond_flag_set.asm)*

---

### AI State Dispatch (Offset Table + Timer) ($00BE50–$00BEC4, 116 bytes)

Reads state index from ai_state ($A0EA), dispatches via 15-entry jump table. Only handler within this file (entry 0 at $BEAE) increments ai_timer; when timer reaches 120, advances state index by 4 and resets timer. Preceded by 12-word offset data table.

- **Modifies**: D0, D4, D7, A0, A2, A4, A6
- **RAM**: $A0EA: ai_state (jump table index: 0/4/8/.../56) $A0EC: ai_timer (counts to $0078 = 120)
*Source: [ai_state_dispatch.asm](disasm/modules/68k/game/ai/ai_state_dispatch.asm)*

---

### AI Dispatch + Triple Object Setup ($00BEC4–$00BEFC, 56 bytes)

Advances AI dispatch counter, clears substate. Initializes 3 SH2 objects at $FF6800/$FF6810/$FF6820 (byte +$00 = $01). Loads race_state as index into handler table at $BEFC(PC), stores handler address into third object's +$08 field.

- **Modifies**: D0, A1
- **RAM**: $A0EA: AI dispatch counter (word, advanced by 4) $A0EC: AI substate (word, cleared) $C8A0: race_state (word, used as table index) $FF6800: SH2 object 0 base $FF6810: SH2 object 1 base $FF6820: SH2 object 2 base
*Source: [ai_dispatch_triple_object_setup.asm](disasm/modules/68k/game/ai/ai_dispatch_triple_object_setup.asm)*

---

### Advance AI State Machine ($00BFD4–$00BFDE, 10 bytes)

Advances the AI state variable at $A0EA by 4 (jump table index step) and clears the AI sub-state at $A0EC. Identical to advance_ai_state_machine_00c01e.

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFA0EA = AI state variable (word, incremented by 4) $FFFFA0EC = AI sub-state (word, cleared)
*Source: [advance_ai_state_machine_00bfd4.asm](disasm/modules/68k/game/ai/advance_ai_state_machine_00bfd4.asm)*

---

### Advance AI State Machine (Duplicate) ($00C01E–$00C028, 10 bytes)

Advances the AI state variable at $A0EA by 4 (jump table index step) and clears the AI sub-state at $A0EC. Identical to advance_ai_state_machine_00bfd4.

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFA0EA = AI state variable (word, incremented by 4) $FFFFA0EC = AI sub-state (word, cleared)
*Source: [advance_ai_state_machine_00c01e.asm](disasm/modules/68k/game/ai/advance_ai_state_machine_00c01e.asm)*

---

## Game / Camera

### camera_param_calc ($002984–$002A72, 238 bytes)

Camera Parameter Calculation Computes camera/view parameters from entity state. Reads positions and velocities from entity A0 (at $FF9000), computes scaled derivatives (ASR #3 = divide by 8), and stores results to camera parameter buffer A1 (at $FF6100). Parameters computed: +$04: Lateral offset (from $009C, scaled, minus reference) +$06: Vertical reference (from RAM $C034) +$08/$0C: Height components (from $003A/$003C, with velocity $0044/$0046) +$0A: Roll component (from $003C + $0096) +$16: Speed indicator (from $0030) +$18-$20: Position derivatives and acceleration +$30/$32/$44/$46/$58: Rotation parameters (from $0090/$00BC) If entity has flag bit 3 at +$E5 and $C3AC is set, clears all primary parameters (zero-fill slots $00/$14/$28/$3C/$50/$64).

- **Entry**: Uses fixed addresses A0=$FF9000, A1=$FF6100
- **Modifies**: D0, D1, A0, A1
*Source: [camera_param_calc.asm](disasm/modules/68k/game/camera/camera_param_calc.asm)*

---

### camera_param_calc_b ($002ADE–$002BB0, 210 bytes)

Camera Parameter Calculation B Computes camera view parameters from entity A0 ($FF9000), stores to camera buffer A1 ($FF6100). Reads positions/velocities, scales by ASR #3 (÷8), computes lateral/height/roll components relative to world reference points (RAM $C034-$C03E area). Includes angular velocity smoothing at end: averages $008E(A0) with stored value, applies non-linear scaling (ASR #7 + ASR #6 + shift).

- **Entry**: A0 = entity ($FF9000), A1 = camera buffer ($FF6100)
- **Modifies**: D0, D1, A0, A1
*Source: [camera_param_calc_b.asm](disasm/modules/68k/game/camera/camera_param_calc_b.asm)*

---

### camera_param_calc_c ($002CDC–$002DCA, 238 bytes)

Camera Parameter Calculation C (Dual Output) Computes camera view parameters from entity A0, stores to both camera buffer A1 and secondary buffer A2. Same position/velocity scaling as camera_param_calc/025 (ASR #3 ÷8) but writes duplicated results to A2 offsets +$011A through +$015C for the second viewport. Includes additional reference offsets from RAM ($C034-$C042 area) for stereo camera.

- **Entry**: A0 = entity, A1 = primary camera buffer, A2 = secondary buffer
- **Modifies**: D0, D1, A0, A1, A2
*Source: [camera_param_calc_c.asm](disasm/modules/68k/game/camera/camera_param_calc_c.asm)*

---

### camera_param_calc_d ($002F04–$003010, 268 bytes)

Camera Parameter Calculation D (Dual Output) Computes camera view parameters with dual output (A1 + A2), plus angular velocity smoothing. Similar to camera_param_calc_c but uses different velocity subtraction order and includes the rotation averaging calculation from camera_param_calc_b (ASR #7 + ASR #6 + ADD + ASL #1 → non-linear smoothing).

- **Entry**: A0 = entity, A1 = primary camera buffer, A2 = secondary buffer
- **Modifies**: D0, D1, A0, A1, A2
*Source: [camera_param_calc_d.asm](disasm/modules/68k/game/camera/camera_param_calc_d.asm)*

---

### Camera Offset Clamping (Y + X Limits) ($0030C6–$003116, 80 bytes)

If $C30E bit 5 set (race active): Y clamping: loads VDP field $FF610A, subtracts camera_offset_y ($C0B0). If diff > $F000 → adds $0040 to $C0B0, clamps to diff. Writes clamped value to $FF610A. X clamping: loads camera_offset_x ($C056). Limit = $0280 (normal) or $0350 (if boost_flag $C8C8 nonzero). If $C056 > limit → subtracts $0010 from $C056, clamps.

- **Modifies**: D0, D1, A1
- **RAM**: $C056: camera_offset_x (word) $C0B0: camera_offset_y (word) $C30E: race_flags (byte, bit 5) $C8C8: boost_flag (word)
*Source: [camera_offset_clamping.asm](disasm/modules/68k/game/camera/camera_offset_clamping.asm)*

---

### VDP Buffer Transfer + Camera Offset Apply ($003126–$003160, 58 bytes)

Copies camera parameters to VDP buffer at $FF6100. Writes $C086 to buffer field +$02, calls $002996 (buffer init). Adds 3 camera offset words ($C0AE/$C0B0/$C0B2) to buffer fields +$08/+$0A/+$0C. If $C8C8 nonzero → adds $E0 to field +$06 (speed boost).

- **Modifies**: D0, A0, A1
- **Calls**: $002996: VDP buffer init
- **RAM**: $9000: work buffer base (word) $C086: camera parameter (word) $C0AE: camera offset X (word) $C0B0: camera offset Y (word) $C0B2: camera offset Z (word) $C8C8: boost flag (word)
*Source: [vdp_buffer_xfer_camera_offset_apply.asm](disasm/modules/68k/game/camera/vdp_buffer_xfer_camera_offset_apply.asm)*

---

### Object Camera Position Update ($0080D6–$008170, 154 bytes)

Updates object camera/position state from ROM parameter table. Loads 4 parameter words from table indexed by D2×8. Decrements velocity_x timer; when expired, clears all motion fields, clamps minimum speed to $011C, checks race_substate for special position range ($0069-$0071), then sets steering target + heading copy.

- **Entry**: A0 = object pointer, D2 = table index
- **Modifies**: D0, D2, A0, A1
- **RAM**: $C004: camera_transition_flag $C048: camera_position $C04C: camera_state_timer $C0AC: steering_target $C89C: race_substate
*Source: [object_camera_pos_update.asm](disasm/modules/68k/game/camera/object_camera_pos_update.asm)*

---

### Camera View Toggle 020 ($0088BE–$00896E, 176 bytes)

Toggles camera view mode and configures rendering parameters Button press (bits 5-6) toggles view flag When view active: computes zoom, scroll speed, and position from speed Two speed ranges with different scaling formulas

- **Modifies**: D0, D1, A0
- **RAM**: $C86D: button_raw $C86C: button_state $C313: view_toggle $9000: view_config_base $C0C8: view_active $C8E0: zoom_level $C8D8: view_speed $C8D4: scroll_rate $C8D6: scroll_speed $C0AE: render_distance $C0B0: render_param_a $C0B2: render_param_b $C054: track_pos_hi $C056: track_pos_lo $C0C6: render_angle $C0BA: waypoint_x
- **Confidence**: medium
*Source: [camera_view_toggle_020.asm](disasm/modules/68k/game/camera/camera_view_toggle_020.asm)*

---

### camera_state_disp_viewport_control ($00896E–$008B28, 442 bytes)

Camera State Dispatcher + Viewport Control Multi-state camera controller with acceleration/deceleration phases, button/flag checks, and a jump table dispatcher. Manages viewport scrolling, camera position updates, music trigger proximity checks, and render parameter writes. Jump table at $008A0E selects camera mode.

- **Entry**: A0 = camera/entity pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7
- **Object fields**: +$04 speed, +$06 current speed, +$0E param, +$1C height, +$24 segment, +$30 x_pos, +$34 y_pos
- **Confidence**: high
*Source: [camera_state_disp_viewport_control.asm](disasm/modules/68k/game/camera/camera_state_disp_viewport_control.asm)*

---

### Camera Direct Setup ($008B9C–$008BC2, 38 bytes)

Direct camera parameter setup from stored configuration values. Clears the camera override flag, sets elevation to $0080, then copies pitch and yaw from configuration RAM to both viewport and working registers. MEMORY VARIABLES $FFFFC0BA  Camera override flag (word, cleared to 0) $FFFFC0B0  Camera elevation (word, set to $0080) $FFFFC8DC  Pitch input config (word, read) $FFFFC8DE  Yaw input config (word, read) $FFFFC054  Viewport pitch (word, written) $FFFFC892  Working pitch (word, written) $FFFFC056  Viewport yaw (word, written) $FFFFC894  Working yaw (word, written)

- **Entry**: No register inputs
- **Returns**: Camera parameters configured from stored values
- **Modifies**: D0
*Source: [camera_direct_setup.asm](disasm/modules/68k/game/camera/camera_direct_setup.asm)*

---

### Camera Buffer Setup ($008BC2–$008BF2, 48 bytes)

Camera setup reading from the parameter buffer at $C0C0. Copies three buffer values to camera parameters ($C0AE, $C0B0, $C0B2), loads pitch from config, and sets yaw to a constant $0800. MEMORY VARIABLES $FFFFC0BA  Camera override flag (word, cleared to 0) $FFFFC0C0  Camera parameter buffer (3 words: read sequentially) $FFFFC0AE  Camera param A (word, from buffer[0]) $FFFFC0B0  Camera param B (word, from buffer[1]) $FFFFC0B2  Camera param C (word, from buffer[2]) $FFFFC8DC  Pitch config (word, read) $FFFFC054  Viewport pitch (word, written) $FFFFC892  Working pitch (word, written) $FFFFC056  Viewport yaw (word, set to $0800) $FFFFC894  Working yaw (word, set to $0800)

- **Entry**: No register inputs
- **Returns**: Camera configured from buffer with constant yaw
- **Modifies**: D0, A1
*Source: [camera_buffer_setup.asm](disasm/modules/68k/game/camera/camera_buffer_setup.asm)*

---

### Camera Simple Setup ($008BF2–$008C16, 36 bytes)

Simple camera setup from the $C0C0 parameter buffer. Reads pitch from buffer[0], copies to viewport/working. Copies buffer[1] to param B ($C0B0). Reads yaw from buffer[2], copies to viewport/working. MEMORY VARIABLES $FFFFC0BA  Camera override flag (word, cleared to 0) $FFFFC0C0  Camera parameter buffer (3 words: pitch, param B, yaw) $FFFFC054  Viewport pitch (word, from buffer[0]) $FFFFC892  Working pitch (word, from buffer[0]) $FFFFC0B0  Camera param B (word, from buffer[1]) $FFFFC056  Viewport yaw (word, from buffer[2]) $FFFFC894  Working yaw (word, from buffer[2])

- **Entry**: No register inputs
- **Returns**: Camera configured from buffer
- **Modifies**: D0, A1
*Source: [camera_simple_setup.asm](disasm/modules/68k/game/camera/camera_simple_setup.asm)*

---

### Camera Offset Setup ($008C16–$008C40, 42 bytes)

Camera setup with elevation offset from $C0BC. Reads pitch from buffer[0], copies buffer[1] to param A ($C0AE), loads elevation from $C0BC into param B ($C0B0), and reads yaw from buffer[2]. MEMORY VARIABLES $FFFFC0BA  Camera override flag (word, cleared to 0) $FFFFC0C0  Camera parameter buffer (3 words: pitch, param A, yaw) $FFFFC054  Viewport pitch (word, from buffer[0]) $FFFFC892  Working pitch (word, from buffer[0]) $FFFFC0AE  Camera param A (word, from buffer[1]) $FFFFC0BC  Elevation offset source (word, read) $FFFFC0B0  Camera param B (word, from $C0BC) $FFFFC056  Viewport yaw (word, from buffer[2]) $FFFFC894  Working yaw (word, from buffer[2])

- **Entry**: No register inputs
- **Returns**: Camera configured from buffer with elevation offset
- **Modifies**: D0, A1
*Source: [camera_offset_setup.asm](disasm/modules/68k/game/camera/camera_offset_setup.asm)*

---

### Camera Parameter Init (Two-Level Dispatch) ($008C40–$008CB0, 112 bytes)

Clears $C0BA, then dispatches via 3-entry word-offset table indexed by $C896 (two-level: load offset, then JMP). State 0 handler: initializes 15+ camera/display parameters: $C0C8 = $C0, $FF60CC = $100, copies $C8DA → $C0AE, clears $C0C6/$C0AE/$C0B0/$C0B2/$C086/$C88C/$C88E/$C890/$C8F6, copies $C8DC → $C054/$C892, copies $C8DE → $C056/$C894. Advances $C896 by 2.

- **Modifies**: D0, D6
- **RAM**: $C054: display param A (word) $C056: display param B (word) $C086: camera parameter (word, cleared) $C0AE: camera offset X (word, set then cleared) $C0B0: camera offset Y (word, cleared) $C0B2: camera offset Z (word, cleared) $C0BA: param base (word, cleared) $C0C6: display offset delta (word, cleared) $C0C8: display scale (word, set to $C0) $C88C: work param A (word, cleared) $C88E: work param B (word, cleared) $C890: work param C (word, cleared) $C892: reference param A (word, set from $C8DC) $C894: reference param B (word, set from $C8DE) $C896: sub_state (byte, +2 per call) $C8DA: initial camera offset (word) $C8DC: reference value A (word) $C8DE: reference value B (word) $C8F6: counter (word, cleared)
*Source: [camera_param_init.asm](disasm/modules/68k/game/camera/camera_param_init.asm)*

---

### Camera Scroll Update ($008CB0–$008CCC, 28 bytes)

Increments camera scroll positions (pitch and yaw) by 8 each frame, then copies working values to viewport registers. Also copies a counter value from $C8F6 to $C0C6. MEMORY VARIABLES $FFFFC892  Working pitch (word, incremented by 8) $FFFFC894  Working yaw (word, incremented by 8) $FFFFC054  Viewport pitch (word, copied from working) $FFFFC056  Viewport yaw (word, copied from working) $FFFFC8F6  Counter source (word, read) $FFFFC0C6  Counter destination (word, written)

- **Entry**: No register inputs
- **Returns**: Scroll positions advanced and synced to viewport
- **Modifies**: (none modified beyond RAM writes)
*Source: [camera_scroll_update.asm](disasm/modules/68k/game/camera/camera_scroll_update.asm)*

---

### Camera Yaw Increment + Mirror to Viewports ($008D12–$008D38, 38 bytes)

Increments working yaw ($C894) by $0050, clamped at $EC0A. If yaw exceeds max, falls through to next function (skips increment). Mirrors yaw to viewport backup ($C0BE), and if yaw > $E8E8, also copies to SH2 shared memory ($FF3028).

- **Entry**: none | Exit: yaw incremented | Uses: none
- **RAM**: $FFFFC894 = working yaw (word, incremented by $0050, max $EC0A) $FFFFC0BE = viewport backup (word, mirror of yaw) $00FF3028 = SH2 shared yaw (word, conditionally updated)
*Source: [camera_yaw_inc_mirror_to_viewports.asm](disasm/modules/68k/game/camera/camera_yaw_inc_mirror_to_viewports.asm)*

---

### Camera Value Store Full ($008D38–$008D52, 26 bytes)

Sets the working yaw to a fixed value ($EC0A), copies it to both viewport backup and shared memory, then advances the mode counter. MEMORY VARIABLES $FFFFC894  Working yaw (word, set to $EC0A) $FFFFC0BE  Viewport yaw backup (word, written) $00FF3028  Shared memory yaw (word, written for SH2) $FFFFC896  Mode counter (byte, advanced by 2)

- **Entry**: No register inputs
- **Returns**: Yaw set to $EC0A, copied, mode counter advanced
- **Modifies**: (none modified beyond RAM writes)
*Source: [camera_value_store_full.asm](disasm/modules/68k/game/camera/camera_value_store_full.asm)*

---

### Camera Value Store ($008D52–$008D62, 16 bytes)

Copies the working yaw value ($C894) to both the viewport backup register ($C0BE) and the shared memory location ($00FF3028) for SH2 access. MEMORY VARIABLES $FFFFC894  Working yaw (word, read) $FFFFC0BE  Viewport yaw backup (word, written) $00FF3028  Shared memory yaw (word, written for SH2)

- **Entry**: No register inputs
- **Returns**: Yaw value copied to viewport and shared memory
- **Modifies**: (none modified beyond RAM writes)
*Source: [camera_value_store.asm](disasm/modules/68k/game/camera/camera_value_store.asm)*

---

### camera_angle_smoothing_with_trigonometry ($008DC0–$008EB6, 246 bytes)

Camera Angle Smoothing with Trigonometry Computes smoothed camera angles using ai_steering_calc for initial angle, then applies cosine/sine lookups with conditional blending. Smooths both horizontal and vertical camera rotation with damping. Dual-axis processing with mirrored logic for each axis.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, D3, A0
- **Calls**: $008F4E (cosine_lookup), $008F52 (sine_lookup), $00A7A0 (ai_steering_calc), $00A7A4 (steering variant)
- **Object fields**: +$30 x_pos, +$32 z_pos, +$34 y_pos
- **Confidence**: high
*Source: [camera_angle_smoothing_with_trigonometry.asm](disasm/modules/68k/game/camera/camera_angle_smoothing_with_trigonometry.asm)*

---

### Clear Camera Override ($008EF4–$008EFC, 8 bytes)

Clears camera position override flag.

- **Entry**: none
- **Modifies**: none
*Source: [clear_camera_override.asm](disasm/modules/68k/game/camera/clear_camera_override.asm)*

---

### drift_physics_and_camera_offset_calc ($009688–$009802, 378 bytes)

Drift Physics and Camera Offset Calculation Computes lateral drift from steering velocity +$8E, applies speed-based scaling with sine lookup, updates heading mirror +$3C. Calculates camera follow distance from entity displacement fields +$5A/+$5C, speed +$06, and applies polynomial scaling. Manages drift accumulator +$AA with decay and heading snap-back toward target +$40.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, D3, A0
- **Calls**: $008F52 (sine_lookup)
- **Object fields**: +$04 speed, +$06 display speed, +$0C slope, +$1E target heading, +$3C heading mirror, +$40 heading angle, +$5A trail X, +$5C trail Y, +$76 camera dist, +$8E steer vel, +$90 drift rate, +$92 slide, +$AA drift accum
- **Confidence**: high
*Source: [drift_physics_and_camera_offset_calc.asm](disasm/modules/68k/game/camera/drift_physics_and_camera_offset_calc.asm)*

---

### Set Camera Registers to Invalid ($FFFF) ($009B54–$009B82, 46 bytes)

Sets 3 camera registers to $FFFF unconditionally. Then checks $FF6114 (SH2 status) and $C048 (camera_state): if both non-zero, falls through to next function (skip remaining). Otherwise sets 4 more camera registers to $FFFF, then returns.

- **Modifies**: D0
- **RAM**: $C00C: camera register A (word) $C018: camera register B (word) $C012: camera register C (word) $C01E: camera register D (word, conditional) $C024: camera register E (word, conditional) $C00E: camera register F (word, conditional) $C010: camera register G (word, conditional) $C048: camera_state (word) $FF6114: SH2 status (word)
*Source: [set_camera_regs_to_invalid.asm](disasm/modules/68k/game/camera/set_camera_regs_to_invalid.asm)*

---

### Camera State Selector ($00B770–$00B7E6, 118 bytes)

Selects camera view based on button input. Increments per-camera frame counter, then checks directional buttons (bits 5, 8-10) in game_input to switch between 4 camera positions (0-3).

- **Entry**: A0 = buffer selector ($9000 = alternate)
- **Modifies**: D0, A0, A1, A2
- **RAM**: $C048: camera_position (0-3, word index) $C064: camera_enable $C0A2: camera_frame_counters (word array, indexed by position×2) $C302: camera_max_frames $C314: camera_input_enable $C972: game_input (button bitmap)
*Source: [camera_state_selector.asm](disasm/modules/68k/game/camera/camera_state_selector.asm)*

---

### camera_animation_state_disp ($00B7EE–$00B964, 374 bytes)

Camera Animation State Dispatcher State machine for camera animation transitions. Reads state byte from $C045, dispatches via jump table at $00B864. Oscillates a counter between 0-$10 for smooth animation interpolation. Computes display viewport coordinates from animation data tables and writes to screen position registers. Second phase loads camera parameters from ROM and populates display object (A2) fields.

- **Entry**: A0 = player entity, A2 = display object
- **Modifies**: D0, D1, D2, D4, A0, A1, A2, A4
- **Confidence**: high
*Source: [camera_animation_state_disp.asm](disasm/modules/68k/game/camera/camera_animation_state_disp.asm)*

---

### Scene Camera Init ($00CC74–$00CD4C, 216 bytes)

Initializes camera/scene for race start. First entry copies ROM segment data to $C08C via segment_copy. Main body sets up object A0 with animation params, loads track and road segment data from ROM tables indexed by sh2_comm_state ($C89C), configures camera scale/ repeat/zoom fields, sets initial frame countdown ($001E), and adjusts scene_timer based on race mode (vint_state $C8C8).

- **Entry**: D0 = ROM table offset (first entry only) A0 = object/entity pointer (main entry)
- **Modifies**: D0, A0, A1, A2
- **Calls**: $00884922: segment_copy_to_buffer (JMP/JSR target)
- **RAM**: $C048: camera_state (word, set to 1) $C05A: camera_state_end (word, set to $FFFF) $C07A: camera_target_x (word) $C086: camera_flags (word, cleared) $C08C: camera_segment_buffer $C094: camera_source_x (word, copied to $C07A) $C0AC: frame_countdown (word, set to $001E) $C0E4: camera_viewport_size (word, set to $0040) $C268: road_segment_ptr (longword) $C302: animation_speed (byte, set to $04) $C311: animation_index (byte, cleared) $C700: track_data_buffer $C819: scene_active (byte, cleared) $C824: scene_timer (byte, $14 or $1E) $C89C: sh2_comm_state (word, ×$14 for track table) $C8C8: vint_state (word, race mode check) $C8CC: race_substate (word, indexes road segment table) $C8E4: road_data_buffer $FEA9: system_flags (byte) ROM tables: $008997EC: camera_segment_rom_table (indexed by D0) $00898A04: track_param_table (stride $14, indexed by sh2_comm_state) $00930612: road_segment_ptr_table (longword, indexed by race_substate) $009305D6: road_data_table (longword, indexed by race_substate)
- **Object fields**: +$18: base_position (longword) +$2A: repeat_count (word, set to 1) +$76: scale_x (word, set to $0100) +$78: scale_y (word, set to $0100) +$A4: zoom_frames (word, set to $000F) +$A6: zoom_step (word, set to 1) +$AC: zoom_rate (word, set to 3) +$B2: base_position_copy (longword)
*Source: [scene_camera_init.asm](disasm/modules/68k/game/camera/scene_camera_init.asm)*

---

### camera_tile_block_send ($0126A6–$0126D2, 44 bytes)

Camera Tile Block Send Sends a 56×16 tile block from SH2 framebuffer to display. Computes source address: $0601F9C0 + (D5 & 3) × $380. Used to update individual camera view tiles in the camera selection screen.

- **Entry**: D5 = camera index (0-3)
- **Returns**: tile data sent to SH2 framebuffer
- **Modifies**: D0, D1, D5, A0
- **Calls**: $00E35A: sh2_send_cmd
*Source: [camera_tile_block_send.asm](disasm/modules/68k/game/camera/camera_tile_block_send.asm)*

---

### camera_angle_increment_clamp ($012C9E–$012CB0, 18 bytes)

Camera Angle Increment Clamp Adds a small increment ($10) to D0 if D0 ≤ $4000 (≤ 90° in 16-bit angle space). If D0 > $4000, returns unchanged. Secondary entry at $012CAA adds a larger increment ($40) unconditionally.

- **Entry**: D0 = camera angle (16-bit, $0000-$FFFF)
- **Returns**: D0 = adjusted angle
- **Modifies**: D0
*Source: [camera_angle_increment_clamp.asm](disasm/modules/68k/game/camera/camera_angle_increment_clamp.asm)*

---

### camera_angle_decrement_clamp ($012CB0–$012CC2, 18 bytes)

Camera Angle Decrement Clamp Subtracts a small decrement ($10) from D0 if D0 ≥ $C000 (≥ 270° in 16-bit angle space). If D0 < $C000, returns unchanged. Secondary entry at $012CBC subtracts a larger decrement ($40) unconditionally.

- **Entry**: D0 = camera angle (16-bit, $0000-$FFFF)
- **Returns**: D0 = adjusted angle
- **Modifies**: D0
*Source: [camera_angle_decrement_clamp.asm](disasm/modules/68k/game/camera/camera_angle_decrement_clamp.asm)*

---

### camera_selection_main_loop ($012CC2–$012F0A, 584 bytes)

Camera Selection Main Loop Per-frame update for the camera selection screen. Handles: 1. DMA transfer, object_update, sprite_update 2. Render main camera view ($06038000) and overlay ($0603DE80) 3. Camera selection via D-pad up/down (cycles through 6 cameras, with skip logic for locked camera positions via bit 3 of $C958) 4. Optional replay mode toggle via left/right (with smooth scrolling) 5. Confirm selection (A button → state $0002), cancel (Start → exit) 6. State machine: browsing ($0000), confirming ($0001/$0002)

- **Modifies**: D0, D1, D2, A0, A1
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer
- **RAM**: $C87E: game_state
*Source: [camera_selection_main_loop.asm](disasm/modules/68k/game/camera/camera_selection_main_loop.asm)*

---

## Game / Collision

### object_proximity_check_jump_table_dispatch ($0037B6–$00385E, 168 bytes)

Object Proximity Check + Jump Table Dispatch Checks distance between an object at ($FFFF9000) and up to 3 target objects. If any target is within $0C80 range in both X and Y, copies its data into the proximity buffer at $FF659C and dispatches via jump table at end. Jump table (6 longword entries) selects the next handler based on race_state.

- **Entry**: (implicit — uses RAM addresses directly)
- **Modifies**: D0, D1, D2, D4, D7, A0, A1, A2
- **RAM**: $9000 (object_base), $C008 (proximity_counter), $C8A0 (race_state) Object fields (via A0 at $9000): +$30: x_position +$34: y_position
*Source: [object_proximity_check_jump_table_dispatch.asm](disasm/modules/68k/game/collision/object_proximity_check_jump_table_dispatch.asm)*

---

### Proximity Check with Sine Billboard ($003866–$003924, 190 bytes)

3D proximity + sine-animated sprite Checks object position against sprite table entries in 3D space. First pass: static position check against thresholds (X/Z=$0C80, Y=$1400). If within range, copies sprite parameters (type=2) with both static and animated data. Second pass uses sine_lookup to compute oscillating offset for billboard animation. Increments animation counter by 3 per call.

- **Entry**: A0 = player entity pointer (+$30=X, +$32=Y, +$34=Z); A1 (loaded internally from $00883924 sprite table); A2 (loaded internally to $00FF65B0 output buffer)
- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1, A2
- **Calls**: $008F52: sine_lookup
- **Confidence**: medium
*Source: [proximity_check_with_sine_billboard.asm](disasm/modules/68k/game/collision/proximity_check_with_sine_billboard.asm)*

---

### Sprite Init + Collision Check (56-Byte Data Prefix) ($003924–$00397C, 88 bytes)

Data prefix: 56 bytes ($3924-$395B) of sprite/collision configuration records (4 × 14-byte entries with $222A markers). Code ($395C): loads sprite data from ROM $3A4E into sprite buffer at $FF65B0. Sets sprite pattern $22295A24, loop count D7=3. Calls collision_distance_calc ($0039EC). If collision_flag ($C80F) is zero → falls through to next function (no RTS).

- **Modifies**: D0, D1, D2, D7, A1, A2, A3, A6
- **Calls**: $0039EC: collision_distance_calc
- **RAM**: $C80F: collision_flag (byte, 0 = fall through)
*Source: [sprite_init_collision_check_003924.asm](disasm/modules/68k/game/collision/sprite_init_collision_check_003924.asm)*

---

### Proximity Check Simple ($0039EC–$003A3E, 82 bytes)

3D range test with sprite data copy Tests entity position (A0 +$30/+$32/+$34) against reference object (A1) in 3 axes: X/Z threshold $0C80, Y threshold $0300. If all within range, copies sprite data from A1 to output buffer A2 (type=1, 4 words + D0).

- **Entry**: A0 = player entity pointer (+$30=X, +$32=Y, +$34=Z); A1 = reference object pointer (+$00=X, +$02=Y, +$04=Z); A2 = output buffer pointer; D0.L = sprite texture/animation ID
- **Modifies**: D0, D1, D2, D3, D4, D5
- **Confidence**: medium
*Source: [proximity_check_simple.asm](disasm/modules/68k/game/collision/proximity_check_simple.asm)*

---

### Proximity Loop Iterator A ($003A3E–$003A4E, 16 bytes)

advance and repeat proximity check Advances A1 by 10 bytes to next object entry, loops back to proximity_check_simple body via DBRA D7. If loop exhausted without match, clears output buffer visibility flag at (A2)+$00.

- **Entry**: A1 = current object pointer (advanced by $0A per iteration); A2 = output buffer pointer; D7 = loop counter
- **Modifies**: D7, A1
- **Confidence**: medium
*Source: [proximity_loop_iterator_a.asm](disasm/modules/68k/game/collision/proximity_loop_iterator_a.asm)*

---

### Sprite Init + Collision Check (92-Byte Data Prefix) ($003A4E–$003AB2, 100 bytes)

Data prefix: 92 bytes ($3A4E-$3AA9) of sprite/collision configuration records. Code ($3AAA): checks collision_flag ($C80F). If zero → falls through to next function (no RTS). Otherwise returns.

- **Modifies**: none (just data + simple test)
- **RAM**: $C80F: collision_flag (byte, 0 = fall through)
*Source: [sprite_init_collision_check_003a4e.asm](disasm/modules/68k/game/collision/sprite_init_collision_check_003a4e.asm)*

---

### Proximity Check 062 ($003AB2–$003B28, 118 bytes)

Tests if object is within 3D bounding box of reference point Checks X, Z, Y deltas against thresholds ($0C80 and $1400) On match: copies reference data (position, params) to output buffer Also updates rotation angle counter

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1, A2
- **RAM**: $C8E2: rotation_angle Object fields (A0): +$30: x_position +$32: z_position +$34: y_position Output buffer (A2 → $FF65B0): +$00: match_flag (0=no, 1=yes) +$02-$05: ref_position (longword) +$06: ref_y +$0A: rotation_angle +$0C-$0E: ref_params +$10-$13: ref_data (longword)
- **Confidence**: medium
*Source: [proximity_check_062.asm](disasm/modules/68k/game/collision/proximity_check_062.asm)*

---

### Object Table 3 Proximity with Animation ($003B28–$003C1A, 242 bytes)

trackside object visibility Loads player position from object table 3 ($9F00), gets sprite table via indexed ROM lookup at $00895A64. Checks 2D proximity (X/Z threshold $0C80) for 3 objects (D7=2). On match, copies sprite data and cycles animation frame counter (12 frames at $C008, D0 doubled twice for 4-byte stride). Second pass (if race_state $C89C = mode 1): checks 4 objects from table $00883A4E with 3D proximity (Y threshold $0300), static textures.

- **Entry**: A0 (loaded internally from $9F00 obj_table_3)
- **Modifies**: D0, D1, D2, D3, D4, D5, D7, A0, A1, A2
- **RAM**: $9F00: obj_table_3 $C008: animation frame counter (0-11, wraps) $C89C: race_state (selects second proximity pass)
- **Confidence**: medium
*Source: [object_table_3_proximity_with_animation.asm](disasm/modules/68k/game/collision/object_table_3_proximity_with_animation.asm)*

---

### Proximity Loop Iterator B ($003C1A–$003C2A, 16 bytes)

advance and repeat object_table_3_proximity_with_animation inner loop Advances A1 by 10 bytes to next object entry, loops back to object_table_3_proximity_with_animation inner loop body ($003BCC) via DBRA D7. If loop exhausted without match, clears output buffer visibility flag at (A2)+$00.

- **Entry**: A1 = current object pointer (advanced by $0A per iteration); A2 = output buffer pointer; D7 = loop counter
- **Modifies**: D7, A1
- **Confidence**: medium
*Source: [proximity_loop_iterator_b.asm](disasm/modules/68k/game/collision/proximity_loop_iterator_b.asm)*

---

### rotational_offset_calc ($00764E–$0076A2, 84 bytes)

Rotational Offset Calculation Computes rotational offsets for billboard rendering. Takes entity heading angle (+$1E), computes cos/sin via lookup tables, multiplies by position deltas (+$20 - +$30 and +$22 - +$34), and stores results as lateral offset (+$72) and longitudinal offset (+$E2). Uses cross-product style rotation.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D2, D3, D4, D5, A0
- **Object fields**: +$1E heading_angle, +$20 target_x, +$22 target_y, +$30 x_position, +$34 y_position, +$72 lateral_offset, +$E2 long_offset
- **Confidence**: high
*Source: [rotational_offset_calc.asm](disasm/modules/68k/game/collision/rotational_offset_calc.asm)*

---

### collision_response_surface_tracking ($007700–$00789C, 412 bytes)

Collision Response + Surface Tracking Iterative collision response with surface tracking. Calls obj_frame_calc ($00789C), then iteratively adjusts heading (+$40), scale (+$46), X (+$30), and Y (+$34) in 1/4 steps up to 4 iterations, checking collision flag (+$55 bit 0) each time. On collision, reverses last step. Second half performs surface-relative calculations on 4 neighboring probe points using tile lookup data from entity fields +$CE/+$D2/+$D6/+$DA.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7
- **Object fields**: +$30 x_pos, +$32 y_sub, +$34 y_pos, +$36/+$38 prev_pos, +$40 heading, +$42 prev_heading, +$46 scale, +$48 prev_scale, +$55 collision_flag, +$5A/+$5C/+$5E/+$32 surface_offsets
- **Confidence**: high
*Source: [collision_response_surface_tracking.asm](disasm/modules/68k/game/collision/collision_response_surface_tracking.asm)*

---

### track_boundary_collision_detection ($00789C–$007A40, 420 bytes)

Track Boundary Collision Detection Probes 4 points around entity for track boundary collisions. For each probe: computes position with offset, calls tile_position_calc to find road segment, checks if segment matches current tile (angle_normalize), tests collision via velocity_apply, and stores result in entity fields +$55 through +$59. Final combined collision flag written to +$55.

- **Entry**: A0 = entity base pointer, A4 = scratch buffer pointer
- **Modifies**: D0, D1, D2, A0, A1, A2, A3, A4
- **Object fields**: +$30 x_position, +$34 y_position, +$40 heading, +$46 scale, +$55-$59 collision flags per probe, +$CE/+$D2/+$D6/+$DA tile data pointers
- **Confidence**: high
*Source: [track_boundary_collision_detection.asm](disasm/modules/68k/game/collision/track_boundary_collision_detection.asm)*

---

### directional_collision_probe ($007AD6–$007BAC, 214 bytes)

Directional Collision Probe Probes for collisions in the entity's heading direction. Computes offset from heading angle via ROM table at $0093661E, performs tile lookup at offset position, checks for track boundary collision via angle_normalize and velocity_apply. Probes two points (forward and adjacent) and stores surface tracking data in +$C6/+$C8. Falls through to center probe check.

- **Entry**: A0 = entity base pointer, A4 = scratch buffer pointer
- **Modifies**: D0, D1, D2, A0, A1, A2, A3, A4
- **Object fields**: +$30 x_position, +$34 y_position, +$40 heading, +$46 scale, +$55 collision_flag, +$C6/+$C8 surface_offsets
- **Confidence**: high
*Source: [directional_collision_probe.asm](disasm/modules/68k/game/collision/directional_collision_probe.asm)*

---

### Collision Flag Check 054 ($007CF0–$007D56, 102 bytes)

Checks collision conditions and sets object flags Tests speed threshold, lateral position, and collision state On collision: sets flag bits $1000/$2000 in obj.flags, sets sound $B2 On active collision sequence: tail-calls obj_collision_response

- **Entry**: D0 = input flags; A0 = object/entity pointer
- **Modifies**: D0, D1, A0
- **Calls**: $007EA4: obj_collision_response (tail call via JMP) Object fields (A0): +$02: flags +$04: speed +$1C: collision_param +$55: collision_mask +$56: collision_state_a +$57: collision_state_b +$62: collision_active +$6A: collision_cooldown +$8C: collision_lock +$94: lateral_position
- **RAM**: $C8D2: lateral_threshold $C8A4: sound_command
- **Confidence**: medium
*Source: [collision_flag_check_054.asm](disasm/modules/68k/game/collision/collision_flag_check_054.asm)*

---

### Proximity Zone Simple (Single Entity Pair) ($008672–$0086C8, 86 bytes)

Calculates proximity zone between entities (A0) and (A1). Zones: 0=far, 1=closest, 2=near, 3=approaching.

- **Entry**: A0 = entity, A1 = target entity
- **Modifies**: D2, D4, D5, D6
*Source: [proximity_zone_simple.asm](disasm/modules/68k/game/collision/proximity_zone_simple.asm)*

---

### Proximity Zone Multi (Entity Loop with Camera Override) ($0086C8–$00877A, 178 bytes)

Multi-entity proximity check with camera position override. Loops 15 entities at ($9100).W with $100 stride. 3 entry paths with different threshold sets based on flag bits.

- **Entry**: A0 = entity
- **Modifies**: D0-D7, A1
*Source: [proximity_zone_multi.asm](disasm/modules/68k/game/collision/proximity_zone_multi.asm)*

---

### Proximity Zone Loop (Fixed Thresholds) ($00877A–$0087E2, 104 bytes)

Simplified proximity loop over 15 entities. Fixed thresholds. 3 zone levels plus inner zone ($8001). Entity table at ($9100).W.

- **Entry**: A0 = entity
- **Modifies**: D0-D7, A1
*Source: [proximity_zone_loop.asm](disasm/modules/68k/game/collision/proximity_zone_loop.asm)*

---

### Proximity Trigger (Cooldown Timer) ($009E6E–$009EC0, 82 bytes)

Proximity trigger with cooldown. Indexes entity table, compares distances, sets 12-frame timer if close.

- **Entry**: A0 = entity
- **Modifies**: D0, D1, A1
*Source: [proximity_trigger.asm](disasm/modules/68k/game/collision/proximity_trigger.asm)*

---

### Proximity Distance Check ($00ADC4–$00AE04, 66 bytes)

Checks 3D proximity between two entities (A0, A1). Compares absolute differences of positions $32, $30, $34 against thresholds. If all within range ($200, $40, $40), chains to zone_check at $AE0A. Otherwise returns D0=0.

- **Entry**: A0 = entity A, A1 = entity B (from entity_target_action chain)
- **Modifies**: D0 Fields accessed: A0/A1+$30: Position X A0/A1+$32: Position Z A0/A1+$34: Position Y A1+$88: Direction flags (cleared)
*Source: [proximity_distance_check.asm](disasm/modules/68k/game/collision/proximity_distance_check.asm)*

---

### Zone Check Inner ($00AE06–$00AED6, 210 bytes)

Angle-Based Visibility Chained from proximity_distance_check via JMP when entities are close. Computes angle-based visibility zones for both entities using a 2KB lookup table, then sets direction bits in A0+$89 and A1+$89. Two symmetric passes: Pass 1: Angle from A1→A0, check against bounding box at $C8E4-$C8EA, set bits in A0+$89 Pass 2: Angle from A0→A1, check against bounding box at $C8EC-$C8F2, set bits in A1+$89 FIELDS ACCESSED A0/A1+$30  Position X (word) A0/A1+$34  Position Y (word) A0+$3C, A1+$3C  Facing angle A (word) A0+$40     Facing angle B (word) A0+$89, A1+$89  Direction zone bits (byte, output) MEMORY VARIABLES $FFFFC268  Angle lookup table base pointer (long) $FFFFC8E4  Pass 1 X min bound (word) $FFFFC8E6  Pass 1 Y max bound (word) $FFFFC8E8  Pass 1 X max bound (word) $FFFFC8EA  Pass 1 Y min bound (word) $FFFFC8EC  Pass 2 X min bound (word) $FFFFC8EE  Pass 2 X max bound (word) $FFFFC8F0  Pass 2 Y min bound (word) $FFFFC8F2  Pass 2 Y max bound (word)

- **Entry**: A0 = entity A, A1 = entity B
- **Returns**: D0 = A0 zone bits; zone bits written to A0+$89 and A1+$89
- **Modifies**: D0-D7, A2
*Source: [zone_check_inner.asm](disasm/modules/68k/game/collision/zone_check_inner.asm)*

---

### Object Collision Detection ($00AF18–$00AFC2, 170 bytes)

Checks collision between two objects (A0 = player, A1 = $9F00). Sums velocities + lateral offsets; if nonzero, skips (already processed). Compares distance at +$32; if too far (>$200), skips. Calls proximity check ($00AE0A); on hit, triggers sound $B8, computes post-collision speeds with 3/4+1/4 weighted average, clamps to $04DC, and swaps if needed so faster object gets higher speed. Sets collision flag $0800 in +$02 if position gap exceeds threshold.

- **Entry**: A0 = player object, A1 = opponent (loaded from $9F00)
- **Modifies**: D0, D1, D2, D3, A0, A1
- **Calls**: $00AE0A: proximity_check (returns Z=1 if no collision) $00AFFE: collision_speed_apply (external, via BLE.W)
- **RAM**: $9F00: obj_table_3 (opponent base) $C8A4: sound_trigger (byte) $C8CE: collision_speed_threshold (word) $C8D0: collision_position_threshold (word)
- **Object fields**: +$02: flags (bit 11 = collision) +$04: velocity +$06: speed +$32: lateral_offset +$6A: accel_x +$88: collision_result +$8C: velocity_x
*Source: [object_collision_detection.asm](disasm/modules/68k/game/collision/object_collision_detection.asm)*

---

### Close Position Flags ($00AFC2–$00AFFC, 58 bytes)

Stores speed param D1 to A0+$06, then sets status flag bits based on direction flags in A0+$88 (same logic as entity_target_action .close_position). Swaps bit 12/13 assignment between A0 and A1 based on direction bits 0 and 2. Sets AI mode byte to $B2 in ($C8A4).W.

- **Entry**: A0 = entity, A1 = target, D1 = speed param value
- **Modifies**: D0, D1 Fields accessed: A0+$02: Status flags (ORI.W bit-set) A1+$02: Status flags (ORI.W bit-set) A0+$06: Speed param (written with D1) A0+$88: Direction flags (tested bits 0, 2)
- **RAM**: ($C8A4).W: Active AI mode byte (set to $B2)
*Source: [close_position_flags.asm](disasm/modules/68k/game/collision/close_position_flags.asm)*

---

### Position Separation ($00AFFE–$00B02A, 44 bytes)

Pushes two entities apart by 16 units on both X and Y axes. Direction is based on which entity has the larger coordinate.

- **Entry**: A0 = first entity, A1 = second entity
- **Modifies**: D0, D1 Fields accessed: A0+$30: X position (modified) A0+$34: Y position (modified) A1+$30: X position (modified) A1+$34: Y position (modified)
*Source: [position_separation.asm](disasm/modules/68k/game/collision/position_separation.asm)*

---

## Game / Data

### tile_decompressor_setup ($0010F4–$001140, 76 bytes)

Tile Decompressor Setup Entry point for tile decompression. Two entry points with different lookup table bases: $0010F4: Uses table at $008811B8 (primary tiles) $001106: Uses table at $008811CE (alternate tiles) Reads compressed tile header from (A0)+: bit 15 selects table offset (+$0A if set), remaining bits shifted left 2 become tile index in A5. Calls inner decompression loop at $0011E4 via BSR.W, then reads output parameters (D5 = dimensions, D6 = tile count $10).

- **Entry**: A0 = pointer to compressed tile data
- **Returns**: Tiles decompressed to VDP via A4 (VDP_DATA)
- **Modifies**: D0-D7, A0, A1, A3, A4, A5
*Source: [tile_decompressor_setup.asm](disasm/modules/68k/game/data/tile_decompressor_setup.asm)*

---

### huffman_lz_decompression_inner_loop ($001140–$0011C2, 130 bytes)

Huffman/LZ Decompression Inner Loop Bit-level decoder for compressed data. Uses D5/D6 as a shift register, D4 as a nibble accumulator, D3 as output counter. Reads from (A0)+ source stream, uses (A1) as Huffman/lookup table with 2-byte entries (+$00 = signed delta, +$01 = length/nibble pair). On completion, writes 32-bit decoded value via MOVE.L D4,(A4) and decrements tile counter A5; loops until A5 reaches zero.

- **Entry**: A0 = compressed data stream pointer A1 = Huffman/lookup table A3 = return address for completed values (JMP (A3)) A4 = output buffer pointer A5 = tile counter D3 = remaining nibbles to fill D4 = nibble accumulator D5 = bit shift register (16-bit) D6 = remaining bits in shift register
- **Modifies**: D0, D1, D3, D4, D5, D6, D7, A0
*Source: [huffman_lz_decompression_inner_loop.asm](disasm/modules/68k/game/data/huffman_lz_decompression_inner_loop.asm)*

---

### tile_decompressor_inner_loop_a ($0011C2–$0011CE, 12 bytes)

Tile Decompressor Inner Loop A Decompression variant A: XOR-combine and store without post-increment. EORs D4 into D2, writes D2 to (A4), decrements counter A5, loops back to main decompressor body at $001182 if not done.

- **Entry**: D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = counter
- **Modifies**: D2, D4, A4, A5
*Source: [tile_decompressor_inner_loop_a.asm](disasm/modules/68k/game/data/tile_decompressor_inner_loop_a.asm)*

---

### tile_decompressor_inner_loop_b ($0011CE–$0011D8, 10 bytes)

Tile Decompressor Inner Loop B Decompression variant B: Store with post-increment, no XOR. Writes D4 to (A4)+, decrements counter A5, loops back to main decompressor body at $001182 if not done.

- **Entry**: D4 = tile data, A4 = VDP_DATA, A5 = counter
- **Modifies**: D4, A4, A5
*Source: [tile_decompressor_inner_loop_b.asm](disasm/modules/68k/game/data/tile_decompressor_inner_loop_b.asm)*

---

### tile_decompressor_inner_loop_c ($0011D8–$0011E4, 12 bytes)

Tile Decompressor Inner Loop C Decompression variant C: XOR-combine and store with post-increment. EORs D4 into D2, writes D2 to (A4)+, decrements counter A5, loops back to main decompressor body at $001182 if not done.

- **Entry**: D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = counter
- **Modifies**: D2, D4, A4, A5
*Source: [tile_decompressor_inner_loop_c.asm](disasm/modules/68k/game/data/tile_decompressor_inner_loop_c.asm)*

---

### tile_data_stream_byte_read ($0011E4–$0011EE, 10 bytes)

Tile Data Stream Byte Read Reads next byte from tile data stream (A0)+. If byte is $FF (end marker), returns to caller. Otherwise falls through to tile decompressor engine at $0011EE (tile_decompressor_engine).

- **Entry**: A0 = pointer to compressed tile data stream
- **Returns**: D0 = byte read; falls through if not $FF
- **Modifies**: D0, A0
*Source: [tile_data_stream_byte_read.asm](disasm/modules/68k/game/data/tile_data_stream_byte_read.asm)*

---

### tile_decompressor_engine ($0011EE–$0012F4, 262 bytes)

Tile Decompressor Engine Main tile decompression engine. Reads compressed tile commands from (A0)+ and decompresses to output buffer via (A1)+. Uses 8-way jump table at $0012CC for different decompression modes: 0-1: Sequential copy from base A2 (incrementing tile IDs) 2-3: Fill from base A4 (constant tile) 4: Literal tile (from bit-stream) 5: Incrementing tile sequence (from bit-stream) 6: Decrementing tile sequence (from bit-stream) 7: Individual tiles (each from bit-stream), $0F = end sentinel Second entry at $001236: Nametable decompressor variant — saves all regs, reads compressed nametable format with tile dimensions and bit-stream.

- **Entry**: A0 = compressed data, A1 = output buffer, D0 = initial value Entry (alt $001236): A0 = compressed nametable data, D0 = base offset
- **Modifies**: D0-D7, A0-A5
- **Calls**: $0012F4: tile_bit_stream_unpacker (BSR PC-relative) $0013A4: bit_stream_refill (BSR PC-relative)
*Source: [tile_decompressor_engine.asm](disasm/modules/68k/game/data/tile_decompressor_engine.asm)*

---

### tile_bit_stream_unpacker ($0012F4–$00136E, 122 bytes)

Tile Bit-Stream Unpacker Unpacks a tile value from a compressed bit-stream. Builds tile index in D3 by testing successive carry bits from ADD.B D1,D1 (shift left). For each set bit, reads a bit from the D5/D6 bit-stream to determine if the corresponding power-of-2 bit ($8000, $4000, $2000, $1000, $0800) is set in the output tile value. After 5 high bits, handles bit-stream boundary crossing: if remaining bits (D6) are less than needed (A5), refills from next bytes in (A0)+. Uses bitmask table at $001382 (tile_bit_stream_refill_with_mask_table) for variable-width extraction.

- **Entry**: D1 = bit-shift accumulator, D3 = base tile (from A3) D4 = shift control, D5 = bit-stream word, D6 = bits remaining
- **Returns**: D1 = updated, D3 = unpacked tile value
- **Modifies**: D0, D1, D3, D4, D5, D6, D7, A0
*Source: [tile_bit_stream_unpacker.asm](disasm/modules/68k/game/data/tile_bit_stream_unpacker.asm)*

---

### tile_bit_stream_refill_with_mask_table ($00136E–$0013B4, 70 bytes)

Tile Bit-Stream Refill with Mask Table Continuation of tile bit-stream unpacker. Contains: 1. Alternate refill path ($00136E): handles case where bit-stream crosses byte boundary — shifts, masks, and adds partial bits 2. Bitmask lookup table ($001382): 16 entries for variable-width bit extraction: $0001, $0003, $000F, $003F, $007F, $00FF, $01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF 3. Bit-stream refill subroutine ($0013A4): decrements D6 by D0, if D6 < 9, reads next byte from (A0)+ into D5 and adds 8 to D6

- **Entry**: D0 = bits needed, D5 = bit-stream, D6 = bits remaining, A0 = data
- **Modifies**: D0, D1, D5, D6, D7, A0, A5
*Source: [tile_bit_stream_refill_with_mask_table.asm](disasm/modules/68k/game/data/tile_bit_stream_refill_with_mask_table.asm)*

---

### tile_decompression_disp_a ($0014BE–$0014E0, 34 bytes)

Tile Decompression Dispatcher A Dispatches up to 4 tile decompression jobs packed in D0 (one byte per job). Iterates 4 times (D2=3), extracting each byte via ROR.L #8. For each non-zero byte: multiplies by 8 as index into parameter table at $0014E0, loads VDP command word to (A5) and source pointer to A0, then calls tile decompressor setup at $0010F4.

- **Entry**: D0 = 4 packed job IDs (one per byte), A5 = VDP_CTRL
- **Modifies**: D0, D1, D2, A0, A5
- **Calls**: $0010F4: tile_decompressor_setup (JSR PC-relative)
*Source: [tile_decompression_disp_a.asm](disasm/modules/68k/game/data/tile_decompression_disp_a.asm)*

---

### tile_decompression_disp_b ($0014E0–$00154E, 110 bytes)

Tile Decompression Dispatcher B Data prefix ($0014E0-$00152F): Tile decompression parameter table. Each 8-byte entry contains: VDP command word (long) + source ROM address (long). Entries correspond to tile set IDs used by tile_decompression_disp_a. Code entry at $001530: Alternate tile decompression dispatcher. Same 4-iteration pattern as tile_decompression_disp_a but calls the alternate decompressor entry at $001106 (which uses table base $008811CE). Loads parameters via PC-relative indexed access into the table.

- **Entry**: D0 = 4 packed job IDs (one per byte)
- **Modifies**: D0, D1, D2, D6, A0, A2, A4, A5
- **Calls**: $001106: tile_decompressor_setup_alt (JSR PC-relative)
*Source: [tile_decompression_disp_b.asm](disasm/modules/68k/game/data/tile_decompression_disp_b.asm)*

---

### descriptor_table_bit_unpacker_disp ($001586–$001610, 138 bytes)

Descriptor Table + Bit Unpacker Dispatcher Contains a 10-entry descriptor table (100 bytes) followed by code that iterates 4 bytes of D0 (via ROR.L #8), using each byte as an index to look up source/destination pointer pairs and call bit_unpack_loop. Descriptor table format: 10 entries × 5 words each {$0090, address, $00FF, $1000, $0011} Entries 1-2 are zeroed (unused). Valid addresses reference compressed data sources elsewhere in ROM.

- **Entry**: D0 = packed 4-byte index (each byte selects a descriptor)
- **Modifies**: D0, D1, D2, A0, A1, A2, A4, A5
- **Calls**: $0013B4 (bit_unpack_loop)
*Source: [descriptor_table_bit_unpacker_disp.asm](disasm/modules/68k/game/data/descriptor_table_bit_unpacker_disp.asm)*

---

### VDP Tile Unpack (12 regions) ($0024CA–$002594, 202 bytes)

Unpacks tile data to 12 VRAM regions via repeated calls to unpack_tiles_vdp. Each call sets a VRAM write address command via (A5) and loads A0 with the source tile data pointer. Skipped entirely if tile_update_flag ($C80D) is set.

- **Entry**: A5 = VDP control port
- **Modifies**: A0, A5
- **Calls**: $00247C: unpack_tiles_vdp (JSR PC-relative, called 12 times)
- **RAM**: $C80D: tile_update_flag (nonzero = skip) $C880: vscroll_a (set to $FFF8 during unpack)
*Source: [vdp_tile_unpack_0024ca.asm](disasm/modules/68k/game/data/vdp_tile_unpack_0024ca.asm)*

---

### VDP Tile Unpack (12× Calls to unpack_tiles_vdp) ($0025B0–$00263E, 142 bytes)

If skip_flag ($C80D) is clear: unpacks tile data to two VRAM nametable rows via 12 calls to unpack_tiles_vdp ($00247C). Row A: VDP addresses $6502/$6514/$651E/$6528/$6532 (6 calls). Row B: VDP addresses $6602/$6614/$661E/$6628/$6632 (6 calls). Uses tile_source_ptr ($C888) as source, advancing by 8 between rows and restoring after.

- **Modifies**: A0, A5
- **Calls**: $00247C: unpack_tiles_vdp (12×)
- **RAM**: $C80D: skip_flag (byte, nonzero = skip) $C888: tile_source_ptr (longword)
*Source: [vdp_tile_unpack_0025b0.asm](disasm/modules/68k/game/data/vdp_tile_unpack_0025b0.asm)*

---

### Bulk Table Copy (Two ROM Blocks to RAM) ($00A83E–$00A866, 40 bytes)

Copies two ROM data blocks to RAM during initialization: Block 1: 288 bytes from $00937E7E to ($FAD8).W Block 2: 432 bytes from $00937F9E to ($FBF8).W

- **Modifies**: D0, A1, A2
*Source: [bulk_table_copy.asm](disasm/modules/68k/game/data/bulk_table_copy.asm)*

---

### word_to_nibble_unpacker ($00B43C–$00B478, 60 bytes)

Word-to-Nibble Unpacker Unpacks two words from (A1) into individual nibble bytes at (A3). Reads +$02(A1) → shifts right 4 bits at a time to fill +$07,+$06,+$05. Reads (A1) → shifts right to fill +$04,+$03,+$02,+$01. Masks results with ANDI to keep only low nibble per byte. Used by sequence/sound system for BCD-style data unpacking.

- **Entry**: A1 = source word pointer, A3 = output nibble buffer
- **Modifies**: D0, A1, A3
- **Confidence**: high
*Source: [word_to_nibble_unpacker.asm](disasm/modules/68k/game/data/word_to_nibble_unpacker.asm)*

---

## Game / Entity

### Entity Visibility Check ($002C9A–$002CDA, 66 bytes)

Determines entity visibility based on race mode, entity flags, and global state. Writes visibility (0 or 1) to four display slots.

- **Entry**: A0 = entity, A2 = display slot buffer
- **Modifies**: D0
*Source: [entity_visibility_check.asm](disasm/modules/68k/game/entity/entity_visibility_check.asm)*

---

### Object Field Clear (Conditional) ($002EC6–$002EEE, 40 bytes)

If $C31C is nonzero and obj.field_E5 bit 3 is set: clears 7 fields of target object (A1) at offsets $00/$14/$28/$3C/$50/$64 to zero. Otherwise exits to $002EEE.

- **Entry**: A0 = source object, A1 = target object
- **Modifies**: D0, A0, A1
- **RAM**: $C31C: enable flag (byte)
- **Object fields**: A0+$E5: control flags (byte, bit 3) A1+$00/$14/$28/$3C/$50/$64: animation fields (word, cleared)
*Source: [object_field_clear.asm](disasm/modules/68k/game/entity/object_field_clear.asm)*

---

### Object Table Lookup Loop (6 Iterations) ($0058EA–$005908, 30 bytes)

Masks D0 with $0130 — if non-zero, branches back to previous function. Otherwise clears $FF5FFE, loads object table base ($9100) into A0, and calls table_lookup ($0059EC) 6 times.

- **Entry**: D0 = status bits | Exit: table processed | Uses: D0, D7, A0
- **RAM**: $00FF5FFE = SH2 shared byte (cleared) $FFFF9100 = object table base (address loaded into A0)
*Source: [object_table_lookup_loop.asm](disasm/modules/68k/game/entity/object_table_lookup_loop.asm)*

---

### Object Table Clear Loop ($005926–$00593C, 22 bytes)

If D0 has any bits in $0130 set, branches back (to caller's loop). Otherwise, loads the object table base at $9700 and calls table_lookup ($0059EC) 8 times to process entries.

- **Entry**: D0 = status flags | Exit: table processed
- **Modifies**: D0, D7, A0
- **RAM**: $FFFF9700 = object table 2 base (address, loaded into A0)
*Source: [object_table_clear_loop.asm](disasm/modules/68k/game/entity/object_table_clear_loop.asm)*

---

### player_entity_frame_update ($005D08–$005DC8, 192 bytes)

Player Entity Frame Update Per-frame player entity update. Sets player-active flag, clears display offsets, runs steering/physics/rendering pipeline (20 subroutines), then dispatches to mode-specific handler via jump table indexed by race state. Transitions to race start when frame counter reaches $0014.

- **Entry**: A0 = player entity pointer
- **Modifies**: D0, A0, A1
- **RAM**: $C89C sh2_comm_state, $C8A0 race_state, $C8AA scene_state, $C8AC state_dispatch_idx
- **Object fields**: +$44 display_offset, +$46 display_scale, +$4A display_aux
- **Confidence**: high
*Source: [player_entity_frame_update.asm](disasm/modules/68k/game/entity/player_entity_frame_update.asm)*

---

### Object Bitmask Table + Lookup ($006B96–$006BCA, 52 bytes)

40-byte data table of 10 bitmask pairs (powers of 2 from 1-512), followed by 3-instruction lookup: reads word index from $C07A, fetches word from object_bitmask_table_button_flag_handler's bitmask table ($006BCA) indexed by that value, stores result to $C26C.

- **Modifies**: D0
- **RAM**: $C07A: bitmask table index (word) $C26C: bitmask lookup result (word)
*Source: [object_bitmask_table_lookup.asm](disasm/modules/68k/game/entity/object_bitmask_table_lookup.asm)*

---

### Object Position Table Lookup ($006D50–$006D6E, 30 bytes)

Increments object+$1C frame counter, multiplies by 4 (two ADD.W D0,D0), then indexes into the position table pointed to by $C700 to set object X (+$30) and Y (+$34) positions.

- **Entry**: A0 = object pointer | Exit: position updated | Uses: D0, A0, A2
- **RAM**: $FFFFC700 = position table pointer (long, loaded into A2)
*Source: [object_pos_table_lookup.asm](disasm/modules/68k/game/entity/object_pos_table_lookup.asm)*

---

### Object Link Copy + Table Lookup ($00714A–$0071A6, 92 bytes)

Follows object link (A0+$CE → A1), copies type byte A1+$1B to A0+$1D. Looks up byte from table_ptr_A ($C704)[type] → A0+$25. Computes index D0×4 via table_ptr_B ($C700), copies word pair to A0+$20/$22. Extracts heading high byte from A1+$1A → A0+$1E. Copies A1+$19 → A0+$E5, sets A0+$E4 = 1 if A0+$E5 bit 0 set.

- **Modifies**: D0, D1, A0, A1, A2
- **RAM**: $C700: table_ptr_B (longword, word-pair table) $C704: table_ptr_A (longword, byte table) Object (A0): +$1D: type copy (byte) +$1E: heading (word, from A1+$1A high byte) +$20: position X (word, from table) +$22: position Y (word, from table) +$25: table value (byte) +$27: prev table value (byte) +$CE: link pointer (longword → A1) +$E4: flip flag (byte, 0 or 1) +$E5: type flags (byte, from A1+$19)
*Source: [object_link_copy_table_lookup.asm](disasm/modules/68k/game/entity/object_link_copy_table_lookup.asm)*

---

### object_type_return_007a8e ($007A8E–$007A92, 4 bytes)

Object Type Return — Type 2 Returns constant 2 in D0. Target of object_type_dispatch jump table, indicating object type classification 2 (e.g., scenery/non-collidable).

- **Entry**: (from jump table dispatch)
- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007a8e.asm](disasm/modules/68k/game/entity/object_type_return_007a8e.asm)*

---

### object_type_return_007aaa ($007AAA–$007AAE, 4 bytes)

Object Type Return — Type 2 (B) Returns constant 2 in D0. Jump table target for object type dispatch, indicating type classification 2.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007aaa.asm](disasm/modules/68k/game/entity/object_type_return_007aaa.asm)*

---

### object_type_return_007aae ($007AAE–$007AB2, 4 bytes)

Object Type Return — Type 2 (C) Returns constant 2 in D0. Jump table target for object type dispatch, indicating type classification 2.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007aae.asm](disasm/modules/68k/game/entity/object_type_return_007aae.asm)*

---

### object_type_return_007c32 ($007C32–$007C36, 4 bytes)

Object Type Return — Type 2 (D) Returns constant 2 in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c32.asm](disasm/modules/68k/game/entity/object_type_return_007c32.asm)*

---

### object_type_return_007c36 ($007C36–$007C3A, 4 bytes)

Object Type Return — Type 4 Returns constant 4 in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c36.asm](disasm/modules/68k/game/entity/object_type_return_007c36.asm)*

---

### object_type_return_007c3a ($007C3A–$007C3E, 4 bytes)

Object Type Return — Type 8 Returns constant 8 in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c3a.asm](disasm/modules/68k/game/entity/object_type_return_007c3a.asm)*

---

### object_type_return_007c3e ($007C3E–$007C42, 4 bytes)

Object Type Return — Type 16 Returns constant $10 (16) in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c3e.asm](disasm/modules/68k/game/entity/object_type_return_007c3e.asm)*

---

### object_type_return_007c42 ($007C42–$007C46, 4 bytes)

Object Type Return — Type 2 (E) Returns constant 2 in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c42.asm](disasm/modules/68k/game/entity/object_type_return_007c42.asm)*

---

### object_type_return_007c46 ($007C46–$007C4A, 4 bytes)

Object Type Return — Type 2 (F) Returns constant 2 in D0. Jump table target for object type dispatch.

- **Modifies**: D0
- **Confidence**: high
*Source: [object_type_return_007c46.asm](disasm/modules/68k/game/entity/object_type_return_007c46.asm)*

---

### entity_flag_bit_test_guard ($0083BC–$0083C6, 10 bytes)

Entity Flag Bit Test Guard Tests bit 6 of entity flags field +$02(A0). If set, falls through past RTS to continue processing. If clear, returns immediately. Guards subsequent code from executing on inactive entities.

- **Entry**: A0 = entity pointer
- **Modifies**: A0
- **Object fields**: +$02 flags (bit 6 = processing gate)
- **Confidence**: high
*Source: [entity_flag_bit_test_guard.asm](disasm/modules/68k/game/entity/entity_flag_bit_test_guard.asm)*

---

### Entity Position Init (Table Fill + Compare) ($009124–$009182, 94 bytes)

Initializes entity position table. If ($EEDC).L != 0, fills with $7FFF0000. Then compares entity positions and conditionally copies.

- **Entry**: A0 = entity
- **Modifies**: D0, D1, D7, A1, A2
*Source: [entity_position_init.asm](disasm/modules/68k/game/entity/entity_position_init.asm)*

---

### Entity Speed Clamp ($009B12–$009B32, 32 bytes)

Clamps entity speed to max, multiplies by $48, stores result.

- **Entry**: A0 = entity
- **Modifies**: D0
*Source: [entity_speed_clamp.asm](disasm/modules/68k/game/entity/entity_speed_clamp.asm)*

---

### Entity Table Load (Mode-Based) ($00A7E2–$00A808, 38 bytes)

Loads entity data from a ROM speed/attribute table into RAM entity entries. Table entry is selected by mode index at ($C89C), 32 bytes per entry. Copies one word per entity into two fields (+$B6 and +$A) for 15 entities.

- **Modifies**: D0, A1, A2
- **RAM**: ($C89C).W: Mode/table index ($9100).W: Entity table base (stride 256 bytes per entity)
*Source: [entity_table_load.asm](disasm/modules/68k/game/entity/entity_table_load.asm)*

---

### Entity Table Load (Mode+Index Combined) ($00A80A–$00A83C, 50 bytes)

Loads entity data from a RAM lookup table into entity entries, using a combined mode and secondary index to select the table offset. Mode contributes stride of 96, secondary index contributes stride of 32.

- **Modifies**: D0, D1, A1, A2
- **RAM**: ($FDA9).W: Secondary table index (byte) ($FAD8).W: RAM lookup table base ($C8C8).W: Mode flag ($9100).W: Entity table base (stride 256)
*Source: [entity_table_load_mode.asm](disasm/modules/68k/game/entity/entity_table_load_mode.asm)*

---

### Object State Return ($00A8F8–$00A970, 120 bytes)

Computes or interpolates a position value for an entity. Two paths depending on whether A0+$04 (speed index) is nonzero: Path 1 (speed-based): speed * lookup_table[index] * 596, scaled by >>12 Result clamped to 0-17000, stored at A0+$74 Path 2 (interpolation): delta toward target*64, clamped +-1024/768 Result clamped to 0-16000, stored at A0+$74 and A0+$7E

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, A1 Fields accessed: A0+$04: Speed index (0 = use interpolation path) A0+$06: Speed value A0+$0E: Interpolation target value A0+$74: Current position value (read/write) A0+$7A: Lookup table index A0+$7E: Position mirror (written in path 2 only)
- **RAM**: ($C278).W: Pointer to lookup table
*Source: [obj_state_return.asm](disasm/modules/68k/game/entity/obj_state_return.asm)*

---

### Entity Target Action ($00AD14–$00ADC2, 174 bytes)

Chained from ai_target_check via BNE.S when conditions met. Computes speed/distance between two entities (A0, A1), adjusts speed values, flips directional bits, and either returns or chains to entity_directional_push at $AED8.

- **Entry**: A0 = object, A1 = entity target (from ai_target_check)
- **Modifies**: D0-D3 Fields accessed: A0/A1+$02: Status flags (ORI.W bit-set) A0/A1+$04: Speed value A0/A1+$06: Speed parameter A0+$88: Direction flags
- **RAM**: ($C8A4).W: Active AI mode byte ($C8CE).W: Speed threshold ($C8D0).W: Position threshold
*Source: [entity_target_action.asm](disasm/modules/68k/game/entity/entity_target_action.asm)*

---

### Entity Directional Push ($00AED8–$00AF16, 62 bytes)

Applies a fixed directional offset ($18 = 24 units) to entity X/Y position based on 4 direction bits in A0+$88: Bit 0: X += D1, Y -= D1  (push right-up) Bit 1: X -= D1, Y -= D1  (push left-up) Bit 2: X += D1, Y += D1  (push right-down) Bit 3: X -= D1, Y += D1  (push left-down)

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1 Fields accessed: A0+$30: X position (modified) A0+$34: Y position (modified) A0+$88: Direction flags (bits 0-3)
*Source: [entity_directional_push.asm](disasm/modules/68k/game/entity/entity_directional_push.asm)*

---

### Backward Object Scan + Copy Scroll Data ($00BD00–$00BD2A, 42 bytes)

Scans backward through 16-byte object entries starting from A0, skipping entries with type byte $0C. Copies 6 words from the first non-$0C entry to scroll/position registers. Same destination registers as clear_state_copy_scroll_data_object.

- **Entry**: A0 = object pointer (scan start)
- **Modifies**: A1
- **RAM**: $C086: scroll register 1 (word) $C054: scroll register 2 (word) $C056: scroll register 3 (word) $C0AE: position register 1 (word) $C0B0: position register 2 (word) $C0B2: position register 3 (word)
*Source: [backward_object_scan_copy_scroll_data.asm](disasm/modules/68k/game/entity/backward_object_scan_copy_scroll_data.asm)*

---

### Object Field Store Helper ($00C9AE–$00C9B6, 8 bytes)

Source: code_c200 Stores a word value and a long pointer into an object entry. Used as a helper subroutine during object table initialization. - Writes D0 (word) to the base of the object entry at (A1) - Copies the next long from the ROM table pointer (A4) into offset $10 of the object entry, advancing A4 to the next table value

- **Entry**: D0 = word value to store at object base A1 = object entry pointer A4 = ROM table cursor (advanced by 4 after call)
- **Returns**: Object fields written, A4 advanced
- **Modifies**: A4 (post-incremented)
*Source: [object_field_store_helper.asm](disasm/modules/68k/game/entity/object_field_store_helper.asm)*

---

### Object Array Initialization from ROM Tables ($00CC06–$00CC72, 108 bytes)

Source: code_c200 Initializes a 15-element object array in work RAM at $FF6218. Each object entry is 60 bytes ($3C). Data comes from two ROM tables, selected by an index value at $C8CC, plus a shared state pointer at $C73C. For each of the 15 objects, the function: 1. Writes constant 1 to three status fields (offsets $00, $14, $28) 2. Copies 3 longs from the primary ROM table (offsets $10, $24, $38) 3. Copies geometry data from the state pointer (offsets $16, $1A, $2A, $2E) After the main loop, a second loop copies one word per object from a secondary ROM table into offset $0E of each 60-byte entry. OBJECT ENTRY LAYOUT (60 bytes each) +$00  Status word 1 (set to 1) +$0E  Secondary table value (word, from second loop) +$10  Primary table value A (long) +$14  Status word 2 (set to 1) +$16  Geometry data A (long, from state pointer) +$1A  Geometry data B (word, from state pointer) +$24  Primary table value B (long) +$28  Status word 3 (set to 1) +$2A  Geometry data C (long, from state pointer) +$2E  Geometry data D (word, from state pointer) +$38  Primary table value C (long) ROM TABLES $008958B4  Primary table index (array of long pointers, indexed by D1) $0093816C  Secondary table index (array of long pointers, indexed by D1) MEMORY VARIABLES $FFFFC73C  Geometry state pointer (long, read into A2 each iteration) $FFFFC8CC  Table index selector (word, selects which ROM table entry) $00FF6218  Object array base (15 entries × 60 bytes = 900 bytes) $00FF6226  Secondary value base (offset $0E within object array)

- **Entry**: No register inputs (reads index from $C8CC)
- **Returns**: 15 objects initialized in $FF6218 area
- **Modifies**: D0, D1, D7, A1, A2, A3, A4
*Source: [object_array_init_rom_tables.asm](disasm/modules/68k/game/entity/object_array_init_rom_tables.asm)*

---

### Object Table Init ($00CD4C–$00CD92, 70 bytes)

256-Byte Entry Array Source: code_c200 Initializes a 15-element object table at $FFFF9100, with each entry being 256 ($100) bytes. Data comes from two ROM sources selected by the current game mode ($C8A0). For each of the 15 entries, the function: 1. Loads a pointer from the primary ROM table into offset $18 2. Copies a word from the secondary ROM table into offset $C2 3. Writes sequential counters (wrapping 0-15) into offsets $A4 and $A6 The counters D0 and D1 start at 0 and 2 respectively, incrementing with wrap-around at 16 (AND #$000F), providing staggered phase indices. ROM TABLES $00898A7C  Primary table index (array of long pointers, indexed by game mode) $0093814E  Secondary table (flat word array, sequential read) MEMORY VARIABLES $FFFFC8A0  Game mode × 4 (word, used as long-pointer table index) $FFFF9100  Object table base (15 entries × 256 bytes = 3840 bytes)

- **Entry**: No register inputs
- **Returns**: 15 object entries initialized at $FFFF9100
- **Modifies**: D0, D1, D7, A0, A1, A2, A3
*Source: [object_table_init_entry_array.asm](disasm/modules/68k/game/entity/object_table_init_entry_array.asm)*

---

### Object Entry Loader ($00CDD2–$00CE02, 48 bytes)

16-Entry Loop with Table Lookup Source: code_c200 Initializes 16 consecutive 256-byte object entries at $FFFF9000 by performing a double-indexed ROM table lookup and calling the shared copy_entry_fields subroutine (in fn_c200_048) for each entry. After the loop, clears a control long at $FFFF902C. ROM TABLE $009382BA  Table index (double-indexed: track × 4, then mode × 4 + D0) MEMORY VARIABLES $FFFFC8A0  Game mode × 4 (word, added to D0) $FFFFC8CC  Track × 4 (word, primary index) $FFFF9000  Object table base (16 entries × 256 bytes) $FFFF902C  Control field (long, cleared after init)

- **Entry**: D0 = base entry offset (added to game mode for sub-index)
- **Returns**: 16 object entries loaded, control field cleared
- **Modifies**: D0, D2, D7, A0, A1
*Source: [object_entry_loader_loop_table_lookup.asm](disasm/modules/68k/game/entity/object_entry_loader_loop_table_lookup.asm)*

---

### Dual Object Entry Init ($00CE02–$00CE22, 32 bytes)

Primary and Alternate Entries Source: code_c200 Initializes two specific object entries: the primary entry at $FFFF9000 and an alternate entry at $FFFF9F00. Calls object_entry_data_copy (fn_c200_048) for the full table lookup + copy on the primary entry, then calls the shared copy_entry_fields subroutine directly for the alternate entry (reusing the data pointer A1 from the first call). After each copy, sets counter fields at offsets $A4/$A6: Primary ($9000):  both set to $000F (maximum) Alternate ($9F00): both set to $0000 (zero / D1) MEMORY VARIABLES $FFFF9000  Primary object entry (256 bytes) $FFFF9F00  Alternate object entry (256 bytes)

- **Entry**: D0 = entry offset selector (passed to object_entry_data_copy)
- **Returns**: Both entries initialized with counter fields set
- **Modifies**: D0, D1, D2, A0, A1
*Source: [dual_object_entry_init_primary_alternate.asm](disasm/modules/68k/game/entity/dual_object_entry_init_primary_alternate.asm)*

---

### Object Entry Data Copy (with Shared Field Copy Subroutine) ($00CE22–$00CE56, 52 bytes)

Source: code_c200 Copies field data from a ROM table into a single 256-byte object entry. Performs a double-indexed ROM table lookup: first by track ($C8CC), then by a caller-provided offset in D0 (combined with game mode from $C8A0). The field copy subroutine at `copy_entry_fields` is shared across multiple object entry loaders (fn_c200_046, fn_c200_047, fn_c200_049). FIELD COPY SUBROUTINE (copy_entry_fields) Copies 5 words and 1 long from ROM data into an object entry: +$30: word from (A1)+ +$32: word from (A1)+ +$34: word from (A1)+ +$3C: word from (A1)  (no advance — duplicated to $40) +$40: word from (A1)+ (same value as $3C, then advance) +$2C: long from D1    (caller-provided value) Entry:  A0 = object entry pointer A1 = ROM data source (advanced by 8 bytes) D1 = value for offset $2C Exit:   A1 advanced past copied data Uses:   A1 (post-incremented) ROM TABLE $009382BA  Table index (array of long pointers, indexed by track then mode) MEMORY VARIABLES $FFFFC8A0  Game mode × 4 (word, added to D0 for sub-index) $FFFFC8CC  Track × 4 (word, primary table index) $FFFF9000  Object entry base (256 bytes per entry)

- **Entry**: D0 = entry offset selector (combined with game mode) D1 = value for object field $2C
- **Returns**: Object entry fields populated
- **Modifies**: D0, D2, A0, A1
*Source: [object_entry_data_copy.asm](disasm/modules/68k/game/entity/object_entry_data_copy.asm)*

---

### Object Entries Reset ($00CE56–$00CE76, 32 bytes)

16-Entry Init from Fixed Table Source: code_c200 Initializes 16 consecutive 256-byte object entries at $FFFF9000 using data from a fixed ROM table at $00938EAE. Unlike fn_c200_046 which does a double-indexed lookup by track and mode, this function always uses the same source data (a default/reset configuration). Calls the shared copy_entry_fields subroutine (in fn_c200_048) for each entry, then clears the control long at $FFFF902C. ROM TABLE $00938EAE  Fixed field data source (sequential read by copy_entry_fields) MEMORY VARIABLES $FFFF9000  Object table base (16 entries × 256 bytes) $FFFF902C  Control field (long, cleared after init)

- **Entry**: No register inputs
- **Returns**: 16 object entries reset, control field cleared
- **Modifies**: D7, A0, A1
*Source: [object_entries_reset_init_fixed_table.asm](disasm/modules/68k/game/entity/object_entries_reset_init_fixed_table.asm)*

---

### Object Update + Conditional Game State Advance ($00D8B8–$00D8CC, 20 bytes)

Calls object_update ($00B684), then checks sync flag bit 6. If clear, advances the main game state by 4. If set, skips.

- **Entry**: none | Exit: state optionally advanced | Uses: none
- **RAM**: $FFFFC80E = sync/transition flags (byte, bit 6 tested) $FFFFC87E = main game state (word, conditionally incremented by 4)
*Source: [object_update_cond_game_state_advance.asm](disasm/modules/68k/game/entity/object_update_cond_game_state_advance.asm)*

---

## Game / Hud

### Conditional Tile Index Expand ($002594–$0025B0, 28 bytes)

Tests VDP update flag ($C80D). If non-zero, returns immediately. Otherwise loads frame counter address ($C886) into A0, writes VDP command $622A0002 to VDP port (A5), calls tile_index_expand at $0024AE, then clears the frame counter.

- **Entry**: A5 = VDP port | Exit: tiles updated or skipped | Uses: A0, A5
- **RAM**: $FFFFC80D = VDP update flag (byte, tested) $FFFFC886 = frame counter (byte/source addr for tile expand, cleared)
*Source: [conditional_tile_index_expand.asm](disasm/modules/68k/game/hud/conditional_tile_index_expand.asm)*

---

### sprite_hud_layout_builder ($003C2A–$003CCE, 164 bytes)

Sprite/HUD Layout Builder Builds 4 sprite entries at $FF66DC from two PC-relative data tables: - Animation table at sprite_hud_layout_builder (18 words): indexed by race_state + comm_sub - Position table at .pos_table (24 words = 3 groups × 8 words): indexed by vint_state × 16 Each sprite entry (20 bytes at $14 stride) gets: +$00: visibility flag ($0001) +$02: anim_word + pos_offset (added) +$04: anim_word (direct copy) +$06: anim_word - pos_offset (subtracted) Alternate exit at $3CC4: loads RAM $C026, returns if negative.

- **Modifies**: D0, D1, D2, A1, A2, A3
- **RAM**: $C89E (sh2_comm_sub), $C8A0 (race_state), $C8C8 (vint_state), $C026
*Source: [sprite_hud_layout_builder.asm](disasm/modules/68k/game/hud/sprite_hud_layout_builder.asm)*

---

### HUD Element Initialization ($003D5A–$003D9A, 64 bytes)

configure 3 HUD display slots Initializes 3 HUD element slots with type $09 and ROM data pointers: Slot 1 ($FF6980): type=$09, data=$040268F8, aux=$222F0FBE Slot 2 ($FF69C0): type=$09 (data inherited/zero) Slot 3 ($FF6990): type=$09, data=$0402C8EC, aux=$222F22A2 Each slot is a 64-byte structure with type at +$00, data pointer at +$04, auxiliary pointer at +$08.

- **Modifies**: A1
- **Confidence**: medium
*Source: [hud_element_init.asm](disasm/modules/68k/game/hud/hud_element_init.asm)*

---

### digit_extraction_via_division ($0082E8–$0082FA, 18 bytes)

Digit Extraction via Division Data prefix (2 bytes) followed by a division chain. Performs three successive DIVU operations to extract digits from D1, writing each remainder byte to the output buffer via OR.B D1,(A0)+.

- **Entry**: D1 = value to extract digits from, A0 = output buffer pointer
- **Modifies**: D1, A0
- **Confidence**: medium
*Source: [digit_extraction_via_division.asm](disasm/modules/68k/game/hud/digit_extraction_via_division.asm)*

---

### BCD Scoring Calculation ($00B25E–$00B2D8, 122 bytes)

Reads 4 seed bytes + 18 groups of 4 params from a RAM buffer at $C200. For each group, performs chained ABCD (add with extend) to accumulate a BCD score across D0/D1/D2/D6. Uses SBCD to check overflow against a threshold in D7. Writes final 4-byte BCD result back to $C260.

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7
- **RAM**: $C200: bcd_input_buffer (4 seed bytes + 18×4 param bytes) $C260: bcd_result (4 bytes output)
*Source: [bcd_scoring_calc.asm](disasm/modules/68k/game/hud/bcd_scoring_calc.asm)*

---

### BCD Time Update 010 ($00B2FC–$00B36E, 114 bytes)

Updates BCD time counter (MM:SS:FF format) Reads speed factor from lookup table, scales by obj speed Subtracts BCD delta from time digits using SBCD instructions Clamps minutes to $59

- **Entry**: A0 = object/entity pointer; A1 = BCD time buffer (4 bytes: [0]=min, [1]=sec_hi, [2]=sec_lo, [3]=frames)
- **Modifies**: D0, D1, D2, A0, A1, A3
- **RAM**: $C89E: speed_factor_index Data table (external, at ai_table_lookup_cond_fall_through): Speed factor lookup at $00B2D8 (PC-relative) Object fields (A0): +$06: obj_speed (divisor) +$E2: speed_offset (added to factor)
- **Confidence**: high
*Source: [bcd_time_update_010.asm](disasm/modules/68k/game/hud/bcd_time_update_010.asm)*

---

### bcd_nibble_subtractor ($00B478–$00B4CA, 82 bytes)

BCD Nibble Subtractor Performs BCD subtraction on nibble pairs stored at (A4). Clears extend flag, then subtracts source nibbles (+$04-$07) from destination nibbles (+$00-$03) using SBCD. Handles carry propagation with ORI.B #$10,CCR to set extend. Clamps result at $59 (max 59 minutes/seconds). Paired with word_to_nibble_unpacker (nibble unpacker).

- **Entry**: A4 = nibble buffer pointer
- **Modifies**: D0, D1, A4
- **Confidence**: high
*Source: [bcd_nibble_subtractor.asm](disasm/modules/68k/game/hud/bcd_nibble_subtractor.asm)*

---

### Display Digit Extract (Multi-Entry) ($00B4CA–$00B55A, 144 bytes)

Multiple entry points for extracting BCD/display digits from various game values. Each path looks up a digit pair from a ROM table at $00899884 (indexed by value×2), then splits into high and low nibbles for display buffer output. Entry 1 ($00B4CA): copy scroll data + JMP to copy routine Entry 2 ($00B4DC): scroll_state → digit pair → display Entry 3a ($00B4F8): H-scroll value → digit pair → display Entry 3b ($00B504): V-scroll value → digit pair → display Entry 4 ($00B522): track sector → name + digit pair → display

- **Modifies**: D0, D1, A0, A1, A2
- **Calls**: $004920: data_copy (JMP PC-relative)
- **RAM**: $9004: vscroll_lookup $9F04: hscroll_lookup $C050: scroll_state $C200: game_data (source for copy) $C254: camera_scroll $C30C: track_sector $EEDC: display_buf_copy_dest $EEFC: camera_scroll_display
*Source: [display_digit_extract.asm](disasm/modules/68k/game/hud/display_digit_extract.asm)*

---

### HUD Panel Config ($00B55A–$00B58E, 52 bytes)

Conditionally configures a HUD panel structure at $FF69E0. If ($C819).W flag is set, exits immediately. Otherwise: sets tile reference based on lap comparison, and enables/disables panel based on ($C967).W bit 4.

- **Modifies**: D0, D1
- **RAM**: ($C819).W: Guard flag (non-zero = skip) ($902A).W: Current lap value ($9F2A).W: Lap threshold ($C967).W: Config bits (bit 4 checked) $FF69E0+$00: Panel enable (byte) $FF69E0+$04: Tile reference (long)
*Source: [hud_panel_config.asm](disasm/modules/68k/game/hud/hud_panel_config.asm)*

---

### HUD Activate Check ($00BDA8–$00BDC6, 30 bytes)

Conditionally activates HUD elements: If ($A0F0).W != 0, exit (already active) If bit 1 of ($C8AB).W is clear, exit Otherwise: set $FF60C8 = $FFFF, $FF6850 = $09

- **Modifies**: (none modified)
- **RAM**: ($A0F0).W: Active flag (must be 0) ($C8AB).W: Mode bits (bit 1 checked) $FF60C8: HUD enable flag (set to $FFFF) $FF6850: HUD mode (set to $09)
*Source: [hud_activate_check.asm](disasm/modules/68k/game/hud/hud_activate_check.asm)*

---

### display_entry_builder ($00BEFC–$00BF9E, 162 bytes)

Display Entry Builder (5 Racers) Builds 5 display entries at $FF6900 from racer data in RAM table ($EF08) and ROM data at $0088C05C (display_list_builder data prefix). Each entry includes counter, racer fields, nibble-extracted speed digits, and position data. The 6 MOVE.L instructions at the start form a dispatch table — external code jumps to display_entry_builder + index×4 to select which A6-relative value to load into D1 before falling through to the main code.

- **Entry**: A6 = base pointer for dispatch table offsets
- **Modifies**: D0, D1, D2, D3, A1, A2, A3
- **RAM**: $A0EA (buffer_write_index), $A0EE (entry_counter), $C89C (sh2_comm_state), $C8CA (race_substate_read), $C8CC (race_substate), $EF08 (racer_data_table)
*Source: [display_entry_builder.asm](disasm/modules/68k/game/hud/display_entry_builder.asm)*

---

### HUD Buffer Clear ($00C028–$00C05A, 50 bytes)

Clears HUD display buffer entries: - Zeroes first byte at $FF6800, $FF6810, $FF6820 - Clears 6 word entries at $FF6900 with $14 stride

- **Modifies**: D0, D1, A1
- **RAM**: $FF6800: HUD entry 0 (byte cleared) $FF6810: HUD entry 1 (byte cleared) $FF6820: HUD entry 2 (byte cleared) $FF6900: HUD table (6 words at stride $14, cleared)
*Source: [hud_buffer_clear.asm](disasm/modules/68k/game/hud/hud_buffer_clear.asm)*

---

### Display List Builder ($00C05C–$00C0F0, 148 bytes)

Clears 16 display slots ($FF6800, stride $10), then if display_list_count ($C0FC) is nonzero, reads entries from a ROM offset table and populates slots with sprite data. Scroll_offset ($C0FE) is subtracted from each Y position; entries with negative Y are skipped, positive clamped to $0050. Scroll_offset increments by 8 per frame, clamped to $7FFF. Data table (20 bytes, 5 entries × 4 bytes): +$00: $0402,$C030  $0402,$E030  $0403,$0030  $0403,$2030  $0403,$4030

- **Modifies**: D0, D1, D2, D3, A1, A2
- **RAM**: $C0FC: display_list_count (word, signed; bit 15 = processed flag) $C0FE: scroll_offset (word, clamped to $7FFF) ROM tables: $0089ACF0: display_entry_ptr_table (longword pointers indexed by count×4)
*Source: [display_list_builder.asm](disasm/modules/68k/game/hud/display_list_builder.asm)*

---

### Score/Stat Lookup and Accumulate ($00CEC2–$00CEEE, 44 bytes)

Dual Entry Point Source: code_c200 Looks up a score or stat modifier from a PC-relative data table and adds it to an accumulator at $C0E8. Has two entry points for different object table bases (primary at $FFFF9000, alternate at $FFFF9F00). The lookup index is computed from: - A byte from $FEAD (primary) or $FEAE (alternate), sign-extended × 2 - Track index: ($C8CC × 2) + $C8CA = track × 10 Combined: index = 2 × sign_ext(byte) + track × 10 The data table is located at the start of entity_heading_and_turn_rate_calculator ($CEEE), accessed via PC-relative indexed read. The table words are interleaved with the code of entity_heading_and_turn_rate_calculator (a common compiled-code optimization). ENTRY POINTS score_stat_lookup_accum_dual   Primary:   A0=$FFFF9000, input from $FEAD c200_func_020b  Alternate: A0=$FFFF9F00, input from $FEAE MEMORY VARIABLES $FFFFFEAD  Input byte for primary entry (sign-extended) $FFFFFEAE  Input byte for alternate entry (sign-extended) $FFFFC8CA  Track × 2 (word, added to index) $FFFFC8CC  Track × 4 (word, doubled to track × 8) $FFFFC0E8  Accumulator (word, lookup value added to it)

- **Entry**: No register inputs (entry point selects configuration)
- **Returns**: Accumulator updated with looked-up modifier
- **Modifies**: D0, D1, A0
*Source: [score_stat_lookup_accum_dual.asm](disasm/modules/68k/game/hud/score_stat_lookup_accum_dual.asm)*

---

### lap_time_digit_renderer_a ($010606–$01063A, 52 bytes)

Lap Time Digit Renderer A Renders a BCD-encoded lap time as digit tiles to SH2 framebuffer region A ($06023200). Reads 4 bytes from (A2)+: byte 1 → 2 digit tiles + separator (tile 10), byte 2 → 2 digits + separator (tile 11), byte 3 → 1 digit (low nibble only), byte 4 → 2 digits. Total: 7 digit tiles + 2 separators.

- **Entry**: A1 = destination tile pointer, A2 = BCD time data pointer
- **Returns**: A1 advanced past tiles, A2 advanced 4 bytes
- **Modifies**: D1, D3, A1, A2
- **Calls**: bcd_nibble_splitter_a: BCD nibble splitter (high + low digit tiles) digit_tile_dma_to_framebuffer_a: single digit tile DMA to framebuffer A
*Source: [lap_time_digit_renderer_a.asm](disasm/modules/68k/game/hud/lap_time_digit_renderer_a.asm)*

---

### bcd_nibble_splitter_a ($01063A–$010656, 28 bytes)

BCD Nibble Splitter A Splits byte in D3 into high nibble (shift right 4) and low nibble (AND $0F), rendering each as a digit tile via digit_tile_dma_to_framebuffer_a. Advances A1 by 8 after each tile (total +16 for both nibbles).

- **Entry**: D3 = BCD byte, A1 = destination tile pointer
- **Returns**: A1 advanced by 16
- **Modifies**: D1, D3, A1
- **Calls**: digit_tile_dma_to_framebuffer_a: digit tile DMA to framebuffer A
*Source: [bcd_nibble_splitter_a.asm](disasm/modules/68k/game/hud/bcd_nibble_splitter_a.asm)*

---

### digit_tile_dma_to_framebuffer_a ($010656–$010674, 30 bytes)

Digit Tile DMA to Framebuffer A Computes SH2 framebuffer address for digit tile D1: offset = D1 × 192 (D1<<6 + D1<<7), added to base $06023200. Sends a 12×16 tile block via sh2_send_cmd (D0=$0C width, D1=$10 height).

- **Entry**: D1 = tile/digit index
- **Returns**: tile data sent to SH2 framebuffer
- **Modifies**: D0, D1, A0
- **Calls**: $00E35A: sh2_send_cmd
*Source: [digit_tile_dma_to_framebuffer_a.asm](disasm/modules/68k/game/hud/digit_tile_dma_to_framebuffer_a.asm)*

---

### ascii_character_to_tile_index_mapper_010674 ($010674–$01071C, 168 bytes)

ASCII Character to Tile Index Mapper (SH2, Alternate) Maps ASCII/special character code in D0 to a tile index, computes the ROM address at base $06024000 + index × 192 ($C0), then sends to SH2 via sh2_send_cmd with dimensions $0018 × $0028. Character mapping: $20 (space) → index $37 $08 (BS)    → index $38 $03 (ETX)   → index $39 $2E (.)     → index $34 $21 (!)     → index $35 $3F (?)     → index $36 $41-$5A (A-Z) → indices $00-$19 (subtract $41) $61-$7A (a-z) → indices $1A-$33 (subtract $47) default     → index $36 Address computation: index × 192 via shift+add chain: D0 × 64 → D1, then D0 = D0×128 + D1×2 + D1×4 = index × 192 + ... × 192

- **Entry**: D0 = character code
- **Modifies**: D0, D1, A0
- **Calls**: $00E35A (sh2_send_cmd)
*Source: [ascii_character_to_tile_index_mapper_010674.asm](disasm/modules/68k/game/hud/ascii_character_to_tile_index_mapper_010674.asm)*

---

### lap_time_digit_renderer_b ($0118D4–$011908, 52 bytes)

Lap Time Digit Renderer B Identical logic to lap_time_digit_renderer_a but renders to SH2 framebuffer region B ($0601DF00) for the second display area (2-player mode). Reads 4 BCD bytes from (A2)+, rendering 7 digit tiles + 2 separator tiles via bcd_nibble_splitter_b (nibble split) and digit_tile_dma_to_framebuffer_b (tile DMA).

- **Entry**: A1 = destination tile pointer, A2 = BCD time data pointer
- **Returns**: A1 advanced past tiles, A2 advanced 4 bytes
- **Modifies**: D1, D3, A1, A2
- **Calls**: bcd_nibble_splitter_b: BCD nibble splitter B digit_tile_dma_to_framebuffer_b: digit tile DMA to framebuffer B
*Source: [lap_time_digit_renderer_b.asm](disasm/modules/68k/game/hud/lap_time_digit_renderer_b.asm)*

---

### bcd_nibble_splitter_b ($011908–$011924, 28 bytes)

BCD Nibble Splitter B Identical logic to bcd_nibble_splitter_a — splits byte in D3 into high and low nibbles, rendering each as a digit tile via digit_tile_dma_to_framebuffer_b (framebuffer B at $0601DF00). Advances A1 by 8 after each tile.

- **Entry**: D3 = BCD byte, A1 = destination tile pointer
- **Returns**: A1 advanced by 16
- **Modifies**: D1, D3, A1
- **Calls**: digit_tile_dma_to_framebuffer_b: digit tile DMA to framebuffer B
*Source: [bcd_nibble_splitter_b.asm](disasm/modules/68k/game/hud/bcd_nibble_splitter_b.asm)*

---

### digit_tile_dma_to_framebuffer_b ($011924–$011942, 30 bytes)

Digit Tile DMA to Framebuffer B Identical logic to digit_tile_dma_to_framebuffer_a — computes SH2 framebuffer address for digit tile D1: offset = D1 × 192, added to base $0601DF00 (framebuffer region B for 2-player mode). Sends 12×16 tile block via sh2_send_cmd.

- **Entry**: D1 = tile/digit index
- **Returns**: tile data sent to SH2 framebuffer
- **Modifies**: D0, D1, A0
- **Calls**: $00E35A: sh2_send_cmd
*Source: [digit_tile_dma_to_framebuffer_b.asm](disasm/modules/68k/game/hud/digit_tile_dma_to_framebuffer_b.asm)*

---

### lap_time_digit_renderer_c ($011942–$01197E, 60 bytes)

Lap Time Digit Renderer C (Register-Saving) Same logic as lap_time_digit_renderer_a/030 but saves/restores D3/D4 on stack via MOVEM. Renders BCD lap time as digit tiles to SH2 framebuffer region B ($0601DF00). Reads 4 BCD bytes from (A2)+, rendering 7 digit tiles + 2 separators via bcd_nibble_splitter_c (nibble split) and digit_tile_blit_to_framebuffer (tile blit).

- **Entry**: A1 = destination tile pointer, A2 = BCD time data pointer
- **Returns**: A1 advanced past tiles, A2 advanced 4 bytes
- **Modifies**: D1, D3, D4, A1, A2
- **Calls**: bcd_nibble_splitter_c: BCD nibble splitter C digit_tile_blit_to_framebuffer: digit tile blit to framebuffer
*Source: [lap_time_digit_renderer_c.asm](disasm/modules/68k/game/hud/lap_time_digit_renderer_c.asm)*

---

### bcd_nibble_splitter_c ($01197E–$01199A, 28 bytes)

BCD Nibble Splitter C Same logic as bcd_nibble_splitter_a/031 — splits byte in D3 into high and low nibbles, rendering each as a digit tile via digit_tile_blit_to_framebuffer. Advances A1 by 8 after each tile (total +16).

- **Entry**: D3 = BCD byte, A1 = destination tile pointer
- **Returns**: A1 advanced by 16
- **Modifies**: D1, D3, A1
- **Calls**: digit_tile_blit_to_framebuffer: digit tile blit to framebuffer
*Source: [bcd_nibble_splitter_c.asm](disasm/modules/68k/game/hud/bcd_nibble_splitter_c.asm)*

---

### digit_tile_blit_to_framebuffer ($01199A–$0119B8, 30 bytes)

Digit Tile Blit to Framebuffer Same structure as digit_tile_dma_to_framebuffer_a/032 — computes framebuffer address for digit tile D1: offset = D1 × 192, added to base $0601DF00. Sends 12×16 tile block via name_entry_check ($011A98) which acts as a strided tile blit function.

- **Entry**: D1 = tile/digit index
- **Returns**: tile data sent to SH2 framebuffer
- **Modifies**: D0, D1, A0
- **Calls**: $011A98: name_entry_check (tile blit with stride)
*Source: [digit_tile_blit_to_framebuffer.asm](disasm/modules/68k/game/hud/digit_tile_blit_to_framebuffer.asm)*

---

### lap_time_digit_renderer ($01259C–$0125D0, 52 bytes)

Lap Time Digit Renderer (Records Screen) Same pattern as lap_time_digit_renderer_a — renders BCD lap time as digit tiles to SH2 framebuffer at $0601F000. Reads 4 BCD bytes from (A2)+, rendering 7 digit tiles + 2 separators via bcd_nibble_splitter (nibble split) and digit_tile_dma (tile DMA).

- **Entry**: A1 = destination tile pointer, A2 = BCD time data pointer
- **Returns**: A1 advanced past tiles, A2 advanced 4 bytes
- **Modifies**: D1, D3, A1, A2
- **Calls**: bcd_nibble_splitter: BCD nibble splitter digit_tile_dma: digit tile DMA to $0601F000
*Source: [lap_time_digit_renderer.asm](disasm/modules/68k/game/hud/lap_time_digit_renderer.asm)*

---

### bcd_nibble_splitter ($0125D0–$0125EC, 28 bytes)

BCD Nibble Splitter (Records Screen) Same pattern as bcd_nibble_splitter_a — splits byte in D3 into high and low nibbles, rendering each as a digit tile via digit_tile_dma. Advances A1 by 8 per tile.

- **Entry**: D3 = BCD byte, A1 = destination tile pointer
- **Returns**: A1 advanced by 16
- **Modifies**: D1, D3, A1
- **Calls**: digit_tile_dma: digit tile DMA to $0601F000
*Source: [bcd_nibble_splitter.asm](disasm/modules/68k/game/hud/bcd_nibble_splitter.asm)*

---

### digit_tile_dma ($0125EC–$01260A, 30 bytes)

Digit Tile DMA (Records Screen) Same pattern as digit_tile_dma_to_framebuffer_a — computes SH2 framebuffer address for digit tile D1: offset = D1 × 192, added to base $0601F000. Sends 12×16 tile block via sh2_send_cmd.

- **Entry**: D1 = tile/digit index
- **Returns**: tile data sent to SH2 framebuffer
- **Modifies**: D0, D1, A0
- **Calls**: $00E35A: sh2_send_cmd
*Source: [digit_tile_dma.asm](disasm/modules/68k/game/hud/digit_tile_dma.asm)*

---

### ascii_character_to_tile_index_mapper_012618 ($012618–$0126A6, 142 bytes)

ASCII Character to Tile Index Mapper (SH2) Maps ASCII character code in D1 to a tile index, computes the ROM address of the tile at base $060207C0 + index × $C0, then sends it to the SH2 via sh2_send_cmd with dimensions $000C × $0010. Character mapping: $20 (space) → index $37 (blank tile) $21 (!)     → index $35 $2E (.)     → index $34 $41-$5A (A-Z uppercase) → indices $00-$19 $61-$7A (a-z lowercase) → indices $00-$33 (via subtract $47) default     → index $36 (placeholder)

- **Entry**: D1 = ASCII character code
- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A (sh2_send_cmd)
*Source: [ascii_character_to_tile_index_mapper_012618.asm](disasm/modules/68k/game/hud/ascii_character_to_tile_index_mapper_012618.asm)*

---

## Game / Menu

### Conditional Scene Transition (State $A6) ($003DA6–$003DD4, 46 bytes)

Checks if scene state ($C8AA) exceeds 20. If not, returns. Otherwise sets up SH2 object at $FF69C0 (command $09 at +$00, data $222F1D4A at +$08), clears scene state, sets state variable ($C8A4) to $A6, and advances dispatch index.

- **Entry**: none | Exit: scene transitioned or no-op | Uses: A1, A6
- **RAM**: $FFFFC8AA = scene state (word, tested, then cleared) $00FF69C0 = SH2 object (byte +$00 set to $09, long +$08 set) $FFFFC8A4 = state variable (byte, set to $A6) $FFFFC8AC = state dispatch index (word, advanced by 4)
*Source: [conditional_scene_transition_003da6.asm](disasm/modules/68k/game/menu/conditional_scene_transition_003da6.asm)*

---

### Conditional Scene Transition (State $A7) ($003DD4–$003E08, 52 bytes)

Checks if scene state ($C8AA) exceeds 20. If not, returns. Otherwise sends two SH2 commands ($222F29EE to $FF69C8, $222F1716 to $FF6998), clears scene state, sets state variable ($C8A4) to $A7, sets bit 4 of control flag ($C30E), and advances dispatch index ($C8AC) by 4.

- **Entry**: none | Exit: scene transitioned or no-op | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, tested, then cleared) $00FF69C8 = SH2 shared command 1 (long, set to $222F29EE) $00FF6998 = SH2 shared command 2 (long, set to $222F1716) $FFFFC8A4 = state variable (byte, set to $A7) $FFFFC30E = control flag (byte, bit 4 set) $FFFFC8AC = state dispatch index (word, advanced by 4)
*Source: [conditional_scene_transition_003dd4.asm](disasm/modules/68k/game/menu/conditional_scene_transition_003dd4.asm)*

---

### Conditional Scene Transition (State $C1) ($003E7E–$003EA2, 36 bytes)

Checks if scene state ($C8AA) exceeds 20. If not, returns. Otherwise sends SH2 command data $222F038A to $FF6988, sets state variable ($C8A4) to $C1, clears scene state, and advances dispatch index ($C8AC) by 4.

- **Entry**: none | Exit: scene transitioned or no-op | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, tested, then cleared) $00FF6988 = SH2 shared command data (long, set to $222F038A) $FFFFC8A4 = state variable (byte, set to $C1) $FFFFC8AC = state dispatch index (word, advanced by 4)
*Source: [conditional_scene_transition_003e7e.asm](disasm/modules/68k/game/menu/conditional_scene_transition_003e7e.asm)*

---

### Conditional Scene Transition (State $C2) ($003EA2–$003EC6, 36 bytes)

Checks if scene state ($C8AA) exceeds 20. If not, returns. Otherwise sends SH2 command data $222F002C to $FF6988, sets state variable ($C8A4) to $C2, clears scene state, and advances dispatch index ($C8AC) by 4.

- **Entry**: none | Exit: scene transitioned or no-op | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, tested, then cleared) $00FF6988 = SH2 shared command data (long, set to $222F002C) $FFFFC8A4 = state variable (byte, set to $C2) $FFFFC8AC = state dispatch index (word, advanced by 4)
*Source: [conditional_scene_transition_003ea2.asm](disasm/modules/68k/game/menu/conditional_scene_transition_003ea2.asm)*

---

### Conditional Scene Transition (State $C3) ($003EC6–$003EF6, 48 bytes)

Checks if scene state ($C8AA) exceeds 20. If not, returns. Otherwise sends SH2 command $222EEF3A to $FF6988, sets state variable ($C8A4) to $C3, clears scene state, sets bit 4 of control flag ($C30E) and $B4EE, and advances dispatch index.

- **Entry**: none | Exit: scene transitioned or no-op | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, tested, then cleared) $00FF6988 = SH2 shared command (long, set to $222EEF3A) $FFFFC8A4 = state variable (byte, set to $C3) $FFFFC30E = control flag (byte, bit 4 set) $FFFFB4EE = secondary flag (byte, bit 4 set) $FFFFC8AC = state dispatch index (word, advanced by 4)
*Source: [conditional_scene_transition_003ec6.asm](disasm/modules/68k/game/menu/conditional_scene_transition_003ec6.asm)*

---

### Call Subs + Advance Game State ($004D00–$004D1A, 26 bytes)

Calls three subroutines: $00210A, animation_update ($00B09E), and sprite_update_check ($005908). Advances game state dispatch ($C87E) by 4 and sets display mode/frame delay to $0010.

- **Entry**: none | Exit: game state advanced | Uses: none
- **RAM**: $FFFFC87E = game state dispatch (word, advanced by 4) $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
*Source: [call_subs_advance_game_state.asm](disasm/modules/68k/game/menu/call_subs_advance_game_state.asm)*

---

### Call Subs + Advance Game State + Set Frame Delay ($005348–$00535E, 22 bytes)

Calls two sub-routines ($00210A and animation_update at $00B09E), then advances the main game state by 4 and sets frame delay to $0010.

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC87E = main game state (word, incremented by 4) $00FF0008 = display mode / frame delay (word, set to $0010)
*Source: [call_subs_advance_game_state_set_frame_delay.asm](disasm/modules/68k/game/menu/call_subs_advance_game_state_set_frame_delay.asm)*

---

### SFX Queue + Sprite Check + Advance Game State ($0055BA–$0055D0, 22 bytes)

Calls sfx_queue_process ($0021CA) and sprite_update_check ($005908), then advances the main game state by 4 and sets frame delay to $0010.

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC87E = main game state (word, incremented by 4) $00FF0008 = display mode / frame delay (word, set to $0010)
*Source: [sfx_queue_sprite_check_advance_game_state.asm](disasm/modules/68k/game/menu/sfx_queue_sprite_check_advance_game_state.asm)*

---

### Call 4 Subs + Advance Game State ($005658–$005676, 30 bytes)

Calls SFX queue process ($0021CA), two game subs ($00B02C, $00B632), and sprite_update_check ($005908). Advances game state dispatch ($C87E) by 4 and sets display mode to $0010.

- **Entry**: none | Exit: game state advanced | Uses: none
- **RAM**: $FFFFC87E = game state dispatch (word, advanced by 4) $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
*Source: [call_4_subs_advance_game_state.asm](disasm/modules/68k/game/menu/call_4_subs_advance_game_state.asm)*

---

### Reset Scene and Menu State ($00BCCA–$00BCDA, 16 bytes)

Clears the scene state ($C8AA) and menu sub-state ($C084), then sets the state variable at $C07A to $001C.

- **Entry**: none | Exit: states reset | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, cleared) $FFFFC084 = menu sub-state (word, cleared) $FFFFC07A = state parameter (word, set to $001C)
*Source: [reset_scene_menu_state.asm](disasm/modules/68k/game/menu/reset_scene_menu_state.asm)*

---

### VDP Slot Activation ($00CA4C–$00CA66, 26 bytes)

Configuration A Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800). Each 16-byte slot's first byte is a control/enable flag. Slot layout (VDP work area at $FF6800, 16 bytes per slot): $FF6920 = slot 18 (offset $120): set to 4 (active/priority) $FF6880 = slot  8 (offset $080): set to 1 (enabled) $FF69A0 = slot 26 (offset $1A0): set to 1 (enabled)

- **Entry**: No register inputs
- **Returns**: Three VDP slots activated
- **Modifies**: (none)
*Source: [vdp_slot_activation_config_a.asm](disasm/modules/68k/game/menu/vdp_slot_activation_config_a.asm)*

---

### VDP Slot Activation ($00CA66–$00CA80, 26 bytes)

Configuration B Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800). Same pattern as configuration A (fn_c200_041) but with different slot selection. Slot layout: $FF6920 = slot 18 (offset $120): set to 4 (active/priority) $FF6880 = slot  8 (offset $080): set to 1 (enabled) $FF6800 = slot  0 (offset $000): set to 1 (enabled)

- **Entry**: No register inputs
- **Returns**: Three VDP slots activated
- **Modifies**: (none)
*Source: [vdp_slot_activation_config_b.asm](disasm/modules/68k/game/menu/vdp_slot_activation_config_b.asm)*

---

### VDP Slot Activation ($00CA80–$00CA9A, 26 bytes)

Configuration C Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800). Same pattern as configurations A and B but targeting a different set of slots. Slot layout: $FF6910 = slot 17 (offset $110): set to 4 (active/priority) $FF6870 = slot  7 (offset $070): set to 1 (enabled) $FF69D0 = slot 29 (offset $1D0): set to 1 (enabled)

- **Entry**: No register inputs
- **Returns**: Three VDP slots activated
- **Modifies**: (none)
*Source: [vdp_slot_activation_config_c.asm](disasm/modules/68k/game/menu/vdp_slot_activation_config_c.asm)*

---

### time_trial_records_display_init ($00FB98–$010084, 1260 bytes)

Time Trial Records Display Initialization Major scene initialization for time trial records display. Searches timing records to find player's position, sorts entries using insertion sort with BCD time comparison via ABCD/SBCD instructions. Computes record table addresses from player/track indices. Loads SH2 palette, tile graphics, and 8 compressed data blocks. Configures 32X VDP for records overlay. Marks insertion points in record table with $20 padding bytes.

- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1
- **Calls**: $00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E2F0 (sh2_load_data), $00E316 (sh2_send_cmd_wait)
- **Confidence**: high
*Source: [time_trial_records_display_init.asm](disasm/modules/68k/game/menu/time_trial_records_display_init.asm)*

---

### records_scene_state_disp ($010084–$01017A, 246 bytes)

Records Scene State Dispatcher Data prefix (~164 bytes: scene configuration tables with display parameters, palette/color data). Two scene dispatchers: first uses jump table at $010138 (3 states), second uses jump table at $010158 (3 states). Calls object_update and advances state counter when fade-in completes (bit 6 of $C8B2 clear).

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, A0
- **Calls**: $00B684 (object_update)
- **Confidence**: high
*Source: [records_scene_state_disp.asm](disasm/modules/68k/game/menu/records_scene_state_disp.asm)*

---

### Name Entry SH2 Transfer + Advance ($010200–$010244, 68 bytes)

Reads current name byte from buffer, sends two SH2 DMA commands. First: transfers $A8 bytes at $10 width (sprite data). Second: calculates VRAM row from player index × 640 ($A022 × 128 + × 512), transfers $28 bytes at $10 width (character tile). Advances game_state.

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
- **RAM**: $A022: player selection index (word) $C87E: game_state (word, advanced by 4)
*Source: [name_entry_sh2_xfer_advance.asm](disasm/modules/68k/game/menu/name_entry_sh2_xfer_advance.asm)*

---

### Name Entry Character Input (Player 1) ($010244–$01035C, 280 bytes)

Handles character input for player 1 name entry. DMA transfer, cursor render, controller poll. Processes character placement: validates against space ($20) and end marker ($03), writes to name buffer(s) at cursor position. Handles backspace (delete button), supports dual-player mode via $A014. Advances game_state on completion or timeout.

- **Modifies**: D0, D1, D2, A0
- **Calls**: $00E52C: dma_transfer (D0=mode) $010796: cursor_render (A0=buffer) $0088179E: controller_poll $01084C: input_handler (name_entry_input_handler) $0088FB36: SH2 transition check
- **RAM**: $A014: dual-player config flags (byte) $A018: name buffer pointer P1 (long) $A01C: name buffer pointer P2 (long) $A020: cursor position (byte) $A024: character index (word) $A02C: input active flag (byte) $A02D: blink timer (byte) $A036: confirm state (word) $C86C: controller data (word) $C87E: game_state (word) $C8A4: sound effect (byte) $C80E: display control (byte)
*Source: [name_entry_character_input_010244.asm](disasm/modules/68k/game/menu/name_entry_character_input_010244.asm)*

---

### Name Entry Object Update + DMA ($01035C–$0103C4, 104 bytes)

DMA transfer, object update, and character table rendering. Sends SH2 DMA for VRAM block ($0601C300 → $2400E030, $80×$20). Calculates name table offset: $FEB1 value × 48 + $FEA5 value × 8 + 4, adds to base $FA48 to get source address for character rendering. Advances game_state, display mode $0020.

- **Modifies**: D0, D1, A0, A1, A2
- **Calls**: $00B684: object_update $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width) $00E52C: dma_transfer (D0=mode) $01071C: name_entry_sub $010606: character_render (A1=palette, A2=source)
- **RAM**: $FA48: name table base address (long) $FEA5: column offset byte $FEB1: row offset byte $C87E: game_state (word, advanced by 4)
*Source: [name_entry_object_update_dma.asm](disasm/modules/68k/game/menu/name_entry_object_update_dma.asm)*

---

### Name Entry Character Input (Player 2) ($0103C4–$0104A2, 222 bytes)

Handles character input for player 2 name entry. Nearly identical to name_entry_character_input_010244 (Player 1) but uses P2 buffer ($A01C). No dual-player buffer mirroring (single buffer only). Same character validation, backspace, and completion logic.

- **Modifies**: D0, D1, D2, A0
- **Calls**: $00E52C: dma_transfer $010796: cursor_render $0088179E: controller_poll $01084C: input_handler $0088FB36: SH2 transition check
- **RAM**: $A01C: name buffer pointer P2 (long) $A020: cursor position (byte) $A024: character index (word) $A02C: input active flag (byte) $A02D: blink timer (byte) $A036: confirm state (word) $C86C: controller data (word) $C87E: game_state (word) $C8A4: sound effect (byte) $C80E: display control (byte)
*Source: [name_entry_character_input_0103c4.asm](disasm/modules/68k/game/menu/name_entry_character_input_0103c4.asm)*

---

### Name Entry Sprite Update + Animation ($0104A2–$0105DE, 316 bytes)

Orchestrates name entry sprite display with DMA, animation, and character preview rendering. Sends SH2 DMA for sprite data ($06014000 → $24014034, $D8×$50). Handles blinking cursor animation with timeout counter ($A030). Renders up to 3 character preview slots at $24034060/$90/$C0. On completion ($A036=2), transitions via SH2 call, enables display flags.

- **Modifies**: D0, D1, A0, A1, A4
- **Calls**: $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer $010674: sprite_slot_render $0088205E: SH2 scene transition $0088FB36: SH2 completion check
- **RAM**: $A014: config flags (byte) $A018: P1 buffer pointer (long) $A01C: P2 buffer pointer (long) $A02C: input active/blink flag (byte) $A02D: blink timer (byte) $A02E: blink animation counter (word) $A030: timeout counter (word, init $0BB8=3000) $A036: confirm state (word) $C87E: game_state (word) $C809/$C80A/$C80E/$C802: display enable flags
*Source: [name_entry_sprite_update_anim.asm](disasm/modules/68k/game/menu/name_entry_sprite_update_anim.asm)*

---

### name_entry_background_tile_transfer ($01071C–$010796, 122 bytes)

Name Entry Background Tile Transfer Transfers 5 tile data blocks to SH2 framebuffer for the name entry screen background and UI elements. Each block is a sh2_send_cmd call with specific source (ROM/RAM) and destination (SH2 framebuffer) addresses: 1. $24014034 → $06014000 (216×80 — main background) 2. $240080A0 → $06019700 (88×16 — UI element) 3. $2400A0A0 → $06019C80 (88×16 — UI element) 4. $24008060 → $06019000 (56×32 — UI element) 5. $24004C60 → $0601A200 (128×16 — UI element)

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd
*Source: [name_entry_background_tile_transfer.asm](disasm/modules/68k/game/menu/name_entry_background_tile_transfer.asm)*

---

### Name Entry Cursor Render ($010796–$01084C, 182 bytes)

Renders name entry cursor with blink animation. Decrements blink timer, toggles input_active flag on underflow. Renders 1-3 sprite slots based on cursor position ($A020): pos >= 2: all 3 slots, pos == 1: 2 slots, pos == 0: 1 slot. Each slot displays either the current character or cursor indicator.

- **Entry**: A0 = name buffer pointer
- **Modifies**: D0, A0, A1, A4
- **Calls**: $010674: sprite_slot_render (A0=source, A1=dest, D0=char)
- **RAM**: $A02C: input active/blink flag (byte, toggled) $A02D: blink timer (byte, decremented) $A020: cursor position (byte, 0/1/2+) $A024: character index (word)
*Source: [name_entry_cursor_render.asm](disasm/modules/68k/game/menu/name_entry_cursor_render.asm)*

---

### Name Entry Input Handler ($01084C–$010974, 296 bytes)

Processes directional input for name entry cursor. Handles D-pad left/right (bits 2/3) with auto-repeat, and up/down (bits 0/1) for character set toggle. Maps cursor position through character table at $890974. Auto-repeat: initial delay ($39=57), then accelerates ($19=25 gap).

- **Entry**: D1 = controller input bits
- **Modifies**: D0, D1, D2
- **RAM**: $A02A: last input direction (byte) $A02B: repeat counter (byte, 0→$0C max) $A02C: input active flag (byte) $A02D: blink timer (byte) $A024: character index (word, result) $A026: repeat delay counter (word) $A028: direction flag (word, 0=down, 1=up) $C8A4: sound effect (byte, set to $A9)
*Source: [name_entry_input_handler.asm](disasm/modules/68k/game/menu/name_entry_input_handler.asm)*

---

### name_entry_screen_init ($010974–$01103E, 1738 bytes)

Name Entry Screen Initialization Large orchestrator that initializes the entire name entry screen for high score entry. Data prefix ($010974-$0109AB) contains the ASCII character set (A-Z, a-z, 0-9, punctuation) for the on-screen keyboard grid. Initialization sequence: 1. Configure VDP mode, adapter control, display parameters 2. Clear RAM regions (name buffers, score tables) 3. Set up graphics command for 38×26 tile region 4. Load palette data via sh2_palette_load 5. Load character tile assets to 6 SH2 framebuffer regions 6. Accumulate BCD scores from RAM ($C200) using ABCD/SBCD 7. Rank scores and find insertion point for new entry 8. Render existing high score times via name_digit_render 9. Set up COMM0/COMM4 for SH2 framebuffer page flip ($06020000) 10. Handle 1P/2P/3P variants (BTST #4/#5 on flags at $C90E)

- **Entry**: (no register parameters — uses global RAM state)
- **Modifies**: D0, D1, D2, D3, D4, D5, D7, A0, A1, A2
- **Calls**: $00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0: sh2_load_data $00E316: sh2_send_cmd_wait $011942: name_digit_render (lap_time_digit_renderer_b) $011A98: name_entry_check
- **RAM**: $C87A: vint_dispatch_state $C87E: game_state $C90E: player mode flags (bit 4 = 2P, bit 5 = 1P)
*Source: [name_entry_screen_init.asm](disasm/modules/68k/game/menu/name_entry_screen_init.asm)*

---

### name_entry_state_disp ($01103E–$0111A4, 358 bytes)

Name Entry State Dispatcher Data prefix ($01103E-$011121) contains structured parameter blocks for each name entry sub-state: entity field offsets (+$0E), coordinate pairs, and sentinel values ($7FFF). Multiple blocks with ASCII headers ("IF", "HIDE", "FADED") define display states for name entry UI elements. Code section ($011122-$0111A3) is a state dispatcher: reads game_state from RAM $C87E, indexes a PC-relative jump table, and dispatches to the appropriate handler. Each handler updates object fields and calls object_update to process the current name entry state.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, D6, A0
- **Calls**: $00B684: object_update
- **RAM**: $C87E: game_state
- **Object fields**: +$0E: param_e (state parameter) +$77: state flags
*Source: [name_entry_state_disp.asm](disasm/modules/68k/game/menu/name_entry_state_disp.asm)*

---

### Advance Game State + Set Frame Delay ($0111A4–$0111B6, 18 bytes)

Calls a sub-routine at $011B08, then advances the main game state by 4 and sets the frame delay parameter to $0018 (24 frames).

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC87E = main game state (word, incremented by 4) $00FF0008 = display mode / frame delay (word, set to $0018)
*Source: [advance_game_state_set_frame_delay.asm](disasm/modules/68k/game/menu/advance_game_state_set_frame_delay.asm)*

---

### Name Entry Score Display Transfer ($0111B6–$011240, 138 bytes)

Sends 4 SH2 DMA transfers for score display areas, then renders two time digit fields from BCD buffers at $A046 and $A04A. Also transfers two identical UI element blocks. Advances game_state, display mode $0018.

- **Modifies**: D0, D1, A0, A1, A2
- **Calls**: $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width) $0118D4: time_digit_render (A1=dest, A2=BCD source)
- **RAM**: $A046: time digits buffer 1 (long, BCD) $A04A: time digits buffer 2 (long, BCD) $C87E: game_state (word, advanced by 4)
*Source: [name_entry_score_disp_xfer.asm](disasm/modules/68k/game/menu/name_entry_score_disp_xfer.asm)*

---

### Name Entry Mode Select + Input Handler ($011240–$01141A, 474 bytes)

DMA + object_update + sprite_update, then 4 sh2_send_cmd transfers (score display, scroll view, time digits, status bar). If $A042 flag clear: 3 additional DMA transfers for name display. Input handler reads P1 controller ($C86C): Action buttons (A/B/C): play SFX $A8, enable display flags, SH2 transition, action_state = 2. Start button (bit 4): toggle mode flag $A019 (0↔1), if $A019 was set or $A042 active: full SH2 transition instead. Left (bit 2): clear $A019 if set, play SFX $A9. Right (bit 3): set $A019 if clear, play SFX $A9. Action state machine (same pattern as name_entry_scroll_view_action_handler): State 1: wait for bit 6 clear, State 2: wait for bit 7 clear → advance. Calls fn_10200_041 ($0119B8) on revert path.

- **Modifies**: D0, D1, D2, A0, A1, A2
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer $0118D4: time_digit_render $0119B8: fn_10200_041 (cursor update) $0088179E: controller_poll $0088205E: SH2 scene transition $0088FB36: SH2 completion check
- **RAM**: $A019: mode toggle flag (byte) $A042: display mode flag (word) $A046: time digit buffer (address via LEA) $A05C: action state (word, 0/1/2) $C80E: display control (byte, bits 6/7) $C809: display enable A (byte) $C80A: display enable B (byte) $C802: display enable C (byte) $C86C: controller P1 data (word) $C87E: game_state (word) $C8A4: sound effect (byte)
*Source: [name_entry_mode_select_input_handler.asm](disasm/modules/68k/game/menu/name_entry_mode_select_input_handler.asm)*

---

### Name Entry SH2 COMM Setup + DMA ($01141A–$01146E, 84 bytes)

DMA transfer, then sends two SH2 COMM commands. First: waits for COMM0 idle, sends cmd $2C with COMM6=$0101/COMM4=$8000. Second: waits for COMM6 idle, sends COMM4=$0050/COMM6=$0101. Advances game_state, display mode $0020.

- **Modifies**: D0
- **Calls**: $00E52C: dma_transfer (D0=mode)
- **RAM**: $C87E: game_state (word, advanced by 4)
*Source: [name_entry_sh2_comm_setup_dma.asm](disasm/modules/68k/game/menu/name_entry_sh2_comm_setup_dma.asm)*

---

### Name Entry Scroll View + Action Handler ($01146E–$0115A8, 314 bytes)

DMA transfer, updates objects and sprites, sends SH2 DMA. Handles smooth scrolling of name entry view with velocity ($A026) applied over duration ($A02E steps). Processes action buttons: D-pad up/down for scrolling, A/B/C for confirmation. On confirm: enables display flags and triggers SH2 transition.

- **Modifies**: D0, D1, D2, A0, A1
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer $0088179E: controller_poll $0088205E: SH2 scene transition $0088FB36: SH2 completion check
- **RAM**: $A022: scroll position (long) $A026: scroll velocity (long) $A02A: max scroll position (long) $A02E: scroll step counter (byte) $A05C: action state (word) $C86C: controller data (word) $C87E: game_state (word) $C8A4: sound effect (byte) $C809/$C80A/$C80E/$C802: display enable flags
*Source: [name_entry_scroll_view_action_handler.asm](disasm/modules/68k/game/menu/name_entry_scroll_view_action_handler.asm)*

---

### Name Entry SH2 COMM + Scroll DMA + Blink ($0115A8–$011630, 136 bytes)

DMA transfer, sends SH2 COMM commands (same as name_entry_sh2_comm_setup_dma), then sends scroll view DMA ($26028000+offset → $24010018, $80×$50). Decrements blink counter ($A052), toggles display toggle ($A050) on underflow. Calls score area transfer sub ($011C7E). Advances game_state, display mode $0020.

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd $00E52C: dma_transfer $011C7E: score_area_transfer (name_entry_score_area_dma_xfer)
- **RAM**: $A022: scroll position (long) $A050: display toggle (byte, bit 0) $A052: blink counter (word) $C87E: game_state (word, advanced by 4)
*Source: [name_entry_sh2_comm_scroll_dma_blink.asm](disasm/modules/68k/game/menu/name_entry_sh2_comm_scroll_dma_blink.asm)*

---

### Name Entry Dual Scroll View + Action Handler ($011630–$0117F4, 452 bytes)

DMA + object_update + sprite_update, then sh2_send_cmd for scroll view (source $26032000 + offset $A032, dest $240100A0). Applies P1 scroll velocity ($A026→$A022, 3 steps, ±$200) and P2 scroll velocity ($A036→$A032, 3 steps, ±$200). P1 uses controller $C86C: action buttons → SH2 transition (state 2), D-pad down/up → scroll P1 view. P2 uses controller $C86E: same pattern for second scroll area. Action state machine: state 1 checks bit 6, state 2 checks bit 7 of $C80E. Display mode $0018.

- **Modifies**: D0, D1, D2, A0, A1
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer $0088179E: controller_poll $0088205E: SH2 scene transition $0088FB36: SH2 completion check
- **RAM**: $A022: P1 scroll position (long) $A026: P1 scroll velocity (long) $A02A: P1 max scroll (long) $A02E: P1 step counter (byte) $A032: P2 scroll position (long) $A036: P2 scroll velocity (long) $A03A: P2 max scroll (long) $A03E: P2 step counter (byte) $A05C: action state (word, 0/1/2) $C80E: display control (byte, bits 6/7) $C809/$C80A/$C802: display enable flags $C86C: controller P1 data (word) $C86E: controller P2 data (word) $C87E: game_state (word) $C8A4: sound effect (byte)
*Source: [name_entry_dual_scroll_view_action_handler.asm](disasm/modules/68k/game/menu/name_entry_dual_scroll_view_action_handler.asm)*

---

### SH2 Scene Reset ($0117F4–$011862, 110 bytes)

Name Entry Mode Dispatcher Resets SH2 communication and selects a scene handler based on game mode flags. Three possible scene handlers: 1. $00884A3E — if no track selected ($A019==0) and $A042==0 2. $0088C0F0 — if VDP flag ($FEB7) bit 7 is set 3. $0088D48A — default fallback Also manages sync flags at $C80E and debug flags at $C81C.

- **Entry**: none | Exit: SH2 scene configured | Uses: none
- **RAM**: $FFFFC87E = main game state (word, cleared to 0) $FFFFA019 = player 1 selection / track index (byte, tested) $FFFFA042 = game mode parameter (word, tested) $FFFFC80E = sync/transition flags (byte, bits 3/7 modified) $FFFFC81C = debug/mode flags (byte, bit 7 modified) $FFFFFEB7 = VDP/display flag (byte, bit 7 tested) $00FF0002 = SH2 scene handler pointer (long, set) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sh2_scene_reset_name_entry_mode_disp.asm](disasm/modules/68k/game/menu/sh2_scene_reset_name_entry_mode_disp.asm)*

---

### Name Entry Color/Palette Update ($0119B8–$011A5C, 164 bytes)

Updates name entry palette with animated color cycling. Copies 8 base palette entries from ROM, then generates 4 dynamic entries by splitting RGB channels, shifting/combining with OR. Color offset ($A019) animates via BCD-style clamped increment/decrement driven by fade direction ($A01C).

- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1
- **RAM**: $A019: color offset index (byte) $A01A: brightness value (byte) $A01C: fade direction/step (byte) $C821: display update flag (byte, set to $01) $FF6E00+$1E0: palette destination (CRAM)
*Source: [name_entry_color_palette_update.asm](disasm/modules/68k/game/menu/name_entry_color_palette_update.asm)*

---

### cursor_pos_clamp ($011A5C–$011A70, 20 bytes)

Cursor Position Clamp [0, 31] Adds D1 offset to D5 then clamps result to [0, 31]. Used for name entry cursor position bounds checking — 32 character positions in the alphabet grid.

- **Entry**: D1 = offset to add, D5 = current position
- **Returns**: D5 = clamped position (0 ≤ D5 ≤ 31)
- **Modifies**: D5
*Source: [cursor_pos_clamp.asm](disasm/modules/68k/game/menu/cursor_pos_clamp.asm)*

---

### name_entry_ui_tile_refresh ($011B08–$011B6A, 98 bytes)

Name Entry UI Tile Refresh Refreshes 4 UI tile blocks on the name entry screen via sh2_send_cmd: 1. $04004C78 → $06018000 (80×16 — header/title tiles) 2. $04008090 → $0601E8C0 (88×16 — score area tiles) 3. $0400A090 → $0601EE40 (88×16 — score area tiles) 4. $04008048 → $06018500 (56×32 — name area tiles)

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd
*Source: [name_entry_ui_tile_refresh.asm](disasm/modules/68k/game/menu/name_entry_ui_tile_refresh.asm)*

---

### Name Entry BCD Score Comparison ($011B6A–$011C7E, 276 bytes)

Compares player's score against high score table using BCD arithmetic. Copies 1024 bytes from high score table ($B400) to comparison buffer ($C400). Processes 20 BCD digit-pairs using ABCD/SBCD instructions. Fills empty slots with sentinel $CCCC0CCC. Sets ranking result: $A04E = 0 (new high), 1 (tied/lower), 2 (not placed).

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3
- **RAM**: $A058: saved score snapshot (long) $A04A: BCD comparison buffer (long) $A04E: ranking result (word, 0/1/2) $B400: high score table source (1024 bytes) $C200: BCD working buffer $C260: current score (long) $C400: comparison buffer destination
*Source: [name_entry_bcd_score_cmp.asm](disasm/modules/68k/game/menu/name_entry_bcd_score_cmp.asm)*

---

### Name Entry Score Area DMA Transfer ($011C7E–$011D0A, 140 bytes)

Sends SH2 DMA for one of 4 score display areas based on ranking result ($A04E) and display toggle ($A050). If $A04E == 0: sends current score area ($06018F80 or $06010000) If $A04E == 1: sends alternate score area ($06019AC0 or $06010000) If $A04E == 2: skips transfer entirely. Toggle bit 0 of $A050 selects between two VRAM sources.

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
- **RAM**: $A04E: ranking result (word, 0/1/2) $A050: display toggle (byte, bit 0)
*Source: [name_entry_score_area_dma_xfer.asm](disasm/modules/68k/game/menu/name_entry_score_area_dma_xfer.asm)*

---

### records_screen_init ($011D0A–$011F38, 558 bytes)

Records Screen Initialization Initializes the records/results display screen. Similar structure to name_entry_screen_init (name entry init) but simpler — no BCD score accumulation or player count variants. Sequence: 1. Configure VDP mode, adapter control, display parameters 2. Clear RAM regions (score buffers, display state) 3. Set up 38×26 tile graphics region via sh2_graphics_cmd 4. Load palette data via sh2_palette_load 5. Copy palette entries with priority bit set to CRAM buffer 6. Transfer 7 tile data blocks to SH2 framebuffer regions 7. Initialize record display parameters 8. Set VDP display mode and enable V-INT

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0: sh2_load_data $00E316: sh2_send_cmd_wait
- **RAM**: $C87A: vint_dispatch_state $C87E: game_state
*Source: [records_screen_init.asm](disasm/modules/68k/game/menu/records_screen_init.asm)*

---

### records_screen_state_disp ($011F38–$012084, 332 bytes)

Records Screen State Dispatcher Data prefix ($011F38-$012055) contains: - 15-bit RGB color palette ($0000, $0421, $0842... grayscale ramp) - Structured parameter blocks with sentinel values ($7FFF) - ASCII identifiers ("IF", "HIDE", "FADED") for display states Code section ($012056-$012083) is a state dispatcher: reads game_state from RAM $C87E, indexes a PC-relative jump table (3 states), and dispatches to the appropriate handler. Calls object_update to process current state.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, D3, D4, D5, D6, A0, A1
- **Calls**: $00B684: object_update
- **RAM**: $C87E: game_state
*Source: [records_screen_state_disp.asm](disasm/modules/68k/game/menu/records_screen_state_disp.asm)*

---

### Name Entry Rendering + SH2 Transfer ($012084–$0121FA, 374 bytes)

DMA transfer + 3 static sh2_send_cmd DMA transfers. Two sh2_cmd_27 calls with dynamic table lookups based on player flag ($A01A): if 0, uses $A019 index with D2=$10; else uses $A01B with D2=$FFC0. First cmd27 uses ×4 table at $8921FA, second uses ×6 table at $892206. COMM protocol (cmd $2C, COMM4=$4000) sends transfer params. Resolves active player selection indices and stores to $A01E/$A022. Calculates row offset ($A02C × $280) for final DMA from $0601BE00. Advances game_state, display mode $0020.

- **Modifies**: D0, D1, D2, D3, A0, A1
- **Calls**: $00E35A: sh2_send_cmd $00E3B4: sh2_cmd_27 $00E52C: dma_transfer
- **RAM**: $A019: camera mode index P1 (byte) $A01A: active player flag (byte, 0=P1, !0=P2) $A01B: camera mode index P2 (byte) $A01C: selection index P2 (byte) $A01E: resolved selection A (long) $A022: resolved selection B (long) $A02C: display row (word) $A034: VRAM dest pointer (long) $C87E: game_state (word, advanced by 4)
*Source: [name_entry_rendering_sh2_xfer.asm](disasm/modules/68k/game/menu/name_entry_rendering_sh2_xfer.asm)*

---

### records_viewer_main_loop ($012200–$01250C, 780 bytes)

Records Viewer Main Loop Data prefix ($012200-$012223) contains VDP/entity parameter blocks ($0401 entries with field offsets +$3A, +$3B for display state). Per-frame update loop for the records/replay browsing screen: 1. DMA transfer, object_update, sprite_update 2. Send camera/display data to SH2 via COMM registers (cmd $2C) 3. Render lap time digits via byte_iterator and related digit renderers 4. Handle scrolling acceleration for record list navigation 5. Process D-pad input (up/down = scroll records, left/right = page) 6. Handle button input (A = confirm → state $0002, Start = exit) 7. Manage repeat delay for held buttons 8. State machine: idle ($0000), confirming ($0001), transitioning ($0002)

- **Modifies**: D0, D1, D2, D5, A0, A1, A2, A5
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_transfer
- **RAM**: $C87E: game_state
*Source: [records_viewer_main_loop.asm](disasm/modules/68k/game/menu/records_viewer_main_loop.asm)*

---

### Camera Tile Render (3D Array Index) ($012534–$01259C, 104 bytes)

Calculates 3D array offset into tile data at $EF08: section (D0) × $3C0 + row (D1) × 160 + column (D2) × 8. Then renders 6 tile strips, each calling 3 subroutines per strip. Strips are spaced $2000 apart in destination, 8 bytes apart in source.

- **Entry**: D0 = section index, D1 = row index, D2 = column index, A1 = dest base
- **Modifies**: D0, D1, D2, D3, D4, D5, A1, A2, A3, A4
- **Calls**: $01259C: tile_render_sub_A (A1=dest, A2=source) $01260A: tile_render_sub_B (A1=dest, A2=source) $0126A6: tile_render_sub_C (A1=dest, A2=source)
- **RAM**: $EF08: tile data base (long)
*Source: [camera_tile_render.asm](disasm/modules/68k/game/menu/camera_tile_render.asm)*

---

### byte_iterator ($01260A–$012618, 14 bytes)

Byte Iterator (3-Byte Loop) Reads 3 bytes sequentially from (A2)+, calling the immediately following subroutine (BSR.S) for each byte. Used to process 3-component data (e.g. RGB or XYZ coordinates) one byte at a time.

- **Entry**: A2 = source data pointer, D1 = byte value (set per iteration)
- **Returns**: A2 advanced by 3
- **Modifies**: D1, D2, A2
*Source: [byte_iterator.asm](disasm/modules/68k/game/menu/byte_iterator.asm)*

---

### camera_replay_screen_init ($0126D2–$0129E0, 782 bytes)

Camera/Replay Screen Initialization Initializes the camera selection/replay viewing screen. Similar structure to name_entry_screen_init (name entry init) but with camera-specific setup: Sequence: 1. Configure VDP mode, adapter control, display parameters 2. Clear RAM regions (score tables, display state, VRAM) 3. Set up scroll offsets and camera parameters 4. Set up 38×26 tile graphics region via sh2_graphics_cmd 5. Load palette data, copy palette with priority bits to CRAM 6. Transfer tile data to SH2 framebuffer ($06038000) 7. Handle replay mode variant (split viewport for replays) 8. Transfer camera overlay tiles to $0603DE80 9. Initialize camera selection state machine 10. Send SH2 command $03 (scene init) via COMM registers

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0: sh2_load_data $00E316: sh2_send_cmd_wait
- **RAM**: $C87A: vint_dispatch_state $C87E: game_state
*Source: [camera_replay_screen_init.asm](disasm/modules/68k/game/menu/camera_replay_screen_init.asm)*

---

### Camera Demo Palette + SH2 Setup ($012A72–$012BFA, 392 bytes)

DMA transfer, palette setup, SH2 object configuration. Decrements rotation counter ($A036) and applies angular offset ($A038). Loads palette from ROM table indexed by $A019 (×4 for pointer, ×16 for data). Configures SH2 objects at $FF6100 with camera/position parameters. For mode 5 ($A019=5), enables special flag $FF60D4. Sends camera data via COMM0/COMM1 to SH2, then reads back $82 words from adapter register $A15112. Updates circular buffer at $A014.

- **Modifies**: D0, D1, D7, A0, A1, A2
- **Calls**: $00E52C: dma_transfer
- **RAM**: $A014: circular buffer offset (long) $A019: palette/mode index (byte) $A020: cursor/animation data (long) $A022: display scroll position (word) $A024: velocity/speed value (long) $A028: deceleration counter (word) $A02C: SH2 object flags (word) $A02E: SH2 object param A (word) $A030: SH2 object param B (word) $A032: SH2 object param C (word) $A034: SH2 object param D (word) $A036: rotation counter (word) $A038: angular offset (word) $C87E: game_state (word, advanced by 4)
*Source: [camera_demo_palette_sh2_setup.asm](disasm/modules/68k/game/menu/camera_demo_palette_sh2_setup.asm)*

---

### Camera DMA Transfer (Data Prefix) ($012BFA–$012C9E, 164 bytes)

Data prefix (144 bytes) containing sprite descriptors (6 entries at $012BFA, 24 bytes each) and palette pointer table (6 longword pointers at $012C72). Executable code at fn_12200_025_exec is minimal: DMA transfer, display mode $0020, advance game_state.

- **Modifies**: D0
- **Calls**: $00E52C: dma_transfer
- **RAM**: $C87E: game_state (word, advanced by 4)
*Source: [camera_dma_xfer.asm](disasm/modules/68k/game/menu/camera_dma_xfer.asm)*

---

### SH2 Mode Dispatcher ($012F0A–$012F56, 76 bytes)

Select Scene by Track/Mode Resets the SH2 communication state, reads the player 1 selection from $A019, copies it to the race mode flag at $C817, then uses it as an index into a jump table to select the appropriate SH2 scene handler address. Special case: if selection == 2 and bit 3 of controller config ($C818) is set, forces index to 6.

- **Entry**: none | Exit: SH2 scene configured
- **Modifies**: D1
- **RAM**: $FFFFC87E = main game state (word, cleared to 0) $FFFFA019 = player 1 selection / track index (byte, read) $FFFFC817 = race mode flag (byte, written from selection) $FFFFC818 = controller config flags (byte, bit 3 tested) $00FF0002 = SH2 scene handler pointer (long, set from table) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sh2_mode_disp_select_scene_by_track_mode.asm](disasm/modules/68k/game/menu/sh2_mode_disp_select_scene_by_track_mode.asm)*

---

### Camera SH2 Command 27 Dispatch (Data Prefix) ($012F56–$012F9C, 70 bytes)

Data prefix (28 bytes, 7 longword pointers referenced elsewhere) + SH2 command dispatch. Reads camera mode index from $A019, computes ×6 table lookup into command table at $892F9C. Loads source pointer and size param, calls sh2_cmd_27 with height=$48, width=$10.

- **Modifies**: D0, D1, D2
- **Calls**: $00E3B4: sh2_cmd_27
- **RAM**: $A019: camera mode index (byte)
*Source: [camera_sh2_command_27_dispatch.asm](disasm/modules/68k/game/menu/camera_sh2_command_27_dispatch.asm)*

---

### vdp_tile_fill_with_data_table ($012F9C–$012FE4, 72 bytes)

VDP Tile Fill with Data Table Data prefix ($012F9C-$012FBF) contains structured VDP parameters: repeated $0401 entries with field offsets (+$38, +$39) defining tile fill regions. Code section ($012FC0-$012FE3) fills VDP VRAM with a repeated tile value. For each region: sets VDP address register via A5, then writes D3 to VDP data port (A6) for D1+1 words. Advances base address D0 by D4 per region, looping D2+1 times.

- **Entry**: D0 = VDP base address, D1 = words per row, D2 = row count, D3 = fill value, D4 = row stride, A5 = VDP control, A6 = VDP data
- **Modifies**: D0, D1, D2, D3, D4, D5, D6
*Source: [vdp_tile_fill_with_data_table.asm](disasm/modules/68k/game/menu/vdp_tile_fill_with_data_table.asm)*

---

### sh2_multi_param_command_send ($012FE4–$013054, 112 bytes)

SH2 Multi-Parameter Command Send Sends command $21 to SH2 with 4 parameters via COMM register handshake: 1. Wait COMM0_HI clear, send A1 via COMM4, cmd $21 via COMM0 2. Wait COMM6 clear, send D0/D1 via COMM4/COMM5 3. Wait COMM6 clear, send D2 via COMM4 4. Wait COMM6 clear, send A0 via COMM4 Each parameter is acknowledged by SH2 clearing COMM6.

- **Entry**: A0 = param 4, A1 = param 1, D0 = param 2 hi, D1 = param 2 lo, D2 = param 3
- **Modifies**: D0, D1, D2, A0, A1
*Source: [sh2_multi_param_command_send.asm](disasm/modules/68k/game/menu/sh2_multi_param_command_send.asm)*

---

### standings_screen_init ($013054–$013292, 574 bytes)

Standings Screen Initialization Initializes the championship standings/results screen. Two entry points: - $013054: sets camera mode 0 (default) - $01305E: sets camera mode 4 (alternate view) Sequence: 1. Configure VDP mode, adapter control, display parameters 2. Clear RAM regions and VRAM 3. Set up 38×26 tile graphics region via sh2_graphics_cmd 4. Load palette data, copy palette with priority bits to CRAM 5. Transfer 7 tile data blocks to SH2 framebuffer regions 6. Initialize standings display parameters (race count, positions) 7. Set VDP display mode, enable V-INT, send SH2 init commands

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0: sh2_load_data $00E316: sh2_send_cmd_wait
- **RAM**: $C87A: vint_dispatch_state $C87E: game_state
*Source: [standings_screen_init.asm](disasm/modules/68k/game/menu/standings_screen_init.asm)*

---

### Camera State Dispatcher (Data Prefix + Jump Table) ($013292–$013346, 180 bytes)

Data prefix (128 bytes of object/sprite descriptors) + state dispatcher. Calls initialization ($00882080), then reads game_state ($C87E) to index a 3-entry PC-relative jump table: State 0 → $00893346 (camera_render_dma_overlay: camera render DMA) State 4 → $008934F0 (camera_menu_orch: camera menu orchestrator) State 8 → $00893824 (camera finalize) After dispatch returns: calls object_update, checks display bit 6, advances game_state if clear, then SH2 scene transition.

- **Modifies**: D0, D4, A0, A1
- **Calls**: $00B684: object_update $00882080: initialization $0088205E: SH2 scene transition
- **RAM**: $C87E: game_state (word) $C80E: display control (byte, bit 6 checked)
*Source: [camera_state_disp.asm](disasm/modules/68k/game/menu/camera_state_disp.asm)*

---

### Camera Render DMA + Overlay ($013346–$0134C8, 386 bytes)

DMA transfer + 3 static SH2 DMA transfers (header, main display, bottom panel). Then 5 dynamic SH2 transfers using pointer tables indexed by camera selection counters ($A01A-$A020): $89ABEE[replay_angle]  → $04009088 (40×10) $89ABFA[music_track]   → $0400C088 (78×10) $89AC7C[sfx_a]         → $0400F088 (68×10) $89ACBE[sfx_b]         → $04012088 (88×10) If blink toggle ($A026) active and mode != 5: sends overlay via sh2_cmd_27 using table at $8934C8, waits for COMM0. Copies 5×8 bytes of highlight palette from $8934E8 to CRAM+$178. If blinking and mode-specific: overwrites 8 bytes in CRAM. Sets $C821 display update flag, advances game_state, display $0020.

- **Modifies**: D0, D1, D2, A0, A1
- **Calls**: $00E35A: sh2_send_cmd $00E3B4: sh2_cmd_27 $00E52C: dma_transfer
- **RAM**: $A019: camera mode index (byte) $A01A: replay angle counter (word) $A01C: music track counter (word) $A01E: SFX counter A (word) $A020: SFX counter B (word) $A026: blink toggle (word) $C821: display update flag (byte) $C87E: game_state (word, advanced by 4)
*Source: [camera_render_dma_overlay.asm](disasm/modules/68k/game/menu/camera_render_dma_overlay.asm)*

---

### Camera Menu Orchestrator (Data Prefix) ($0134C8–$0135C4, 252 bytes)

Data prefix (40 bytes) + camera menu orchestrator. DMA transfer + object_update + sprite_update, then reads P1 ($C86C) and P2 ($C86E) controllers via camera_menu_input_handler (camera input handler). If selection state ($A022) == 1: enable display flags + SH2 transition, set action_state ($A028) = 2. If selection state > 1: dispatch via handler table at $8936AA with mode index from $A019 and D2=1 flag. Action state machine: state 1 checks bit 6, state 2 checks bit 7 of $C80E to detect SH2 completion. Clears $A022, display mode $0018.

- **Modifies**: D0, D1, D2, A0
- **Calls**: $00B684: object_update $00B6DA: sprite_update $00E52C: dma_transfer $0135C4: camera_menu_input_handler (camera input handler) $0088179E: controller_poll $0088205E: SH2 scene transition $0088FB36: SH2 completion check
- **RAM**: $A019: camera mode index (byte) $A022: selection state (word) $A028: action state (word, 0/1/2) $C80E: display control (byte, bits 6/7) $C809: display enable A (byte) $C80A: display enable B (byte) $C802: display enable C (byte) $C86C: controller P1 data (word) $C86E: controller P2 data (word) $C87E: game_state (word)
*Source: [camera_menu_orch.asm](disasm/modules/68k/game/menu/camera_menu_orch.asm)*

---

### Camera Menu Input Handler ($0135C4–$0136AA, 230 bytes)

Processes controller input for camera selection menu. Entry: D1 = controller data. D-pad down (bit 0): decrement $A019 counter, wrap at 0→5. D-pad up (bit 1): increment $A019 counter, wrap at 5→0. Left (bit 2): dispatch via handler table at $8936AA with D0=$FFFF. Right (bit 3): dispatch via same table with D0=$0001. Action buttons (bits 4-7): set selection state $A022 (1=start, 2=confirm, 3=accept). All inputs play SFX $A9. Updates blink timer from $FF2100 and toggles $A026.

- **Entry**: D1 = controller data
- **Modifies**: D0, D1, D2, A0
- **RAM**: $A019: camera mode index (byte, range 0-5) $A022: selection state (word) $A024: blink timer (word) $A026: blink toggle (word, toggled via NEG) $C8A4: sound effect (byte)
*Source: [camera_menu_input_handler.asm](disasm/modules/68k/game/menu/camera_menu_input_handler.asm)*

---

### Camera Selection Counter (Replay Angle) ($0136AA–$0136EA, 64 bytes)

Data prefix (24 bytes), then code at $0136C2. If D2 == 0: adds D0 to replay angle counter ($A01A), wraps 0-2. If D2 != 0: reverts game_state by 4.

- **Entry**: D0 = increment/decrement, D2 = action flag
- **Modifies**: D0, D2
- **RAM**: $A01A: replay angle counter (word, range 0-2) $C87E: game_state (word)
*Source: [camera_selection_counter_0136aa.asm](disasm/modules/68k/game/menu/camera_selection_counter_0136aa.asm)*

---

### Camera Selection Counter (Music Track) ($0136EA–$013734, 74 bytes)

If D2 == 0: adds D0 to music track counter ($A01C), wraps 0-25. If D2 != 0: checks ranking ($A022), sets sound effect ($C822/$C8A7), looks up music track from table at $0089AC62, reverts game_state.

- **Entry**: D0 = increment, D2 = action flag
- **Modifies**: D0, D2, A0
- **RAM**: $A01C: music track counter (word, range 0-25) $A022: ranking result (word) $C822: sound effect ID (byte, set to $F3) $C8A5: sound parameter (byte, from table) $C8A7: sound clear flag (byte, cleared) $C87E: game_state (word)
*Source: [camera_selection_counter_0136ea.asm](disasm/modules/68k/game/menu/camera_selection_counter_0136ea.asm)*

---

### Camera Selection Counter (Sound Effect A) ($013734–$01377A, 70 bytes)

If D2 == 0: adds D0 to SFX counter A ($A01E), wraps 0-12. If D2 != 0: checks ranking ($A022), sets sound effect ($C822=$CA), looks up SFX from table at $0089ACB0, stores to $C8A4, reverts game_state.

- **Entry**: D0 = increment, D2 = action flag
- **Modifies**: D0, D2, A0
- **RAM**: $A01E: SFX counter A (word, range 0-12) $A022: ranking result (word) $C822: sound effect ID (byte, set to $CA) $C8A4: sound parameter (byte, from table) $C87E: game_state (word)
*Source: [camera_selection_counter_013734.asm](disasm/modules/68k/game/menu/camera_selection_counter_013734.asm)*

---

### Camera Selection Counter (Sound Effect B) ($01377A–$0137C0, 70 bytes)

If D2 == 0: adds D0 to SFX counter B ($A020), wraps 0-9. If D2 != 0: checks ranking ($A022), sets sound effect ($C822=$CA), looks up SFX from table at $0089ACE6, stores to $C8A4, reverts game_state. Same pattern as camera_selection_counter_013734 but different counter/table/range.

- **Entry**: D0 = increment, D2 = action flag
- **Modifies**: D0, D2, A0
- **RAM**: $A020: SFX counter B (word, range 0-9) $A022: ranking result (word) $C822: sound effect ID (byte, set to $CA) $C8A4: sound parameter (byte, from table) $C87E: game_state (word)
*Source: [camera_selection_counter_01377a.asm](disasm/modules/68k/game/menu/camera_selection_counter_01377a.asm)*

---

### Conditional State Set + Enable Flags + SH2 Call (with ST) ($0137C0–$0137F4, 52 bytes)

Tests D2. If zero, returns. Otherwise sets state variable ($C8A4) to $A8, sets $A018 to $FF (ST), enables SH2 flag ($C809), display mode ($C80A), command flag ($C802), sets sync bit 7 ($C80E), calls SH2 routine, and sets $A028 to $0002.

- **Entry**: D2 = condition value | Exit: flags set or no-op | Uses: D2
- **RAM**: $FFFFC8A4 = state variable (byte, set to $A8) $FFFFA018 = P1 data (byte, set to $FF via ST) $FFFFC809 = SH2 enable flag (byte, set to $01) $FFFFC80A = display mode flag (byte, set to $01) $FFFFC80E = sync/transition flags (byte, bit 7 set) $FFFFC802 = command flag (byte, set to $01) $FFFFA028 = player data (word, set to $0002)
*Source: [conditional_state_set_enable_flags_sh2_call_0137c0.asm](disasm/modules/68k/game/menu/conditional_state_set_enable_flags_sh2_call_0137c0.asm)*

---

### Conditional State Set + Enable Flags + SH2 Call ($0137F4–$013824, 48 bytes)

Tests D2. If zero, returns. Otherwise sets state variable ($C8A4) to $A8, enables SH2 flag ($C809), display mode ($C80A), command flag ($C802), sets sync bit 7 ($C80E), calls SH2 routine $0088205E, and sets $A028 to $0002.

- **Entry**: D2 = condition value | Exit: flags set or no-op | Uses: D2
- **RAM**: $FFFFC8A4 = state variable (byte, set to $A8) $FFFFC809 = SH2 enable flag (byte, set to $01) $FFFFC80A = display mode flag (byte, set to $01) $FFFFC80E = sync/transition flags (byte, bit 7 set) $FFFFC802 = command flag (byte, set to $01) $FFFFA028 = player data (word, set to $0002)
*Source: [conditional_state_set_enable_flags_sh2_call_0137f4.asm](disasm/modules/68k/game/menu/conditional_state_set_enable_flags_sh2_call_0137f4.asm)*

---

### race_config_screen_init ($013864–$013A88, 548 bytes)

Race Config Screen Initialization Initializes the race configuration/car selection screen. Standard VDP setup template with track-variant tile loading: - Loads track-specific tile sets based on bits 0-3 of $C958 (race config) - Three tile data regions at $06014000, $06017CC0, $0601DFC0 - Selects between 3 tile ROM sources per player based on config flags

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0: sh2_load_data $00E316: sh2_send_cmd_wait
- **RAM**: $C87A: vint_dispatch_state $C87E: game_state
*Source: [race_config_screen_init.asm](disasm/modules/68k/game/menu/race_config_screen_init.asm)*

---

### race_config_state_disp ($013A88–$013C30, 424 bytes)

Race Config State Dispatcher Data prefix ($013A88-$013BC5) contains: - 15-bit RGB color palette (grayscale ramp + game-specific colors) - Structured parameter blocks with coordinate pairs and sentinel $7FFF - Display state identifiers for car selection UI elements Code section ($013BC6-$013C2F) is a state dispatcher: reads game_state, indexes PC-relative jump table (4 states), dispatches to handler. First handler configures player 1 and player 2 car selection via car_driver_selection_input_handler.

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7
- **RAM**: $C87E: game_state
*Source: [race_config_state_disp.asm](disasm/modules/68k/game/menu/race_config_state_disp.asm)*

---

### Camera SH2 Scene Transition + Dual DMA ($013C30–$013CBA, 138 bytes)

Calls SH2 scene transition, then DMA transfer. Sends COMM protocol (cmd $2C, COMM4=$4000) to SH2, waits for ack. Then sets height=$B8 via COMM4, sends two sh2_send_cmd DMA transfers for dual display buffers ($06017CC0→$04007010 and $0601DFC0→$04013010). Advances game_state, display mode $0020.

- **Modifies**: D0, D1, A0, A1
- **Calls**: $00E35A: sh2_send_cmd $00E52C: dma_transfer $0088205E: SH2 scene transition
- **RAM**: $C87E: game_state (word, advanced by 4)
*Source: [camera_sh2_scene_transition_dual_dma.asm](disasm/modules/68k/game/menu/camera_sh2_scene_transition_dual_dma.asm)*

---

### race_config_main_loop ($013CBA–$013F80, 710 bytes)

Race Config Main Loop Per-frame update for the race configuration / car selection screen: 1. DMA transfer, object_update, sprite_update 2. Render 3 static tile blocks (header, P1 area, P2 area) 3. Render dynamic car preview tiles using lookup tables ($0089AA12/2E) with indexed tile selection based on current car/driver choice 4. Handle player 1 input (D-pad, buttons) via car_driver_selection_input_handler 5. Handle player 2 input via car_driver_selection_input_handler (if 2P config) 6. State machine: browsing ($0000), confirm ($0001/$0002)

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A2
- **Calls**: $00E35A: sh2_send_cmd $00E52C: dma_transfer
- **RAM**: $C87E: game_state
*Source: [race_config_main_loop.asm](disasm/modules/68k/game/menu/race_config_main_loop.asm)*

---

### I/O Port Config Backup + SH2 Scene Reset ($013F80–$013FE0, 96 bytes)

Conditionally copies 8-byte I/O port configuration blocks for each controller port whose status byte equals $06. Port 1 config ($FE82) is copied to $FE94; Port 2 config ($FE8A) is copied to $FE9C. Then waits for SH2 idle and sets scene handler $0089305E.

- **Entry**: none | Exit: port configs backed up, SH2 reset
- **Modifies**: D0, A0, A1
- **RAM**: $FFFFFE92 = port 1 status (byte, compared to $06) $FFFFFE93 = port 2 status (byte, compared to $06) $FFFFFE82 = port 1 config source (8 bytes, read) $FFFFFE8A = port 2 config source (8 bytes, read) $FFFFFE94 = port 1 config backup (8 bytes, written) $FFFFFE9C = port 2 config backup (8 bytes, written) $FFFFC87E = main game state (word, cleared to 0) $00FF0002 = SH2 scene handler pointer (long, set) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [i_o_port_config_backup_sh2_scene_reset.asm](disasm/modules/68k/game/menu/i_o_port_config_backup_sh2_scene_reset.asm)*

---

### car_driver_selection_input_handler ($013FE0–$01418E, 430 bytes)

Car/Driver Selection Input Handler Processes input for car/driver selection on the race config screen. - D-pad up/down: cycle through car choices (0-4 or 0-7 depending on D0) - D-pad left/right: cycle through color/driver variants with wrap - Button A+B: confirm selection → copy choice to output buffer - Button C: toggle manual/auto transmission - Start (bit 7): signal ready for race start Uses lookup tables at $0089AB8E/$0089ABBE for car graphics data.

- **Entry**: D0 = max car count flag, D1 = button state, D2 = player index, D3 = repeat timer flag, A0 = car index ptr, A1 = saved choices, A2 = output buffer, A3 = current selection ptr, A4 = ready flag
- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A2
*Source: [car_driver_selection_input_handler.asm](disasm/modules/68k/game/menu/car_driver_selection_input_handler.asm)*

---

### table_entry_swap_by_index ($01418E–$0141DC, 78 bytes)

Table Entry Swap by Index Swaps two entries in array (A1) based on lookup indices. Reads index from (A3), looks up value in table A0 (selected by D0: $008941DC or $008941E2), searches (A1) for matching entry, saves position. Repeats for second index from (A4). Then swaps the two found entries in (A1). Used for reordering standings/rankings by swapping positions.

- **Entry**: A1 = sortable array, A3 = pointer to index 1, A4 = pointer to index 2, D0 = table selector (0 = table A, nonzero = table B)
- **Modifies**: D0, D1, D3, D4, D5, D6, A0, A1
*Source: [table_entry_swap_by_index.asm](disasm/modules/68k/game/menu/table_entry_swap_by_index.asm)*

---

### sprite_strip_renderer_via_sh2_cmd_27 ($014200–$014262, 98 bytes)

Sprite Strip Renderer via SH2 Cmd 27 DC.W $AB6E (2 bytes, likely a constant or flags word). Renders a multi-row sprite strip to SH2 by looping through entity table entries. For each row: computes entry address via D2×4 index into (A1), adds vertical offset (D1 first row, D5 subsequent), sends 80×7 tile data via sh2_cmd_27. Loop count from D3 (default 6 rows).

- **Entry**: A0 = base data, A1 = entity table, D1 = initial Y offset, D3 = row count, D5 = per-row Y offset
- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1
- **Calls**: $00E3B4: sh2_cmd_27
*Source: [sprite_strip_renderer_via_sh2_cmd_27.asm](disasm/modules/68k/game/menu/sprite_strip_renderer_via_sh2_cmd_27.asm)*

---

### game_mode_transition_init ($014262–$0143C6, 356 bytes)

Game Mode Transition Init Initializes hardware state for a game mode transition. Performs full VDP reset including DMA fills to clear VRAM: 1. Disable interrupts (SR = $2700), configure adapter control 2. Request Z80 bus, set up VDP DMA parameters 3. DMA fill: clear nametable A ($C000, 8KB) and sprite table ($4000) 4. Release Z80 bus, initialize sound driver 5. Set VDP display mode to 256-color (mode $03) 6. Configure COMM0 for SH2 scene sync 7. Set dispatch table pointer to mode-specific handler

- **Modifies**: D0, D1, D4, D7, A5, A6
- **RAM**: $C082: menu_state $C87E: game_state
*Source: [game_mode_transition_init.asm](disasm/modules/68k/game/menu/game_mode_transition_init.asm)*

---

### Advance Game State ($0143FA–$014400, 6 bytes)

Advances the main game state machine by one step (4 = one state entry).

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC87E = main game state index (word)
*Source: [advance_game_state.asm](disasm/modules/68k/game/menu/advance_game_state.asm)*

---

### Menu State Dispatch and Display Mode Set ($014400–$01440E, 14 bytes)

Calls the menu state dispatcher at $01457C, then sets the display mode to $0024 via the adapter register at $FF0008.

- **Entry**: none | Exit: menu dispatched, display mode set
- **Modifies**: (per called function)
- **RAM**: $00FF0008 = display mode register (word, set to $0024)
*Source: [menu_state_dispatch_disp_mode_set.asm](disasm/modules/68k/game/menu/menu_state_dispatch_disp_mode_set.asm)*

---

### Menu State Dispatch 042 ($01440E–$01446C, 94 bytes)

Menu state dispatcher with 8-entry jump table State 0: clears substate + fade, advances state State 1: loads DMA transfer, calls menu_state_check State 2: countdown timer, advances when done

- **Modifies**: D0, D1, A0, A1, A2, A4
- **Calls**: $0145F0: menu_state_check
- **RAM**: $C082: menu_state (dispatch index, increments by 4) $C084: menu_substate $A006: menu_timer $A008: fade_counter
- **Confidence**: high
*Source: [menu_state_dispatch_042.asm](disasm/modules/68k/game/menu/menu_state_dispatch_042.asm)*

---

### Menu Item Draw Loop (Jump Table Indexed) ($01446C–$0144A8, 60 bytes)

Calls $014566 (check/init); if nonzero sets $C084 = $0F. Loads longword address from jump table at $01462A indexed by $C084 (×4), calls $0145F0 (menu_state_check) with D1=$9A00. Increments $C084; when $C084 > $0F: advances $C082 by 4 and sets timer ($A006) = $28.

- **Modifies**: D0, D1, A0, A1
- **Calls**: $014566: menu check/init $0145F0: menu_state_check Jump table: $01462A: 16 longword entries (menu item addresses)
- **RAM**: $A006: timer (word, set to $28) $C082: menu_state (word, +4 on completion) $C084: menu_substate (word, 0-$F loop counter)
*Source: [menu_item_draw_loop.asm](disasm/modules/68k/game/menu/menu_item_draw_loop.asm)*

---

### Menu State Check + Timer Countdown (Variant A) ($0144A8–$0144D0, 40 bytes)

Loads table address and parameter, calls menu_state_check. Decrements timer ($A006). If not expired, returns. Otherwise advances menu dispatch ($C082) by 4, sets comm signal ($C822) to $F0, and sets $A008 to $0802.

- **Entry**: none | Exit: timer decremented | Uses: D1, A1
- **RAM**: $FFFFA006 = countdown timer (word, decremented) $FFFFC082 = menu dispatch index (word, advanced by 4) $FFFFC822 = comm signal (byte, set to $F0) $FFFFA008 = player data (word, set to $0802)
*Source: [menu_state_check_timer_countdown_0144a8.asm](disasm/modules/68k/game/menu/menu_state_check_timer_countdown_0144a8.asm)*

---

### Menu State Check + Conditional Advance (Variant A) ($0144D0–$0144F2, 34 bytes)

Loads table address and parameter, calls menu_state_check. Tests player data ($A008): if non-zero, returns. Otherwise advances menu dispatch ($C082) by 4 and sets $A008 to $0801.

- **Entry**: none | Exit: menu state checked | Uses: D1, A1
- **RAM**: $FFFFA008 = player data (word, tested, conditionally set to $0801) $FFFFC082 = menu dispatch index (word, advanced by 4)
*Source: [menu_state_check_cond_advance_0144d0.asm](disasm/modules/68k/game/menu/menu_state_check_cond_advance_0144d0.asm)*

---

### Menu State Check + Conditional Advance (Variant B) ($0144F2–$014518, 38 bytes)

Loads alternate table address and parameter, calls menu_state_check. Tests player data ($A008): if non-zero, returns. Otherwise clears $A008, advances menu dispatch ($C082) by 4, and sets timer ($A006) to $0014.

- **Entry**: none | Exit: menu state checked | Uses: D1, A1
- **RAM**: $FFFFA008 = player data (word, tested, cleared) $FFFFC082 = menu dispatch index (word, advanced by 4) $FFFFA006 = countdown timer (word, set to $0014)
*Source: [menu_state_check_cond_advance_0144f2.asm](disasm/modules/68k/game/menu/menu_state_check_cond_advance_0144f2.asm)*

---

### Menu State Check + Timer Countdown (Variant B) ($014518–$014540, 40 bytes)

Loads alternate table address and parameter, calls menu_state_check. Decrements timer ($A006). If not expired, returns. Otherwise advances menu dispatch ($C082) by 4, sets comm signal ($C822) to $F0, and sets $A008 to $0802.

- **Entry**: none | Exit: timer decremented | Uses: D1, A1
- **RAM**: $FFFFA006 = countdown timer (word, decremented) $FFFFC082 = menu dispatch index (word, advanced by 4) $FFFFC822 = comm signal (byte, set to $F0) $FFFFA008 = player data (word, set to $0802)
*Source: [menu_state_check_timer_countdown_014518.asm](disasm/modules/68k/game/menu/menu_state_check_timer_countdown_014518.asm)*

---

### Read Combined Start Button State ($014566–$01457C, 22 bytes)

Reads the start button flag from $C86D. If the current mode ($C810) is $0D (2-player), ORs in the second player's flag from $C86F. Returns bit 7 (start pressed) in D0.

- **Entry**: none | Exit: D0.B bit 7 = start pressed (either player)
- **Modifies**: D0
- **RAM**: $FFFFC86D = player 1 input flags (byte, bit 7 = start) $FFFFC810 = current game mode (byte, $0D = 2-player) $FFFFC86F = player 2 input flags (byte, bit 7 = start)
*Source: [read_combined_start_button_state.asm](disasm/modules/68k/game/menu/read_combined_start_button_state.asm)*

---

### Palette Fade 003 ($01457C–$0145F0, 116 bytes)

Applies brightness fade to 256-entry CRAM palette Scales R/G/B channels (5-bit each in $7C00/$03E0/$001F format) Decrements fade counter; clears when done

- **Modifies**: D0, D1, D2, D3, D4, D5, A1
- **RAM**: $A008: fade_counter (byte: intensity 0-8; word: nonzero = active) $A009: fade_mode $A100: cram_shadow (256 words)
- **Confidence**: high
*Source: [palette_fade_003.asm](disasm/modules/68k/game/menu/palette_fade_003.asm)*

---

### Menu Tile Copy to VDP (Block Transfer) ($0145F0–$01462A, 58 bytes)

Copies tile data from (A1) to VDP nametable at $00844000 + D1. First reads 3 header words: D2 = row count, D3 = column count, D0 = data longword count. Copies D0 longwords from (A2) to work buffer at $A100. Then doubles D0 (word count) and advances A1 past the longword data. For each row: reads word count from (A1)+, copies that many words to VDP base, advances base by $200.

- **Modifies**: D0, D1, D2, D3, D4, A1, A2, A3
- **RAM**: $A100: VDP tile work buffer
*Source: [menu_tile_copy_to_vdp.asm](disasm/modules/68k/game/menu/menu_tile_copy_to_vdp.asm)*

---

### Menu Item Address Table + VDP Register Clear ($01462A–$014696, 108 bytes)

Data prefix: 16-entry longword table of menu item data addresses ($0090E732..$009286AE in ROM data segment). Code: sets D0 = 0, writes to $C80D and 6 VDP tile registers at $FF6870/$FF68A0/$FF6820/$FF6850/$FF6830/$FF68B0 (clear all).

- **Modifies**: D0
- **RAM**: $C80D: menu state flag (byte, cleared)
*Source: [menu_item_address_table_vdp_reg_clear.asm](disasm/modules/68k/game/menu/menu_item_address_table_vdp_reg_clear.asm)*

---

### Set Control Flag $C30D ($0146B4–$0146BC, 8 bytes)

Sets the control flag byte at $C30D to 1.

- **Entry**: none | Exit: flag set | Uses: none
- **RAM**: $FFFFC30D = control flag (byte)
*Source: [set_control_flag_c30d.asm](disasm/modules/68k/game/menu/set_control_flag_c30d.asm)*

---

### Set Mode Flag and Copy State Counter ($0146BC–$0146CA, 14 bytes)

Sets bit 0 of the mode flag at $C30E, then copies the state value from $C096 to the V-INT state variable at $C07A.

- **Entry**: none | Exit: flag set, state copied | Uses: none
- **RAM**: $FFFFC30E = mode flag (bit 0 set) $FFFFC096 = source state value (word) $FFFFC07A = V-INT state counter (word, written)
*Source: [set_mode_flag_copy_state_counter.asm](disasm/modules/68k/game/menu/set_mode_flag_copy_state_counter.asm)*

---

### Scroll X: Increment by 1 ($0146CA–$0146DA, 16 bytes)

Adds 1 to the horizontal scroll position and copies to SH2 shared memory. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll X incremented | Uses: D0
- **RAM**: $FFFFC054 = scroll X position (word) $00FF6104 = scroll X shared memory mirror (word)
*Source: [scroll_x_inc_by_1.asm](disasm/modules/68k/game/menu/scroll_x_inc_by_1.asm)*

---

### Scroll X: Decrement by 1 ($0146DA–$0146EA, 16 bytes)

Subtracts 1 from the horizontal scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll X decremented | Uses: D0
- **RAM**: $FFFFC054 = scroll X position (word) $00FF6104 = scroll X shared memory mirror (word)
*Source: [scroll_x_dec_by_1.asm](disasm/modules/68k/game/menu/scroll_x_dec_by_1.asm)*

---

### Scroll Y: Increment by 1 ($0146EA–$0146FA, 16 bytes)

Adds 1 to the vertical scroll position and copies to SH2 shared memory. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll Y incremented | Uses: D0
- **RAM**: $FFFFC056 = scroll Y position (word) $00FF6106 = scroll Y shared memory mirror (word)
*Source: [scroll_y_inc_by_1.asm](disasm/modules/68k/game/menu/scroll_y_inc_by_1.asm)*

---

### Scroll Y: Decrement by 1 ($0146FA–$01470A, 16 bytes)

Subtracts 1 from the vertical scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll Y decremented | Uses: D0
- **RAM**: $FFFFC056 = scroll Y position (word) $00FF6106 = scroll Y shared memory mirror (word)
*Source: [scroll_y_dec_by_1.asm](disasm/modules/68k/game/menu/scroll_y_dec_by_1.asm)*

---

### Scroll X: Increment by 32 ($01470A–$01471A, 16 bytes)

Adds 32 ($20) to the horizontal scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll X incremented by 32 | Uses: D0
- **RAM**: $FFFFC054 = scroll X position (word) $00FF6104 = scroll X shared memory mirror (word)
*Source: [scroll_x_inc_by_32.asm](disasm/modules/68k/game/menu/scroll_x_inc_by_32.asm)*

---

### Scroll X: Decrement by 32 ($01471A–$01472A, 16 bytes)

Subtracts 32 ($20) from the horizontal scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).

- **Entry**: none | Exit: scroll X decremented by 32 | Uses: D0
- **RAM**: $FFFFC054 = scroll X position (word) $00FF6104 = scroll X shared memory mirror (word)
*Source: [scroll_x_dec_by_32.asm](disasm/modules/68k/game/menu/scroll_x_dec_by_32.asm)*

---

### Scroll Y: Increment by 32 ($01472A–$01473A, 16 bytes)

Adds 32 ($20) to the vertical scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-015).

- **Entry**: none | Exit: scroll Y incremented by 32 | Uses: D0
- **RAM**: $FFFFC056 = scroll Y position (word) $00FF6106 = scroll Y shared memory mirror (word)
*Source: [scroll_y_inc_by_32.asm](disasm/modules/68k/game/menu/scroll_y_inc_by_32.asm)*

---

### Scroll Y: Decrement by 32 ($01473A–$01474A, 16 bytes)

Subtracts 32 ($20) from the vertical scroll position and copies to SH2. Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-015).

- **Entry**: none | Exit: scroll Y decremented by 32 | Uses: D0
- **RAM**: $FFFFC056 = scroll Y position (word) $00FF6106 = scroll Y shared memory mirror (word)
*Source: [scroll_y_dec_by_32.asm](disasm/modules/68k/game/menu/scroll_y_dec_by_32.asm)*

---

### Add Track Segment Offset ($01474A–$014754, 10 bytes)

Reads the track segment value from $C8B0 and adds it to the accumulator at $C056. Paired with subtract_track_segment_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B0 = track segment value (word, read) $FFFFC056 = segment accumulator (word, incremented)
*Source: [add_track_segment_offset.asm](disasm/modules/68k/game/menu/add_track_segment_offset.asm)*

---

### Subtract Track Segment Offset ($014754–$01475E, 10 bytes)

Reads the track segment value from $C8B0 and subtracts it from the accumulator at $C056. Paired with add_track_segment_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B0 = track segment value (word, read) $FFFFC056 = segment accumulator (word, decremented)
*Source: [subtract_track_segment_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_offset.asm)*

---

### Add Track Segment 1 Offset ($01475E–$014768, 10 bytes)

Reads track segment value 1 from $C8B2 and adds it to its accumulator at $C086. Paired with subtract_track_segment_1_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B2 = track segment value 1 (word, read) $FFFFC086 = segment accumulator 1 (word, incremented)
*Source: [add_track_segment_1_offset.asm](disasm/modules/68k/game/menu/add_track_segment_1_offset.asm)*

---

### Subtract Track Segment 1 Offset ($014768–$014772, 10 bytes)

Reads track segment value 1 from $C8B2 and subtracts it from its accumulator at $C086. Paired with add_track_segment_1_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B2 = track segment value 1 (word, read) $FFFFC086 = segment accumulator 1 (word, decremented)
*Source: [subtract_track_segment_1_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_1_offset.asm)*

---

### Add Track Segment 2 Offset ($014772–$01477C, 10 bytes)

Reads track segment value 2 from $C8B4 and adds it to its accumulator at $C0B0. Paired with subtract_track_segment_2_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B4 = track segment value 2 (word, read) $FFFFC0B0 = segment accumulator 2 (word, incremented)
*Source: [add_track_segment_2_offset.asm](disasm/modules/68k/game/menu/add_track_segment_2_offset.asm)*

---

### Subtract Track Segment 2 Offset ($01477C–$014786, 10 bytes)

Reads track segment value 2 from $C8B4 and subtracts it from its accumulator at $C0B0. Paired with add_track_segment_2_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B4 = track segment value 2 (word, read) $FFFFC0B0 = segment accumulator 2 (word, decremented)
*Source: [subtract_track_segment_2_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_2_offset.asm)*

---

### Add Track Segment 3 Offset ($014786–$014790, 10 bytes)

Reads track segment value 3 from $C8B6 and adds it to its accumulator at $C0AE. Paired with subtract_track_segment_3_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B6 = track segment value 3 (word, read) $FFFFC0AE = segment accumulator 3 (word, incremented)
*Source: [add_track_segment_3_offset.asm](disasm/modules/68k/game/menu/add_track_segment_3_offset.asm)*

---

### Subtract Track Segment 3 Offset ($014790–$01479A, 10 bytes)

Reads track segment value 3 from $C8B6 and subtracts it from its accumulator at $C0AE. Paired with add_track_segment_3_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B6 = track segment value 3 (word, read) $FFFFC0AE = segment accumulator 3 (word, decremented)
*Source: [subtract_track_segment_3_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_3_offset.asm)*

---

### Add Track Segment 4 Offset ($01479A–$0147A4, 10 bytes)

Reads track segment value 4 from $C8B8 and adds it to its accumulator at $C0B2. Paired with subtract_track_segment_4_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B8 = track segment value 4 (word, read) $FFFFC0B2 = segment accumulator 4 (word, incremented)
*Source: [add_track_segment_4_offset.asm](disasm/modules/68k/game/menu/add_track_segment_4_offset.asm)*

---

### Subtract Track Segment 4 Offset ($0147A4–$0147AE, 10 bytes)

Reads track segment value 4 from $C8B8 and subtracts it from its accumulator at $C0B2. Paired with add_track_segment_4_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8B8 = track segment value 4 (word, read) $FFFFC0B2 = segment accumulator 4 (word, decremented)
*Source: [subtract_track_segment_4_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_4_offset.asm)*

---

### Add Track Segment 5 Offset ($0147AE–$0147B8, 10 bytes)

Reads track segment value 5 from $C8BA and adds it to the scroll X accumulator at $C054. Paired with subtract_track_segment_5_offset (subtract).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8BA = track segment value 5 (word, read) $FFFFC054 = scroll X position / accumulator (word, incremented)
*Source: [add_track_segment_5_offset.asm](disasm/modules/68k/game/menu/add_track_segment_5_offset.asm)*

---

### Subtract Track Segment 5 Offset ($0147B8–$0147C2, 10 bytes)

Reads track segment value 5 from $C8BA and subtracts it from the scroll X accumulator at $C054. Paired with add_track_segment_5_offset (add).

- **Entry**: none | Exit: accumulator updated | Uses: D0
- **RAM**: $FFFFC8BA = track segment value 5 (word, read) $FFFFC054 = scroll X position / accumulator (word, decremented)
*Source: [subtract_track_segment_5_offset.asm](disasm/modules/68k/game/menu/subtract_track_segment_5_offset.asm)*

---

### Initialize Scroll + Position Registers ($0147C2–$0147E8, 38 bytes)

Sets initial values for scroll and track position registers. Scroll X = $F400, Scroll Y = $3400, segment positions zeroed/set.

- **Entry**: none | Exit: scroll/position initialized | Uses: none
- **RAM**: $FFFFC086 = segment 1 position (word, set to $0000) $FFFFC054 = scroll X (word, set to $F400) $FFFFC056 = scroll Y (word, set to $3400) $FFFFC0AE = segment 3 position (word, set to $0000) $FFFFC0B0 = segment 2 position (word, set to $0800) $FFFFC0B2 = segment 4 position (word, set to $0000)
*Source: [initialize_scroll_pos_regs.asm](disasm/modules/68k/game/menu/initialize_scroll_pos_regs.asm)*

---

### Initialize Track Segment Values to Center ($0147E8–$01480E, 38 bytes)

Sets all 6 track segment variables ($C8B0-$C8BA) to $0080 (center/default). These segments feed into the scroll and position registers via other track segment add/subtract functions.

- **Entry**: none | Exit: all segments centered | Uses: none
- **RAM**: $FFFFC8B0 = track segment 0 (word, set to $0080) $FFFFC8B2 = track segment 1 (word, set to $0080) $FFFFC8B4 = track segment 2 (word, set to $0080) $FFFFC8B6 = track segment 3 (word, set to $0080) $FFFFC8B8 = track segment 4 (word, set to $0080) $FFFFC8BA = track segment 5 (word, set to $0080)
*Source: [initialize_track_segment_values_to_center.asm](disasm/modules/68k/game/menu/initialize_track_segment_values_to_center.asm)*

---

### Adjust $903C: Add $0400 ($01480E–$014816, 8 bytes)

Adds $0400 to the word at $903C. One of a group of four related adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).

- **Entry**: none | Exit: value incremented | Uses: none
- **RAM**: $FFFF903C = adjustable parameter (word)
*Source: [adjust_903c_add_0400.asm](disasm/modules/68k/game/menu/adjust_903c_add_0400.asm)*

---

### Adjust $903C: Subtract $0400 ($014816–$01481E, 8 bytes)

Subtracts $0400 from the word at $903C. One of a group of four related adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).

- **Entry**: none | Exit: value decremented | Uses: none
- **RAM**: $FFFF903C = adjustable parameter (word)
*Source: [adjust_903c_subtract_0400.asm](disasm/modules/68k/game/menu/adjust_903c_subtract_0400.asm)*

---

### Adjust $903C: Add $1000 ($01481E–$014826, 8 bytes)

Adds $1000 to the word at $903C. One of a group of four related adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).

- **Entry**: none | Exit: value incremented | Uses: none
- **RAM**: $FFFF903C = adjustable parameter (word)
*Source: [adjust_903c_add_1000.asm](disasm/modules/68k/game/menu/adjust_903c_add_1000.asm)*

---

### Adjust $903C: Add $2000 ($014826–$01482E, 8 bytes)

Adds $2000 to the word at $903C. One of a group of four related adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).

- **Entry**: none | Exit: value incremented | Uses: none
- **RAM**: $FFFF903C = adjustable parameter (word)
*Source: [adjust_903c_add_2000.asm](disasm/modules/68k/game/menu/adjust_903c_add_2000.asm)*

---

### Fade Level Increment (Brightness Up) ($01482E–$014848, 26 bytes)

Reads the fade level from $C888 (long), increments by 8, and clamps at $00FFFFFF (maximum). Writes the result back.

- **Entry**: none | Exit: fade level incremented | Uses: D0
- **RAM**: $FFFFC888 = fade level (long, incremented by 8, max $00FFFFFF)
*Source: [fade_level_inc.asm](disasm/modules/68k/game/menu/fade_level_inc.asm)*

---

### Fade Level Decrement (Brightness Down) ($014848–$014862, 26 bytes)

Reads the fade level from $C888 (long), decrements by 8, and clamps at minimum $00FF6000. Writes the result back.

- **Entry**: none | Exit: fade level decremented | Uses: D0
- **RAM**: $FFFFC888 = fade level (long, decremented by 8, min $00FF6000)
*Source: [fade_level_dec.asm](disasm/modules/68k/game/menu/fade_level_dec.asm)*

---

### scroll_pos_increment ($014862–$014872, 16 bytes)

Scroll Position Increment Increments a scroll position by $10 (16 pixels). Compares current value at (A1) with target at (A2), updates (A2) if different, then adds $10 to (A2) and writes result back to (A1).

- **Entry**: A1 = current position pointer, A2 = target position pointer
- **Returns**: (A1) updated with incremented value
- **Modifies**: D0, A1, A2
*Source: [scroll_pos_increment.asm](disasm/modules/68k/game/menu/scroll_pos_increment.asm)*

---

### scroll_pos_decrement ($014872–$014882, 16 bytes)

Scroll Position Decrement Decrements a scroll position by $10 (16 pixels). Compares current value at (A1) with target at (A2), updates (A2) if different, then subtracts $10 from (A2) and writes result back to (A1).

- **Entry**: A1 = current position pointer, A2 = target position pointer
- **Returns**: (A1) updated with decremented value
- **Modifies**: D0, A1, A2
*Source: [scroll_pos_decrement.asm](disasm/modules/68k/game/menu/scroll_pos_decrement.asm)*

---

## Game / Physics

### Weighted Average Position Clamp (Variant B) ($0023DC–$00240C, 48 bytes)

Computes weighted average: D1 = (D0×29/256 + $1A5E + *A1) / 2. Clamps result to range [$1A5E, $21D0]. If D1 > $21D0 → branches to $00240C (external upper-clamp path). If D1 in range → branches to $002410 (external store path). If D1 ≤ $1A5E → clamps to $1A5E, stores to (A1) and $8760. Same structure as weighted_average_pos_clamp_002426 but different coefficients and upper bound.

- **Entry**: D0 = input value, A1 = position pointer
- **Modifies**: D0, D1, A1
- **RAM**: $8760: output position (word)
*Source: [weighted_average_pos_clamp_0023dc.asm](disasm/modules/68k/game/physics/weighted_average_pos_clamp_0023dc.asm)*

---

### Weighted Average Position Clamp ($002426–$002452, 44 bytes)

Computes weighted average: D1 = (D0×7/64 + $1A5E + *A1) / 2. Clamps result to range [$1A5E, $21A0]. If D1 > $21A0 → branches to $002452 (external upper-clamp path). If D1 in range → branches to $002456 (external store path). If D1 ≤ $1A5E → clamps to $1A5E, stores to (A1) and $8760.

- **Entry**: D0 = input value, A1 = position pointer
- **Modifies**: D0, D1, A1
- **RAM**: $8760: output position (word)
*Source: [weighted_average_pos_clamp_002426.asm](disasm/modules/68k/game/physics/weighted_average_pos_clamp_002426.asm)*

---

### Object Velocity Init + Conditional Clear ($002AAA–$002AC4, 26 bytes)

Copies velocity data from $C748 to object A1 offset +$24. Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero, falls through to next function. Otherwise clears A1+$64 and returns.

- **Entry**: A0 = source object, A1 = target object
- **Returns**: conditional return or fall-through | Uses: A0, A1
- **RAM**: $FFFFC748 = velocity data source (long)
*Source: [object_velocity_init_cond_clear.asm](disasm/modules/68k/game/physics/object_velocity_init_cond_clear.asm)*

---

### Object Velocity Init (Dual Object) ($002DF4–$002E14, 32 bytes)

Copies velocity data from $C748 to both A1+$24 and A2+$128. Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero, falls through to next function. Otherwise clears A1+$64 and returns.

- **Entry**: A0 = source obj, A1 = target obj 1, A2 = target obj 2
- **Returns**: conditional return or fall-through | Uses: A0, A1, A2
- **RAM**: $FFFFC748 = velocity data source (long)
*Source: [object_velocity_init_002df4.asm](disasm/modules/68k/game/physics/object_velocity_init_002df4.asm)*

---

### Object Velocity Init (Dual Object, Source $C710) ($002E14–$002E34, 32 bytes)

Copies velocity data from $C710 to both A1+$24 and A2+$128. Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if non-zero, clears the active flag before returning.

- **Entry**: A0 = source obj, A1 = target obj 1, A2 = target obj 2
- **Returns**: velocity set | Uses: A0, A1, A2
- **RAM**: $FFFFC710 = velocity data source (long)
*Source: [object_velocity_init_002e14.asm](disasm/modules/68k/game/physics/object_velocity_init_002e14.asm)*

---

### Object Velocity Init (Dual Object, Alt Source) ($002E5E–$002E7E, 32 bytes)

Copies velocity data from $C75C to both A1+$24 and A2+$128. Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if zero, falls through to next function. Otherwise clears A1+$64 and returns.

- **Entry**: A0 = source obj, A1 = target obj 1, A2 = target obj 2
- **Returns**: conditional return or fall-through | Uses: A0, A1, A2
- **RAM**: $FFFFC75C = velocity data source (long)
*Source: [object_velocity_init_002e5e.asm](disasm/modules/68k/game/physics/object_velocity_init_002e5e.asm)*

---

### Object Velocity Init (Dual Object, Source $C754) ($002E7E–$002E9E, 32 bytes)

Copies velocity data from $C754 to both A1+$24 and A2+$128. Sets A1+$64 to 1 (active). Tests A0+$8C (velocity_x): if non-zero, clears the active flag before returning.

- **Entry**: A0 = source obj, A1 = target obj 1, A2 = target obj 2
- **Returns**: velocity set | Uses: A0, A1, A2
- **RAM**: $FFFFC754 = velocity data source (long)
*Source: [object_velocity_init_002e7e.asm](disasm/modules/68k/game/physics/object_velocity_init_002e7e.asm)*

---

### Object Speed Ramp-Up + State Advance ($00413A–$004168, 46 bytes)

Ramps up object speed at $FF6754: increments $C25C by 8 each frame, copies to obj.speed ($06), advances obj.speed_index ($04) by 2, adds $01C0 to obj.field8 ($08). When $C25C reaches $0100 (256): advances $C07C (input_state) by 4 and clears $C8AA (scene_state).

- **Modifies**: D0, A2
- **RAM**: $C25C: speed accumulator (word, +8 per frame) $C07C: input_state (word, advanced by 4) $C8AA: scene_state (word, cleared on completion) Object ($FF6754): +$04: speed_index (word, +2 per frame) +$06: speed (word, set from $C25C) +$08: field8 (word, +$01C0 per frame)
*Source: [object_speed_ramp_up_state_advance.asm](disasm/modules/68k/game/physics/object_speed_ramp_up_state_advance.asm)*

---

### conditional_pos_add ($006CDC–$006CE4, 8 bytes)

Conditional Position Add Calls condition check at $006D00, then adds D0 to (A1) if condition is met (Z flag clear). Used for conditional entity position adjustment.

- **Entry**: D0 = adjustment value, A1 = target address
- **Modifies**: D0, A1
- **Confidence**: high
*Source: [conditional_pos_add.asm](disasm/modules/68k/game/physics/conditional_pos_add.asm)*

---

### conditional_pos_subtract ($006CE4–$006CEC, 8 bytes)

Conditional Position Subtract Calls condition check at $006D00, then subtracts D0 from (A1) if condition is met (Z flag clear). Used for conditional entity position adjustment.

- **Entry**: D0 = adjustment value, A1 = target address
- **Modifies**: D0, A1
- **Confidence**: high
*Source: [conditional_pos_subtract.asm](disasm/modules/68k/game/physics/conditional_pos_subtract.asm)*

---

### conditional_speed_add ($006CEC–$006CF6, 10 bytes)

Conditional Speed Add Calls condition check at $006D00, then adds D0 to A1+$04 (speed field) if condition is met (Z flag clear).

- **Entry**: D0 = adjustment value, A1 = entity pointer
- **Modifies**: D0, A1
- **Object fields**: +$04 speed
- **Confidence**: high
*Source: [conditional_speed_add.asm](disasm/modules/68k/game/physics/conditional_speed_add.asm)*

---

### conditional_speed_subtract ($006CF6–$006D00, 10 bytes)

Conditional Speed Subtract Calls condition check at $006D00, then subtracts D0 from A1+$04 (speed field) if condition is met (Z flag clear).

- **Entry**: D0 = adjustment value, A1 = entity pointer
- **Modifies**: D0, A1
- **Object fields**: +$04 speed
- **Confidence**: high
*Source: [conditional_speed_subtract.asm](disasm/modules/68k/game/physics/conditional_speed_subtract.asm)*

---

### entity_pos_update ($006F98–$006FFA, 98 bytes)

Entity Position Update — Heading-Based Movement Computes entity X/Y position delta from heading angle and speed using sine/cosine lookups. Contains sub at $006FDE that multiplies speed by sin/cos and accumulates into D3 (X) and D4 (Y). Three dispatch paths: normal (heading_mirror), special (+$92 > 0), and alternate (+$62 != 0).

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D2, D3, D4, D5, D6, A0
- **Object fields**: +$06 speed, +$30 x_position, +$34 y_position, +$3C heading_mirror, +$40 heading_angle, +$62 mode, +$92 param, +$96 heading_offset
- **Confidence**: high
*Source: [entity_pos_update.asm](disasm/modules/68k/game/physics/entity_pos_update.asm)*

---

### Conditional Object Velocity Negate ($007624–$007636, 18 bytes)

If the word at $C0BA is nonzero, loads the word at $C0C2, negates it, and stores the result into object+$CC. Falls through past $7636 if $C0BA is zero.

- **Entry**: A0 = object pointer | Exit: object+$CC set or falls through
- **Modifies**: D0, A0
- **RAM**: $FFFFC0BA = velocity enable flag (word, tested) $FFFFC0C2 = velocity value (word, read and negated)
*Source: [conditional_object_velocity_negate.asm](disasm/modules/68k/game/physics/conditional_object_velocity_negate.asm)*

---

### Calculate Object Heading Composite ($007636–$00764E, 24 bytes)

Computes a heading value: ($C0CA + $C0B0) * 8 + object+$3C + object+$96, storing the result in object+$CC.

- **Entry**: A0 = object pointer | Exit: +$CC updated | Uses: D0, A0
- **RAM**: $FFFFC0CA = heading base (word) $FFFFC0B0 = segment 2 position (word)
*Source: [calculate_object_heading_composite.asm](disasm/modules/68k/game/physics/calculate_object_heading_composite.asm)*

---

### entity_heading_init ($007AB2–$007AD6, 36 bytes)

Entity Heading Initialization Initializes entity heading angles. Has data prefix (4 bytes), then checks render flag bit 7 (+$C0); if clear, calls heading calculation at $007BAC, copies heading value (+$32) to both +$C6 and +$C8 (prev/current heading), and increments global object counter at $FF5FFE.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D1, A0
- **Object fields**: +$32 heading, +$C0 render_flags, +$C6 prev_heading, +$C8 current_heading
- **Confidence**: high
*Source: [entity_heading_init.asm](disasm/modules/68k/game/physics/entity_heading_init.asm)*

---

### entity_speed_guard ($007C4A–$007C56, 12 bytes)

Entity Speed Guard Guard function with data prefix (4 bytes). Tests if entity speed (+$04) is zero; if so, returns immediately. Otherwise falls through to continue processing. Prevents updates on stationary entities.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0
- **Object fields**: +$04 speed
- **Confidence**: high
*Source: [entity_speed_guard.asm](disasm/modules/68k/game/physics/entity_speed_guard.asm)*

---

### Tire Screech Sound Trigger 053 ($007C56–$007CD8, 130 bytes)

Checks 4 collision/contact channels and triggers screech sound Each channel: tests cooldown timer, checks contact bit, sets 15-frame timer Only queues sound $D2 if no other sound is pending

- **Entry**: A0 = object/entity pointer
- **Modifies**: D2, A0
- **RAM**: $C8A4: sound_command Object fields (A0): +$58: contact_flags_a +$59: contact_flags_b +$98: screech_timer_a (bit 3 of +$58) +$9A: screech_timer_b (bit 3 of +$59) +$E6: screech_timer_c (bit 4 of +$58) +$E8: screech_timer_d (bit 4 of +$59)
- **Confidence**: high
*Source: [tire_screech_sound_trigger_053.asm](disasm/modules/68k/game/physics/tire_screech_sound_trigger_053.asm)*

---

### Object Drift Check + SFX Trigger ($007D56–$007D82, 44 bytes)

Plays SFX $B5 (skid sound). Computes absolute difference between heading_angle (A0+$40) and field_1E. Checks if speed_index > $0118 AND angle difference > $0800 — if both true and velocity_x ≠ 0, returns. Otherwise branches to $007E0C (external) or $007D82 (fall-through).

- **Entry**: A0 = object pointer
- **Modifies**: D0, A0
- **RAM**: $C8A4: sound effect (byte)
- **Object fields**: A0+$04: speed_index (word) A0+$1E: reference angle (word) A0+$40: heading_angle (word) A0+$8C: velocity_x (word)
*Source: [object_drift_check_sfx_trigger.asm](disasm/modules/68k/game/physics/object_drift_check_sfx_trigger.asm)*

---

### Drift Init 057 ($007E0C–$007E74, 104 bytes)

Initiates drift/skid sequence when conditions met Checks race state, collision state, and speed threshold On trigger: computes drift direction, angle delta, and duration

- **Entry**: D0 = current speed value; A0 = object/entity pointer
- **Modifies**: D0, D1, A0
- **Calls**: $007EA4: obj_collision_response (tail call via JMP) Object fields (A0): +$14: effect_duration +$1C: collision_param +$1D: collision_type +$40: heading_angle +$56: collision_state_a +$57: collision_state_b +$62: drift_active (counter) +$64: drift_angle_delta +$66: drift_target_angle +$68: drift_direction +$72: lateral_velocity +$92: drift_cooldown
- **RAM**: $C89C: race_substate
- **Confidence**: medium
*Source: [drift_init_057.asm](disasm/modules/68k/game/physics/drift_init_057.asm)*

---

### Object Animation Timer + Speed Clear ($007E74–$007EA4, 48 bytes)

6-byte data prefix ($0101 × 3, referenced externally). Code checks obj.field55 bit 1: if set → clears $C02A, done. If clear: increments frame counter $C02A; when > 80 ($50): clears counter, clears obj.speed ($06), loads obj.field1C into D0, and jumps to external handler at $007EA4.

- **Entry**: A0 = object pointer
- **Modifies**: D0, D1, A0
- **RAM**: $C02A: frame counter (word, counts to 80)
- **Object fields**: A0+$06: speed (word, cleared on timeout) A0+$1C: next state param (word, loaded into D0) A0+$55: control flags (byte, bit 1)
*Source: [object_anim_timer_speed_clear.asm](disasm/modules/68k/game/physics/object_anim_timer_speed_clear.asm)*

---

### Object Movement Velocity Computation ($007EB2–$007EFC, 74 bytes)

Computes per-frame velocity for position interpolation. Copies $C090 → $C07A, stores D1 → $C02C. Indexes table via table_ptr ($C700) at D0×4, computes X/Y/heading velocity as (target - current) / frames_remaining (D1). Stores results in A0+$4E (X vel), A0+$50 (Y vel), A0+$52 (heading vel).

- **Modifies**: D0, D1, D2, D3, A0, A1
- **RAM**: $C02C: frame_count (word) $C07A: source copy (word, from $C090) $C090: source param (word) $C700: table_ptr (longword, word-pair table) Object (A0): +$1E: heading (word) +$30: x_position (word) +$34: y_position (word) +$3C: heading_mirror (word) +$4E: x_velocity (word) +$50: y_velocity (word) +$52: heading_velocity (word)
*Source: [object_movement_velocity_calc.asm](disasm/modules/68k/game/physics/object_movement_velocity_calc.asm)*

---

### Object Heading Deviation Check + Warning Flag ($007EFC–$007F50, 84 bytes)

Two entry points (A2 selects VDP target): Entry 1 ($007EFC): A2 = $FF6940 Entry 2 ($007F04): A2 = $FF6930 Computes heading_mirror (A0+$3C) - heading (A0+$1E). If negative, adds $10000 (wrap). If deviation is in range ($4000,$C000) exclusive (i.e., more than 90° off): sets $C312 warning flag, clears (A2). If $C8AB bit 2 set → writes $01 to (A2) instead. If deviation is within safe range and $C312 is set: clears (A2) and $C312.

- **Modifies**: D0, A0, A2
- **RAM**: $C312: heading warning flag (byte) $C8AB: scene flags (byte, bit 2) Object (A0): +$1E: heading (word) +$3C: heading_mirror (word)
*Source: [object_heading_deviation_check_warning_flag.asm](disasm/modules/68k/game/physics/object_heading_deviation_check_warning_flag.asm)*

---

### Object Timer Expire + Speed Parameter Reset ($008170–$0081C0, 80 bytes)

Decrements object timer (A0+$62). On expiry (→0): If sh2_comm_state ($C89C) == 1 AND A0+$E5 bits 1-2 nonzero AND A0+$24 in range [$69,$6F] → skip (protected range). Otherwise: sets speed_frames ($C0AC) = $F (or $4 if boost_flag $C8C8 == 2), sets A0+$92 = $28, copies heading_mirror → heading.

- **Modifies**: D0, A0
- **RAM**: $C0AC: speed_frames (word) $C89C: sh2_comm_state (word) $C8C8: boost_flag (word) Object (A0): +$24: object_id (word) +$3C: heading_mirror (word) +$40: heading_angle (word, set from mirror) +$62: timer (word, countdown) +$92: speed_param (word, set to $28) +$E5: type_flags (byte, bits 1-2)
*Source: [object_timer_expire_speed_param_reset.asm](disasm/modules/68k/game/physics/object_timer_expire_speed_param_reset.asm)*

---

### Speed Degrade Calculation ($00859A–$0085C4, 42 bytes)

Calculates speed degradation for entity. Reads speed, clamps, applies to drag field at $00BC(A0).

- **Entry**: A0 = entity
- **Modifies**: D0, D1
*Source: [speed_degrade_calc.asm](disasm/modules/68k/game/physics/speed_degrade_calc.asm)*

---

### Calculate Relative Position + Negate ($008ED6–$008EF4, 30 bytes)

Computes relative position from object to viewport: loads object+$32 minus $C0BC (X offset), shifted right 4. Loads object+$34 minus $C0BE (Y offset). Calls sub at $00A7A4, negates result D0, and stores in $C0C0.

- **Entry**: A0 = object pointer | Exit: $C0C0 set | Uses: D0, D2, D3
- **RAM**: $FFFFC0BC = viewport X reference (word, subtracted) $FFFFC0BE = viewport Y reference (word, subtracted) $FFFFC0C0 = result (word, negated value stored)
*Source: [calculate_relative_pos_negate.asm](disasm/modules/68k/game/physics/calculate_relative_pos_negate.asm)*

---

### sine_cosine_quadrant_lookup ($008F4E–$008F88, 58 bytes)

Sine/Cosine Quadrant Lookup Shared sine/cosine lookup with two entry points: $008F4E = cosine (adds 90° phase shift, falls through to sine) $008F52 = sine Normalizes angle D0, extracts quadrant via shift, dispatches through jump table at $008F66 to load value from trig table at $00930000.

- **Entry**: D0 = angle (0-$FFFF = 0-360°)
- **Returns**: D0 = sine or cosine value (16-bit signed)
- **Modifies**: D0, D1, A1
- **Confidence**: high
*Source: [sine_cosine_quadrant_lookup.asm](disasm/modules/68k/game/physics/sine_cosine_quadrant_lookup.asm)*

---

### Heading from Position ($009040–$009064, 36 bytes)

Computes heading from entity position data. Camera correction applied.

- **Entry**: none
- **Modifies**: D0
*Source: [heading_from_position.asm](disasm/modules/68k/game/physics/heading_from_position.asm)*

---

### Clear Heading Register ($00909C–$0090A4, 8 bytes)

Clears heading register at $8000.

- **Entry**: none
- **Modifies**: none
*Source: [clear_heading.asm](disasm/modules/68k/game/physics/clear_heading.asm)*

---

### Heading with Camera Rotation ($0090A4–$0090CE, 42 bytes)

Heading calculation with camera rotation offset from $C0B0.

- **Entry**: none
- **Modifies**: D0
*Source: [heading_with_camera.asm](disasm/modules/68k/game/physics/heading_with_camera.asm)*

---

### Heading Broadcast (Bulk Entity Fill) ($0090CE–$009124, 86 bytes)

Computes heading and writes to entity table via MOVEM bulk fill. 1 initial + 11 predecrement MOVEM.L writes = ~96 longs.

- **Entry**: A0 = entity, A1 = entity table destination
- **Modifies**: D0-D7
*Source: [heading_broadcast.asm](disasm/modules/68k/game/physics/heading_broadcast.asm)*

---

### entity_speed_acceleration_and_braking ($009182–$009300, 382 bytes)

Entity Speed Acceleration and Braking Manages entity longitudinal speed using acceleration/braking tables at $0088A1F0 and $00939EDE. Applies multiplicative acceleration when accelerating, division-based deceleration when braking. Speed index +$7A controls gear/phase, speed value at +$74. Triggers sound $B4 on speed threshold events. Clamps final speed delta to +/-$0400.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, A0, A1
- **Object fields**: +$04 speed, +$6A collision, +$74 raw speed, +$7A speed index, +$7E target speed, +$82 sound timer, +$84 brake timer, +$8C lateral flag, +$AE table offset
- **Confidence**: high
*Source: [entity_speed_acceleration_and_braking.asm](disasm/modules/68k/game/physics/entity_speed_acceleration_and_braking.asm)*

---

### entity_force_integration_and_speed_calc ($009300–$009458, 344 bytes)

Entity Force Integration and Speed Calculation Integrates forces on entity: computes drag from speed tables, applies directional force from param $000E, subtracts friction/air resistance, handles speed overflow with sound trigger $B1/$B4. Computes final display speed at +$74 from gear table lookups. Multiple entry points — first 18 bytes serve as alternate entry with BRA to mid-function.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, D3, A0, A1, A2
- **Object fields**: +$04 speed, +$06 display speed, +$0C slope, +$0E force, +$10 drag, +$16 calc speed, +$74 raw speed, +$78 grip, +$7A gear, +$80 sound timer, +$82 brake timer
- **Confidence**: high
*Source: [entity_force_integration_and_speed_calc.asm](disasm/modules/68k/game/physics/entity_force_integration_and_speed_calc.asm)*

---

### Speed Calculation + Multiplier Chain ($009458–$0094F4, 156 bytes)

Computes effective speed ($0016) from velocity index ($0004) via ROM lookup table, applies MULS scaling by track_speed_factor, then applies ×6 multiplier (high-speed) or ×1.5 (braking) boost depending on state. Adds wind_resistance correction and boost_timer bonus.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, A0, A1
- **Calls**: $009B32: wind_resistance_calc
- **RAM**: $C27C: speed_table_ptr (longword → ROM speed lookup) $C0E6: track_speed_factor (word, signed) $C826: has_boost_flag (byte) $C31B: wind_active (byte)
- **Object fields**: +$04: velocity_index +$06: base_speed +$0A: min_speed_threshold +$14: boost_timer (countdown) +$16: calc_speed (output) +$8A: boost_modifier +$A8: speed_state
*Source: [speed_calc_multiplier_chain.asm](disasm/modules/68k/game/physics/speed_calc_multiplier_chain.asm)*

---

### steering_input_processing_and_velocity_update ($0094F4–$00961E, 298 bytes)

Steering Input Processing and Velocity Update Data prefix (2 bytes) at start. Reads controller button bits for left/right and up/down input, computes steering direction with acceleration and deadzone. Smooths steering velocity with damping, clamps to +/-$7F range. Applies integrated steering to entity field +$8E. Manages lateral drift accumulator at +$AA.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, D3, A0, A1
- **Object fields**: +$8E steering velocity, +$94 drift rate, +$AA drift accum
- **Confidence**: high
*Source: [steering_input_processing_and_velocity_update.asm](disasm/modules/68k/game/physics/steering_input_processing_and_velocity_update.asm)*

---

### Tilt Adjust (Entity Banking) ($00961E–$009688, 106 bytes)

Adjusts entity tilt for banking. Checks race condition first. X-tilt clamped to [$FFCD, $00FF], Z-tilt clamped to [$0000, $00FF].

- **Entry**: A0 = entity
- **Modifies**: D0, D1
*Source: [tilt_adjust.asm](disasm/modules/68k/game/physics/tilt_adjust.asm)*

---

### lateral_drift_velocity_processing_00987e ($00987E–$0099AA, 300 bytes)

Lateral Drift Velocity Processing (A) Processes lateral drift/slide physics. Reduces grip based on steering magnitude, handles slip angle detection from +$4C with threshold $0037, applies force integration to +$94 (lateral velocity). Triggers spin-out via flag OR on +$02 with sound $B2 when drift exceeds limit. Natural damping decays velocity toward zero with sign preservation.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, A0
- **Object fields**: +$02 flags, +$10 drag, +$3C heading, +$4C slip angle, +$62 collision, +$6A lateral collision, +$78 grip, +$8C lateral flag, +$92 slide, +$94 lateral velocity, +$96 lateral display
- **Confidence**: high
*Source: [lateral_drift_velocity_processing_00987e.asm](disasm/modules/68k/game/physics/lateral_drift_velocity_processing_00987e.asm)*

---

### lateral_drift_velocity_processing_0099aa ($0099AA–$009B12, 360 bytes)

Lateral Drift Velocity Processing (B) Variant of lateral_drift_velocity_processing_00987e with speed-dependent grip reduction and AI boost. Same lateral drift physics: slip detection from +$4C, force integration to +$94, spin-out trigger with sound $B2. Writes final viewport scaling values to $FF617A/$FF618E.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, D2, D6, D7, A0
- **Object fields**: +$02 flags, +$04 speed, +$0E force, +$10 drag, +$3C heading, +$4C slip angle, +$62 collision, +$6A lateral collision, +$78 grip, +$80 effect timer, +$8C lateral flag, +$92 slide, +$94 lateral velocity, +$96 lateral display
- **Confidence**: high
*Source: [lateral_drift_velocity_processing_0099aa.asm](disasm/modules/68k/game/physics/lateral_drift_velocity_processing_0099aa.asm)*

---

### Speed Modifier (Conditional Scaling) ($009B32–$009B54, 34 bytes)

Applies speed modification based on ($C31A).W flag. If flag=0: returns 0. If flag>2: extra shift.

- **Entry**: A0 = entity
- **Returns**: D0 = modified speed value
- **Modifies**: D0, D1 (preserved)
*Source: [speed_modifier.asm](disasm/modules/68k/game/physics/speed_modifier.asm)*

---

### track_physics_param_table_loader ($00A0B4–$00A1CA, 278 bytes)

Track Physics Parameter Table Loader Data prefix (144 bytes of track configuration data) followed by parameter loader. Reads physics parameter table from ROM $00898818 indexed by track/mode. Populates steering, grip, friction, and acceleration parameters into RAM. Also sets up timing table pointer based on race mode and controller config.

- **Modifies**: D0, D1, A0, A1
- **Confidence**: high
*Source: [track_physics_param_table_loader.asm](disasm/modules/68k/game/physics/track_physics_param_table_loader.asm)*

---

### Physics Lookup Tables Module ($00A200–$00A34F, 336 bytes)

Contains: - physics_lookup_accessor: Index calculation function for table access - Acceleration/speed lookup tables - Sine/cosine table (64 entries, $00A2D8-$00A347)

*Source: [physics_lookup_tables.asm](disasm/modules/68k/game/physics/physics_lookup_tables.asm)*

---

### Speed Calculation (Table-Based) ($00A3BA–$00A3E8, 46 bytes)

Reads speed value from lookup table, optionally divides by 4 based on a RAM flag, then applies a speed boost if effect timer is active.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A1 Fields accessed: A0+$04: Speed table index A0+$14: Effect duration (from effect_timer_mgmt) A0+$16: Calculated speed (output)
- **RAM**: $C8C8: Mode flag (if == 2, speed is divided by 4)
*Source: [speed_calculation.asm](disasm/modules/68k/game/physics/speed_calculation.asm)*

---

### Speed Interpolation (Table-Based with Clamping) ($00A3EA–$00A432, 74 bytes)

Gradually adjusts speed toward a target value read from a lookup table. The delta is divided by 103 for smooth interpolation, then clamped to system-defined acceleration bounds stored in RAM.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, A1 Fields accessed: A0+$04: Speed table index A0+$06: Accumulated speed delta (output, clamped >= 0) A0+$08: Secondary speed field A0+$16: Current speed
- **RAM**: ($C0F8).W: Upper acceleration limit ($C0FA).W: Lower acceleration limit
*Source: [speed_interpolation.asm](disasm/modules/68k/game/physics/speed_interpolation.asm)*

---

### Physics Integration ($00A666–$00A6F6, 144 bytes)

Computes distance to target, derives a steering factor, calls ai_steering_calc to get a target heading angle, then smoothly interpolates toward it. Converts heading to velocity via sine/cosine and updates position.

- **Entry**: A0 = object/entity pointer ($A000).W = target X coordinate (set by collision_avoidance setup) ($A002).W = target Y coordinate (set by collision_avoidance setup)
- **Modifies**: D0, D1, D2, D3, D6
- **Calls**: ai_steering_calc ($A7A0), sine_lookup ($8F52), cosine_lookup ($8F4E) Fields accessed: A0+$06: Speed value (used as divisor) A0+$30: X position (updated) A0+$34: Y position (updated) A0+$3C: Heading mirror (written) A0+$40: Current heading angle (read/written) A0+$54: Steering mode flags (bit 0 selects D6=2)
*Source: [physics_integration.asm](disasm/modules/68k/game/physics/physics_integration.asm)*

---

### Speed Scale Simple ($00B02C–$00B03A, 14 bytes)

Loads a value from RAM ($FF907E), scales it via speed_scale_calc, and stores the result to $FF674C.

- **Modifies**: D0, D1
- **Calls**: speed_scale_calc (via BSR.S)
- **RAM**: ($907E).W: Input value (sign-extended: $FFFF907E) $FF674C: Output scaled value
*Source: [speed_scale_simple.asm](disasm/modules/68k/game/physics/speed_scale_simple.asm)*

---

### Speed Scale Conditional ($00B03C–$00B068, 44 bytes)

Conditionally scales two speed values based on flag bits: If bit 5 of ($C30E).W clear: scale ($907E).W → $FF6328 If bit 5 of ($B4EE).W clear: scale ($9F7E).W → $FF6558

- **Modifies**: D0, D1
- **Calls**: speed_scale_calc (via BSR.S)
- **RAM**: ($C30E).W: Flag byte 1 (bit 5 checked) ($B4EE).W: Flag byte 2 (bit 5 checked) ($907E).W: First input value ($9F7E).W: Second input value $FF6328: First output (scaled) $FF6558: Second output (scaled)
*Source: [speed_scale_conditional.asm](disasm/modules/68k/game/physics/speed_scale_conditional.asm)*

---

### Speed Scale Calculation ($00B06A–$00B092, 40 bytes)

Converts a raw distance/speed value to a scaled result: 1. Subtract base offset 6000 ($1770), clamp to 0 2. Clamp max to 11000 ($2AF8) 3. Compute D0 = D0/8 + D0/16 = 3*D0/16 4. Clamp max to 2048 ($0800) 5. Add base 2048 ($0800) Result range: $0800-$1000 (2048-4096)

- **Entry**: D0.W = raw value
- **Returns**: D0.W = scaled result ($0800-$1000)
- **Modifies**: D0, D1
*Source: [speed_scale_calc.asm](disasm/modules/68k/game/physics/speed_scale_calc.asm)*

---

### entity_heading_and_turn_rate_calculator ($00CEEE–$00CFD6, 232 bytes)

Entity Heading and Turn Rate Calculator Data prefix (3 × 10-byte parameter blocks). Main loop iterates over 15 entities, calling obj_heading_update ($007AB6) 9 times per entity. Computes heading difference via sine/cosine lookup tables at $0093AC2C/$0093A82C, calculates turn rate stored to +$3A and lateral force stored to +$3E. Copies display scale from +$6E to +$46. Second entry point loads track overlay data from $008955CC.

- **Entry**: A0 = entity table base
- **Modifies**: D0, D7, A0, A1, A2, A6
- **Object fields**: +$32 heading, +$3A turn rate, +$3E lateral force, +$46 display scale, +$6E source scale, +$C6 ref angle, +$C8 target angle
- **Confidence**: high
*Source: [entity_heading_and_turn_rate_calculator.asm](disasm/modules/68k/game/physics/entity_heading_and_turn_rate_calculator.asm)*

---

### Positive Velocity Step ($00DCAC–$00DCBE, 18 bytes)

Small Increment Source: code_c200 Adjusts D0 toward positive limit. If D0 <= $4000 (signed), adds $0010 (small step). If D0 > $4000, returns unchanged. An alternate entry at .add_large provides a $0040 (large step) variant for external callers. This is the positive counterpart to negative_velocity_step_small_dec (fn_c200_053).

- **Entry**: D0 = velocity/position value (word)
- **Returns**: D0 = adjusted value
- **Modifies**: D0
*Source: [positive_velocity_step_small_inc.asm](disasm/modules/68k/game/physics/positive_velocity_step_small_inc.asm)*

---

### Negative Velocity Step ($00DCBE–$00DCD0, 18 bytes)

Small Decrement Source: code_c200 Adjusts D0 toward negative limit. If D0 >= $C000 (-$4000 signed), subtracts $0010 (small step). If D0 < $C000, returns unchanged. An alternate entry at .sub_large provides a $0040 (large step) variant. This is the negative counterpart to positive_velocity_step_small_inc (fn_c200_052).

- **Entry**: D0 = velocity/position value (word)
- **Returns**: D0 = adjusted value
- **Modifies**: D0
*Source: [negative_velocity_step_small_dec.asm](disasm/modules/68k/game/physics/negative_velocity_step_small_dec.asm)*

---

## Game / Race

### Sound State Init + Clear Comm Variables ($002066–$00207E, 24 bytes)

Initializes sound driver configuration ($8506 = $03 tempo, $8504 = $30 volume/mode), then clears comm ready flag ($C822) and state variable ($C8A4) to zero.

- **Entry**: none | Exit: sound + comm initialized | Uses: D0
- **RAM**: $FFFF8506 = sound driver tempo (byte, set to $03) $FFFF8504 = sound driver volume/mode (byte, set to $30) $FFFFC822 = comm/input ready flag (byte, cleared) $FFFFC8A4 = state variable (long, cleared)
*Source: [sound_state_init_clear_comm_variables.asm](disasm/modules/68k/game/race/sound_state_init_clear_comm_variables.asm)*

---

### Sound Command Dispatch + Sound Driver Call ($002080–$0020D6, 86 bytes)

Processes pending sound commands from 3 RAM slots: Priority 1 ($C822): if nonzero, writes to Z80 command ($8509), clears $C822 and $C8A4, then calls sound driver. Priority 2 ($C8A5): if nonzero and different from $C8A7 (last sent), writes to Z80 ($850A) and updates $C8A7. Priority 3 ($C8A4): if nonzero, writes to Z80 ($850A) and updates $C8A6. Always calls sound driver at $008B0000 (preserves A5/A6).

- **Modifies**: D0, A5, A6
- **RAM**: $8509: Z80 sound command A (byte) $850A: Z80 sound command B (byte) $C822: high-priority sound command (byte) $C8A4: low-priority sound command (byte/long, cleared) $C8A5: SFX command (byte) $C8A6: last sent SFX B (byte) $C8A7: last sent SFX A (byte)
*Source: [sound_command_dispatch_sound_driver_call.asm](disasm/modules/68k/game/race/sound_command_dispatch_sound_driver_call.asm)*

---

### Audio Frequency Update (Dual Channel) ($00220C–$002294, 136 bytes)

Updates audio frequency for two channels (A and B). Each channel reads port data, checks source select bit, compares stored audio level, and recalculates frequency via weighted shift average. Channel A is processed first via BSR.S, then channel B falls through to the same shared subroutine.

- **Modifies**: D0, D1, A1, A2, A3
- **RAM**: $8517: ch_b_update_flag $8760: ch_a_frequency $8759: ch_a_stored_level $8790: ch_b_frequency $8789: ch_b_stored_level $9074: port_b_data $9F74: port_a_data $9FE5: port_a_control $90E5: port_b_control $C827: audio_level_raw $C828: audio_level $C8C8: vint_state
*Source: [audio_frequency_update.asm](disasm/modules/68k/game/race/audio_frequency_update.asm)*

---

### Audio Trigger + Frequency Calc ($00232A–$0023C2, 152 bytes)

Manages audio trigger state for channel B. Reads port B control bit 4 to detect trigger events, loads sound command from lookup table. Optionally copies audio level to channel B. Then calculates frequency via weighted shift average and copies result to channel A.

- **Modifies**: D0, D1, A1
- **RAM**: $8516: ch_b_update_flag $8760: ch_a_frequency (receives copy) $8789: ch_b_stored_level $8790: ch_b_frequency $9074: port_b_data $90E5: port_b_control $C805: sound_command_id $C80B: audio_mode_flags $C823: audio_trigger_flag $C828: audio_level $C8C8: vint_state (table index for sound lookup)
*Source: [audio_trigger_frequency_calc.asm](disasm/modules/68k/game/race/audio_trigger_frequency_calc.asm)*

---

### Randomized Sound Parameter (Base $1E00) ($0023C2–$0023DC, 26 bytes)

Loads base value $1E00 into D1. If current value at (A1) matches the base, calls random_number_gen, masks to 0-15, and subtracts from D1 to add jitter. Stores D1 to (A1) and copies to sound register $8760.

- **Entry**: A1 = parameter pointer | Exit: sound param updated | Uses: D0, D1
- **RAM**: $FFFF8760 = sound register (word, updated)
*Source: [randomized_sound_param_0023c2.asm](disasm/modules/68k/game/race/randomized_sound_param_0023c2.asm)*

---

### Randomized Sound Parameter (Base $21D0) ($00240C–$002426, 26 bytes)

Loads base value $21D0 into D1. If current value at (A1) matches the base, calls random_number_gen, masks to 0-15, and subtracts from D1 to add jitter. Stores D1 to (A1) and copies to sound register $8760.

- **Entry**: A1 = parameter pointer | Exit: sound param updated | Uses: D0, D1
- **RAM**: $FFFF8760 = sound register (word, updated)
*Source: [randomized_sound_param_00240c.asm](disasm/modules/68k/game/race/randomized_sound_param_00240c.asm)*

---

### Randomized Sound Parameter (Base $21A0) ($002452–$00246C, 26 bytes)

Loads base value $21A0 into D1. If current value at (A1) matches the base, calls random_number_gen, masks to 0-15, and subtracts from D1 to add jitter. Stores D1 to (A1) and copies to sound register $8760.

- **Entry**: A1 = parameter pointer | Exit: sound param updated | Uses: D0, D1
- **RAM**: $FFFF8760 = sound register (word, updated)
*Source: [randomized_sound_param_002452.asm](disasm/modules/68k/game/race/randomized_sound_param_002452.asm)*

---

### Object Timer Tick + SFX Lookup + Field Clear ($003204–$003250, 76 bytes)

Decrements countdown ($C308); when zero: compares $C08E with $C07A — if different, indexes SFX table at $008989EE by object field +$2C and writes to $C8A5. Reloads countdown from #4 to $C305. If $C04E nonzero: clears object via (A1) pointer from $C258, clears VDP flags at $FF6940/$FF6950, advances $C305 by 4.

- **Modifies**: D0, A0, A1
- **RAM**: $C04E: timer/counter (word) $C07A: bitmask table index (word) $C08E: current param (word, compared with $C07A) $C258: object pointer (long) $C305: sub-counter (byte, reload=4, +4 on clear) $C308: countdown timer (byte, decremented) $C8A5: sound effect (byte)
*Source: [object_timer_tick_sfx_lookup_field_clear.asm](disasm/modules/68k/game/race/object_timer_tick_sfx_lookup_field_clear.asm)*

---

### race_result_recording_003272 ($003272–$00337A, 264 bytes)

Race Result Recording Records race completion result for single-player. Steps: 1. Sets race status flag ($C3B8) to $02 2. Selects result slot from entity +$2C (car index x 16) 3. Reads lap timing data from RAM ($C876-$C878): steering byte, throttle byte (rebased from $C4), brake byte (rebased from $C4) 4. Looks up compressed time values via ROM tables ($00899884/$0089980C) 5. Appends to timing buffer, updates buffer pointer ($C07A) 6. Calls score calculation ($00B2E4) and ranking update ($00B422) 7. Compares with best time ($C298), updates if new record 8. Sets race complete flag ($FF6940) and computes result display code

- **Entry**: A0 = entity pointer (car)
- **Modifies**: D0, A0, A1, A2, A3
*Source: [race_result_recording_003272.asm](disasm/modules/68k/game/race/race_result_recording_003272.asm)*

---

### Lap Check Dispatcher (15-Entry Jump Table + Lap Advance) ($00337A–$0033E3, 105 bytes)

Dispatches via 15-entry longword jump table indexed by dispatch_idx ($C305). Jump table covers states $00-$38. States $08-$2C share handler at $33C2. Inline handler: compares camera_state ($C08E) with camera_target ($C07A). If equal: branches to set_state_0x34 (external function). Otherwise advances state by 4, checks lap count (A0+$2C) vs total_laps ($C310). If race complete: sets state=$30.

- **Modifies**: D0, D2, D4, A0, A1, A2, A4, A6
- **RAM**: $C07A: camera_target (word) $C08E: camera_state (word) $C305: dispatch_idx (byte) $C310: total_laps (byte) Object (A0): +$2C: current_lap (word)
*Source: [lap_check_disp.asm](disasm/modules/68k/game/race/lap_check_disp.asm)*

---

### race_result_recording_003404 ($003404–$0034D2, 206 bytes)

Race Result Recording (2-Player) Records race completion result for 2-player mode. Selects player's timing data source based on entity address (A0=$9000 → player 1 at $C876, else → player 2 at $C883). Same timing lookup/compression as race_result_recording_003272. After recording, compares with best time and updates leaderboard slot. Also handles replay counter advance if in demo mode ($C3B9 set).

- **Entry**: A0 = entity pointer (car), selects player by address
- **Modifies**: D0, A0, A1, A2, A3
*Source: [race_result_recording_003404.asm](disasm/modules/68k/game/race/race_result_recording_003404.asm)*

---

### Object Timer Tick + SFX Lookup (Variant B ($003540–$00359C, 92 bytes)

Extra Flag Check) Like object_timer_tick_sfx_lookup_field_clear but adds extra checks: Decrements countdown ($C308); when zero and $C08E != $C07A and $C30E bit 5 clear: indexes SFX table at $008989EE by object +$2C, writes to $C8A5. Special case: if $FF6948 == $222E0508 → SFX = $97. Reloads sub-counter $C305 = 4. If $C04E nonzero: clears VDP flags $FF6940/$FF6950, advances $C305.

- **Modifies**: D0, A0, A1
- **RAM**: $C04E: timer/counter (word) $C07A: bitmask table index (word) $C08E: current param (word) $C305: sub-counter (byte, reload=4) $C308: countdown timer (byte, decremented) $C30E: button/control flags (byte, bit 5) $C8A5: sound effect (byte)
*Source: [object_timer_tick_sfx_lookup.asm](disasm/modules/68k/game/race/object_timer_tick_sfx_lookup.asm)*

---

### race_result_with_leaderboard_update ($0035B4–$0036C8, 276 bytes)

Race Result with Leaderboard Update Extended race result recording with leaderboard/records comparison. Similar to race_result_recording_003272 but additionally: 1. Checks if this is the final car finishing (compares +$2C with count) 2. Reads lap timing, looks up compressed values, appends to buffer 3. Calls score calculation ($00B2E4) and score display ($00B40E) 4. Compares with personal best ($C298) — updates if new record 5. Computes track/car-specific leaderboard slot using: track_index x 32 + car_index x 8 + position (from RAM $C87C/$C880) 6. Compares with leaderboard entry, copies timing data if beaten 7. Sets race complete flag and result display code

- **Entry**: A0 = entity pointer (car)
- **Modifies**: D0, D1, D2, A0, A1, A2, A3
*Source: [race_result_with_leaderboard_update.asm](disasm/modules/68k/game/race/race_result_with_leaderboard_update.asm)*

---

### SFX Trigger + Object Enable Fields ($003D22–$003D5A, 56 bytes)

If D1 == 4 or D1 == $16: plays SFX $BA via $C8A4. Sets object fields at $FF6128: field $00 and $14 = 1. If $C04C == 0: also sets fields $28 and $3C = 1.

- **Entry**: D1 = event index
- **Modifies**: D0, D1, A1
- **RAM**: $C04C: 2-player flag (word) $C8A4: sound effect (byte) Object ($FF6128): +$00/$14/$28/$3C: enable flags (word, set to 1)
*Source: [sfx_trigger_object_enable_fields.asm](disasm/modules/68k/game/race/sfx_trigger_object_enable_fields.asm)*

---

### Race Completion Check + Lap Bit Tracking ($00417C–$0041E4, 104 bytes)

If scene_state ($C8AA) == $15 (race checkpoint): copies $C096 → $C07A, advances $C07C by 4, clears $FF6754. If $FDA9 nonzero (race active) AND $C30C == 1 AND $FDA8 bit 7 clear: uses $C89C as bit index, sets that bit in $EF07 (lap tracking A). If $FDA9 == 2: also sets bit in $FEB7 (lap tracking B). If $FEB7 reaches $1F: sets bits 6+7 (completion flags). If $EF07 reaches $1F: sets bit 0 of $FDA8 (race complete).

- **Modifies**: D0
- **RAM**: $C07A: bitmask table index (word, set from $C096) $C07C: input_state (word, +4) $C096: source parameter (word) $C30C: race phase (byte, checked == 1) $C89C: SH2 comm state / bit index (word) $C8AA: scene_state (word, checked == $15) $EF07: lap tracking A (byte, bit accumulator) $FDA8: race control (byte, bit 0 = complete, bit 7 = paused) $FDA9: race active flag (byte, 0/1/2) $FEB7: lap tracking B (byte, bit accumulator)
*Source: [race_completion_check_lap_bit_tracking.asm](disasm/modules/68k/game/race/race_completion_check_lap_bit_tracking.asm)*

---

### Sound Queue and Advance (SH2 Gate) ($0043BC–$0043D0, 20 bytes)

If SH2 processing flag (bit 7 of $C80E) is clear, queues sound $F3 and advances state machine.

- **Entry**: none
- **Modifies**: none
*Source: [sound_advance_check.asm](disasm/modules/68k/game/race/sound_advance_check.asm)*

---

### Call Sub + Address Check + Set Race Mode ($004538–$004556, 30 bytes)

Calls sub at $00B25E, advances input state ($C07C) by 4. If A0 is not $9000, falls through to next function. Otherwise sets race/mode state ($C8A5) to $AA and clears SH2 shared byte.

- **Entry**: A0 = address from sub | Exit: conditional return | Uses: A0
- **RAM**: $FFFFC07C = input state (word, advanced by 4) $FFFFC8A5 = race/mode state (byte, conditionally set to $AA) $00FF6930 = SH2 shared byte (cleared on match)
*Source: [call_sub_address_check_set_race_mode.asm](disasm/modules/68k/game/race/call_sub_address_check_set_race_mode.asm)*

---

### Sound Queue, Sprite Adjust, Advance ($004638–$00464A, 18 bytes)

Queues sound $F2, moves sprite up by 6 pixels, advances state.

- **Entry**: none
- **Modifies**: none
*Source: [sound_sprite_advance.asm](disasm/modules/68k/game/race/sound_sprite_advance.asm)*

---

### race_scene_init_004a32 ($004A32–$004C8A, 600 bytes)

Race Scene Initialization (1-Player) Initializes a 1-player race scene. Disables interrupts, configures MARS adapter control and VDP mode, loads track/car data, sets up rendering pipelines, object tables, and SH2 communication. Waits for SH2 handshake via COMM1 bit 0, then sets main loop entry at $004CBC.

- **Entry**: Called as scene init orchestrator
- **Modifies**: D0, D1, A0, A1, A2, A5 MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
- **RAM**: $C87E game_state, $C89C sh2_comm_state, $C8A0 race_state, $C8AA scene_state, $C8C8 vint_state, $C8CC race_substate
- **Confidence**: high
*Source: [race_scene_init_004a32.asm](disasm/modules/68k/game/race/race_scene_init_004a32.asm)*

---

### race_scene_init_004d98 ($004D98–$005020, 648 bytes)

Race Scene Initialization (2-Player) Initializes a 2-player split-screen race scene. Similar to 1-player init but sets COMM1_HI=$04 (2-player mode flag), sets bit 4 of race options, clears bit 7 of flags(-600), and copies 32x32-byte blocks between object tables for the second player viewport. Sets main loop entry at $005024.

- **Entry**: Called as scene init orchestrator
- **Modifies**: D0-D7, A0, A1, A2, A5 MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
- **RAM**: $9F00 obj_table_3, $C87E game_state, $C8A0 race_state, $C8AA scene_state, $C8C8 vint_state, $C8CC race_substate
- **Confidence**: high
*Source: [race_scene_init_004d98.asm](disasm/modules/68k/game/race/race_scene_init_004d98.asm)*

---

### race_scene_init_005100 ($005100–$005308, 520 bytes)

Race Scene Initialization (Grand Prix) Initializes a Grand Prix race scene. Sets bit 5 ($20) of race options for GP mode, uses track index from (-345), configures extended object tables, and additional subsystem initialization. Sets main loop entry at $005308.

- **Entry**: Called as scene init orchestrator
- **Modifies**: D0, D1, A0, A1, A2, A5 MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
- **RAM**: $C87E game_state, $C8A0 race_state, $C8AA scene_state, $C8C8 vint_state, $C8CC race_substate
- **Confidence**: high
*Source: [race_scene_init_005100.asm](disasm/modules/68k/game/race/race_scene_init_005100.asm)*

---

### race_scene_init_0053b0 ($0053B0–$005586, 470 bytes)

Race Scene Initialization (Free Run) Initializes a Free Run / Time Attack race scene. Allocates 7 object slots, clamps track index to <=5, sends sound command $9B, sets COMM mode $0105. Includes additional calls for timer and replay setup. Sets main loop entry at $005586.

- **Entry**: Called as scene init orchestrator
- **Modifies**: D0, D1, A0, A2, A5 MARS: adapter_ctrl, COMM0, COMM1, VDP_MODE, SYS_INTCTL
- **RAM**: $C87E game_state, $C8A0 race_state, $C8AA scene_state, $C8CC race_substate
- **Confidence**: high
*Source: [race_scene_init_0053b0.asm](disasm/modules/68k/game/race/race_scene_init_0053b0.asm)*

---

### Process SFX + Poll Controllers + Advance Frame ($0055FE–$005618, 26 bytes)

Calls SFX queue process ($0021CA), poll controllers ($00179E), and sub at $00BAD4. Increments frame counter ($C886) and sets SH2 display mode/frame delay to $0054.

- **Entry**: none | Exit: controllers polled, frame advanced | Uses: none
- **RAM**: $FFFFC886 = frame counter (byte, incremented by 1) $00FF0008 = SH2 display mode/frame delay (word, set to $0054)
*Source: [process_sfx_poll_ctrls_advance_frame.asm](disasm/modules/68k/game/race/process_sfx_poll_ctrls_advance_frame.asm)*

---

### Sound Queue + Enable Flags + Advance State ($005822–$00584A, 40 bytes)

Calls the sound queue sub at $002474, enables SH2 flag ($C809), display mode flag ($C80A), sets sync bit 7 ($C80E), enables command flag ($C802), sets comm signal ($C822) to $F3, and advances the sub-sequence timer ($C8C5) by 4.

- **Entry**: none | Exit: flags set, state advanced | Uses: none
- **RAM**: $FFFFC809 = SH2 enable flag (byte, set to $01) $FFFFC80A = display mode flag (byte, set to $01) $FFFFC80E = sync/transition flags (byte, bit 7 set) $FFFFC802 = command flag (byte, set to $01) $FFFFC822 = comm signal (byte, set to $F3) $FFFFC8C5 = sub-sequence timer (byte, advanced by 4)
*Source: [sound_queue_enable_flags_advance_state.asm](disasm/modules/68k/game/race/sound_queue_enable_flags_advance_state.asm)*

---

### race_entity_update_loop ($00593C–$005AB6, 378 bytes)

Race Entity Update Loop Per-frame update for race entities. Selects from two 8-entry jump tables (normal vs special mode, selected by bit 3 of race options). Executes movement calculation, speed, collision avoidance, heading update, and lateral/longitudinal force computation using sine lookup tables.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D1, D7, A0, A1, A2, A4, A6
- **RAM**: $9F00 obj_table_3, $C89C sh2_comm_state
- **Object fields**: +$02 flags, +$04 speed, +$18 position, +$24/+$26 heading, +$2C lap counter, +$32 angle, +$3A/+$3E lateral/longitudinal force, +$46 tilt, +$54 collision flags, +$6A lock, +$C6/+$C8 angles
- **Confidence**: high
*Source: [race_entity_update_loop.asm](disasm/modules/68k/game/race/race_entity_update_loop.asm)*

---

### Race Init Orchestrator 005 ($00671A–$00677A, 96 bytes)

Initializes race frame — calls 12 subroutines sequentially Sets up camera, loads params, runs steering/position/velocity calcs On frame 20 ($14): copies camera state, clears init flag, advances state

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A0
- **Calls**: $00B770: camera_state_selector (camera init) $0080CC: load_object_params $008548: suspension_steering_damping+offset $009802: suspension_steering_damping (state dispatch) $007E7A: obj_velocity_y $006F98: calc_steering $007CD8: obj_position_x $0070AA: angle_to_sine $00714A: conditional_pos_add $00764E: track_data_index_calc_table_lookup $008032: race_position_check $009B54: fn_8200_065 Object fields (A0): +$44: display_offset +$46: display_scale +$4A: param_4a
- **RAM**: $C800: race_init_flag $C89A: scene_state $C8AA: frame_counter $C8AC: state_dispatch_idx $C092: camera_state $C07A: camera_target
- **Confidence**: high
*Source: [race_init_orch_005.asm](disasm/modules/68k/game/race/race_init_orch_005.asm)*

---

### Race Frame Update (State 7) ($006A3A–$006AB4, 122 bytes)

Race-mode frame update: calls camera selector, sets game_active, clears display offsets, then executes 12 subroutine calls for physics/steering/position updates. Dispatches to state handler via external jump table at $006AB4. On frame 20: copies camera state, clears game_active, and advances dispatch state.

- **Entry**: A0 = object pointer (+$44, +$46, +$4A cleared)
- **Modifies**: D0, A0, A1
- **Calls**: $006F98: calc_steering (JSR PC-relative) $0070AA: angle_to_sine (JSR PC-relative) $007CD8: obj_position_x (JSR PC-relative) $007E7A: obj_velocity_y (JSR PC-relative) $007F50: obj_velocity_x (JSR PC-relative) $0080CC: load_object_params (JSR PC-relative) $00B770: camera_state_selector (JSR PC-relative) Jump table: external at $006AB4 (5 entries, in next module)
- **RAM**: $C048: camera_position (set to 1 on dispatch) $C07A: camera_state_copy (receives value from $C092) $C092: camera_state $C800: game_active $C89C: race_substate $C8A0: race_state (jump table index at $006AB4) $C8AA: scene_state (frame counter) $C8AC: state_dispatch_idx
*Source: [race_frame_update.asm](disasm/modules/68k/game/race/race_frame_update.asm)*

---

### race_frame_main_dispatch_entity_updates ($006D9C–$006F98, 508 bytes)

Race Frame Main Dispatch + Entity Updates Main race frame dispatch. First updates state index, then calls table_lookup for 6-8 entities in obj_table_3/obj_table_2. Main section dispatches through 10-entry jump table indexed by state, running full render pipeline (30+ subs) with countdown timer variant. Ends with tile block copy setup (2 entries via FastCopy16).

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D1, D6, D7, A0, A1, A2, A3
- **RAM**: $9100 obj_table_1, $9700 obj_table_2, $9F00 obj_table_3
- **Object fields**: +$06 speed, +$18 position, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$74 render_state, +$B2 stored_pos, +$E5 flags
- **Confidence**: high
*Source: [race_frame_main_dispatch_entity_updates.asm](disasm/modules/68k/game/race/race_frame_main_dispatch_entity_updates.asm)*

---

### Race State Read + Sound Trigger ($007D82–$007E0C, 138 bytes)

Checks race_substate, handles camera state transitions, reads object position data, applies speed multiplier via shift lookup table, loads velocity parameters, copies camera state, then calls race state read and triggers sound $B0.

- **Entry**: A0 = object pointer (+$14, +$24, +$8A, +$8C, +$E5)
- **Modifies**: D0, D1, D6, A0, A1
- **Calls**: $007EB8: speed_calc (JSR PC-relative) $00A1FC: race_state_read (JSR PC-relative)
- **RAM**: $C004: camera_transition_flag $C048: camera_position $C04C: camera_state_timer $C09A: camera_copy_src $C07A: camera_copy_dest $C312: terrain_type $C708: speed_shift_table_ptr $C826: sound_enable $C89C: race_substate $C8A4: sound_command
*Source: [race_state_read_sound_trigger.asm](disasm/modules/68k/game/race/race_state_read_sound_trigger.asm)*

---

### Lap Complete Check 062 ($007F64–$007FDA, 118 bytes)

Processes lap completion and race finish conditions Increments checkpoint counter, checks lap vs total_laps On race finish: sets flags, timer, and phase Also checks if current position exceeds total racers

- **Entry**: D0 = speed/proximity value; A0 = object/entity pointer
- **Modifies**: D0, D1, A0
- **RAM**: $C305: race_phase $C310: total_racers $C30E: race_flags $C80E: race_ctrl $C04E: timer_countdown $C8AA: scene_state Object fields (A0): +$02: flags +$08: sprite_id +$1C: position +$28: checkpoint_count +$2C: lap_count +$2D: racer_index +$2E: checkpoint_total +$AC: race_score
- **Confidence**: high
*Source: [lap_complete_check_062.asm](disasm/modules/68k/game/race/lap_complete_check_062.asm)*

---

### Object Scoring + Lap Advance Check ($008054–$0080AE, 90 bytes)

Mid-function entry: if D0 >= $FF9C (-100) → returns to caller. Increments position counter (A0+$2E), sets sprite=$0497. If position matches lap target (A0+$2C): advances dispatch_idx ($C305) to 4, increments lap, sets score flag (bit 14), starts timer ($C04E), clears scene_state ($C8AA). If lap count exceeds total_laps ($C310): clears score flag, zeroes timer, sets race_flags ($C30E) bit 5.

- **Modifies**: D0, D1, A0
- **RAM**: $C04E: timer (word, set to $0050) $C305: dispatch_idx (byte, set to 4) $C30E: race_flags (byte, bit 5 = scoring complete) $C310: total_laps (byte) $C8AA: scene_state (word, cleared) Object (A0): +$02: flags (word, bit 14 = score flag) +$08: sprite_index (word) +$28: work field (word, cleared) +$2C: current_lap (word) +$2D: lap_limit (byte) +$2E: position_counter (word)
*Source: [object_scoring_lap_advance_check.asm](disasm/modules/68k/game/race/object_scoring_lap_advance_check.asm)*

---

### Table Lookup ($008246–$008256, 16 bytes)

Object Field to Race State Byte Uses the word at object+$2C as an index into a lookup table immediately following this function ($008256+), and stores the resulting byte into $C8A5.

- **Entry**: A0 = object pointer | Exit: table value stored
- **Modifies**: D0, A0, A1
- **RAM**: $FFFFC8A5 = race/mode state byte (byte, written from table)
*Source: [table_lookup_object_field_to_race_state_byte.asm](disasm/modules/68k/game/race/table_lookup_object_field_to_race_state_byte.asm)*

---

### race_pos_comparison_with_sound_triggers ($0087E2–$0088BE, 220 bytes)

Race Position Comparison with Sound Triggers Compares race positions of two entities (A0, A2) using segment/position indices. When tied, uses trig-based distance calculation with sine/cosine lookups to break the tie. Updates rank fields +$2A and triggers sound effects ($CC/$CF/$B3) on position changes.

- **Entry**: A0 = player 1 entity, A2 = player 2/AI entity
- **Modifies**: D0, D1, D2, D3, D4, A0, A2
- **Calls**: $008F4E (cosine_lookup), $008F52 (sine_lookup)
- **Object fields**: +$04 speed, +$1E heading, +$24 segment, +$2A rank, +$2E lap segment, +$30 x_pos, +$34 y_pos, +$E5 AI flags
- **Confidence**: high
*Source: [race_pos_comparison_with_sound_triggers.asm](disasm/modules/68k/game/race/race_pos_comparison_with_sound_triggers.asm)*

---

### race_pos_sorting_and_rank_assignment ($009C9C–$009DD6, 314 bytes)

Race Position Sorting and Rank Assignment Data tables (50 bytes) at start, then race position sorting logic. Builds sorted entity lists by segment position and lap distance across all 16 race entities. Assigns rank (+$2A) to each entity. Detects position changes and triggers appropriate sound effects based on race mode ($CC series). Saves/restores A0 via stack.

- **Entry**: A0 = player entity pointer
- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7, A0-A3
- **Object fields**: +$04 speed, +$24 segment, +$2A rank, +$2B prev rank, +$2C lap, +$2E lap segment, +$A4 sort key A, +$A6 sort key B, +$C2 sound trigger, +$E5 AI flags
- **Confidence**: high
*Source: [race_pos_sorting_and_rank_assignment.asm](disasm/modules/68k/game/race/race_pos_sorting_and_rank_assignment.asm)*

---

### race_start_countdown_sequence ($009EC0–$00A050, 400 bytes)

Race Start Countdown Sequence Multi-phase race start countdown dispatcher. Jump table at $009ECA selects phase: initial delay, "3-2-1" countdown with sound triggers ($C0-$C3), green light, and random tire screech. Manages SH2 communication flags, display list entries, and race state transitions. PRNG at end generates random crowd noise timing.

- **Modifies**: D0, D6, D7, A0, A1
- **Confidence**: high
*Source: [race_start_countdown_sequence.asm](disasm/modules/68k/game/race/race_start_countdown_sequence.asm)*

---

### Race Parameter Block Load + Table Pointer Setup ($00A050–$00A0B4, 100 bytes)

Loads 15 parameter words + 1 longword from data table at $00898824 into RAM block $C278..$C0FA. Sets work pointer $C27C = $0093925E. Computes per-race table pointer: D1 = $C8A0 (race_state) × 2, D0 = $C8C8 × $30 (48-byte stride), $C280 = address of $00A0B4 + D1 + D0.

- **Modifies**: D0, D1, A1
- **RAM**: $C0E6-$C0FA: parameter block (14 words: $C0E6..$C0FA) $C278: work param (long, from table) $C27C: work pointer (long, set to $0093925E) $C280: per-race table pointer (long) $C8A0: race_state (word) $C8C8: boost flag (word, used as multiplier) $C8CE-$C8D2: work params (3 words, from table)
*Source: [race_param_block_load_table_pointer_setup.asm](disasm/modules/68k/game/race/race_param_block_load_table_pointer_setup.asm)*

---

### Race Mode Flag Set ($00ACC0–$00ACD2, 18 bytes)

Sets flag at $FF6970 based on bit 2 of ($C8AB).W: If bit 2 set: flag = 0 If bit 2 clear: flag = 1

- **Modifies**: D0
- **RAM**: ($C8AB).W: Mode control bits $FF6970: Race mode flag (output)
*Source: [race_mode_flag_set.asm](disasm/modules/68k/game/race/race_mode_flag_set.asm)*

---

### Lap Display Update + VDP Tile Write ($00B5AE–$00B604, 86 bytes)

Two entry points: Entry 1 ($00B5AE): Sets A1 → $FF689A, reads $902C (lap count), adds 1, doubles (×2), indexes table at $00899884 for display value, tail-jumps to $00B54C (write routine). Entry 2 ($00B5CA): Reads $902C, clamps to max 4, shifts left 4 (×16). If $C305 nonzero: subtracts $10, computes VDP tile address at $FF68D0 + offset. Writes $0201 (or $0200 if != current tile at $C960). Clears $C305.

- **Modifies**: D0, A0, A1
- **RAM**: $902C: lap count / race position (word) $C305: sub-counter (byte, cleared) $C960: current tile pointer (long, compared with A1)
*Source: [lap_disp_update_vdp_tile_write.asm](disasm/modules/68k/game/race/lap_disp_update_vdp_tile_write.asm)*

---

### Lap Value Store 1 ($00B632–$00B644, 18 bytes)

If flag ($C30F).W is set, loads value from ($907A).W, adds 1, and stores the low byte to $FF692B.

- **Modifies**: D0
- **RAM**: ($C30F).W: Enable flag (must be non-zero) ($907A).W: Input lap value $FF692B: Output (byte)
*Source: [lap_value_store_1.asm](disasm/modules/68k/game/race/lap_value_store_1.asm)*

---

### Lap Value Store 2 ($00B646–$00B658, 18 bytes)

If flag ($FEB0).W is set, loads value from ($9F7A).W, adds 1, and stores the low byte to $FF691B.

- **Modifies**: D0
- **RAM**: ($FEB0).W: Enable flag (must be non-zero) ($9F7A).W: Input lap value $FF691B: Output (byte)
*Source: [lap_value_store_2.asm](disasm/modules/68k/game/race/lap_value_store_2.asm)*

---

### SFX Dispatch + Object Update + Animation Sequence ($00B65A–$00B6D0, 118 bytes)

Three parts: 1) SFX dispatch ($B65A): sets $C802=1, calls dispatch_sfx ($B670) 3× with A2=$8480 work buffer. Each call: computes A1 from ROM table $8BA000 + (D0 & $FF) × 32, tail-jumps to $00491A. 2) object_update ($B684): if $C80E bit 6 set, decrements rate counter ($C80A). On tick: reads anim_idx ($C825), looks up byte from 10-entry sequence table, writes to VDP $FF60D5. Advances index; after 10 entries, clears bit 6 and resets index. Data: 10-byte descending sequence ($FF..$F8,$F8,$80) at $B6D0.

- **Modifies**: D0, D1, A1, A2
- **RAM**: $C802: sfx_enable (byte) $C809: anim_rate_init (byte) $C80A: anim_rate_counter (byte) $C80E: display_flags (byte, bit 6) $C825: anim_idx (byte, 0-9) $C96C: object_base_ptr (longword)
*Source: [sfx_dispatch_object_update_anim_seq.asm](disasm/modules/68k/game/race/sfx_dispatch_object_update_anim_seq.asm)*

---

### Countdown Timer Setup ($00C5AE–$00C618, 106 bytes)

Race Start Initialization Source: code_c200 Manages the race-start countdown trigger based on the timeline frame counter ($C080). When the timeline reaches exactly frame 995 ($03E3), this function initializes the countdown sequence: sets the active flag, configures camera parameters, copies stored viewport settings, and prepares animation state. For frames before 995, it skips directly to the RTS in the countdown update module (countdown_timer_update_anim_race_start). For frames after 995, it falls through to countdown_timer_update_anim_race_start which handles the ongoing countdown animation and camera zoom. TIMELINE FLOW Frame < 995:  Early return (BLT → countdown_done) Frame = 995:  Initialize countdown (this function), then return Frame > 995:  Fall through to countdown_timer_update_anim_race_start (countdown update) Frame 1296:   Race starts (handled by countdown_timer_update_anim_race_start) MEMORY VARIABLES $FFFFC080  Timeline frame counter (word, incremented each frame) $FFFFC081  (low byte of above, used for countdown display) $FFFFC0AE  Active camera X position (word) $FFFFC0B0  Camera zoom level (word, animated 0→$1000) $FFFFC0B2  Camera rotation (word, cleared at countdown start) $FFFFC0BA  Countdown frame counter (word, cleared at start) $FFFFC0C6  Countdown animation timer (word, animated 0→$30) $FFFFC0C8  Camera distance setting (word, set to $00C0) $FFFFC0FC  Control mode (word, set to 8 = countdown mode) $FFFFC054  Viewport width (word, copied from stored value) $FFFFC056  Viewport height (word, copied from stored value) $FFFFC313  State flags (bit 1 = countdown active, bit 3 = cleared) $FFFFC81C  Countdown trigger flag (bit 0 = countdown started) $FFFFC896  Countdown phase byte (cleared to 0) $FFFFC8DA  Stored camera X position (word, template) $FFFFC8DC  Stored viewport width (word, template) $FFFFC8DE  Stored viewport height (word, template) $00FF60CC  Display control flag (word, set to $0100)

- **Entry**: No register inputs (reads timeline from RAM)
- **Returns**: Countdown initialized if frame == 995; otherwise no-op or falls through
- **Modifies**: D0
*Source: [countdown_timer_setup_race_start_init.asm](disasm/modules/68k/game/race/countdown_timer_setup_race_start_init.asm)*

---

### Countdown Timer Update ($00C618–$00C662, 74 bytes)

Animation and Race Start Trigger Source: code_c200 Called each frame after the countdown begins (timeline > 995). Handles two concurrent animations and the final race-start trigger: 1. Animation timer ($C0C6): Incremented by 2 each frame, clamped to 48. Controls the visual countdown overlay animation speed. 2. Camera zoom ($C0B0): Incremented by $80 each frame, clamped to $1000. Produces a smooth zoom-in effect during the countdown sequence. 3. Race start: At frame 1241 ($04D9), calls a subroutine at $00882066. At frame 1296 ($0510), sets the transition trigger ($C8F4 = 4) to begin the actual race, unless already triggered. This module is tightly coupled with fn_c200_034 (countdown setup), which branches here for frames > 995 and uses `countdown_done` for early return. TIMELINE Frame  995: Countdown initialized (fn_c200_034) Frame 996-1295: Animation updates (this function) Frame 1241: Pre-race subroutine called Frame 1296: Race start triggered ($C8F4 = 4) MEMORY VARIABLES $FFFFC080  Timeline frame counter (word, read only) $FFFFC0B0  Camera zoom level (word, animated $0080 per frame, max $1000) $FFFFC0C6  Countdown animation timer (word, animated +2/frame, max $30) $FFFFC8F4  State transition trigger (byte: 0=idle, 4=race start)

- **Entry**: No register inputs
- **Returns**: Animation state updated; race started if frame >= 1296
- **Modifies**: D0 (preserved by subroutine call convention — caller saves)
*Source: [countdown_timer_update_anim_race_start.asm](disasm/modules/68k/game/race/countdown_timer_update_anim_race_start.asm)*

---

### Scene State Dispatcher ($00C662–$00C680, 30 bytes)

Race Initialization Phases Source: code_c200 Dispatches to the appropriate race initialization handler based on the scene state byte ($C8F4). Uses a PC-relative indexed jump table with 68K CPU addresses (ROM base $880000 + file offset). STATE MACHINE State  0 ($C8F4=0):  Idle — returns immediately (no-op) State  4 ($C8F4=4):  race_init_phase_1_flag_setup — race init phase 1 (flag setup) State  8 ($C8F4=8):  race_init_phase_2_vdp_scroll_mode_config — race init phase 2 (VDP config) State 12 ($C8F4=12): race_scene_data_loader — race init phase 3 (scene setup) Each handler advances $C8F4 by 4, progressing through the state machine until the race scene is fully initialized. MEMORY VARIABLES $FFFFC8F4  Scene state byte (0/4/8/12, selects handler)

- **Entry**: No register inputs (A5 may be VDP control port for state 8)
- **Returns**: Dispatched to appropriate handler
- **Modifies**: D0, A1
*Source: [scene_state_disp_race_init_phases.asm](disasm/modules/68k/game/race/scene_state_disp_race_init_phases.asm)*

---

### Race Init Phase 1 ($00C680–$00C6A4, 36 bytes)

Flag Setup Source: code_c200 First phase of race initialization, called when scene state ($C8F4) = 4. Enables several control flags, sets a display configuration value, and advances the scene state to 8 for the next phase. Called from the scene state dispatcher (scene_state_disp_race_init_phases / fn_c200_035). MEMORY VARIABLES $FFFFC802  Control flag C (byte, set to 1) $FFFFC809  Control flag A (byte, set to 1) $FFFFC80A  Control flag B (byte, set to 1) $FFFFC80E  Display control flags (bit 7 set) $FFFFC822  Configuration value (byte, set to $F3) $FFFFC8F4  Scene state (word, advanced from 4 to 8)

- **Entry**: No register inputs
- **Returns**: Flags configured, scene state advanced to 8
- **Modifies**: (none modified beyond RAM writes)
*Source: [race_init_phase_1_flag_setup.asm](disasm/modules/68k/game/race/race_init_phase_1_flag_setup.asm)*

---

### Race Init Phase 2 ($00C6A4–$00C6B6, 18 bytes)

VDP Scroll Mode Configuration Source: code_c200 Second phase of race initialization, called when scene state ($C8F4) = 8. Checks if display bit 7 has been set (by phase 1). If not yet set, writes VDP register 11 command ($8B00) to configure horizontal scroll mode to full-screen scrolling, then advances the scene state to 12. VDP register $0B ($8B00): Bits 1-0 = 00: Full screen horizontal scroll Bit 2 = 0: Full screen vertical scroll Bit 3 = 0: External interrupt disabled Called from the scene state dispatcher (scene_state_disp_race_init_phases / fn_c200_035). Assumes A5 points to VDP control port ($C00004). MEMORY VARIABLES $FFFFC80E  Display control flags (bit 7 tested) $FFFFC8F4  Scene state (word, advanced from 8 to 12)

- **Entry**: A5 = VDP control port
- **Returns**: VDP register 11 configured, scene state advanced to 12
- **Modifies**: (none modified beyond VDP write and RAM)
*Source: [race_init_phase_2_vdp_scroll_mode_config.asm](disasm/modules/68k/game/race/race_init_phase_2_vdp_scroll_mode_config.asm)*

---

### race_scene_data_loader ($00C6B6–$00C7C2, 268 bytes)

Race Scene Data Loader Race initialization orchestrator. Loads terrain, entity, and track data via 4 subroutine calls ($0048EA, $0048D2). Configures SH2 communication ($00FF0002/$00FF0008), sets camera viewport ($00C0/$0540), race parameters (speed limits, distances), and populates entity sort keys (+$0A, +$B6) from ROM table. Initializes timing table pointer at $0088C7E0.

- **Modifies**: D0-D7, A0-A6 (saves/restores via MOVEM)
- **Confidence**: high
*Source: [race_scene_data_loader.asm](disasm/modules/68k/game/race/race_scene_data_loader.asm)*

---

### race_track_overlay_config ($00CA9A–$00CC06, 364 bytes)

Race Track Overlay Configuration Configures race track overlays and HUD elements. Loads track-specific overlay data from ROM tables $00898C68/$00898C74 indexed by race mode. Two entry points: first loads basic overlay + mode-specific HUD width, second loads extended overlay with dual-screen support. Inline data tables contain display object descriptors. Final section configures $FF672C display list entry from $00895668 track pointer table.

- **Modifies**: D0, D1, D4, D5, D7, A1, A2, A3
- **Confidence**: high
*Source: [race_track_overlay_config.asm](disasm/modules/68k/game/race/race_track_overlay_config.asm)*

---

### Race Scene Init + 6-Entry Jump Table Dispatch ($00D04C–$00D08A, 62 bytes)

Data prefix: 4 words ($5041,$4100,$504B,$4600) — ASCII-like scene identifiers ("PA","A\0","PK","F\0"). Calls $00D00C (scene pre-init), loads race_state ($C8A0) and copies 4-byte data from table at $00898C0C indexed by race_state to VDP at $FF6868. Dispatches via 6-entry longword jump table (all 6 entries point to $00D088 = shared RTS).

- **Modifies**: D0, D1, A0, A1, A3
- **Calls**: $00D00C: scene pre-init
- **RAM**: $C8A0: race_state (word, dispatch index)
*Source: [race_scene_init_jump_table_dispatch.asm](disasm/modules/68k/game/race/race_scene_init_jump_table_dispatch.asm)*

---

### race_sprite_table_init ($00D08A–$00D19C, 274 bytes)

Race Sprite Table Initialization Initializes race sprite table. Sets sound parameters ($C4 default), display mode ($C200). Loads display data from ROM timing table, copies palette entries via word_to_nibble_unpacker (nibble unpacker) in a 5- iteration loop. Searches palette table for match, configures sprite table via $006C46, and sets race viewport parameters.

- **Modifies**: D0, D1, D7, A1, A2, A3
- **Calls**: $006C46 (sprite_table_init), $00B43C (word_to_nibble_unpacker)
- **Confidence**: high
*Source: [race_sprite_table_init.asm](disasm/modules/68k/game/race/race_sprite_table_init.asm)*

---

## Game / Render

### vdp_reg_table_load ($000512–$0005CE, 188 bytes)

VDP Register Table Load Data prefix ($000512-$0005A5) contains the game's internal identification strings: "MAIN Course...", "Security Program...", "Copyright SEGA ENTERPRISES 1994" — ASCII text embedded in ROM. Code section ($0005A6-$0005CD) loads all 19 VDP registers ($80xx-$92xx) from a table pointed to by A0. Reads VDP status first, then writes each register value as $80xx + table byte to VDP control port.

- **Entry**: A0 = VDP register value table (19 bytes)
- **Modifies**: D0, D1, D7, A0, A1
*Source: [vdp_reg_table_load.asm](disasm/modules/68k/game/render/vdp_reg_table_load.asm)*

---

### vdp_vram_clear_via_dma ($0005CE–$00063E, 112 bytes)

VDP VRAM Clear via DMA Clears VDP VRAM using DMA fill operations. Loads DMA parameters from table at $0000063E, then: 1. Write 7 VDP register commands + DMA trigger from table 2. Wait for DMA completion (poll VDP status bit 1) 3. Write 2 more register commands from table 4. Fill CRAM ($C0000000) with zeros — 16 iterations × 4 words = 64 colors 5. Fill sprite table ($40000010) with zeros — 10 iterations × 4 words

- **Entry**: D1 = initial DMA fill value
- **Modifies**: D0, D1, D7, A0, A1
*Source: [vdp_vram_clear_via_dma.asm](disasm/modules/68k/game/render/vdp_vram_clear_via_dma.asm)*

---

### framebuffer_auto_fill_clear ($00063E–$000694, 86 bytes)

Framebuffer Auto-Fill Clear Data prefix ($00063E-$000653): VDP register values for DMA fill setup ($8114, $8F01, $93FF, $94FF, $9500, $9600, $9780, $4000, $0080, $8104, $8F02). Code entry at $000654: Clears 32X framebuffer using auto-fill registers. Waits for framebuffer access (BCLR #7 on adapter control), sets auto-fill length to 255, then iterates 256 times filling with zero via auto-increment ($0100 per iteration).

- **Entry**: Called from system_boot_init at $000654 (NOT at framebuffer_auto_fill_clear label)
- **Modifies**: D0, D1, D7, A1 Hardware: MARS_VDP_MODE ($A15180): Auto-fill length (+$04), address (+$06), data (+$08)
*Source: [framebuffer_auto_fill_clear.asm](disasm/modules/68k/game/render/framebuffer_auto_fill_clear.asm)*

---

### gfx_32x_cram_fill ($000694–$0006BC, 40 bytes)

32X CRAM Fill Fills all 256 entries (512 bytes) of 32X CRAM with the color value in D0. Waits for framebuffer access via adapter control register (BCLR #7 at MARS_CRAM-$0100), then writes 32 iterations x 16 bytes = 512 bytes.

- **Entry**: D0 = 32-bit color value to fill (typically 0 for black/clear)
- **Modifies**: D0, D7, A0 Hardware: MARS_CRAM ($A15200): 32X color RAM (256 x 16-bit entries)
*Source: [gfx_32x_cram_fill.asm](disasm/modules/68k/game/render/gfx_32x_cram_fill.asm)*

---

### vdp_display_init ($000DD2–$000FEA, 536 bytes)

VDP Display Initialization VDP display initialization and main dispatch loop setup: 1. Requests Z80 bus, configures display mode ($8C00) and scroll ($9010) 2. DMA fill sprite attribute table: 128 entries at VRAM $0000 (regs $9380/$9403/$9500/$9688/$977F, cmd $4000/$0083) 3. DMA fill scroll/nametable: 64x14 entries at VRAM $C000 (regs $9340/$9400/$9540/$96C2/$977F, cmd $C000/$0080) 4. Configures rendering flags and palette transfer 5. Polls completion via subroutine loop 6. Resets Z80 with halt program, silences PSG (4 channels) 7. Calls z80_bus_vdp_init for final VDP/sound setup 8. Fills CRAM with initial palette (64 entries of color $0E) 9. Copies one of two dispatch loop variants to RAM ($FF0000): - $000F92: Normal dispatch (game_tick + frame wait loop) - $000FAA: Alternate dispatch (alternate_tick + flag sync)

- **Modifies**: D0, D1, D4, D6, D7, A0, A1, A5
- **Calls**: $000FEA: z80_bus_vdp_init
- **RAM**: $C87A: vint_dispatch_state
*Source: [vdp_display_init.asm](disasm/modules/68k/game/render/vdp_display_init.asm)*

---

### VDP Register Initialization ($000FEA–$001034, 74 bytes)

Disables interrupts, requests Z80 bus, calls io_port_init ($0018D8), releases Z80 bus, restores SR. Then loads a 19-byte register table and programs all VDP registers ($00-$12). Also initializes VDP register caches at $C874/$C875.

- **Entry**: A5 = VDP control port | Exit: VDP initialized
- **Modifies**: D0, D7, A0, A5
- **RAM**: $FFFFC874 = VDP register cache 1 (byte, set to $81 = mode reg 1) $FFFFC875 = VDP register cache 2 (byte, loaded from table[1])
*Source: [vdp_reg_init.asm](disasm/modules/68k/game/render/vdp_reg_init.asm)*

---

### VDP DMA Transfer + VRAM Clear (10-Word Data Prefix) ($001034–$0010C4, 144 bytes)

Data prefix: 10 words — VDP DMA config or padding. Code: Disables interrupts, requests Z80 bus, sets VDP regs ($C81C with bit 4 set, DMA regs $8F01/$93FF/$94FF/$9780), writes zero to VRAM $0000 via DMA, polls DMA complete, restores VDP reg $8F02 and $C81C, releases Z80 bus, restores SR. Calls handler at $10AC, sets VDP CRAM $40000010, tail-jumps to $48A8. Includes handlers for VSRAM clear ($10AC) and nametable clear ($10B8).

- **Modifies**: D0, D1, D3, D4, D7, A5, A6
- **Calls**: $0048A8: cram_handler $004888: vsram_handler
- **RAM**: $C874: vdp_reg (word, read and modified)
*Source: [vdp_dma_xfer_vram_clear.asm](disasm/modules/68k/game/render/vdp_dma_xfer_vram_clear.asm)*

---

### nametable_copy_disp ($00154E–$001586, 56 bytes)

Nametable Copy Dispatcher Data prefix ($00154E-$00155D): 16 bytes of initialization data (decoded as ORI.B #$00,D0 no-ops by disassembler). Code entry at $00155E: Dispatches up to 4 nametable copy operations packed in D1 (one byte per job). Iterates 4 times (D2=3), extracting each byte via ROR.L #8. For each non-zero byte: multiplies by 10 ($000A) as index into parameter table at $001586, loads source address, dest address, and row count, then calls nametable copy at $001236.

- **Entry**: D1 = 4 packed job IDs (one per byte)
- **Modifies**: D0, D1, D2, D3, A0, A1
- **Calls**: $001236: nametable_decompressor (JSR PC-relative)
*Source: [nametable_copy_disp.asm](disasm/modules/68k/game/render/nametable_copy_disp.asm)*

---

### vdp_row_copy_disp ($001610–$00166C, 92 bytes)

VDP Row Copy Dispatcher Data prefix ($001610-$001637): VDP row copy parameter table. Each 12-byte entry contains: source ROM address (long), dest VRAM address (long), column count (word), row count (word). Code entry at $001638: Dispatches up to 4 VDP row copy operations packed in D0 (one byte per job). Iterates 4 times (D2=3), extracting each byte via ROR.L #8. For each non-zero byte: multiplies by 12 ($000C) as index into parameter table at $00166C, loads parameters, then calls vdp_copy_rows at $0010C4.

- **Entry**: D0 = 4 packed job IDs (one per byte)
- **Modifies**: D0, D1, D2, A0
- **Calls**: $0010C4: vdp_copy_rows (JSR PC-relative)
*Source: [vdp_row_copy_disp.asm](disasm/modules/68k/game/render/vdp_row_copy_disp.asm)*

---

### VDP DMA Transfer Setup (Scroll Data) ($0019EA–$001A64, 122 bytes)

Data prefix: 10-word VDP register configuration table. Code: Reads VDP status (A5), sets VDP address $6C000003 (scroll table), writes 2 words from $8000/$8002 (scroll A/B). Sets VDP address $40000010, writes 2 words from $C880/$C882. Performs Z80 bus request cycle, configures DMA registers ($9340/$9400/$9540/$96C2/$977F), sets DMA target $C000, triggers with $0080 from $C876, restores VDP mode from $C874, releases Z80 bus.

- **Modifies**: D0, D3, D4, D5, A1, A5, A6
- **RAM**: $8000: VDP scroll A (word) $8002: VDP scroll B (word) $C874: VDP mode register cache (word) $C876: DMA trigger register cache (word) $C880: VDP parameter A (word) $C882: VDP parameter B (word)
*Source: [vdp_dma_xfer_setup_0019ea.asm](disasm/modules/68k/game/render/vdp_dma_xfer_setup_0019ea.asm)*

---

### Set V-INT Dispatch State + VDP Status Read ($001A64–$001A72, 14 bytes)

Two sub-entries: first sets V-INT dispatch state to $002C and jumps to a handler at $0020C6. Second (at $001A6E) reads VDP status.

- **Modifies**: D0, A5
- **RAM**: $FFFFC87A = V-INT dispatch state (word, set to $002C) Entry 1: none | Entry 2: A5 = VDP control port
*Source: [set_v_int_dispatch_state_vdp_status_read.asm](disasm/modules/68k/game/render/set_v_int_dispatch_state_vdp_status_read.asm)*

---

### VDP DMA Transfer Setup ($001A72–$001ACA, 88 bytes)

Configures and triggers a VDP DMA transfer. Requests Z80 bus, sets VDP DMA registers ($9340/$9400/$9540/$96C2/$977F) for source, length, and mode. Writes VRAM destination ($C000) and triggers DMA. Uses RAM-cached VDP parameters at $C874/$C876/$C880/$C882.

- **Entry**: A5 = VDP control port, A6 = VDP data port
- **Modifies**: D0, D4, A5, A6
- **RAM**: $C874: VDP register cache A (word) $C876: DMA trigger value (word) $C880: VRAM write addr high (word) $C882: VRAM write addr low (word)
*Source: [vdp_dma_xfer_setup_001a72.asm](disasm/modules/68k/game/render/vdp_dma_xfer_setup_001a72.asm)*

---

### VDP DMA Transfer Setup ($001ACA–$001B14, 74 bytes)

Requests Z80 bus, configures VDP DMA registers for a transfer, updates the VDP register cache ($C874/$C876), and releases the Z80 bus. Sets bit 4 of the VDP mode register to enable display during DMA.

- **Entry**: A5 = VDP control port | Exit: DMA configured | Uses: D0, D4, A5
- **RAM**: $FFFFC874 = VDP register cache 1 (word, read + written to VDP) $FFFFC876 = VDP register cache 2 (word, set to $0083, written to VDP)
*Source: [vdp_dma_xfer_setup_001aca.asm](disasm/modules/68k/game/render/vdp_dma_xfer_setup_001aca.asm)*

---

### vdp_dma_transfer_setup ($001B14–$001C66, 338 bytes)

VDP DMA Transfer Setup Sets up VDP DMA transfers for display tables. Two entry points: Entry A ($001B14): Requests Z80 bus, then: 1. Writes window plane data from RAM $8000/$8002 to VRAM $6C00 2. Writes scroll data from RAM $C880/$C882 to VRAM $4000 3. DMA fill sprite attribute table at VRAM $6000 (128 entries) 4. DMA fill nametable at VRAM $C000 (64×14 entries) 5. Releases Z80 bus, jumps to $00179E Entry B ($001BA8): Requests Z80 bus, then: 1. DMA fill sprite table at VRAM $6000 (same as entry A) 2. DMA copy from ROM $08B at VRAM $6000 (sprite data source) 3. DMA fill nametable at VRAM $4000 + $C000 4. Releases Z80 bus, writes window + scroll data, returns

- **Modifies**: D0, D4, A5, A6 Hardware: Z80_BUSREQ: Z80 bus arbitration VDP_CTRL (A5): VDP command/register port VDP_DATA (A6): VDP data port
*Source: [vdp_dma_transfer_setup.asm](disasm/modules/68k/game/render/vdp_dma_transfer_setup.asm)*

---

### VDP DMA + Palette Transfer 036 ($001C66–$001D0C, 166 bytes)

Performs VDP register writes, DMA transfer, and palette copy Writes scroll/color data, sets up VDP DMA from ROM to VRAM Toggles frame buffer via adapter control register Calls PaletteRAMCopy if COMM0 is clear (SH2 not busy)

- **Modifies**: D0, D4, A5, A6
- **Calls**: $002878: PaletteRAMCopy
- **RAM**: $8000: vdp_scroll_h $8002: vdp_scroll_v $C874: vdp_reg_cache $C876: vdp_dma_ctrl $C880: vdp_color_a $C882: vdp_color_b $C80C: frame_toggle
- **Confidence**: high
*Source: [vdp_dma_palette_xfer_036.asm](disasm/modules/68k/game/render/vdp_dma_palette_xfer_036.asm)*

---

### VDP DMA + Frame Swap 037 ($001D0C–$001DBE, 178 bytes)

Performs VDP register writes, DMA transfer, and frame buffer swap Similar to vdp_dma_palette_xfer_036 but checks COMM1 for game state reset Clears game_state and toggles frame buffer on COMM1 signal

- **Modifies**: D0, D4, A5, A6
- **RAM**: $8000: vdp_scroll_h $8002: vdp_scroll_v $C874: vdp_reg_cache $C876: vdp_dma_ctrl $C880: vdp_color_a $C882: vdp_color_b $C87E: game_state $C80C: frame_toggle
- **Confidence**: high
*Source: [vdp_dma_frame_swap_037.asm](disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm)*

---

### VDP Register Write + 32X Adapter Control ($001DBE–$001E42, 132 bytes)

Saves VDP status, waits 100 NOPs, writes VDP scroll data from RAM $8000/$8002 to VRAM $6C00, writes game params $C880/$C882 to VDP CRAM $4000. If COMM1 bit 0 set: clears it, checks $C8C5 for state $18 (resets $C87E), clears $C8C4. Toggles adapter REN bit via $A1518A/B (Z80 bus), then re-enables 32X interrupts.

- **Modifies**: D0, D7, A5, A6
- **RAM**: $8000: scroll_data_A (word) $8002: scroll_data_B (word) $C80C: frame_toggle (byte, bit 0) $C87E: state_dispatch_idx (word, reset on state $18) $C880: cram_data_A (word) $C882: cram_data_B (word) $C8C4: scene_sub_state (byte, cleared) $C8C5: scene_main_state (byte, checked for $18)
*Source: [vdp_reg_write_32x_adapter_control.asm](disasm/modules/68k/game/render/vdp_reg_write_32x_adapter_control.asm)*

---

### VDP Register Write, Frame Swap, and CRAM Copy ($001E42–$001E94, 82 bytes)

End-of-frame display update: writes VDP scroll/VRAM data via the VDP ports (A5=control, A6=data), resets the game state, toggles the MARS frame buffer swap bit, and copies 512 bytes of CRAM palette from work RAM at $A100 to the 32X CRAM. MEMORY VARIABLES $FFFF8000  VDP scroll data A (word, written to VDP data port) $FFFF8002  VDP scroll data B (word, written to VDP data port) $FFFFC880  VDP register data A (word, written to VDP data port) $FFFFC882  VDP register data B (word, written to VDP data port) $FFFFC87E  Main game state index (word, cleared to 0) $FFFFC80C  Frame toggle flag (bit 0 toggled) $00A1518B  MARS adapter register (bit 0 = frame buffer select) $FFFFA100  CRAM palette buffer (512 bytes, source for copy)

- **Entry**: A5 = VDP control port, A6 = VDP data port
- **Returns**: VDP updated, frame swapped, CRAM copied
- **Modifies**: D0, A0, A1
*Source: [vdp_reg_write_frame_swap_cram_copy.asm](disasm/modules/68k/game/render/vdp_reg_write_frame_swap_cram_copy.asm)*

---

### VDP DMA + CRAM Transfer ($001E94–$001F4A, 182 bytes)

Performs VDP DMA to CRAM with Z80 bus synchronization. After DMA, checks COMM1 flag and optionally: resets game_state (if state=$18), transfers palette via MARS CRAM, and toggles frame buffer.

- **Entry**: A5 = VDP control port
- **Modifies**: D0, D4, A1, A2, A5
- **Calls**: $0048D6: palette_copy_a (JSR PC-relative) $0048DA: palette_copy_b (JSR PC-relative)
- **RAM**: $C80C: frame_toggle $C874: vdp_reg_cache $C876: dma_trigger $C87E: game_state $C8C4: frame_counter $C8C5: state_check_val
*Source: [vdp_dma_cram_xfer.asm](disasm/modules/68k/game/render/vdp_dma_cram_xfer.asm)*

---

### VDP DMA + Scroll + Frame Swap ($001F4A–$002010, 198 bytes)

Writes H-scroll and V-scroll data to VDP, then performs DMA to CRAM with Z80 bus synchronization. After DMA, checks COMM1 flag and optionally: resets game_state, transfers palette via MARS CRAM, and toggles frame buffer.

- **Entry**: A5 = VDP control port, A6 = VDP data port
- **Modifies**: D0, D4, A1, A2, A5, A6
- **Calls**: $0048D6: palette_copy_a (JSR PC-relative) $0048DA: palette_copy_b (JSR PC-relative)
- **RAM**: $8000: hscroll_a $8002: hscroll_b $C80C: frame_toggle $C874: vdp_reg_cache $C876: dma_trigger $C87E: game_state $C880: vscroll_a $C882: vscroll_b
*Source: [vdp_dma_scroll_frame_swap.asm](disasm/modules/68k/game/render/vdp_dma_scroll_frame_swap.asm)*

---

### gfx_32x_vdp_mode_reg_setup ($002652–$002680, 46 bytes)

32X VDP Mode Register Setup Data prefix ($002652-$00266B): 32X VDP mode register initialization values (12 bytes: 6 words for bitmap mode, screen shift, auto-fill, etc.). Code at $00266C: Loads A1 = PC-relative pointer to data at $002680 (immediately after this function), loads A2 = MARS_VDP_MODE ($A15180), copies 6 words from table to VDP mode registers.

- **Modifies**: D0, D3, D7, A1, A2 Hardware: MARS_VDP_MODE ($A15180): 32X VDP control registers (6 words)
*Source: [gfx_32x_vdp_mode_reg_setup.asm](disasm/modules/68k/game/render/gfx_32x_vdp_mode_reg_setup.asm)*

---

### MARS Adapter State Init + Framebuffer Setup ($002680–$00270A, 138 bytes)

Two entry points for MARS framebuffer initialization. Both select framebuffer 0, call three sub-routines, switch to framebuffer 1, call the same three subs again, then reset to framebuffer 0 and clear the frame toggle flag. Data prefix at $002680-$00268B (12 bytes, referenced by nearby code). Entry 1 ($00268C): adapter_state_init — uses $0027BE variant, JMP $002782 Entry 2 ($0026C8): alternate init — uses $0027A0 variant, writes CRAM

- **Entry**: none | Exit: framebuffers initialized
- **Modifies**: D0, A4
- **RAM**: $FFFFC80C = frame buffer toggle flag (byte, cleared to 0) MARS_SYS_BASE+$8B = MARS FB control register (byte, selects buffer) $00A15202 = MARS CRAM entry 1 (word, set to $8000 = priority black)
*Source: [mars_adapter_state_init_framebuffer_setup.asm](disasm/modules/68k/game/render/mars_adapter_state_init_framebuffer_setup.asm)*

---

### MARS Framebuffer Preparation (Double-Buffered) ($00270A–$00273C, 50 bytes)

Prepares both MARS framebuffers in sequence. Calls three sub-routines for each buffer, selecting the active framebuffer via the MARS FB control register at offset $8B from MARS_SYS_BASE. The frame toggle flag at $C80C determines which buffer gets drawn first.

- **Entry**: none | Exit: both framebuffers prepared
- **Modifies**: D0, D2, A4
- **RAM**: $FFFFC80C = frame buffer toggle flag (byte, bit 0 tested) MARS_SYS_BASE+$8B = MARS FB control register (byte, selects buffer)
*Source: [mars_framebuffer_preparation.asm](disasm/modules/68k/game/render/mars_framebuffer_preparation.asm)*

---

### gfx_32x_framebuffer_palette_fill ($0027DA–$00281E, 68 bytes)

32X Framebuffer Palette Fill Fills 32X framebuffer palette entries using auto-fill registers. First calls VDPPrep at $00281E, then fills two 16-entry ranges: Range 1: Starting address $2000, auto-fill with $0101, increment $0100 Range 2: Starting address $F000, same fill pattern For each entry: writes start address to $A15186 (palette addr), writes fill value to $A15188 (palette data), waits for fill complete (BTST #1 on status register $008B), then increments fill value.

- **Entry**: None (calls VDPPrep internally)
- **Modifies**: D0, D1, D2, D7, A2, A3, A4 Hardware: MARS_SYS_BASE ($A15100): Adapter control $A15186/$A15188: Palette address/data auto-fill registers
- **Calls**: $00281E: VDPPrep (BSR)
*Source: [gfx_32x_framebuffer_palette_fill.asm](disasm/modules/68k/game/render/gfx_32x_framebuffer_palette_fill.asm)*

---

### V-INT CRAM Transfer Gate ($002878–$002890, 24 bytes)

Checks the CRAM update flag at $C821. If set, loads the palette source (work RAM $FF6E00) and destination (MARS CRAM), then jumps to the palette copy routine at $0048D2. If clear, returns immediately.

- **Entry**: none | Exit: palette copied if flag set
- **Modifies**: A1, A2
- **RAM**: $FFFFC821 = CRAM update flag (byte, tested for nonzero)
*Source: [v_int_cram_xfer_gate.asm](disasm/modules/68k/game/render/v_int_cram_xfer_gate.asm)*

---

### MARS DMA Transfer + VDP Fill ($0028C2–$002984, 194 bytes)

Two entry points: (1) DMA transfer — sets MARS DREQ length/mode, writes command to COMM0, waits for ACK via COMM1, then streams data from $FF6000 to MARS FIFO via 10 calls to block copy routine. (2) VDP fill — clears adapter control, fills MARS framebuffer with zeros starting at VRAM $3000 (192 lines × 256 pixels).

- **Modifies**: D0, D1, D2, D7, A1, A2, A3, A4
- **RAM**: $C8A8: dma_state_timer $C8A9: dma_command_code
*Source: [mars_dma_xfer_vdp_fill.asm](disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm)*

---

### object_render_disp ($002BB0–$002C9A, 234 bytes)

Object Render Dispatcher Dispatches object rendering pipeline for both players. Two entry points: $002BB0: Player 1 (A0=$FF9000, A1=$FF6100, A2=$FF6330) $002C04: Player 2 (A0=$FF9F00, A1=$FF6330, A2=$FF6100) For each player, checks if rendering is paused ($C3AE bit 5), then: - Normal path: obj_render_check → camera_calc → texture_select → finish - Alt path (no camera): position_copy → finish - Paused path: sets visibility=2, obj_flags_set → render_flags → texture Also includes render visibility subroutine ($002C58) that checks entity +$C0 (render state), ghost mode (-$600C/-$B4FC), and flag bit 3 at +$E5.

- **Modifies**: D0, A0, A1, A2
- **Calls**: $002C58: render_visibility_check (internal) $002CDC: camera_param_calc_c (JSR PC-relative) $002DCA/$002E34: texture_select (JSR PC-relative) $002F04: position_copy (JSR PC-relative) $003010: render_flags_set (JSR PC-relative) $003130: obj_flags_set (JSR PC-relative)
*Source: [object_render_disp.asm](disasm/modules/68k/game/render/object_render_disp.asm)*

---

### Load Display List Pointer (Set A) ($002E9E–$002EB2, 20 bytes)

Loads a display list pointer from $C724 into A1+$24. If the param at A0+$8A is nonzero, overrides with the pointer from $C750. Paired with load_disp_list_pointer_002eb2 (set B).

- **Entry**: A0 = param source, A1 = dest struct
- **Returns**: A1+$24 = display list pointer | Uses: A0, A1
- **RAM**: $FFFFC724 = display list pointer A (long, read) $FFFFC750 = display list pointer A alt (long, read)
*Source: [load_disp_list_pointer_002e9e.asm](disasm/modules/68k/game/render/load_disp_list_pointer_002e9e.asm)*

---

### Load Display List Pointer (Set B) ($002EB2–$002EC6, 20 bytes)

Loads a display list pointer from $C758 into A1+$24. If the param at A0+$8A is nonzero, overrides with the pointer from $C764. Paired with load_disp_list_pointer_002e9e (set A).

- **Entry**: A0 = param source, A1 = dest struct
- **Returns**: A1+$24 = display list pointer | Uses: A0, A1
- **RAM**: $FFFFC758 = display list pointer B (long, read) $FFFFC764 = display list pointer B alt (long, read)
*Source: [load_disp_list_pointer_002eb2.asm](disasm/modules/68k/game/render/load_disp_list_pointer_002eb2.asm)*

---

### object_visibility_enable ($002EEE–$002F04, 22 bytes)

Object Visibility Enable Sets visibility flag to 1 for all 5 render slots in the camera buffer: (A1)+$00, +$14, +$28, +$3C, +$50. Each slot is a 20-byte ($14) render parameter block. Value 1 = visible, 0 = hidden, 2 = special.

- **Entry**: A1 = camera/render buffer pointer
- **Modifies**: D0, A1
*Source: [object_visibility_enable.asm](disasm/modules/68k/game/render/object_visibility_enable.asm)*

---

### object_pos_copy_with_render_flags ($003010–$0030C6, 182 bytes)

Object Position Copy with Render Flags Copies entity positions to render buffer (A2) and sets render visibility flags. Checks entity +$C0 for render state (0=hidden, 1=visible). Computes 3D position derivatives from entity offsets: +$120: height velocity (from +$3A/+$44 scaled) +$122: roll velocity (from +$3C/+$96/+$46 scaled) +$124: depth acceleration (from +$3E/+$4A/+$4C scaled) Also copies rotation (+$90, +$BC) and speed (+$30, +$34) to output.

- **Entry**: A0 = entity, A1 = camera buffer, A2 = render output buffer
- **Modifies**: D0, D1, D2, D3, A0, A1, A2
*Source: [object_pos_copy_with_render_flags.asm](disasm/modules/68k/game/render/object_pos_copy_with_render_flags.asm)*

---

### VDP Config Transfer + Scaled Parameters ($003160–$0031A6, 70 bytes)

Writes $0001 to VDP control ($FF6100). Computes display offset D0 = $70 + $C0C6 → writes to $FF60CE. If $C0BA nonzero: writes $0002 to $FF6100, copies 3 words directly from $C0BA to $FF6102, then copies 3 more words with ASR #3 (÷8 scaling).

- **Modifies**: D0, A1, A2
- **RAM**: $C0BA: VDP parameter block (6 words) $C0C6: display offset delta (word)
*Source: [vdp_config_xfer_scaled_params.asm](disasm/modules/68k/game/render/vdp_config_xfer_scaled_params.asm)*

---

### object_table_sprite_param_update ($0036DE–$0037B6, 216 bytes)

Object Table Sprite Parameter Update Iterates through 15 objects (D7=$0E), reading sprite type from entity +$C1 and computing render parameters for the SH2 3D pipeline. For each object with non-zero type: 1. Checks visibility (ghost mode, flag bit 3 at +$E5) 2. Looks up sprite definition from ROM table ($008958E4 + car_index) 3. Doubles type ID and adds +$C2 as sub-index 4. Stores sprite def pointer to output +$10 5. Computes scaled positions: lateral (div8), height with roll (+$6E), depth (div8), and rotation (div8) to output slots 6. Copies speed (+$30) and heading (+$34) as-is 7. Sets visibility flags D5/D6 (type 1 = both visible) Entity stride: $100 bytes. Output stride: $3C bytes.

- **Entry**: Fixed addresses A0=$FF9100, A1=$FF6218
- **Modifies**: D0, D5, D6, D7, A0, A1, A3
*Source: [object_table_sprite_param_update.asm](disasm/modules/68k/game/render/object_table_sprite_param_update.asm)*

---

### Sprite Parameter Setup (Two Sprite Blocks) ($00397C–$0039EC, 112 bytes)

Initializes sprite block A at $FF65D8: advances sprite_counter ($C8E2) by $1E, masks to 13 bits, writes to +$20 (rotation angle). Calls sprite_param_calc ($0038C0) with D1=$0C80, D3=$1400. If block A enabled (nonzero): initializes sprite block B at $FF65C4 with parameters from data table at ROM $3A76 (position, size, tile pattern $222A218E).

- **Modifies**: D0, D1, D3, A1, A2
- **Calls**: $0038C0: sprite_param_calc
- **RAM**: $C8E2: sprite_counter (word, +=$1E each call)
*Source: [sprite_param_setup.asm](disasm/modules/68k/game/render/sprite_param_setup.asm)*

---

### VDP Sprite Pointer Setup + Conditional Display Clear ($003CCE–$003D22, 84 bytes)

Sets up 4 sprite block pointers at $FF66EC (stride $14) from ROM pointer table at $00895B7E, indexed by D0 × 16. If race_phase ($C026) is in range [7,19): clears enable fields at $FF6128 (+$00, +$14, and conditionally +$28, +$3C) based on $C04C and boost_flag ($C8C8).

- **Modifies**: D0, D1, A1, A2, A3
- **RAM**: $C026: race_phase (word) $C04C: display_enable (word) $C8C8: boost_flag (word)
*Source: [vdp_sprite_pointer_setup_cond_disp_clear.asm](disasm/modules/68k/game/render/vdp_sprite_pointer_setup_cond_disp_clear.asm)*

---

### Scene Transition Check + VDP Clear ($003E08–$003E52, 74 bytes)

At scene_state ($C8AA) == 10: loads SFX from table at $003E52 indexed by $C89C, writes to $C8A5. If $C80E bit 5 set → SFX = $93. At scene_state > 40: resets scene_state and state_dispatch_idx ($C8AC), clears 3 VDP registers ($FF6980/$FF6990/$FF69C0).

- **Modifies**: D0
- **RAM**: $C80E: display control (byte, bit 5) $C89C: SH2 comm state (word) $C8A5: sound effect (byte) $C8AA: scene_state (word) $C8AC: state_dispatch_idx (word, cleared)
*Source: [scene_transition_check_vdp_clear.asm](disasm/modules/68k/game/render/scene_transition_check_vdp_clear.asm)*

---

### Scene State Timer + VDP Output ($003EF6–$003F2C, 54 bytes)

If scene_state ($C8AA) == 5 → plays SFX $98 via $C8A5. Reads bit 2 of $C8AB: clear → D0=0, set → D0=9. Writes D0 to VDP register $FF6980. If scene_state > 60 ($3C) → clears VDP output, advances state_dispatch_idx ($C8AC) by 4.

- **Modifies**: D0
- **RAM**: $C8AA: scene_state (word) $C8AB: scene flags (byte, bit 2) $C8A5: sound effect (byte) $C8AC: state_dispatch_idx (word, advanced by 4)
*Source: [scene_state_timer_vdp_output.asm](disasm/modules/68k/game/render/scene_state_timer_vdp_output.asm)*

---

### Render Slot Setup ($003F2E–$004084, 342 bytes)

configure 7 trackside object render slots Four entry points for different viewport configurations: Entry 1 ($003F2E): 1P mode — viewport A ($FF64AC) then viewport B ($FF6178) Entry 2 ($003F5A): 1P alt — viewport C ($FF627C) then viewport D ($FF63A8) Entry 3 ($003F86): 2P mode — viewport B ($FF6178) only Common ($003F90): Iterates 7 render slots with $14-byte stride. For each: reads trackside object index from RAM, doubles it for table lookup, loads 4-byte sprite definition pointer from ROM tables, sets visibility. ROM tables: $008959B0, $008959D0, $008959FC, $00895A24, $00895A44

- **Entry**: A0 = player entity pointer (+$C0=render_flags)
- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A2
- **Confidence**: medium
*Source: [render_slot_setup.asm](disasm/modules/68k/game/render/render_slot_setup.asm)*

---

### Display State Dispatcher ($004084–$00413A, 182 bytes)

13-state game display controller Dispatches to one of 13 display states via jump table indexed by RAM $C07C. State 0 ($0040C8): Initializes display system — sets adapter flag, clears display/race mode flags ($FF6960/$FF6930/$FF6970), configures HUD geometry (A2=$FF6754: offset=$FFE0, size=$0040, Y=$F600), sets camera texture pointer, advances state counter. State 1 ($00412E): Sets sound command byte $96, advances state. Remaining states dispatch to handlers outside this function.

- **Modifies**: D0, A0, A1, A2
- **RAM**: $C07C: display state index (advanced by 4 per transition)
- **Confidence**: high
*Source: [display_state_disp_004084.asm](disasm/modules/68k/game/render/display_state_disp_004084.asm)*

---

### Sprite Config Setup 001 ($004200–$004280, 128 bytes)

Configures sprite display entries from racer data Looks up sprite graphics pointers from ROM tables Copies position data from work buffers via BSR to next function

- **Modifies**: D0, D1, D5, D7, A0, A1, A2, A3
- **RAM**: $C30C: racer_sprite_id $C254: position_buf_b $C25C: position_stride $C260: position_buf_a $C07C: input_state
- **Confidence**: medium
*Source: [sprite_config_setup_001.asm](disasm/modules/68k/game/render/sprite_config_setup_001.asm)*

---

### Sprite Position Check (Player Compare) ($0045CE–$00461A, 76 bytes)

Initializes sprite and checks player score against threshold. Sets player-specific attributes. A0=$9000 for player 1. Falls through to sprite_clear_alt for alternate path.

- **Entry**: A0 = player base, A2 = sprite struct
- **Modifies**: D0
*Source: [sprite_position_check.asm](disasm/modules/68k/game/render/sprite_position_check.asm)*

---

### Sprite Clear (Alternate Path) ($00461A–$004630, 22 bytes)

Clears position flag and sets alternate sprite attributes.

- **Entry**: A2 = sprite struct
- **Modifies**: none
*Source: [sprite_clear_alt.asm](disasm/modules/68k/game/render/sprite_clear_alt.asm)*

---

### entity_render_pipeline ($005AB6–$005D08, 594 bytes)

Entity Render Pipeline Multi-variant entity render pipeline with 4 entry points. Each variant clears display offsets (+$44/+$46/+$4A), then calls 20-46 subroutines covering physics, movement, rendering, palette, display mode, memory copy, and buffer clear. Variant A (full, 46 calls), Variant B (reduced), Variant C (extended with speed=0 init), Variant D (minimal display).

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0
- **RAM**: $C89C sh2_comm_state
- **Object fields**: +$06 speed, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$74 render_state
- **Confidence**: high
*Source: [entity_render_pipeline.asm](disasm/modules/68k/game/render/entity_render_pipeline.asm)*

---

### entity_data_table_render_pipeline_variant ($005DC8–$005E38, 112 bytes)

Entity Data Table + Render Pipeline Variant ROM address lookup table (3 longword entries) followed by a render pipeline variant. The pipeline clears display offsets (+$44/+$46/+$4A) and calls 17 subroutines for angle computation, screen coordinate mapping, palette update, display mode, buffer operations, and overlay rendering.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0, A2, A6
- **Object fields**: +$44 display_offset, +$46 display_scale, +$4A display_aux, +$88 animation data
- **Confidence**: high
*Source: [entity_data_table_render_pipeline_variant.asm](disasm/modules/68k/game/render/entity_data_table_render_pipeline_variant.asm)*

---

### entity_render_pipeline_with_vdp_dma ($005EEA–$00617A, 656 bytes)

Entity Render Pipeline with VDP DMA Extended entity render pipeline with VDP register writes and DMA transfers. Contains 4 entry point variants. Each clears display offsets, runs physics/movement/rendering subroutines, then performs VDP register writes ($003126) and DMA setup ($003160) before buffer/memory operations. Variant C includes countdown timer for state transitions.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0
- **RAM**: $C89C sh2_comm_state
- **Object fields**: +$06 speed, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$74 render_state
- **Confidence**: high
*Source: [entity_render_pipeline_with_vdp_dma.asm](disasm/modules/68k/game/render/entity_render_pipeline_with_vdp_dma.asm)*

---

### entity_render_pipeline_with_vdp_dma_2p_copy ($006240–$006496, 598 bytes)

Entity Render Pipeline with VDP DMA + 2P Copy Multi-entry entity render pipeline with VDP register writes and DMA. Contains data table prefix (3 longword ROM addresses), 4 pipeline variants (full with palette, reduced, stripped, 2-player with MOVEM block copy), and 2-player object table duplication using 32x32-byte MOVEM transfers.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0-D7, A0, A1, A4, A6
- **RAM**: $9F00 obj_table_3
- **Object fields**: +$18 position, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$88 animation, +$92 render_mode, +$B2 stored_pos
- **Confidence**: high
*Source: [entity_render_pipeline_with_vdp_dma_2p_copy.asm](disasm/modules/68k/game/render/entity_render_pipeline_with_vdp_dma_2p_copy.asm)*

---

### entity_render_pipeline_jump_table ($00659C–$00671A, 382 bytes)

Entity Render Pipeline Jump Table Jump table (8 longword ROM addresses) followed by 4 render pipeline variants. Variant A: full pipeline with sprite buffer, physics, steering (27 calls). Variant B: extended with speed=0 init + countdown timer. Variant C: reduced display-only. Variant D: minimal with state check.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0
- **Object fields**: +$06 speed, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$74 render_state
- **Confidence**: high
*Source: [entity_render_pipeline_jump_table.asm](disasm/modules/68k/game/render/entity_render_pipeline_jump_table.asm)*

---

### entity_render_pipeline_with_2_player_dispatch ($00677A–$006A3A, 704 bytes)

Entity Render Pipeline with 2-Player Dispatch Large multi-entry entity render pipeline with 2-player dispatch. Contains 6 variants: full pipeline (43 calls + VDP), reduced (17 calls), 2-player dispatch with 8-entry jump table, full with countdown timer, display-only, and minimal render. Includes MOVEM-based object table copying and entity position/heading updates per viewport.

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, D1, A0, A1, A4
- **RAM**: $9F00 obj_table_3
- **Object fields**: +$06 speed, +$18 position, +$44 display_offset, +$46 display_scale, +$4A display_aux, +$74 render_state, +$92 render_mode, +$AC param
- **Confidence**: high
*Source: [entity_render_pipeline_with_2_player_dispatch.asm](disasm/modules/68k/game/render/entity_render_pipeline_with_2_player_dispatch.asm)*

---

### entity_data_table_full_render_pipeline ($006AB4–$006B96, 226 bytes)

Entity Data Table + Full Render Pipeline ROM address lookup table (3 longword entries) followed by a reduced render pipeline and a full render pipeline variant. The reduced variant handles movement, collision, and display (15 calls). The full variant adds physics, sorting, and palette (30 calls).

- **Entry**: A0 = entity base pointer
- **Modifies**: D0, A0, A2, A6
- **Object fields**: +$44 display_offset, +$46 display_scale, +$4A display_aux, +$88 animation, +$92 render_mode
- **Confidence**: high
*Source: [entity_data_table_full_render_pipeline.asm](disasm/modules/68k/game/render/entity_data_table_full_render_pipeline.asm)*

---

### tile_block_dma_setup ($006C46–$006C88, 66 bytes)

Tile Block DMA Setup Sets up tile block data for DMA transfers. Initializes 6 groups of tile block entries, reading source sizes from ROM table at $89B844, writing destination pointers to $FF3000 region, and calling FastCopy16 for each tile row. Used during scene setup for background tile loading.

- **Entry**: Called during scene initialization
- **Modifies**: D5, D6, D7, A1, A2, A3, A4
- **Confidence**: high
*Source: [tile_block_dma_setup.asm](disasm/modules/68k/game/render/tile_block_dma_setup.asm)*

---

### object_visibility_collector ($0071A6–$007248, 162 bytes)

Object Visibility Collector Computes a camera direction key from an object's own x/y positions (+$30/+$34) and collects visible geometry entries into a buffer at $FF6000. Similar to object_geometry_visibility_collect but uses object-relative coordinates instead of 32X frame registers. Special case: when race_state == 4 and object+$1D is in range [$88,$98], uses alternate geometry table at $0089A434 instead of default $0089A0D4. Sentinel value $2207FFFE marks empty geometry slots.

- **Entry**: A0 = object pointer (+$30=x_pos, +$34=y_pos, +$CA=cam_key, +$CC=table_index, +$1D=type_field)
- **Modifies**: D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, A4
- **RAM**: $C8A0 (race_state)
*Source: [object_visibility_collector.asm](disasm/modules/68k/game/render/object_visibility_collector.asm)*

---

### vdp_nametable_setup_display_list_build ($007248–$007270, 40 bytes)

VDP Nametable Setup + Display List Build Configures VDP nametable addresses (scroll A at $C000, scroll B at $E000) and scroll mode via register writes through A5/A6, then loads display buffer at $FF6000 and calls display list builder. Stores object count in $FF610E.

- **Entry**: A5/A6 = VDP register write ports
- **Modifies**: D0, D4, A2, A5, A6
- **Confidence**: high
*Source: [vdp_nametable_setup_display_list_build.asm](disasm/modules/68k/game/render/vdp_nametable_setup_display_list_build.asm)*

---

### track_tile_object_display_list_builder ($007280–$00734E, 206 bytes)

Track Tile Object Display List Builder Builds display list of visible track objects. Converts entity X/Y position to tile grid coordinates, looks up road segment data from ROM tables at $89A932, iterates 12 neighboring tiles checking for visible objects, and writes their addresses to the display list buffer (A2). Returns object count in D4.

- **Entry**: A0 = entity pointer, A2 = display list write pointer
- **Modifies**: D0, D1, D2, D3, D4, D6, D7, A0, A1, A3, A4
- **Object fields**: +$30 x_position, +$34 y_position, +$CA tile_x, +$CC tile_y
- **Confidence**: high
*Source: [track_tile_object_display_list_builder.asm](disasm/modules/68k/game/render/track_tile_object_display_list_builder.asm)*

---

### Object Geometry Visibility Collect ($00734E–$0073E8, 154 bytes)

Builds a visible-object list for the current viewpoint. Computes a camera direction key from 32X frame registers, reads a track segment table via racer_index, then iterates neighbour offsets collecting objects whose pointers differ from a sentinel ($2207FFFE). Count stored to $FF610E for the renderer.

- **Entry**: A0 = object pointer (reads +$CC for segment index)
- **Modifies**: D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, A4
- **RAM**: $C0BA: segment_table_select (word, nonzero = alternate table) $C8A0: racer_index (word, ×4 into jump table) ROM tables: $0089A5D2: segment_table_primary $0089A0D4: segment_table_alternate $007248 (PC-relative): racer_segment_ptr_table
*Source: [object_geometry_visibility_collect.asm](disasm/modules/68k/game/render/object_geometry_visibility_collect.asm)*

---

### 3D Transform Setup 007 ($0082FA–$008368, 110 bytes)

Sets up 3D transformation parameters for rendering Calls matrix/vector routines, computes composite index from state words Checks depth threshold ($60000000) for visibility

- **Entry**: A3 (clobbered), A4 = output pointer
- **Modifies**: D0, D1, D2, D5, D6, A1, A2, A3
- **Calls**: $00B3CE: matrix_multiply $00B386: vector_transform
- **RAM**: $C806: transform_src $C270: vector_buf_a $C274: vector_buf_b $FDAA: matrix_base $C89C: race_substate $C8A0: race_state $C8C8: vint_state $C8CC: race_substate_b
- **Confidence**: medium
*Source: [gfx_3d_transform_setup_007.asm](disasm/modules/68k/game/render/gfx_3d_transform_setup_007.asm)*

---

### Scroll Pan Calculation + VDP Write ($009064–$00909C, 56 bytes)

If $C313 bit 3 clear: reads obj.$CC, shifts right by 6, writes to $8002. Reads $FF6108, shifts right by 8, clamps to [-8, 16], subtracts 8, stores to $C882. Writes $FEC0 to $8000. If $C313 bit 3 set → exits to $00909C.

- **Entry**: A0 = object pointer
- **Modifies**: D0, A0
- **RAM**: $C313: control flags (byte, bit 3) $C882: VDP pan offset (word) $8000: VDP scroll A (word, set to $FEC0) $8002: VDP scroll B (word, set from obj.$CC)
- **Object fields**: A0+$CC: scroll source value (word)
*Source: [scroll_pan_calc_vdp_write.asm](disasm/modules/68k/game/render/scroll_pan_calc_vdp_write.asm)*

---

### tire_animation_and_smoke_effect_counters ($009B82–$009C9C, 282 bytes)

Tire Animation and Smoke Effect Counters Updates tire/wheel animation and smoke effect counters. Reads entity speed +$04 and multiple effect timers (+$80, +$82, +$84, +$86, +$98, +$9A, +$E6, +$E8) to control animation frame rates. Speed-dependent frequency modulation for tire smoke. Jump table at end selects direction-dependent wheel animation data.

- **Entry**: A0 = entity pointer
- **Modifies**: D0, D1, A0
- **Object fields**: +$04 speed, +$80-$86 tire timers, +$98-$9A smoke timers, +$BE direction index, +$E6-$E8 wheel timers
- **Confidence**: high
*Source: [tire_animation_and_smoke_effect_counters.asm](disasm/modules/68k/game/render/tire_animation_and_smoke_effect_counters.asm)*

---

### depth_sort ($009DD6–$009E5A, 132 bytes)

Depth Sort (Bubble Sort by Priority + Direction Tie-Break) Sorts a 16-element array of 4-byte entries using bubble sort. Primary key: word at entry+$00 (ascending = back-to-front). Tie-break: when keys are equal, compares x/y positions of the referenced objects based on camera direction quadrant (painter's algorithm ordering). 6 words of priority key pairs used elsewhere as lookup data.

- **Entry**: A0 = sort array (16 entries × 4 bytes: word key + word obj_ptr)
- **Modifies**: D0, D1, D2, D7, A0, A1, A2, A3 Object fields (via indirect pointers at entry+$02): +$1E: direction (used for quadrant computation) +$30: x_position +$34: y_position
*Source: [depth_sort.asm](disasm/modules/68k/game/render/depth_sort.asm)*

---

### Animated Sequence Player (Byte Table + Counter) ($00B6D0–$00B722, 82 bytes)

Data prefix: 10-byte descending sequence ($FF..$F8,$F8,$80). If $C80E bit 7 set: decrements countdown ($C80A); when zero reloads from $C809 and indexes sequence table at $00B722 by $C825. Writes byte to $FF60D5 (VDP palette/sprite). Increments $C825; when $C825 reaches $0A: calls $004846 with D1=0/A1=$8480, resets $C825, clears $C80E bit 7 (sequence complete).

- **Modifies**: D0, D1, A1
- **Calls**: $004846: sequence completion handler
- **RAM**: $8480: work buffer (long, passed to $004846) $C809: countdown reload value (byte) $C80A: countdown timer (byte, decremented) $C80E: control flags (byte, bit 7 = sequence active) $C825: sequence index (byte, 0-9)
*Source: [animated_seq_player.asm](disasm/modules/68k/game/render/animated_seq_player.asm)*

---

### Animation Sequence Player (3-Word Data Prefix + Frame Loop) ($00B722–$00B770, 78 bytes)

Data prefix: 3 words ($0102,$0304,$0506) — bit test masks. Code: D7-count loop over animation channels. For each: decrements tick counter (A1+1). On expire: reads sequence index (A1+0), loads byte from A2 table[index], computes word offset (index×2), reads value from A3[offset]. If negative: resets index to 1, uses A3+2. Writes value to work buffer A0[byte_offset], increments index.

- **Modifies**: D0, D1, D2, D3, D4, D6, D7, A0
- **RAM**: $8480: work_buffer (word array indexed by byte)
*Source: [animation_seq_player.asm](disasm/modules/68k/game/render/animation_seq_player.asm)*

---

### display_state_bit_10_guard ($00B7E6–$00B7EE, 8 bytes)

Display State Bit 10 Guard Tests bit 10 of D0. If set, falls through to camera_animation_state_disp camera animation state dispatcher. If clear, returns immediately.

- **Entry**: D0 = flags word
- **Modifies**: D0
- **Confidence**: high
*Source: [display_state_bit_10_guard.asm](disasm/modules/68k/game/render/display_state_bit_10_guard.asm)*

---

### Display Parameter Computation (Shift+Multiply, Word Table) ($00BDFE–$00BE50, 82 bytes)

Computes display viewport parameters from word lookup table. D1 (entry index) → table value + $10 → stored to $A0E6. Computes complement ($E0 - value) for paired parameter. Both values shifted left by 9, added to fixed-point base $04024140, stored to A1+$04 and A1+$14. Writes viewport dimensions to $FF60C8 block. Increments display_counter ($A0F0).

- **Modifies**: D0, D1, D2, A1, A2
- **RAM**: $A0E6: display_param (word) $A0F0: display_counter (word) Data table (8 words at $BE50): $0000,$0002,$0004,$0008,$000C,$0012,$001A,$0024
*Source: [display_param_calc.asm](disasm/modules/68k/game/render/display_param_calc.asm)*

---

### VDP Table Entry Write (Frame-Indexed) ($00BF9E–$00BFD4, 54 bytes)

Increments frame counter $A0EC, computes row and column: row = ($A0EC × 2) / 28, column = remainder + 2. If row >= 5 → exits (past fn). Otherwise computes table offset: row × 20 + column, writes to VDP table at $FF6900.

- **Modifies**: D0, D1, D2, A1
- **RAM**: $A0EC: frame counter (word, +1 per call)
*Source: [vdp_table_entry_write_00bf9e.asm](disasm/modules/68k/game/render/vdp_table_entry_write_00bf9e.asm)*

---

### VDP Table Entry Write (Frame-Indexed, Variant B ($00BFDE–$00C01E, 64 bytes)

Negated Column) Like vdp_table_entry_write_00bf9e but negates the column value and checks for $FFE4 (column -28). Increments frame counter $A0EC, computes: row = ($A0EC × 2) / 28, column = -(remainder + 2). If row >= 5 → exits (past fn). If column == $FFE4 → column = 0. Computes row × 20 + row offset, writes column to VDP table at $FF6900.

- **Modifies**: D0, D1, D2, A1
- **RAM**: $A0EC: frame counter (word, +1 per call)
*Source: [vdp_table_entry_write_00bfde.asm](disasm/modules/68k/game/render/vdp_table_entry_write_00bfde.asm)*

---

### VDP Register Table Copy (with Shared Block Copy Subroutine) ($00C9B6–$00C9E0, 42 bytes)

Source: code_c200 Copies a 512-byte VDP register configuration table from ROM to 32X work RAM. Selects between two ROM source tables based on the split-screen display flag (bit 3 of $C80E). The block copy subroutine at `copy_16b_blocks` is also used as a shared entry point by the sibling VDP init module (fn_c200_040). BLOCK COPY SUBROUTINE (copy_16b_blocks) Copies (D0+1) blocks of 16 bytes from A1 to A2 using four MOVE.L per block. This subroutine is shared across multiple VDP table loaders. Entry:  A1 = source pointer A2 = destination pointer D0 = block count - 1 (loop counter for DBF) Exit:   A1/A2 advanced past copied data Uses:   D0 (decremented to -1) ROM SOURCE TABLES $00898C80  Default VDP register table (512 bytes) $00898F00  Alternate table for split-screen mode (512 bytes) MEMORY VARIABLES $FFFFC80E  Display control flags (bit 3 = split-screen active) $00FF6800  Destination: VDP register work area (512 bytes)

- **Entry**: No register inputs
- **Returns**: VDP register table copied to $FF6800
- **Modifies**: D0, A1, A2
*Source: [vdp_reg_table_copy.asm](disasm/modules/68k/game/render/vdp_reg_table_copy.asm)*

---

### VDP Register Table Init ($00C9E0–$00CA4C, 108 bytes)

Multi-Entry Loader Source: code_c200 Provides five entry points that each load a different VDP configuration table from ROM into the 32X VDP work area at $FF6800. Each entry sets up source address (A1), destination (A2), and block count (D0), then jumps to the shared copy routine `copy_16b_blocks` (defined in fn_c200_039, immediately preceding this module). Entry points 1-4 tail-jump to the copy routine (BRA.S) and return from there. Entry point 5 calls it as a subroutine (BSR.S), then zeroes out a control byte in each of the 24 VDP register slots and clears two status words before returning. ENTRY POINTS vdp_reg_table_init_multi_entry_loader:       A1=$00899500, 32 blocks (512 bytes) — table A vdp_load_table_b:    A1=$00899100, 32 blocks (512 bytes) — table B vdp_load_table_c:    A1=$00899300, 32 blocks (512 bytes) — table C vdp_load_table_d:    A1=$00899700,  8 blocks (128 bytes) — table D (short) vdp_load_and_clear:  A1=$00898E80,  8 blocks (128 bytes) — table E + cleanup Cleanup (entry 5 only): - Zeroes byte at base of each 16-byte VDP slot (24 slots) - Clears $FF6740 and $FF672C (VDP control words) copy_16b_blocks  (fn_c200_039) — shared 16-byte block copy subroutine MEMORY VARIABLES $00FF6800  VDP register work area (destination for all entries) $00FF6740  VDP control word 1 (cleared by entry 5) $00FF672C  VDP control word 2 (cleared by entry 5)

- **Entry**: None (each entry point is self-contained)
- **Returns**: VDP work area loaded; control words cleared (entry 5 only)
- **Modifies**: D0, D1, A1, A2
*Source: [vdp_reg_table_init_multi_entry_loader.asm](disasm/modules/68k/game/render/vdp_reg_table_init_multi_entry_loader.asm)*

---

### Scene Init + VDP Block Setup + Counter Reset ($00CFD6–$00D04C, 118 bytes)

Loads scene data pointer from $00895BCC indexed by race_substate ($C8CC), calls block_copy ($CFC2) 4× to copy to VDP buffers at $FF6178/$FF627C/$FF63A8/$FF64AC. Second entry ($D00C): initializes counter block $C806 to (0,$C4,$C4), sets $C076=$C200. If $C80E bit 3 clear: sets work params $C254/$C260. Reads race_active ($FDA9) as index into table at $D050 → $C051.

- **Modifies**: D0, A1, A2, A3
- **Calls**: $00CFC2: block_copy (4×)
- **RAM**: $C051: track_param (byte, from table) $C076: scene_type (word, set to $C200) $C254: work_param_A (longword) $C260: work_param_B (longword) $C806: counter block (3 bytes) $C80E: display_flags (byte, bit 3) $C8CC: race_substate (word) $FDA9: race_active (byte, table index)
*Source: [scene_init_vdp_block_setup_counter_reset.asm](disasm/modules/68k/game/render/scene_init_vdp_block_setup_counter_reset.asm)*

---

### vdp_dma_config_and_display_init ($00D1D4–$00D3FC, 552 bytes)

VDP DMA Configuration and Display Init Configures VDP via multiple DMA transfers. Acquires Z80 bus, sets VDP auto-increment, DMA length/source, and triggers transfers for VRAM fill, pattern data, and name tables. Loads track-specific data from ROM pointer tables. Handles split-screen setup with additional DMA for second viewport. Sets scroll registers and palette via VDP data port writes.

- **Modifies**: D0, D1, D2, D4, D7, A0, A1, A2
- **Confidence**: high
*Source: [vdp_dma_config_and_display_init.asm](disasm/modules/68k/game/render/vdp_dma_config_and_display_init.asm)*

---

### Scene Init + VDP DMA Setup + Track Parameter Load ($00D3FC–$00D481, 133 bytes)

Data prefix: 48 bytes (12 longword entries) of scene config. Code block A ($D42C): Sets VDP CRAM address, tail-jumps to palette_init. Code block B ($D43A): LEA work buffer, calls nametable_init_A, tail-jumps to nametable_init_B. Data table ($D44C): 4 track parameter bytes. Code block C ($D450): Uses track_id ($FEA8 or $FEAC) to load parameter byte from table → $C81A. Loads longword from ROM table at $898BFC indexed by track_id → $FF6828 (or $FF68B8 if $C80F set).

- **Modifies**: D0, D1, A0, A1, A5
- **Calls**: $00483E: nametable_init_A $004842: nametable_init_B $0048B8: palette_init
- **RAM**: $C80F: track_select_flag (byte) $C81A: track_param (byte) $FEA8: track_id_A (byte) $FEAC: track_id_B (byte)
*Source: [scene_init_vdp_dma_setup_track_param_load.asm](disasm/modules/68k/game/render/scene_init_vdp_dma_setup_track_param_load.asm)*

---

### sh2_display_and_palette_init ($00D482–$00D7B2, 816 bytes)

SH2 Display and Palette Initialization Major scene initialization orchestrator. Data prefix (8 bytes). Configures 32X VDP mode, clears framebuffer and CRAM via DMA. Loads SH2 palette data, sends graphics tile commands, transfers compressed data to SH2 memory via sh2_send_cmd_wait. Configures overlay graphics with split-screen support. Sets MARS interrupts, VDP mode, and initializes SH2 communication via COMM0/COMM1.

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E2F0 (sh2_load_data), $00E316 (sh2_send_cmd_wait)
- **Confidence**: high
*Source: [sh2_display_and_palette_init.asm](disasm/modules/68k/game/render/sh2_display_and_palette_init.asm)*

---

### scene_state_disp_with_palette_data ($00D7B2–$00D8B8, 262 bytes)

Scene State Dispatcher with Palette Data Data prefix (~178 bytes) containing palette/color tables and scene configuration parameters. Code section dispatches scene states via two jump tables at $00D874 and $00D898. Calls $00882080 for scene setup, advances state counter at $C8CE. Second entry triggers sound $81 and increments state by 4.

- **Modifies**: D0, D1, D4, D5, D6, A0, A1, A2
- **Confidence**: high
*Source: [scene_state_disp_with_palette_data.asm](disasm/modules/68k/game/render/scene_state_disp_with_palette_data.asm)*

---

### palette_data_loader_and_cycle_handler ($00D8CC–$00DA90, 452 bytes)

Palette Data Loader and Cycle Handler Loads palette data from ROM tables $0088DAA8/$0088DA90 indexed by current palette selection. Copies 128 words to $FF6E00 framebuffer palette. Populates display object at $FF6100 with viewport and animation parameters. Sends SH2 DMA command via COMM0. Handles D-pad input for palette cycling: right/left advance/retreat through palette entries with wrapping and sound trigger ($A9).

- **Modifies**: D0, D1, D7, A0, A1, A2
- **Calls**: $00E52C (dma_transfer)
- **Confidence**: high
*Source: [palette_data_loader_and_cycle_handler.asm](disasm/modules/68k/game/render/palette_data_loader_and_cycle_handler.asm)*

---

### scene_param_adjustment_and_dma_upload ($00DA90–$00DCAC, 540 bytes)

Scene Parameter Adjustment and DMA Upload Data prefix (48 bytes: 6 longword pointers + 6 word pairs). Sends DMA transfer command, then loads viewport parameters from $FF2000 table indexed by palette selection. Handles D-pad input for multi- axis camera/viewport adjustment with per-axis clamping. Writes updated parameters back to $FF2000. Sends SH2 update command and advances state counter.

- **Modifies**: D0, D1, D3, D4, D5, A0, A1, A4
- **Calls**: $00E35A (sh2_send_cmd), $00E52C (dma_transfer), $00DCAC/$00DCBE/$00DCB8/$00DCCA (increment/decrement helpers)
- **Confidence**: high
*Source: [scene_param_adjustment_and_dma_upload.asm](disasm/modules/68k/game/render/scene_param_adjustment_and_dma_upload.asm)*

---

### SH2 Cmd 27 Sprite Render ($00E118–$00E19E, 134 bytes)

Sends two sprite render commands to SH2 via sh2_cmd_27. First sprite: selects source from ROM table (indexed by player ID), uses ×6 stride. Second sprite: selects base address from player ID, uses ×72 stride, checks COMM0 busy before sending.

- **Modifies**: D0, D1, D2, D3, A0, A1
- **Calls**: $00E3B4: sh2_cmd_27 (JSR PC-relative)
- **RAM**: $A019: player_id_a $A025: player_id_b $A026: player_id_c $A027: player_select
*Source: [sh2_cmd_27_sprite_render.asm](disasm/modules/68k/game/render/sh2_cmd_27_sprite_render.asm)*

---

### default_palette_color_data ($00E5AC–$00E5CE, 34 bytes)

Default Palette Color Data Static palette color data table. Contains 12 CRAM color entries ($0EEE = white, $0000 = black) used as default/fallback palette. The RTS at end allows this to be called as a no-op initializer.

- **Confidence**: high
*Source: [default_palette_color_data.asm](disasm/modules/68k/game/render/default_palette_color_data.asm)*

---

### sh2_split_screen_display_init ($00E5CE–$00E88C, 702 bytes)

SH2 Split-Screen Display Initialization Scene initialization for split-screen modes. Three entry points configure single-screen, dual-screen, and replay modes by setting palette indices and split-screen flags. Shared body clears VDP, CRAM, and framebuffer; loads SH2 graphics commands for tile layout; transfers compressed palette/tile data via sh2_send_cmd_wait; configures viewport parameters and 32X VDP mode. Nearly identical to sh2_display_and_palette_init but handles additional split-screen tile regions.

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E2F0 (sh2_load_data), $00E316 (sh2_send_cmd_wait)
- **Confidence**: high
*Source: [sh2_split_screen_display_init.asm](disasm/modules/68k/game/render/sh2_split_screen_display_init.asm)*

---

### sh2_geometry_transfer_and_palette_cycle_handler ($00E93A–$00EAC2, 392 bytes)

SH2 Geometry Transfer and Palette Cycle Handler Sends SH2 geometry and sprite data via sh2_send_cmd. Loads palette data from ROM table $0088EACE indexed by selection, copies 128 words to framebuffer palette. Transfers display object data via DREQ FIFO (68 words). Handles D-pad palette cycling with wrapping and sound trigger ($A9). Supports dual-palette switching via secondary selection register.

- **Modifies**: D0, D1, D7, A0, A1, A2
- **Calls**: $00E35A (sh2_send_cmd), $00E52C (dma_transfer)
- **Confidence**: high
*Source: [sh2_geometry_transfer_and_palette_cycle_handler.asm](disasm/modules/68k/game/render/sh2_geometry_transfer_and_palette_cycle_handler.asm)*

---

### sh2_three_panel_display_init ($00F130–$00F39C, 620 bytes)

SH2 Three-Panel Display Initialization Data prefix (12 bytes: 3 longword entry point pointers). Scene initialization for three-panel display mode. Configures 32X VDP, clears framebuffer/CRAM, loads palette and tile graphics via sh2_graphics_cmd (3 tile regions). Transfers 8 compressed data blocks to SH2 memory via sh2_send_cmd_wait. Initializes palette selection and panel configuration parameters.

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A5
- **Calls**: $00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E2F0 (sh2_load_data), $00E316 (sh2_send_cmd_wait)
- **Confidence**: high
*Source: [sh2_three_panel_display_init.asm](disasm/modules/68k/game/render/sh2_three_panel_display_init.asm)*

---

### multi_screen_palette_navigation_handler ($00F44C–$00F682, 566 bytes)

Multi-Screen Palette Navigation Handler Handles palette navigation for multi-screen (up to 3-panel) display modes. D-pad left/right cycles through palette entries with per- panel limits based on screen count. D-pad up/down switches active panel. Sends SH2 geometry data via sh2_send_cmd loop (8 command table entries at $0088F682). Advances state counter.

- **Modifies**: D0, D1, D2, A0, A1, A2
- **Calls**: $00E35A (sh2_send_cmd), $00F88C (palette_switch)
- **Confidence**: high
*Source: [multi_screen_palette_navigation_handler.asm](disasm/modules/68k/game/render/multi_screen_palette_navigation_handler.asm)*

---

### sh2_multi_panel_tile_renderer ($00F8F6–$00FB24, 558 bytes)

SH2 Multi-Panel Tile Renderer Data prefix (32 bytes: default palette color data, same as default_palette_color_data). Renders tile overlays to SH2 framebuffer via sh2_cmd_27 for up to 3 screen panels. Computes tile addresses from palette index with bit-shift multiplication. Panel 1 renders main view, panel 2 renders comparison view (optional), panel 3 renders stats overlay. Two identical rendering blocks handle P1 and P2 viewports.

- **Modifies**: D0, D1, D2, A0, A1
- **Calls**: $00E3B4 (sh2_cmd_27)
- **Confidence**: high
*Source: [sh2_multi_panel_tile_renderer.asm](disasm/modules/68k/game/render/sh2_multi_panel_tile_renderer.asm)*

---

## Game / Scene

### System Initialization Orchestrator ($000D68–$000DC4, 92 bytes)

Main system initialization routine. Calls RAM clear, Z80/VDP init, controller port init (if config changed), and a fourth init sub. Then configures MARS interrupt control, VDP mode, and jumps into the game initialization chain. Contains an embedded sub-function at $000DB0 that clears ~47KB of work RAM ($FF1000-$FFFDFF) with zero-fill. MEMORY VARIABLES $FFFFFEA4  Cached controller config (byte) $FFFFC818  Current controller config (byte)

- **Entry**: none
- **Modifies**: D0, D1, D7, A1, A2
- **Calls**: $000DB0 (RAM clear), $000FEA (z80_bus_vdp_init), $00170C (controller_port_init), $001048 (init sub)
*Source: [system_init_orch.asm](disasm/modules/68k/game/scene/system_init_orch.asm)*

---

### V-INT COMM1 Signal Handler ($002010–$00203A, 42 bytes)

Checks COMM1 bit 0 for an SH2 signal. If set, clears the signal and checks if sub-sequence timer ($C8C5) equals $18 — if so, resets the main game state machine. Always clears the sub-sequence flag ($C8C4).

- **Entry**: A5 = VDP control port | Exit: D0 = (A5) | Uses: D0, A5
- **RAM**: $FFFFC8C5 = sub-sequence timer value (byte, compared to $18) $FFFFC8C4 = sub-sequence state flag (byte, cleared) $FFFFC87E = main game state (word, conditionally cleared)
*Source: [v_int_comm1_signal_handler.asm](disasm/modules/68k/game/scene/v_int_comm1_signal_handler.asm)*

---

### sh2_frame_sync_wrapper ($00203A–$00204A, 16 bytes)

SH2 Frame Sync Wrapper Saves all registers (D0-D7, A0-A6), calls the SH2 frame synchronization routine at $008B0004, then restores all registers and returns. Called by system_boot_init to sync 68K with SH2 processors.

- **Modifies**: D0-D7, A0-A6 (saved/restored)
- **Calls**: $008B0004: sh2_frame_sync
*Source: [sh2_frame_sync_wrapper.asm](disasm/modules/68k/game/scene/sh2_frame_sync_wrapper.asm)*

---

### Clear Communication and State Variables ($00204A–$00205E, 20 bytes)

Clears five state/communication variables to zero: $C8A4, $C822 (comm ready flag), $C823, and $C8A2.

- **Entry**: none | Exit: variables cleared | Uses: D0
- **RAM**: $FFFFC8A4 = state variable (word, cleared) $FFFFC822 = comm/input ready flag (byte, cleared) $FFFFC823 = comm flag extension (byte, cleared) $FFFFC8A2 = state variable (word, cleared)
*Source: [clear_communication_state_variables.asm](disasm/modules/68k/game/scene/clear_communication_state_variables.asm)*

---

### Clear Scene State + Advance Dispatch Index ($003E52–$003E64, 18 bytes)

Data prefix (6 bytes) followed by code that clears the scene state ($C8AA) and advances the dispatch index ($C8AC) by 4.

- **Entry**: none | Exit: scene state reset, dispatch advanced
- **Modifies**: D2, D7, A1
- **RAM**: $FFFFC8AA = scene state (word, cleared to 0) $FFFFC8AC = state dispatch index (word, incremented by 4)
*Source: [clear_scene_state_advance_dispatch_index.asm](disasm/modules/68k/game/scene/clear_scene_state_advance_dispatch_index.asm)*

---

### Clear Scene State + Advance Dispatch + Set Mode ($003E64–$003E7E, 26 bytes)

Clears scene state ($C8AA), advances dispatch index ($C8AC) by 4, sends command $09 to SH2 shared memory ($FF6980), and sets the state variable ($C8A4) to $C0.

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC8AA = scene state (word, cleared) $FFFFC8AC = state dispatch index (word, advanced by 4) $00FF6980 = SH2 shared command byte (set to $09) $FFFFC8A4 = state variable (byte, set to $C0)
*Source: [clear_scene_state_advance_dispatch_set_mode.asm](disasm/modules/68k/game/scene/clear_scene_state_advance_dispatch_set_mode.asm)*

---

### Scene State Check + Conditional Advance ($004460–$004498, 56 bytes)

Checks scene_state counter: - If == 1: calls init sub at $002066 - If == 60 ($3C): advances input_state, clears scene_state, enables display flags $C809/$C80A/$C802, sets $C80E bit 7

- **Calls**: $002066: scene init sub (PC-relative)
- **RAM**: $C8AA: scene_state counter (word) $C07C: input_state (word, advanced by 4) $C809: display enable A (byte, set to $01) $C80A: display enable B (byte, set to $01) $C80E: display control (byte, bit 7 set) $C802: display enable C (byte, set to $01)
*Source: [scene_state_check_cond_advance.asm](disasm/modules/68k/game/scene/scene_state_check_cond_advance.asm)*

---

### Set State + Pre-Dispatch + Init SH2 Scene ($004C8A–$004CB8, 46 bytes)

Sets race/mode state ($C8A5) to $9A, calls pre_dispatch_common ($002080) and WaitForVBlank ($004998), then initializes SH2 scene handler to $00885618 and clears two SH2 shared longs.

- **Entry**: none | Exit: SH2 scene initialized | Uses: none
- **RAM**: $FFFFC8A5 = race/mode state (byte, set to $9A) $00FF0002 = SH2 scene handler pointer (long, set to $00885618) $00FF5FF8 = SH2 shared data (long, cleared) $00FF5FFC = SH2 shared data (long, cleared)
*Source: [set_state_pre_dispatch_init_sh2_scene.asm](disasm/modules/68k/game/scene/set_state_pre_dispatch_init_sh2_scene.asm)*

---

### Game Frame Orchestrator 013 ($004D1A–$004D98, 126 bytes)

Main game frame update — calls rendering + logic subroutines Path A: full update (10 calls + input record + sprite/object update) Path B: minimal update (4 calls + increment) Records controller input to replay buffer

- **Modifies**: D0, D1, A0
- **Calls**: $00212E: vdp_display_init (pre-frame) $00179E: poll_controllers $00B09E: animation_update $00B144: sound_buffer_copy_with_decode $00B504: display_param_calc $00B4DC: ai_object_setup_cond_flag_set $00B522: ai_state_dispatch $00593C: sprite_state_process $00B6DA: sprite_update $00B684: object_update $0056F8: state_disp_00573c (tail call via JMP)
- **RAM**: $C8AA: frame_counter $C8C0: controller_ptr $C971: input_mask $C973: input_buttons $C87E: game_state $C886: vint_counter
- **Confidence**: high
*Source: [game_frame_orch_013.asm](disasm/modules/68k/game/scene/game_frame_orch_013.asm)*

---

### Frame Update Orchestrator (8 Subroutines) ($005070–$00509E, 46 bytes)

Calls 8 subroutines via bsr.w in sequence: $002180 (frame init), $00179E (controller_poll), $00B09E (animation_update), $00B094, $00B0DE, $00B128, $00B136, $00640E (object handler). Advances game_state by 4, sets display mode $001C.

- **Modifies**: D0 (from called routines)
- **Calls**: $002180: frame init $00179E: controller_poll $00B09E: animation_update $00B094: animation sub B $00B0DE: animation sub C $00B128: animation sub D $00B136: animation sub E $00640E: object handler
- **RAM**: $C87E: game_state (word, advanced by 4)
*Source: [frame_update_orch_005070.asm](disasm/modules/68k/game/scene/frame_update_orch_005070.asm)*

---

### Frame Orchestrator (12 Subroutines, 2 Entry Points) ($00509E–$005100, 98 bytes)

Two entry points: Entry 1 ($509E): Full orchestrator — calls 12 subroutines (init, scene logic, animation, frame update, sprite processing), increments scene_state, advances state_dispatch_idx by 4, writes $54 to SH2 COMM, tail-jumps to controller handler ($0056F8). Entry 2 ($50DE): Reduced — calls 5 subroutines (init, poll_controllers, animation, update), increments scene_counter, writes $54 to SH2 COMM.

- **Modifies**: D0, D3, D7, A1, A2
- **Calls**: $00179E: poll_controllers $0021A4: init handler A $006496: scene logic $00B094: frame_sync $00B09E: animation_update $00B0DE: display_update $00B4F8: sprite_sort $00B504: sprite_build $00B55A: sprite_commit $00B590: sprite_finalize $00B684: object_update $00B6DA: sprite_update
- **RAM**: $C87E: state_dispatch_idx (word) $C886: scene_counter (byte) $C8AA: scene_state (word)
*Source: [frame_orch_00509e.asm](disasm/modules/68k/game/scene/frame_orch_00509e.asm)*

---

### Frame Orchestrator (9 Subroutines + Controller Tail-Jump) ($00535E–$0053B0, 82 bytes)

Two entry points: Entry 1 ($00535E): Full frame — calls 9 subroutines (init, controllers, animation, 2 updates, 2 setups, sprite+object). Increments scene_state ($C8AA), advances state_dispatch_idx ($C87E) by 4, writes $54 to SH2 COMM, tail-jumps to controller check ($0056F8). Entry 2 ($005396): Reduced frame — calls init, controllers, animation, increments scene counter ($C886), writes $54 to SH2 COMM.

- **Modifies**: D0, D2, A0, A1, A2, A6
- **Calls**: $00179E: poll_controllers $0020D6: init handler (from $00212E) $00212E: frame init $006840: sprite_handler $00B02C: frame_update (from $00B11A) $00B09E: animation_update $00B11A: update_A $00B504: setup_A $00B5A4: setup_B $00B684: object_update $00B6DA: sprite_update
- **RAM**: $C886: scene counter (byte, +1) $C87E: state_dispatch_idx (word, +4) $C8AA: scene_state (word, +1)
*Source: [frame_orch_00535e.asm](disasm/modules/68k/game/scene/frame_orch_00535e.asm)*

---

### Frame Update Orchestrator (7 Subroutines + Scene Tick) ($0055D0–$0055FE, 46 bytes)

Calls 7 subroutines via bsr.w, increments scene_state ($C8AA), advances game_state ($C87E) by 4. Display mode $0054. Subroutine sequence: sfx_queue_process, controller_poll, sprite_state_process, $00BC40, $00BAD4, sprite_update, object_update.

- **Modifies**: D0 (from called routines)
- **Calls**: $0021CA: sfx_queue_process $00179E: controller_poll $00593C: sprite_state_process $00BC40: sub D $00BAD4: sub E $00B6DA: sprite_update $00B684: object_update
- **RAM**: $C8AA: scene_state (word, +1 per frame) $C87E: game_state (word, advanced by 4)
*Source: [frame_update_orch_0055d0.asm](disasm/modules/68k/game/scene/frame_update_orch_0055d0.asm)*

---

### Frame Orchestrator (8 Subroutines, 2 Entry Points, Controller Decode) ($005676–$0056E4, 110 bytes)

Entry 1 ($5676): calls sfx, poll_controllers, 2 sprite handlers, increments scene_state, reads controller byte from RAM pointer ($C8C0), decodes to AI flags ($C971/$C973), calls 4 handlers, advances state, writes $54 to SH2 COMM, tail-jumps to $56F8. Entry 2 ($56CE): calls sfx, poll_controllers, increments scene_counter, writes $54.

- **Modifies**: D0, D1, A0
- **Calls**: $00179E: poll_controllers $0021CA: sfx_queue_process $00593C: sprite_state_process $00B504/$00B522/$00B5CA: sprite handlers $00B684: object_update $00B6DA: sprite_update
- **RAM**: $C87E: state_dispatch_idx (word) $C8C0: controller_ptr (word) $C886: scene_counter (byte) $C8AA: scene_state (word) $C970: work_param (longword, set to $FFFF0000) $C971: ai_input_flags (byte, bits 2,3,4,6) $C973: ai_direction_flags (byte, bits 0-1)
*Source: [frame_orch_005676.asm](disasm/modules/68k/game/scene/frame_orch_005676.asm)*

---

### SH2 Handler Dispatch + Scene Init ($005866–$0058EA, 132 bytes)

Two code paths: (1) reads current SH2 handler address from $00FF0002, matches against 4 known values, replaces with corresponding new handler, then jumps to init routine. (2) Scene setup — calls display digit extract, JSR to track init, checks race_substate and control flags.

- **Modifies**: D0, D1, D4, D7, A0, A1, A4, A6
- **Calls**: $002474: vint_init (JMP PC-relative) $002890: game_init (JMP PC-relative) $0049AA: SetDisplayParams (JSR PC-relative) $006B8A: track_init (JSR PC-relative) $00B4CA: display_digit_extract (JSR PC-relative)
- **RAM**: $A000: scene_palette_base $C26C: display_config $C81C: control_mode_flags $C89C: race_substate $C8C5: state_counter
*Source: [sh2_handler_dispatch_scene_init.asm](disasm/modules/68k/game/scene/sh2_handler_dispatch_scene_init.asm)*

---

### SH2 Comm Check + Conditional Guard ($005908–$005926, 30 bytes)

Loads base address $A000 into A4, reads $C26C into D0. Checks bit 7 of $C81C — if set, goes to mask check. Otherwise tests $C89C — if zero, falls through. Masks D0 with $0138 — if zero, falls through. Otherwise returns.

- **Entry**: none | Exit: conditional return or fall-through | Uses: D0, A4
- **RAM**: $FFFFA000 = base address (loaded into A4) $FFFFC26C = comm data (word, loaded into D0) $FFFFC81C = comm flag (byte, bit 7 tested) $FFFFC89C = SH2 comm state (word, tested)
*Source: [sh2_comm_check_cond_guard.asm](disasm/modules/68k/game/scene/sh2_comm_check_cond_guard.asm)*

---

### Game Frame Orchestrator ($005E38–$005EEA, 178 bytes)

Master frame orchestrator — initializes display params then calls 37 subroutines covering physics, steering, rendering, AI, palette, display mode, buffer management, and memory copy.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A0
- **RAM**: $C970: display_scale_pair (longword: X|Y = $0010|$0010) Calls (37 subroutines via PC-relative JSR): $00B77C, $00859A, $00A350, $008170, $0080CC, $008548, $0094FA, $009312, $009B12, $009182, $00961E, $009688, $009802, $007E7A, $006F98 (calc_steering), $007CD8, $00A434, $0070AA, $007F04, $007C4E, $00714A, $00764E, $007F50, $009CCE, $009B54, $0086FE, $009040, $00ACD4, $004084, $0075FE, $0071A6, $002984 (palette_update), $0031A6 (display_mode_dispatch), $0036DE (clear_buffer), $0037B6 (memory_copy), $003F86 (clear_display_vars), $0030C6
- **Object fields**: +$44: display_offset +$46: display_scale +$4A: display_param +$92: param_92
*Source: [game_frame_orch.asm](disasm/modules/68k/game/scene/game_frame_orch.asm)*

---

### Object State Dispatcher + Scene Transition ($006200–$006240, 64 bytes)

Dispatches via 2-entry jump table at $006240 (BEQ selects D0=0 or D0=4 based on Z flag from caller). Calls handler via JSR (A1). After handler: if scene_state ($C8AA) == 20: clears $C800, copies $C092 → $C07A, sets state_dispatch_idx ($C8AC) = 4. If $C89C nonzero → state_dispatch_idx = $20. If $C81C bit 7 set → state_dispatch_idx = $20.

- **Modifies**: D0, A1
- **RAM**: $C07A: bitmask table index (word, set from $C092) $C092: source param (word) $C800: scene flag (byte, cleared) $C81C: control flags (byte, bit 7) $C89C: SH2 comm state (word) $C8AA: scene_state (word) $C8AC: state_dispatch_idx (word, set to 4 or $20)
*Source: [object_state_disp_scene_transition.asm](disasm/modules/68k/game/scene/object_state_disp_scene_transition.asm)*

---

### gfx_2_player_entity_frame_orch ($006496–$00659C, 262 bytes)

2-Player Entity Frame Orchestrator Updates both player viewports in 2-player mode. Processes player 1 (obj_table_1 at -24832) and player 2 (obj_table_2 at -28672) entity updates, copies object tables between viewports using 32x32-byte MOVEM transfers, and runs render/state subroutines for each.

- **Entry**: Called from 2-player race frame loop
- **Modifies**: D0-D7, A0, A1, A2, A3, A4
- **RAM**: $9F00 obj_table_3
- **Object fields**: +$18 position, +$8A param, +$B2 stored_pos, +$E5 flags
- **Confidence**: high
*Source: [gfx_2_player_entity_frame_orch.asm](disasm/modules/68k/game/scene/gfx_2_player_entity_frame_orch.asm)*

---

### dual_time_display_orch ($0083E4–$0084F4, 272 bytes)

Dual Time Display Orchestrator Main time display handler for 1P and 2P modes. Manages lap/race time display for both players. Reads scene state index, extracts timing data from object tables, calls num_to_decimal for digit rendering, and writes status codes for HUD updates. Two parallel processing blocks handle player 1 (A0) and player 2 (A1) independently.

- **Entry**: A0 = player 1 entity, A1 = player 2 entity
- **Modifies**: D0, D1, D7, A0, A1, A2, A3
- **Calls**: $00839A (num_to_decimal), $00B3CE, $00B3BC, $0084F4 (time_array_entry_comparison), $00850E (fixed_point_threshold_state_marker)
- **RAM**: $68F0 (status_code), $68F8 (time_display_buf), $9F00 (obj_table_3)
- **Object fields**: +$02 flags (bit 6 = update trigger), +$07 display param
- **Confidence**: high
*Source: [dual_time_display_orch.asm](disasm/modules/68k/game/scene/dual_time_display_orch.asm)*

---

### scene_menu_init_and_input_handler ($00BA5E–$00BC1C, 446 bytes)

Scene Menu Initialization and Input Handler Two-phase function: initialization clears camera state, counters, entity rank, and configures animation parameters, then jumps to scene data loader. Input handler phase polls controller buttons, detects start/A-button, triggers menu transitions with sound ($9D), configures SH2 communication ($00FF0002/$00FF0008), and dispatches scene commands indexed by track selection.

- **Entry**: A0 = entity pointer (during init)
- **Modifies**: D0, A0
- **Confidence**: high
*Source: [scene_menu_init_and_input_handler.asm](disasm/modules/68k/game/scene/scene_menu_init_and_input_handler.asm)*

---

### scene_command_disp ($00BC1C–$00BCCA, 174 bytes)

Scene Command Dispatcher Data prefix with 5 BRA.W entries forming a scene command jump table. Main body initializes display object at $FF60C8, calls scene setup subroutines ($00BE68, $00A050, $00BDD6), loads scene data from ROM indexed by track. Dispatches per-frame commands via +$00(A0) byte. Secondary dispatch via +$0E field through pointer table at $00BC30. Advances scene sequence counter.

- **Entry**: A0 = scene data pointer, A1 = display object
- **Modifies**: D0, D6, A0, A1, A6
- **Confidence**: high
*Source: [scene_command_disp.asm](disasm/modules/68k/game/scene/scene_command_disp.asm)*

---

### Scene Init Orchestrator ($00C200–$00C30A, 266 bytes)

Master scene initialization — calls 9 setup subroutines, configures MARS VDP mode (240-line bitmap), sets SH2 interrupt control, initializes frame buffer, loads road geometry from ROM table, waits for SH2 ready signal via COMM1 bit 0, then sets up return address and clears stack.

- **Entry**: (none — standalone orchestrator)
- **Modifies**: D0, A0, A5
- **Calls**: $00A1FC: race_state_read $00C974: track_segment_init $00CF0C: scene_param_setup $00CC06: object_array_init $00CFAE: scene_display_init $00C6DA: palette_scene_setup $0058C8: sprite_input_check $005908: sprite_update_check $00593C: sprite_state_process $0088204A, $008820C6: 32X init routines $00882080: frame_sync $00884998: vblank_wait MARS registers: MARS_VDP_MODE+1: bitmap mode (clear bits 1:0, set bit 0 = 240-line) MARS_SYS_INTCTL: set to $8083 (enable H/V/CMD interrupts) COMM1_LO: SH2 ready handshake (bit 0) ROM tables: $008BB1C4: road_geometry_table (longword ptrs, indexed by race_state)
- **RAM**: $9000: object_base $C802: scene_init_flag (byte, set to 1) $C80A: frame_counter_mode (byte, set to $02) $C80E: scene_config (byte, bit 6 set) $C809: scene_state (byte, set to 1) $C81C: adapter_bit0 (byte, bit 0 cleared) $C874: vdp_state (word, read to A5) $C875: vdp_config (byte, bit 6 set) $C87E: game_state (word, cleared) $C8A0: race_state (word) $C8A4: sound_trigger (byte, set to $C5) $C8A5: sound_param (byte) $C8A8: scene_dispatch_param (word, set to $0102) $C8C0: scene_addr_table (word, set to $C9A0) $C8F4: scene_param_2 (word, cleared) $C96C: road_geometry_ptr (longword) $FEB7: system_ctrl (byte, bit 7 cleared) $A000: frame_delay_counter (word)
*Source: [scene_init_orch.asm](disasm/modules/68k/game/scene/scene_init_orch.asm)*

---

### Scene Init with Multiple SH2 Calls ($00C368–$00C390, 40 bytes)

Calls four subroutines (3 SH2 + 1 local), increments the frame counter ($C886), advances game state dispatch ($C87E) by 4, and sets display mode/frame delay to $0010.

- **Entry**: none | Exit: scene initialized | Uses: none
- **RAM**: $FFFFC886 = frame counter (byte, incremented by 1) $FFFFC87E = game state dispatch (word, advanced by 4) $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
*Source: [scene_init_multiple_sh2_calls.asm](disasm/modules/68k/game/scene/scene_init_multiple_sh2_calls.asm)*

---

### Scene Orchestrator (5 Subroutines + Controller Decode, 2 Entry Points) ($00C390–$00C416, 134 bytes)

Entry 1 ($C390): calls init ($21CA), poll_controllers ($179E), increments frame_counter ($C080) and scene_state, decodes controller byte from RAM pointer ($C8C0) to AI flags ($C971/$C973), calls sprite handlers, object/sprite_update, increments scene_counter, advances state, writes $38 to SH2 COMM, calls 3 handlers, tail-jumps to $C662. Entry 2 ($C3FC): calls init, poll_controllers, increments scene_counter, writes $38, returns.

- **Modifies**: D0, D1, A0
- **Calls**: $00179E: poll_controllers $0021CA: init handler $0024CA: scene handler $00593C: sprite_state_process $00B684: object_update $00B6DA: sprite_update $00C070: handler A $00C416: handler B $00C5AE: handler C
- **RAM**: $C080: frame_counter (word) $C87E: state_dispatch_idx (word) $C8C0: controller_ptr (word) $C886: scene_counter (byte) $C8AA: scene_state (word) $C970: work_param (longword) $C971: ai_input_flags (byte) $C973: ai_direction_flags (byte)
*Source: [scene_orch.asm](disasm/modules/68k/game/scene/scene_orch.asm)*

---

### Scene Dispatch (Jump Table) ($00C416–$00C44C, 54 bytes)

Reads scene dispatch index from $C8F5, looks up target scene ID from PC-relative table at $C44C. If it matches current scene ($C080), initializes scene: SH2 call, sets game/menu/sub-sequence states, advances dispatch index by 2, sets display mode $0044.

- **Modifies**: D0
- **Calls**: $008849AA: SH2 scene init
- **RAM**: $C8F5: scene dispatch index (byte) $C080: current scene ID (word) $C87E: game_state (word, set to $0010) $C8C4: sub-sequence state (word, set to $0C00) $C082: menu_state (byte, set to $04)
*Source: [scene_dispatch.asm](disasm/modules/68k/game/scene/scene_dispatch.asm)*

---

### Scene State Dispatcher (Data Prefix + 4-Entry Jump Table) ($00C44C–$00C4A4, 88 bytes)

Data prefix: 9-word parameter table (7 offsets + 2 × $1000). Calls sfx_queue_process, then dispatches via 4-entry longword jump table indexed by sub_state ($C8C4). State 0 handler: calls VDPSyncSH2, init_handler ($0025B0), sprite_setup ($006D9C), increments scene counter ($C886), advances sub_state by 4, writes $10 to SH2 COMM.

- **Modifies**: D0, D2, A1, A2, A4, A6
- **Calls**: $0021CA: sfx_queue_process $0025B0: init_handler $0028C2: VDPSyncSH2 $006D9C: sprite_setup
- **RAM**: $C886: scene counter (byte, +1) $C8C4: sub_state (byte, dispatch index)
*Source: [scene_state_disp.asm](disasm/modules/68k/game/scene/scene_state_disp.asm)*

---

### Scene Frame Update + Display Mode Set ($00C4A4–$00C4C2, 30 bytes)

Calls two SH2 routines, increments the frame counter ($C886), advances the sub-sequence state ($C8C4) by 4, and sets the display mode/frame delay to $0010.

- **Entry**: none | Exit: frame updated | Uses: none
- **RAM**: $FFFFC886 = frame counter (byte, incremented by 1) $FFFFC8C4 = sub-sequence state (byte, advanced by 4) $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
*Source: [scene_frame_update_disp_mode_set.asm](disasm/modules/68k/game/scene/scene_frame_update_disp_mode_set.asm)*

---

### Scene Dispatch + Input Replay ($00C4C2–$00C542, 128 bytes)

Increments frame/scene counters, reads next input byte from replay buffer (splitting direction + button bits), calls scene logic, then dispatches to state handler via 4-entry jump table indexed by menu_state. Post-dispatch calls sprite_update, object_update, and tail-calls to frame finalize.

- **Modifies**: D0, D1, D2, A0, A1, A2
- **Calls**: $00B684: object_update (JSR PC-relative) $00B6DA: sprite_update (JSR PC-relative) $00C070: scene_logic (JSR PC-relative) $00C662: frame_finalize (JMP PC-relative)
- **RAM**: $C080: frame_counter $C082: menu_state (jump table index: 0/4/8/12) $C886: sub_frame $C8AA: scene_state $C8C0: replay_buffer_ptr $C8C4: frame_counter_b $C970: anim_state (init $FFFF0000) $C971: direction_bits (from replay: bits masked $5C) $C973: button_bits (from replay: bits masked $03)
*Source: [scene_dispatch_input_replay.asm](disasm/modules/68k/game/scene/scene_dispatch_input_replay.asm)*

---

### Scene Phase Timer ($00C544–$00C56A, 38 bytes)

Setup Source: code_c200 Initializes a phase-based timer system that drives scene transitions. Reads the current state transition flag ($C8F5), computes an index, and looks up both a phase duration and a control mode from inline data tables located at the start of fn_c200_032. The phase system works as follows: 1. This function sets up the phase: duration counter in $C083, mode in $C0FC 2. c200_func_002 (fn_c200_032) counts down the phase each frame 3. When the phase counter reaches zero, the timeline sub-counter advances DATA TABLES (defined in fn_c200_032, accessed via PC-relative indexing) scene_phase_timer_tick_data_tables  10 bytes at $C56A — frame counts per phase control_mode_table     9 words at $C574 — mode values (1-8, then 0) MEMORY VARIABLES $FFFFC082  Timeline sub-counter (word, incremented by 4 each phase start) $FFFFC083  Phase countdown byte (loaded from duration table) $FFFFC8F5  State transition flag (byte, read for phase index) $FFFFC0FC  Control mode (word, loaded from mode table) $00FF0008  Display control timer (word, set to $0034)

- **Entry**: No register inputs
- **Returns**: Phase timer configured from state flag
- **Modifies**: D0
*Source: [scene_phase_timer_setup.asm](disasm/modules/68k/game/scene/scene_phase_timer_setup.asm)*

---

### Scene Phase Timer ($00C56A–$00C592, 40 bytes)

Tick and Data Tables Source: code_c200 Contains two inline data tables used by scene_phase_timer_setup (fn_c200_031) for phase-based scene timing, followed by the phase tick handler. The tick handler decrements the phase countdown byte ($C083) each frame. When it reaches zero, the timeline sub-counter ($C082) advances by 4, causing scene_phase_timer_setup to be called again to set up the next phase. DATA TABLES (accessed by fn_c200_031 via PC-relative indexed addressing) scene_phase_timer_tick_data_tables (10 bytes): Index 0: $28 (40 frames)   Index 5: $50 (80 frames) Index 1: $3C (60 frames)   Index 6: $64 (100 frames) Index 2: $64 (100 frames)  Index 7: $78 (120 frames) Index 3: $64 (100 frames)  Index 8: $50 (80 frames) Index 4: $64 (100 frames)  Index 9: $00 (sentinel) control_mode_table (9 words): Modes 1-8 for each phase, then 0 (sentinel) MEMORY VARIABLES $FFFFC082  Timeline sub-counter (word, advanced by 4 when phase expires) $FFFFC083  Phase countdown byte (decremented each frame)

- **Entry**: No register inputs
- **Returns**: Phase counter decremented; timeline advanced if phase expired
- **Modifies**: (none modified beyond RAM writes)
*Source: [scene_phase_timer_tick_data_tables.asm](disasm/modules/68k/game/scene/scene_phase_timer_tick_data_tables.asm)*

---

### Scene Phase Timer ($00C592–$00C5AE, 28 bytes)

Reset Source: code_c200 Resets the phase timer system to its initial state. Called when entering a new scene or restarting the phase sequence. Clears the timeline sub-counter, control mode, and sets the initial phase count. MEMORY VARIABLES $00FF0008  Display control timer (word, set to $003C = 60 frames) $FFFFC082  Timeline sub-counter (byte, cleared to 0) $FFFFC0FC  Control mode (word, cleared to 0) $FFFFC8C5  Phase count / initial state (byte, set to $18 = 24)

- **Entry**: No register inputs
- **Returns**: Phase timer system reset
- **Modifies**: (none)
*Source: [scene_phase_timer_reset.asm](disasm/modules/68k/game/scene/scene_phase_timer_reset.asm)*

---

### Scene Dispatch + Track Data Setup ($00C8E6–$00C9AE, 200 bytes)

Reads race_substate ($C8CC) to index a 6-word data table, storing two config words to $FF6122/$FF6352. Then sets up 4 track data blocks at $FF6114, $FF6218, $FF6344, $FF6448 by loading segment pointers from ROM tables indexed by race_substate, copying header + 3 param groups via a shared subroutine. Data table (6 words at function start, indexed as pairs by D0): +0: $5400,$5500  +4: $5A00,$5B00  +8: $4A00,$4B00

- **Modifies**: D0, A1, A2, A3, A4
- **Calls**: $00C9AE: post_dispatch (called 3 times via BSR/BRA)
- **RAM**: $C8CC: race_substate (word, indexes data table) $C710: track_segment_buffer (destination for first block) $C734: track_transform_ptr (longword pointer) $C754: track_offset_data (longword, copied to $FF6228/$FF6354) ROM tables: $008957A0: track_segment_base_table $008956C8: track_segment_alt_table $008848FE: segment_copy_routine (JMP target)
*Source: [scene_dispatch_track_data_setup.asm](disasm/modules/68k/game/scene/scene_dispatch_track_data_setup.asm)*

---

### Scene Init + SH2 Buffer Clear Loop ($00CD92–$00CDD2, 64 bytes)

Saves/restores $C260 across SH2 init call ($88483A with A1→$C000). Then calls SH2 init ($884842) 16 times with A1→$9000, D1=0. Clears $C30E, $C8AA, $C8AC, $C8AE. Sets $C026 = $FFFF.

- **Modifies**: D1, D7, A1
- **Calls**: $0088483A: SH2 init A $00884842: SH2 init B (called 16 times)
- **RAM**: $C000: SH2 buffer A (via LEA) $C026: control flag (word, set to $FFFF) $C260: saved value (long, preserved via stack) $C30E: control flags (byte, cleared) $C8AA: scene_state (word, cleared) $C8AC: state_dispatch_idx (word, cleared) $C8AE: effect_timer (word, cleared) $9000: SH2 buffer B (via LEA)
*Source: [scene_init_sh2_buffer_clear_loop.asm](disasm/modules/68k/game/scene/scene_init_sh2_buffer_clear_loop.asm)*

---

### Scene Initialization (Variable Reset) ($00CE76–$00CEC2, 76 bytes)

Initializes scene variables: clears display flags ($C81D/$C81F/$C820), sets work buffer ($A9E0-$A9E9) to default values ($0000C4C4), clears $C819 and $C8BE, copies $C81A to $C310. Calls 3 SH2 initialization routines via absolute addresses.

- **Modifies**: D1, A1
- **Calls**: $00884842: SH2 init A $00884846: SH2 init B $00884856: SH2 init C
- **RAM**: $A800: work buffer base (via LEA) $A9E0: work param A (word, cleared) $A9E2: work param B (long, set to $0000C4C4) $A9E6: work param C (long, set to $0000C4C4) $C819: scene flag (byte, cleared) $C81A: scene source param (byte) $C81D: display flag A (byte, cleared) $C81F: display flag B (byte, cleared) $C820: display flag C (byte, cleared) $C8BE: scene counter (word, cleared) $C310: scene target param (byte, copied from $C81A)
*Source: [scene_init.asm](disasm/modules/68k/game/scene/scene_init.asm)*

---

### Game Mode and Track Configuration ($00D19C–$00D1D4, 56 bytes)

Source: code_c200 Configures the game mode and track selection variables used by the entire game engine. Pre-computes scaled index values (×1, ×2, ×4) for each parameter to enable efficient ROM table lookups throughout the codebase. The multiplied values serve as pre-computed offsets: ×1: byte/word index ×2: word-array index ×4: long/pointer-array index Also sets a multiplayer flag ($C826) to 1 if the game mode is 2 or 3 (2-player modes), or 0 for single-player modes (0 and 1). INDEX VARIABLES (used by fn_c200_044, 045, 046, 048, 050, etc.) $FFFFC89C  Game mode (word: 0-3) $FFFFC89E  Game mode × 2 (word: 0-6) $FFFFC8A0  Game mode × 4 (word: 0-12) $FFFFC8C8  Track number (word: 0-N) $FFFFC8CA  Track × 2 (word) $FFFFC8CC  Track × 4 (word) $FFFFC826  Multiplayer flag (byte: 0=single, 1=multi)

- **Entry**: D0 = game mode (0-3) D1 = track number
- **Returns**: All index variables configured
- **Modifies**: D0, D1, D2
*Source: [game_mode_track_config.asm](disasm/modules/68k/game/scene/game_mode_track_config.asm)*

---

### sh2_object_and_sprite_update_orch ($00DCD0–$00DE98, 456 bytes)

SH2 Object and Sprite Update Orchestrator Per-frame SH2 communication orchestrator. Sends DMA transfer, runs object_update + sprite_update, then transfers 3D geometry and sprite data via sh2_send_cmd. Computes text overlay addresses from palette index with bit-shift multiplication. Renders text overlays via text_render. Sends final sh2_cmd_27 for tile updates. Handles exit via button detection with fade-out transition ($A8 sound).

- **Modifies**: D0, D1, D2, D3, D4, A0, A1, A2
- **Calls**: $00B684 (object_update), $00B6DA (sprite_update), $00E35A (sh2_send_cmd), $00E3B4 (sh2_cmd_27), $00E466 (text_render), $00E52C (dma_transfer)
- **Confidence**: high
*Source: [sh2_object_and_sprite_update_orch.asm](disasm/modules/68k/game/scene/sh2_object_and_sprite_update_orch.asm)*

---

### sh2_dual_screen_object_update_orch ($00DE98–$00DFEC, 340 bytes)

SH2 Dual-Screen Object Update Orchestrator Data prefix (54 bytes: display command tables for single/dual screen configurations). Per-frame SH2 update for dual-screen mode. Sends DMA transfer, runs object/sprite update, transfers geometry and sprite data via multiple sh2_send_cmd calls. Includes internal subroutine call at $00E118. Handles exit with dual-player button detection and fade-out transition ($A8 sound).

- **Modifies**: D0, D1, D2, D3, A0, A1, A2, A5
- **Calls**: $00B684 (object_update), $00B6DA (sprite_update), $00E35A (sh2_send_cmd), $00E52C (dma_transfer)
- **Confidence**: high
*Source: [sh2_dual_screen_object_update_orch.asm](disasm/modules/68k/game/scene/sh2_dual_screen_object_update_orch.asm)*

---

### SH2 Handshake and State Advance ($00DFEC–$00E00C, 32 bytes)

Source: code_c200 Performs a synchronization handshake with the SH2 via 32X communication registers, then advances the state machine. If the status byte at $A018 is already set, skips the handshake and just advances state. Handshake protocol: 1. Write config value $F3 to $C822 (sound/display config) 2. Busy-wait on COMM0 high byte ($A15120) until cleared by SH2 3. Clear COMM1 low byte ($A15123) to acknowledge MEMORY VARIABLES $FFFFA018     Status byte (tested; if non-zero, skip handshake) $FFFFC822     Configuration value (byte, set to $F3) $00A15120     32X COMM0 register high byte (polled until zero) $00A15123     32X COMM1 register low byte (cleared after handshake) $FFFFC87E     State machine counter (word, advanced by 4)

- **Entry**: No register inputs
- **Returns**: State advanced; SH2 handshake completed if needed
- **Modifies**: (none modified beyond RAM/register writes)
*Source: [sh2_handshake_state_advance.asm](disasm/modules/68k/game/scene/sh2_handshake_state_advance.asm)*

---

### Scene Setup / Game Mode Transition ($00E00C–$00E117, 268 bytes)

Source: code_c200 Configures the game's scene handler function pointer ($FF0002) based on the current game sub-mode ($A024) and related flags. This is the central dispatch that selects which scene loop runs during gameplay. Also copies track selection parameters to per-mode RAM slots ($FEA5-$FEAC) and configures display control bits ($C80E) for split-screen modes. GAME SUB-MODES ($A024) 0 = Default (single player / standard) 1 = Mode 1 (split-screen player 1 primary) 2 = Mode 2 (split-screen player 2 primary) SCENE HANDLERS SET (at $FF0002) The scene handler is called each frame by the main loop. Mode 0 (default):      $0088E5CE Mode 0 + mirror flag:  $0088E5E6  (bit 7 of $FDA8 set) Mode 1:                $0088E5FE Mode 2:                $0088F13C If not in demo mode ($A018 == 0), also sets a loading/init handler: Mode 0 (default):  $00884A3E Mode 1:            $00885100  (+ display bit 5 set, bit 4 clear) Mode 2:            $00884D98  (+ display bit 4 set, bit 5 clear) Fallback:          $00884D98 MEMORY VARIABLES $FFFFA018  Player 1 data pointer (non-zero = demo/replay mode) $FFFFA019  Player 1 track selection (byte, 0-4) $FFFFA024  Game sub-mode (byte: 0, 1, or 2) $FFFFA025  Saved P1 selection (byte, persisted across calls) $FFFFA026  Saved P2 selection (byte, persisted across calls) $FFFFA027  Two-player flag (byte: 0=first call, non-zero=update) $FFFFC80E  Display control flags (bits 4,5 = split-screen config) $FFFFC87E  Game state (word, cleared to 0 by this function) $FFFFFDA8  Mode flags (bit 7 = mirror/alternate track flag) $FFFFFEA5  Track param: mode 0, primary slot $FFFFFEA6  Track param: mode 0, mirror slot $FFFFFEA7  Track param: mode 1, P1 slot $FFFFFEA8  Track param: mode 1, P2 slot $FFFFFEAB  Track param: mode 2, P1 slot $FFFFFEAC  Track param: mode 2, P2 slot $00FF0002  Scene handler function pointer (long)

- **Entry**: No register inputs (reads state from RAM)
- **Returns**: $FF0002 set to appropriate scene handler
- **Modifies**: No registers modified (all operands are memory-to-memory)
*Source: [scene_setup_game_mode_transition.asm](disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm)*

---

### sh2_scene_object_update_with_lookup_tables ($00ECBE–$00EEF2, 564 bytes)

SH2 Scene Object Update with Lookup Tables Data prefix (~280 bytes: sine/cosine lookup tables for animation interpolation, palette color tables, and command parameters). Code section sends SH2 tile and geometry commands, calls object_update + sprite_update. Handles exit transition with palette save and fade-out ($A8 sound). Supports single-screen and split-screen palette configurations.

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7
- **Calls**: $00B684 (object_update), $00B6DA (sprite_update), $00E35A (sh2_send_cmd), $00E52C (dma_transfer)
- **Confidence**: high
*Source: [sh2_scene_object_update_with_lookup_tables.asm](disasm/modules/68k/game/scene/sh2_scene_object_update_with_lookup_tables.asm)*

---

### scene_state_disp_with_color_tables ($00F39C–$00F44C, 176 bytes)

Scene State Dispatcher with Color Tables Data prefix (~128 bytes: palette/color tables and scene configuration parameters). Scene state dispatcher via jump table at $00F42C. Calls $00882080 for scene setup, dispatches to 3 scene states. Calls object_update and advances state counter when fade-in completes (bit 6 of $C8B2 clear).

- **Modifies**: D0, D1, D5, D6, A1, A2, A3, A4
- **Calls**: $00B684 (object_update)
- **Confidence**: high
*Source: [scene_state_disp_with_color_tables.asm](disasm/modules/68k/game/scene/scene_state_disp_with_color_tables.asm)*

---

### sh2_multi_panel_object_update_orch ($00F682–$00F838, 438 bytes)

SH2 Multi-Panel Object Update Orchestrator Data prefix (~96 bytes: SH2 command tables for single/dual-screen tile transfer configurations). Per-frame update: sends SH2 commands from table, calls internal renderer at $00F916, sends additional tile blocks, performs palette switch via $00F88C. Calls object/ sprite update. Handles dual-player exit with palette save per-panel and fade-out transition. Calls $00FB36 during fade states.

- **Modifies**: D0, D1, D2, D3, D6, A0, A1, A2
- **Calls**: $00B684 (object_update), $00B6DA (sprite_update), $00E35A (sh2_send_cmd), $00F88C (palette_switch)
- **Confidence**: high
*Source: [sh2_multi_panel_object_update_orch.asm](disasm/modules/68k/game/scene/sh2_multi_panel_object_update_orch.asm)*

---

### SH2 Comm Reset and Mode Set ($0105DE–$010606, 40 bytes)

Waits for SH2 to become idle (COMM0 high byte = 0), clears COMM1, resets game state to 0, sets display mode $0020, and writes the SH2 entry point address to the adapter jump vector.

- **Entry**: none | Exit: SH2 idle, game state reset, mode configured
- **Modifies**: none (beyond RAM/register writes)
- **RAM**: $FFFFC87E = main game state index (word, cleared to 0) $00A15120 = COMM0 high byte (polled until zero) $00A15123 = COMM1 low byte (cleared) $00FF0008 = display mode register (word, set to $0020) $00FF0002 = SH2 entry point vector (long, set to $008909AE)
*Source: [sh2_comm_reset_mode_set.asm](disasm/modules/68k/game/scene/sh2_comm_reset_mode_set.asm)*

---

### SH2 Scene Reset ($011862–$01188A, 40 bytes)

Set Handler $88D4A4 Waits for SH2 idle (COMM0 clear), then resets game state and configures a new SH2 scene handler at $0088D4A4 with display mode $0020.

- **Entry**: none | Exit: SH2 reconfigured | Uses: none
- **RAM**: $FFFFC87E = main game state (word, cleared to 0) $00FF0002 = SH2 scene handler pointer (long, set) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sh2_scene_reset_set_handler_88d4a4.asm](disasm/modules/68k/game/scene/sh2_scene_reset_set_handler_88d4a4.asm)*

---

### Sprite Buffer Clear + SH2 Scene Reset ($01188A–$0118D4, 74 bytes)

Clears the 512-byte sprite data buffer at $FF6E00, triggers a sprite update via JSR to sprite_update ($00B6DA), then conditionally resets the SH2 scene handler. If bit 7 of sync flags ($C80E) is set, the SH2 reset is skipped (scene transition already in progress).

- **Entry**: none | Exit: sprites cleared, SH2 optionally reset
- **Modifies**: D0, A0
- **RAM**: $00FF6E00 = sprite data buffer (512 bytes, cleared) $FFFFC821 = sprite update flag (byte, set to 1) $FFFFC80E = sync/transition flags (byte, bit 7 tested) $FFFFC87E = main game state (word, conditionally cleared) $00FF0002 = SH2 scene handler pointer (long, set to $0088D4B8) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sprite_buffer_clear_sh2_scene_reset.asm](disasm/modules/68k/game/scene/sprite_buffer_clear_sh2_scene_reset.asm)*

---

### sh2_command_sender ($011A70–$011B08, 152 bytes)

SH2 Command Sender (Multi-Parameter) Sends multiple parameters to the SH2 via COMM registers using a handshake protocol. After the data prefix, sends: 1. A1 pointer via COMM4 (with command $20) 2. D0 (COMM4) + D1 (COMM5) word pair 3. D2 via COMM4 4. A0 pointer via COMM4 Each send waits for COMM6 acknowledgment from SH2. 40 bytes of structured parameter blocks.

- **Entry**: D0, D1, D2 = parameter words; A0, A1 = parameter pointers
- **Modifies**: D0, D1, D2, A0, A1 32X registers: COMM0_HI, COMM0_LO, COMM4, COMM5, COMM6
*Source: [sh2_command_sender.asm](disasm/modules/68k/game/scene/sh2_command_sender.asm)*

---

### SH2 Scene Reset ($01250C–$012534, 40 bytes)

Set Handler $8926D2 Waits for SH2 idle (COMM0 clear), then resets game state and configures a new SH2 scene handler at $008926D2 with display mode $0020.

- **Entry**: none | Exit: SH2 reconfigured | Uses: none
- **RAM**: $FFFFC87E = main game state (word, cleared to 0) $00FF0002 = SH2 scene handler pointer (long, set) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sh2_scene_reset_set_handler_8926d2.asm](disasm/modules/68k/game/scene/sh2_scene_reset_set_handler_8926d2.asm)*

---

### Scene State Dispatcher with Track Data Tables ($0129E0–$012A72, 146 bytes)

Contains three 16-word track-specific data tables followed by a scene state dispatcher. The dispatcher calls sound_command_dispatch_sound_driver_call for setup, then jumps to a handler based on the game state index at $C87E. A separate entry point handles post-dispatch completion: updates objects, checks display bit 6, and advances the state machine. DATA TABLES 3 tables x 16 words each (96 bytes total) $7FFF / $FFFF used as sentinel values for unused entries MEMORY VARIABLES $FFFFC87E  Game state index (word, used as jump table offset) $FFFFC80E  Display control flags (bit 6 tested)

- **Entry**: scene_state_disp_track_data_tables → data tables (not executed directly) fn_12200_023_dispatch → scene state dispatcher fn_12200_023_complete → post-dispatch completion check
- **Modifies**: D0, A1
- **Calls**: sound_command_dispatch_sound_driver_call: scene setup object_update: object system update Jump table targets: State 0:  camera_demo_palette_sh2_setup State 4:  fn_12200_025_exec (mid-function DMA entry) State 8:  camera_selection_main_loop State 12: sh2_mode_disp_select_scene_by_track_mode
*Source: [scene_state_disp_track_data_tables.asm](disasm/modules/68k/game/scene/scene_state_disp_track_data_tables.asm)*

---

### SH2 Scene Reset ($013824–$013864, 64 bytes)

Conditional Handler by Player 2 Flag Waits for SH2 idle, copies the player 2 active flag ($A01A) to a local variable ($FDB9), then selects the SH2 scene handler based on whether the player 1 data pointer high byte ($A018) is set. Default handler: $00893864; override if $A018 == 0: $008926D2.

- **Entry**: none | Exit: SH2 scene configured | Uses: D0
- **RAM**: $FFFFA01A = player 2 active flag (word, read) $FFFFFDA9 = P2 flag backup (byte, written) $FFFFA018 = player 1 data pointer high byte (byte, tested) $FFFFC87E = main game state (word, cleared to 0) $00FF0002 = SH2 scene handler pointer (long, set) $00FF0008 = display mode / frame delay (word, set to $0020)
*Source: [sh2_scene_reset_cond_handler_by_player_2_flag.asm](disasm/modules/68k/game/scene/sh2_scene_reset_cond_handler_by_player_2_flag.asm)*

---

### Conditional SH2 Scene Reset ($014540–$014566, 38 bytes)

Tests player data word ($A008). If non-zero, returns immediately. Otherwise resets: sets display mode $0020, clears timeline counter ($C080), sets SH2 scene handler to $008853B0, and jumps to SH2 comm init at $00882890.

- **Entry**: none | Exit: scene reset or early return | Uses: none
- **RAM**: $FFFFA008 = player data word (tested, non-zero → early return) $00FF0008 = SH2 display mode/frame delay (word, set to $0020) $FFFFC080 = timeline counter (byte, cleared) $00FF0002 = SH2 scene handler pointer (long, set to $008853B0)
*Source: [conditional_sh2_scene_reset.asm](disasm/modules/68k/game/scene/conditional_sh2_scene_reset.asm)*

---

### SH2 Call with Interrupt Mask ($014696–$0146B4, 30 bytes)

Sets VDP update flag ($C80D), saves all registers, raises interrupt priority mask to level 7 (disable all), calls SH2 routine at $0088D1D4, restores mask to level 3, and restores registers.

- **Entry**: none | Exit: SH2 routine called | Uses: all (saved/restored)
- **RAM**: $FFFFC80D = VDP update flag (byte, set to $01)
*Source: [sh2_call_interrupt_mask.asm](disasm/modules/68k/game/scene/sh2_call_interrupt_mask.asm)*

---

## Game / Sound

### sequence_data_byte_decoder ($00B15E–$00B1B8, 90 bytes)

Sequence Data Byte Decoder Decodes 3 bytes from sequence stream (A2) into display/sound format. Uses lookup tables at $00899884 and $0089980C to translate encoded byte values. Splits decoded bytes into high/low nibbles and writes to output buffer (A1). Shared subroutine at .loc_004C handles the nibble split.

- **Entry**: D3 = output offset, A1 = output buffer, A2 = source stream
- **Modifies**: D0, D1, D3, A0, A1, A2
- **Confidence**: high
*Source: [sequence_data_byte_decoder.asm](disasm/modules/68k/game/sound/sequence_data_byte_decoder.asm)*

---

### sequence_data_word_decoder ($00B3CE–$00B40E, 64 bytes)

Sequence Data Word Decoder Decodes 3 bytes from sequence stream (A1) into word-sized output (A2). Same lookup tables as sequence_data_byte_decoder ($00899884 and $0089980C). Reads encoded bytes, translates via table, writes decoded words to output. Third byte produces a full word instead of split nibbles.

- **Entry**: A1 = source stream, A2 = output buffer
- **Modifies**: D0, A1, A2, A3
- **Confidence**: high
*Source: [sequence_data_word_decoder.asm](disasm/modules/68k/game/sound/sequence_data_word_decoder.asm)*

---

### sound_buffer_copy_with_decode ($00B40E–$00B422, 20 bytes)

Sound Buffer Copy with Decode Loads decode buffer A3 from $FF68D8, calls shared decoder at $00B43C, then copies 8 bytes from decode buffer to sound output at $FF6958.

- **Modifies**: A1, A3
- **Confidence**: high
*Source: [sound_buffer_copy_with_decode.asm](disasm/modules/68k/game/sound/sound_buffer_copy_with_decode.asm)*

---

### sound_buffer_copy_with_offset ($00B422–$00B43C, 26 bytes)

Sound Buffer Copy with Offset Variant of sound_buffer_copy_with_decode with D3-based offset into decode buffer $FF68D8. Scales D3 by 4 to select entry, calls shared decoder at $00B43C, copies 8 bytes to sound output at $FF6958.

- **Entry**: D3 = buffer entry index
- **Modifies**: D3, A1, A3
- **Confidence**: high
*Source: [sound_buffer_copy_with_offset.asm](disasm/modules/68k/game/sound/sound_buffer_copy_with_offset.asm)*

---

### FM Channel Timer Check ($03021A–$03023A, 32 bytes)

decrement timer and reinit on expiry Checks FM sound channel timer at A5+$12. If zero, returns (branches to caller's RTS). Decrements timer; if not yet zero, returns. On expiry (timer reaches 0): sets bit 1 flag at (A5), checks channel sign at A5+$01. If positive, calls fm_init_channel to restart the channel and pops return address (skips caller's remaining code).

- **Entry**: A5 = FM channel structure pointer (+$01=sign, +$12=timer)
- **Modifies**: A5, A7 (stack pop)
- **Calls**: $030C8A: fm_init_channel
- **Confidence**: medium
*Source: [fm_channel_timer_check.asm](disasm/modules/68k/game/sound/fm_channel_timer_check.asm)*

---

### FM Set Volume Wrapper ($03023A–$030242, 8 bytes)

call fm_set_volume and skip caller Calls fm_set_volume subroutine, then pops return address from stack (ADDQ.W #4,A7), causing the caller's remaining code to be skipped. This is a tail-call optimization pattern used by the sound driver.

- **Calls**: $030FB2: fm_set_volume
- **Confidence**: medium
*Source: [fm_set_volume_wrapper.asm](disasm/modules/68k/game/sound/fm_set_volume_wrapper.asm)*

---

### FM Sequence Process Orchestrator ($03029E–$0302EE, 80 bytes)

check channel and write frequency Checks FM channel status (A5+$0A active, bit 1 not muted, bit 2 not key-off). If active, calls fm_sequence_process to read next frequency value into D6. Special handling for channel type $02 (A5+$01) when A6+$0F is set — branches to panning write at $03038E. Otherwise requests Z80 bus, writes frequency high byte to register $A4 and low byte to register $A0 via fm_write_conditional.

- **Entry**: A5 = FM channel structure pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D6, A0, A4, A5, A6
- **Calls**: $0302EE: fm_sequence_process $030CCC: fm_write_conditional $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_sequence_process_orch.asm](disasm/modules/68k/game/sound/fm_sequence_process_orch.asm)*

---

### FM Sequence Data Reader ($0302EE–$030354, 102 bytes)

read note/frequency from sequence table Reads FM sequence data from ROM tables. Looks up sequence pointer from table at $032936 using channel instrument (A5+$0A), advances position counter (A5+$26). Positive bytes are multiplied by channel multiplier (A5+$03) for pitch scaling. Special command bytes: $80=restart, $81=rewind 2, $82=set position, $83=reinit channel, $84=add to multiplier. Output frequency in D6, combined from sequence value + base frequency (A5+$1E) + transpose offset (A5+$10).

- **Entry**: A5 = FM channel structure pointer
- **Modifies**: D0, D6, A0, A5
- **Confidence**: medium
*Source: [fm_sequence_data_reader.asm](disasm/modules/68k/game/sound/fm_sequence_data_reader.asm)*

---

### Stack Pop Return ($030354–$030358, 4 bytes)

skip caller's remaining code Pops return address from stack (ADDQ.W #4,A7), then returns. This causes execution to skip the caller's remaining code and return to the grandparent. Used by the sound driver as a tail-call abort.

- **Confidence**: high
*Source: [stack_pop_return.asm](disasm/modules/68k/game/sound/stack_pop_return.asm)*

---

### FM Sequence Command Handler ($030358–$0303CC, 116 bytes)

process special sequence bytes Multiple entry points for FM sequence special commands, jumped to from fm_sequence_data_reader (fm_sequence_data_reader): $030358: Reset sequence position (CLR.B A5+$26), resume reading $03035E: Rewind 2 positions (SUBQ.B #2 A5+$26), resume reading $030364: Reinit channel — calls fm_init_channel or fm_set_volume $030376: Set position from next data byte $03037E: Add next data byte to channel multiplier (A5+$03) $03038E: Operator/panning write — iterates 4 register pairs from table $0303CC, writes D6 frequency values via fm_write_port0

- **Entry**: A5 = FM channel structure pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D5, D6, A0, A1, A2
- **Calls**: $030CD8: fm_write_port0 $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_sequence_command_handler.asm](disasm/modules/68k/game/sound/fm_sequence_command_handler.asm)*

---

### FM Register Table + State Dispatcher ($0303CC–$0303E8, 28 bytes)

panning register data and dispatch 8 FM register bytes used by fm_sequence_command_handler's operator write loop ($AD,$A9,$AC,$A8,$AE,$AA,$A6,$A2 — frequency/operator registers). Code: Checks bit 1 (mute flag) on channel (A5). If not muted, dispatches to state handler via indexed JMP using state index A5+$28.

- **Entry**: A5 = FM channel structure pointer
- **Modifies**: D0, A5
- **Confidence**: medium
*Source: [fm_reg_table_state_disp.asm](disasm/modules/68k/game/sound/fm_reg_table_state_disp.asm)*

---

### FM State Dispatcher B ($0303E8–$030402, 26 bytes)

3-state indexed jump for panning Jump table prefix: 3 BRA.S instructions dispatching to fm_panning_envelope_proc entry points ($030412, $030408, $030408). Code: Checks bit 1 mute flag on channel (A5). If not muted, dispatches via indexed JMP using A5+$28.

- **Entry**: A5 = FM channel structure pointer
- **Modifies**: D0, A5
- **Confidence**: medium
*Source: [fm_state_disp_b.asm](disasm/modules/68k/game/sound/fm_state_disp_b.asm)*

---

### FM Panning Envelope Processor ($030404–$03046C, 104 bytes)

step through panning envelope data Processes FM panning envelope: reads envelope position (A5+$21) against envelope length (A5+$22), advances through repeat cycles (A5+$23/$24). Looks up envelope data table via ROM pointer at fm_panning_init_channel_stereo_setup's table, indexed by instrument number (A5+$20). Combines envelope value with channel flags (A5+$27 AND $37) using OR, writes to panning register $B4 via fm_conditional_write.

- **Entry**: A5 = FM channel structure pointer
- **Modifies**: D0, D1, D3, A0, A5
- **Calls**: $030CA2: fm_conditional_write
- **Confidence**: medium
*Source: [fm_panning_envelope_proc.asm](disasm/modules/68k/game/sound/fm_panning_envelope_proc.asm)*

---

### FM Panning Init + Channel Stereo Setup ($03046C–$030536, 202 bytes)

initialize panning for all channels 4 longword pointers to panning envelope tables (used by fm_panning_envelope_proc). Code begins at $030480 with two paths: Positive: Writes panning register $B4 with D1=0 (center) for 3 FM channels via fm_write_port0, then writes key-on register $28 for each, branches to $030FC8. Negative: Iterates all sound channels in A6 structure ($0040 stride for 7 channels, $0220 offset for 3 more, $0340 for 1), reads each channel's panning value (A5+$27), writes to register $B4 via fm_write_conditional. Releases Z80 bus when done.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D0, D1, D2, D3, D4, A5, A6
- **Calls**: $030CCC: fm_write_conditional $030CD8: fm_write_port0 $030D1C: z80_bus_request
- **Confidence**: medium
*Source: [fm_panning_init_channel_stereo_setup.asm](disasm/modules/68k/game/sound/fm_panning_init_channel_stereo_setup.asm)*

---

### FM Sound Priority Check ($030536–$03056A, 52 bytes)

compare and accept higher-priority commands Reads new sound command from A6+$0A, looks up its priority in table at $032B30 (128 entries, indexed by command-$81). Compares with current priority level (A6+$00). If new command has equal or higher priority, accepts it: updates priority, stores command byte to A6+$09. Otherwise discards the new command and keeps current state.

- **Entry**: A6 = sound channel state (+$00=priority, +$09=cmd, +$0A=new_cmd)
- **Modifies**: D0, D1, D2, D3, A0, A1, A6
- **Confidence**: medium
*Source: [fm_sound_priority_check.asm](disasm/modules/68k/game/sound/fm_sound_priority_check.asm)*

---

### FM Sound Command Dispatcher ($03056A–$0305BA, 80 bytes)

route command byte to handler Reads sound command byte from A6+$09, dispatches to appropriate handler based on value range. Clears command after reading ($80 = sentinel). Command ranges: $80      = stop/silence -> $030BF6 $81-$9F  = note-on -> $030B90 $A0-$D2  = instrument select -> $03061C $D6-$D7  = special effect -> $030892 $F0-$FE  = system commands -> $030604 Others   = ignored (RTS)

- **Entry**: A6 = sound channel state (+$09=command byte)
- **Modifies**: D2, D6, D7, A0, A6
- **Confidence**: medium
*Source: [fm_sound_command_disp.asm](disasm/modules/68k/game/sound/fm_sound_command_disp.asm)*

---

### FM System Command Dispatcher ($0305BA–$03061C, 98 bytes)

route $F0-$FE system commands Dispatches system commands ($F0-$FE) via 16-entry jump table. First 3 entries route to specific handlers ($030A5C, $03094E, $0309F2); remaining 13 entries all route to silence handler ($030B90). At $030604: special effect handler subtracts $D7, requests Z80 bus, writes raw byte to Z80 RAM ($A00FFE), releases bus.

- **Entry**: D7 = command byte ($F0-$FE range)
- **Modifies**: D7
- **Calls**: $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_system_command_disp.asm](disasm/modules/68k/game/sound/fm_system_command_disp.asm)*

---

### FM Instrument Setup ($03061C–$03078C, 368 bytes)

load instrument data and configure channels Loads instrument definition from ROM table at $032AB8 (indexed by D7-$81). Instrument header: +$00=seq offset, +$02=FM count, +$03=PSG count, +$04=tempo, +$05=multiplier. Sets up FM channels ($0040+N*$30 in A6) with sequence pointers, register assignments from table at $03078C, panning ($C0), and initial frequency. Then sets up PSG channels ($0190+). Iterates existing effect channels ($0220, 6 entries) to set key-off flags. Finally calls fm_init_channel for FM and fm_set_volume for PSG channels not marked key-off. Silences unused PSG noise channel. Pops return addr.

- **Entry**: A6 = sound driver state pointer; D7 = sound command byte ($81-$9F)
- **Modifies**: D0, D1, D4, D5, D6, D7, A0, A1, A2, A3, A4, A5
- **Calls**: $030C8A: fm_init_channel $030CBA: fm_write_wrapper $030D1C: z80_bus_request $030FB2: fm_set_volume
- **Confidence**: high
*Source: [fm_instrument_setup.asm](disasm/modules/68k/game/sound/fm_instrument_setup.asm)*

---

### FM Channel Register Map + Instrument Loader B ($03078C–$030852, 198 bytes)

$A0-$D2 commands FM/PSG register assignment bytes used by fm_instrument_setup. Code at $030798: Loads instrument from ROM table $008B9150 (indexed by D7-$A0). Iterates channels, clears $30-byte channel structs, copies instrument data (type, sequence pointer, initial freq, panning). PSG channels ($C0 type) get special handling: writes PSG silence via $C00011 with noise register toggle (bit 5). Each channel's struct pointer is resolved via table at $030852. Sets key-off flags for special channel pairs ($0250→$0340, $0310→$0370).

- **Entry**: A6 = sound driver state pointer; D7 = sound command byte ($A0-$D2)
- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A5
- **Confidence**: medium
*Source: [fm_channel_reg_map_instrument_loader_b.asm](disasm/modules/68k/game/sound/fm_channel_reg_map_instrument_loader_b.asm)*

---

### FM Channel Pointer Table + SFX Loader ($030852–$030936, 228 bytes)

$D6-$D7 sound effects 16 longword pointers to channel structs within A6 sound driver state (used by fm_instrument_setup, fm_channel_reg_map_instrument_loader_b, fm_channel_stop_reg_map_stop_all). Code at $030892: Loads SFX instrument from ROM table $008B921C (indexed by D7-$D6). Sets up channels similarly to fm_channel_reg_map_instrument_loader_b but targets special effect channels ($0340/$0370). Handles PSG noise channels with direct PSG register writes ($C00011). Sets key-off flags for paired channels ($0250→$0340, $0310→$0370).

- **Entry**: A6 = sound driver state pointer; D7 = sound command byte ($D6-$D7)
- **Modifies**: D0, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A5
- **Confidence**: medium
*Source: [fm_channel_pointer_table_sfx_loader.asm](disasm/modules/68k/game/sound/fm_channel_pointer_table_sfx_loader.asm)*

---

### FM Channel Stop Register Map + Stop All ($030936–$0309F2, 188 bytes)

silence all active channels channel struct pointer table (used alongside $030852 table). Code at $03094E: Clears sound priority (A6+$00), writes key-off all (reg $27, data $00) via fm_write_wrapper. Iterates 6 effect channels at A6+$0220 ($30-byte stride). For each active channel: FM (positive type): calls fm_init_channel, resolves channel struct via $030852 table, clears key-off and sets mute flag, calls $0312E8. PSG (negative type): calls fm_set_volume, resolves channel struct, clears/mutes. $E0 type writes PSG silence byte from +$25.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, D6, A0, A1, A3, A5
- **Calls**: $030C8A: fm_init_channel $030CBA: fm_write_wrapper $030FB2: fm_set_volume
- **Confidence**: high
*Source: [fm_channel_stop_reg_map_stop_all.asm](disasm/modules/68k/game/sound/fm_channel_stop_reg_map_stop_all.asm)*

---

### FM Special Channel Cleanup ($0309F2–$030A5C, 106 bytes)

stop DAC and noise effect channels Handles cleanup of two special sound channels: Channel $0340 (DAC/PCM): clears active flag, checks key-off, calls $030C96 cleanup, maps to struct at $0100, clears/mutes, calls $0312E8 with instrument data from A6+$0030 pointer. Channel $0370 (noise): clears active flag, checks key-off, calls $030FB8 cleanup, maps to struct at $01F0, clears/mutes. If type is $E0, writes PSG silence byte from channel +$25.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D0, A1, A5, A6
- **Confidence**: medium
*Source: [fm_special_channel_cleanup.asm](disasm/modules/68k/game/sound/fm_special_channel_cleanup.asm)*

---

### FM Full Silence ($030A5C–$030A72, 22 bytes)

stop all channels and reset tempo Calls channel stop ($03094E) to silence all FM/PSG channels, then calls special channel cleanup ($0309F2) for DAC/noise channels. Resets sound driver tempo: A6+$06=1 (tick rate), A6+$04=5 (frame divider).

- **Entry**: A6 = sound driver state pointer
- **Modifies**: A6
- **Confidence**: high
*Source: [fm_full_silence.asm](disasm/modules/68k/game/sound/fm_full_silence.asm)*

---

### FM Envelope Tick Update ($030A86–$030AF8, 114 bytes)

advance all channel envelopes per frame Decrements frame counter (A6+$04); if zero, branches to silence handler ($030B90). Sets tempo=1 (A6+$06). Iterates all channel types: DAC ($0040): advances envelope +$09 by 4, overflow→silence, else calls z80_dac_write ($030DF4). FM ($0070, 6 channels): advances +$09 by 1, overflow→silence, else calls $03135A. PSG ($0220+, 3 channels): advances +$09 by 1, limit=$10→silence, else calls $030F60 with position in D6.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D6, D7, A5, A6
- **Calls**: $030DF4: z80_dac_write $03135A: [fm_envelope_write] $030F60: [psg_envelope_write]
- **Confidence**: medium
*Source: [fm_envelope_tick_update.asm](disasm/modules/68k/game/sound/fm_envelope_tick_update.asm)*

---

### FM Total Level Reset ($030B1C–$030B50, 52 bytes)

set all operator volumes to maximum attenuation Requests Z80 bus, then writes all FM Total Level registers ($40-$53) with $7F (maximum attenuation = silence) via fm_write_conditional. Then writes all Sustain/Release registers ($80-$93) with $0F (fastest release rate). Covers 4 operators across all FM channels. Releases bus.

- **Modifies**: D0, D1, D3, D4
- **Calls**: $030CCC: fm_write_conditional $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_total_level_reset.asm](disasm/modules/68k/game/sound/fm_total_level_reset.asm)*

---

### FM Key-Off + Volume Zero ($030B50–$030B90, 64 bytes)

key-off all channels and zero volumes Requests Z80 bus, writes key-off (register $28) for all 6 FM channels (0-2 and 4-6). Then writes Total Level = $7F (silence) to all TL registers ($40-$53) using fm_write_port0 with $030CFE helper for register auto-increment. 3 groups of 4 operators each. Releases bus.

- **Modifies**: D0, D1, D2, D3
- **Calls**: $030CD8: fm_write_port0 $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_key_off_volume_zero.asm](disasm/modules/68k/game/sound/fm_key_off_volume_zero.asm)*

---

### FM Sound Driver Reset ($030B90–$030BE0, 80 bytes)

full/partial silence and state clear Two entry points: $030B90 (full reset): Writes DAC enable ($2B=$80), key-off all ($27=$00), clears entire driver state ($E4 longs = $390 bytes), sets command sentinel $80, calls key-off+volume zero ($030B50), branches to $030FC8. $030BBC (partial reset): Writes key-off all ($27=$00), clears $88 longs ($220 bytes, preserves priority at A6+$00), sets command sentinel $80.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D0, D1, A0, A6
- **Calls**: $030CBA: fm_write_wrapper
- **Confidence**: high
*Source: [fm_sound_driver_reset.asm](disasm/modules/68k/game/sound/fm_sound_driver_reset.asm)*

---

### Z80 Sound Program Upload + FM Key-On ($030BF6–$030C8A, 148 bytes)

load driver and key-on helper Two parts: $030BF6: Requests Z80 bus, uploads sound program from $031688 to Z80 RAM ($A00000, $28D bytes), uploads DAC samples from $031915 to $A01000 ($1000 bytes). Resets Z80 (low→14 NOPs→high), releases bus, branches to silence handler ($030B90). $030C6E (fm_key_on): Checks mute (bit 1) and key-off (bit 2) flags. If neither set, writes key-on register $28 with channel number (A5+$01 OR $F0). Falls through to fm_write_wrapper.

- **Entry**: A5 = FM channel structure pointer (for key-on entry); A6 = sound driver state pointer (loaded at $FF8500 for upload)
- **Modifies**: D0, D1, A0, A1, A5, A6
- **Confidence**: high
*Source: [z80_sound_program_upload_fm_key_on.asm](disasm/modules/68k/game/sound/z80_sound_program_upload_fm_key_on.asm)*

---

### FM Init Channel ($030C8A–$030CA2, 24 bytes)

key-on with flag checks (fm_init_channel) Two entry points: $030C8A: Checks bit 4 (sustain) and bit 2 (key-off). If either set, returns without action. $030C96: Checks only bit 2 (key-off). If set, returns. If checks pass: writes key-on register $28 with channel number from A5+$01. Falls through to fm_write_wrapper ($030CBA).

- **Entry**: A5 = FM channel structure pointer (+$01=channel number)
- **Modifies**: D0, D1, A5
- **Confidence**: high
*Source: [fm_init_channel.asm](disasm/modules/68k/game/sound/fm_init_channel.asm)*

---

### FM Conditional Write with Bus ($030CA2–$030CBA, 24 bytes)

write FM register if not key-off Checks bit 2 (key-off) on channel (A5). If set, skips write. Otherwise requests Z80 bus, calls fm_write_conditional to write register D0 with data D1 (with channel offset), releases Z80 bus.

- **Entry**: A5 = FM channel structure pointer; D0 = FM register number, D1 = data value
- **Modifies**: D0, D1, A5
- **Calls**: $030CCC: fm_write_conditional $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_cond_write_with_bus.asm](disasm/modules/68k/game/sound/fm_cond_write_with_bus.asm)*

---

### FM Write Wrapper ($030CBA–$030CCC, 18 bytes)

request bus, write port 0, release (fm_write_wrapper) Convenience wrapper: requests Z80 bus, calls fm_write_port0 to write register D0 with data D1 to YM2612 port 0, releases Z80 bus.

- **Entry**: D0 = FM register number, D1 = data value
- **Calls**: $030CD8: fm_write_port0 $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_write_wrapper.asm](disasm/modules/68k/game/sound/fm_write_wrapper.asm)*

---

### FM Write Conditional ($030CCC–$030CF4, 40 bytes)

write port 0 with channel offset (fm_write_conditional) Checks bit 2 in A5+$01 (channel flags). If set, skips write entirely. Otherwise adds channel offset (A5+$01) to register number D0, then writes register D0, data D1 to YM2612 port 0 at $A04000/$A04001. Busy-waits on bit 7 (busy flag) between register select and data write.

- **Entry**: A5 = FM channel structure pointer (+$01=channel/flags); D0 = FM register number, D1 = data value
- **Modifies**: D0, D1, A0
- **Confidence**: high
*Source: [fm_write_cond.asm](disasm/modules/68k/game/sound/fm_write_cond.asm)*

---

### FM Write Port 0/1 ($030CF4–$030D1C, 40 bytes)

channel-offset write + direct port 1 write Two entry points: $030CF4 (fm_write_port0): Reads channel byte from A5+$01, clears bit 2, adds offset to register D0 via D2. Falls through to port 1. $030CFE (fm_write_port1): Writes register D0, data D1 to YM2612 port 1 at $A04002/$A04003. Busy-waits on bit 7 between writes.

- **Entry**: A5 = FM channel structure pointer (for port 0 entry); D0 = FM register number, D1 = data value
- **Modifies**: D0, D1, D2, A0
- **Confidence**: high
*Source: [fm_write_port_0_1.asm](disasm/modules/68k/game/sound/fm_write_port_0_1.asm)*

---

### FM Fade In/Out Processor ($030D4E–$030DEE, 160 bytes)

adjust all channel volumes per frame Checks fade state at A6+$38 (0=off, 2=done → skip). For active fades: adjusts envelope position (A5+$09) for all channel types using per-type fade rates stored at A6+$39 (DAC), $3A (FM), $3B (PSG): Fade out (negative $38): subtracts rate, calls write on underflow Fade in (positive $38): adds rate, silences on overflow DAC ($0040): calls z80_dac_write ($030DF4) FM ($0070, 6 channels): calls $03135A PSG ($0220+, 3 channels): limit $10, calls $030F60 After fade-in cycle completes, sets state to $02 (done).

- **Entry**: A6 = sound driver state pointer
- **Modifies**: D5, D6, D7, A5, A6
- **Confidence**: medium
*Source: [fm_fade_in_out_proc.asm](disasm/modules/68k/game/sound/fm_fade_in_out_proc.asm)*

---

### FM Fade Clear ($030DEE–$030DF4, 6 bytes)

reset fade state to off Clears fade state byte (A6+$38 = 0) to disable fade processing. Called when fade operation completes or is cancelled.

- **Entry**: A6 = sound driver state pointer
- **Modifies**: A6
- **Confidence**: high
*Source: [fm_fade_clear.asm](disasm/modules/68k/game/sound/fm_fade_clear.asm)*

---

### PSG Channel Processor ($030E20–$030ECE, 174 bytes)

tick handler with sequence parser FM/PSG register pair table at $030E20-$030E37. Code at $030E38: PSG channel tick handler. Decrements duration timer (A5+$0E). On expiry: clears bit 4, parses next sequence byte from A4: $E0+: special commands (handled by $031094) $80-$DF (negative): note-on — looks up 16-bit frequency from table at $030FE0, indexed by (byte-$81 + transpose A5+$08) $00-$7F (positive): rest/duration (handled by $0301B2) If timer not expired: calls channel timer check (fm_channel_timer_check), volume update ($030F0E), set volume (fm_set_volume_wrapper). At $030EC2: validates frequency — if $FFFF (rest), sets mute.

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: D1, D5, D6, A0, A3, A4, A5, A6
- **Confidence**: medium
*Source: [psg_channel_proc.asm](disasm/modules/68k/game/sound/psg_channel_proc.asm)*

---

### PSG Sequence Tick ($030ECE–$030F0E, 64 bytes)

read frequency and write PSG tone registers Checks channel active (A5+$0A), mute (bit 1), key-off (bit 2). Calls fm_sequence_process to get frequency value in D6. Handles $E0 channel type (maps to $C0). Splits D6: low nibble → PSG latch byte (OR with channel command D0), bits 4-9 → PSG data byte (6 bits). Writes both bytes to PSG port ($C00011).

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: D0, D1, D6, A5
- **Calls**: $0302EE: fm_sequence_process
- **Confidence**: medium
*Source: [psg_sequence_tick.asm](disasm/modules/68k/game/sound/psg_sequence_tick.asm)*

---

### PSG Volume Envelope Processor ($030F0E–$030F82, 116 bytes)

step through volume envelope data Reads envelope position (A5+$09) as base volume D6. If envelope table active (A5+$0B != 0): looks up envelope data from ROM table at $0329FA, advances position counter (A5+$0C). Special bytes: $80=loop end, $81=rewind 2, $82=set position, $83=reinit+mute. Adds envelope delta to D6, clamps to $0F max. At $030F60: writes PSG volume register — combines channel (A5+$01) with volume + $10 offset. Checks mute (bit 1), key-off (bit 2), sustain (bit 4) before writing.

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: D0, D6, A0, A5
- **Confidence**: medium
*Source: [psg_volume_envelope_proc.asm](disasm/modules/68k/game/sound/psg_volume_envelope_proc.asm)*

---

### PSG Vibrato Check ($030F82–$030F90, 14 bytes)

conditional PSG write based on vibrato state Checks vibrato enable (A5+$13). If zero, branches to PSG volume write at $030F72. If enabled, checks vibrato timer (A5+$12): if nonzero, also branches to write. Otherwise returns without update.

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: A5
- **Confidence**: medium
*Source: [psg_vibrato_check.asm](disasm/modules/68k/game/sound/psg_vibrato_check.asm)*

---

### PSG Envelope Command Handler ($030F90–$030FA2, 18 bytes)

rewind/mute for volume envelope Two entry points for special envelope command bytes: $030F90: Rewind 2 positions (SUBQ.B #2 A5+$0C), set mute flag (BSET bit 1), branch to fm_set_volume ($030FB2) for PSG silence. $030F9C: Rewind 2 positions only, return to continue reading.

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: A5
- **Confidence**: high
*Source: [psg_envelope_command_handler.asm](disasm/modules/68k/game/sound/psg_envelope_command_handler.asm)*

---

### PSG Set Position + Silence ($030FA2–$030FC8, 38 bytes)

envelope position set and PSG mute Multiple entry points: $030FA2: Set envelope position from next data byte, resume reading. $030FAA: Clear envelope position to 0, resume reading. $030FB2 (fm_set_volume / PSG silence): Checks key-off (bit 2). If not set, writes PSG max attenuation (channel | $1F) to $C00011.

- **Entry**: A5 = PSG channel structure pointer
- **Modifies**: D0, A0
- **Confidence**: high
*Source: [psg_set_pos_silence.asm](disasm/modules/68k/game/sound/psg_set_pos_silence.asm)*

---

### PSG All Silence ($030FC8–$030FE0, 24 bytes)

mute all 4 PSG channels Writes maximum attenuation to all 4 PSG channels via $C00011: $9F (ch0 vol=F), $BF (ch1 vol=F), $DF (ch2 vol=F), $FF (ch3 vol=F). Standard PSG silence pattern used during sound driver reset.

- **Modifies**: A0
- **Confidence**: high
*Source: [psg_all_silence.asm](disasm/modules/68k/game/sound/psg_all_silence.asm)*

---

### PSG Frequency Table + Special Command Dispatcher ($030FE0–$031166, 390 bytes)

data and $E0+ handler Data prefix ($030FE0-$031093): 128-entry PSG frequency lookup table (16-bit big-endian values, note $00-$7F). Used by PSG channel processor for note-on frequency lookup. Code at $031094: Special command dispatcher for sequence bytes $E0-$FF. Subtracts $E0, dispatches via 32-entry jump table to handlers for: tempo change, transpose, vibrato, portamento, volume adjust, etc. Secondary dispatcher at $03111A: sub-command router (8 entries) for Z80 DAC writes, base frequency set, pitch bend. At $031144: Pitch bend processor — reads channel index from sequence, looks up bend amount/direction from A6+$16/$18 state, applies to envelope position (A5+$09), calls $03135A to write.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, D5, D7, A0, A1, A4, A5, A6
- **Confidence**: medium
*Source: [psg_freq_table_special_command_disp.asm](disasm/modules/68k/game/sound/psg_freq_table_special_command_disp.asm)*

---

### Z80 DAC Byte Write ($031166–$03117C, 22 bytes)

write sequence byte to Z80 DAC register Reads one byte from sequence pointer (A4), requests Z80 bus, writes byte to Z80 DAC register at $A00FFE, releases Z80 bus. Used as a sequence command sub-handler for direct DAC sample control.

- **Entry**: A4 = sequence data pointer (advanced by 1)
- **Modifies**: D0, A4
- **Calls**: $030D1C: z80_bus_request
- **Confidence**: high
*Source: [z80_dac_byte_write.asm](disasm/modules/68k/game/sound/z80_dac_byte_write.asm)*

---

### Set Base Frequency ($03117C–$031188, 12 bytes)

read 16-bit frequency from sequence Reads 2 bytes from sequence pointer (A4) as big-endian 16-bit value (high byte first via LSL #8). Stores result to channel base frequency at A5+$1E. Used as a sequence command for direct frequency override.

- **Entry**: A4 = sequence data pointer (advanced by 2); A5 = channel structure pointer
- **Modifies**: D0, A4
- **Confidence**: high
*Source: [set_base_freq.asm](disasm/modules/68k/game/sound/set_base_freq.asm)*

---

### Pitch Bend Apply ($031188–$0311A8, 32 bytes)

apply portamento/bend to base frequency Reads channel index from sequence (A4), doubles for word offset. Looks up bend state from A6+$10 (direction/enable) and bend amount from A6+$12 (16-bit delta). If positive: adds delta to base frequency (A5+$1E), clears state. If zero or negative: returns without change. Used as a sequence command for portamento effects.

- **Entry**: A4 = sequence data pointer (advanced by 1); A5 = channel structure pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, A4
- **Confidence**: medium
*Source: [pitch_bend_apply.asm](disasm/modules/68k/game/sound/pitch_bend_apply.asm)*

---

### FM Set Panning ($0311B8–$0311D8, 32 bytes)

write panning register from sequence byte Reads panning value from sequence (A4). If FM channel (positive A5+$01): merges with existing panning (A5+$27 AND $37, OR new value), stores result, writes register $B4 via fm_conditional_write ($030CA2). If PSG channel (negative): returns without action.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, D1, A4
- **Confidence**: high
*Source: [fm_set_panning.asm](disasm/modules/68k/game/sound/fm_set_panning.asm)*

---

### Set Channel Multiplier ($0311E2–$0311E8, 6 bytes)

read multiplier from sequence Reads one byte from sequence pointer (A4), stores to sound driver channel multiplier at A6+$03. Used for pitch scaling in sequence data.

- **Entry**: A4 = sequence pointer, A6 = sound driver state pointer
- **Modifies**: A4
- **Confidence**: high
*Source: [set_channel_multiplier.asm](disasm/modules/68k/game/sound/set_channel_multiplier.asm)*

---

### TL Reset + Panning Envelope Setup ($0311E8–$03120C, 36 bytes)

reset volumes or init envelope Two entry points: $0311E8: Calls TL reset ($030B1C) to silence all operators, then branches to $031418 for further processing. $0311F0: Sets panning state index (A5+$28) from sequence byte. If zero, returns. Otherwise reads 4 envelope parameters from sequence: instrument ($20), position ($21), length ($22), repeat ($23=$24).

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: A4
- **Confidence**: medium
*Source: [tl_reset_panning_envelope_setup.asm](disasm/modules/68k/game/sound/tl_reset_panning_envelope_setup.asm)*

---

### Write Panning + PSG Volume Adjust ($03120C–$031228, 28 bytes)

two sequence command handlers Two entry points: $03120C: Writes current panning value (A5+$27) to register $B4 via fm_conditional_write ($030CA2). $031218: Reads byte from sequence. If PSG (negative A5+$01): adds value to volume (A5+$09), skips next byte. If FM: returns.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, D1, A4
- **Confidence**: medium
*Source: [write_panning_psg_volume_adjust.asm](disasm/modules/68k/game/sound/write_panning_psg_volume_adjust.asm)*

---

### Volume Adjust + Write ($031228–$031240, 24 bytes)

add delta and route to channel writer Two entry points: $031228: Reads volume delta from sequence (A4), adds to A5+$09. If DAC channel (A6+$08 negative): calls z80_dac_write ($030DF4). Otherwise calls FM register writer ($03135A). $03123A: Sets sustain flag (bit 4 on A5) and returns.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer; A6 = sound driver state pointer
- **Modifies**: D0, A4
- **Confidence**: medium
*Source: [volume_adjust_write.asm](disasm/modules/68k/game/sound/volume_adjust_write.asm)*

---

### FM Operator Register Write ($03124A–$0312A6, 92 bytes)

load and write 4 operator values Loads instrument data from A6+$30 pointer (or A5+$20 if set). Reads control byte from sequence: bit 7 of each nibble selects which operators to write. Iterates 4 operators using register table at $031298, writes values via fm_conditional_write. Then reads feedback/algorithm byte and writes register $22 via fm_write_wrapper. Finally reads panning byte, merges with existing (A5+$27 AND $C0), writes register $B4. Data suffix at $031298: 4 FM register bytes, then 2 data bytes at $03129C (used as entry for set_instrument_number's set-tempo-and-multiplier).

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D6, A0, A1, A2, A4
- **Calls**: $030CA2: fm_conditional_write $030CBA: fm_write_wrapper
- **Confidence**: high
*Source: [fm_operator_reg_write.asm](disasm/modules/68k/game/sound/fm_operator_reg_write.asm)*

---

### Set Instrument Number ($0312A6–$0312AC, 6 bytes)

read instrument index from sequence Reads one byte from sequence pointer (A4), stores to sound driver instrument number at A6+$0A. Used to switch instrument mid-sequence.

- **Entry**: A4 = sequence pointer, A6 = sound driver state pointer
- **Modifies**: A4
- **Confidence**: high
*Source: [set_instrument_number.asm](disasm/modules/68k/game/sound/set_instrument_number.asm)*

---

### FM Instrument Register Write ($0312B4–$031352, 158 bytes)

full operator + TL register setup Multiple entry points: $0312B4: Write register pair (D0,D1 from seq) via fm_conditional_write. $0312BC: Write register pair via fm_write_wrapper. $0312C4: Full instrument setup. Reads instrument index, resolves data pointer from A6+$30/A5+$20/A6+$34. Writes slot register $B0 (feedback/algo), then 20 operator registers from table at $0313CA. Writes 4 TL registers with volume scaling: uses key scaling table at $031352, adds channel volume (A5+$09) to operators where carry bit is set. Finally writes panning register $B4.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, D5, A1, A2, A4
- **Calls**: $030CCC: fm_write_conditional $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_instrument_reg_write.asm](disasm/modules/68k/game/sound/fm_instrument_reg_write.asm)*

---

### FM TL Scaling Table + Volume Register Writer ($031352–$0313CA, 120 bytes)

update TL with volume 8-byte key scaling table at $031352 (operator TL scaling bits for 8 algorithm types). Code at $03135A: Updates FM Total Level registers with current volume. Checks key-off (bit 2). Resolves instrument data pointer, advances past 21 header bytes to TL data. Reads scaling table by algorithm (A5+$25), gets volume (A5+$09). For each of 4 operators: reads base TL from instrument, adds channel volume if carry bit set in scaling table, writes via fm_write_conditional. Releases Z80 bus when done.

- **Entry**: A5 = channel structure pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, D5, A1, A2
- **Calls**: $030CCC: fm_write_conditional $030D1C: z80_bus_request
- **Confidence**: high
*Source: [fm_tl_scaling_table_volume_reg_writer.asm](disasm/modules/68k/game/sound/fm_tl_scaling_table_volume_reg_writer.asm)*

---

### FM Register Table + Vibrato Setup ($0313CA–$031406, 60 bytes)

operator registers and vibrato init Data prefix ($0313CA-$0313E1): FM operator register number table (20 register bytes for DT/MUL, TL, RS/AR, DR, SR, SL/RR used by fm_instrument_reg_write's instrument write loop, plus 8 TL register bytes). Code at $0313E2: Vibrato setup sequence command. Sets high bit of A5+$0A (marks vibrato active), saves sequence pointer to A5+$14. Reads 4 vibrato parameters from sequence: initial frequency ($18), speed ($19), direction ($1A), depth ($1B, halved). Clears position ($1C).

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, A4
- **Confidence**: medium
*Source: [fm_reg_table_vibrato_setup.asm](disasm/modules/68k/game/sound/fm_reg_table_vibrato_setup.asm)*

---

### PSG Set Envelope ($031406–$031418, 18 bytes)

route by channel type and set envelope number Reads byte from sequence. If FM channel (positive A5+$01): branches to set_envelope_number ($0314F6). If PSG: stores byte to A5+$0A (envelope number), reads next sequence byte (consumed but not used here).

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, A4
- **Confidence**: medium
*Source: [psg_set_envelope.asm](disasm/modules/68k/game/sound/psg_set_envelope.asm)*

---

### FM Note-Off Handler ($031418–$0314DC, 196 bytes)

key-off channel and cleanup related channels Clears active (bit 7) and sustain (bit 4) flags. Routes by channel type: FM (positive A5+$01): calls fm_init_channel, then if multi-channel mode (A6+$0E set): resolves related channel struct via $030852 table, clears key-off/sets mute, writes instrument registers. For channel type 2: writes key-off-all ($27=$00) via fm_write_wrapper. PSG (negative): calls fm_set_volume for silence, resolves PSG channel struct ($0370 or from table), clears key-off/sets mute. $E0 type writes PSG silence byte. Pops 2 return addresses (ADDQ.W #8,A7) — exits both caller and grandparent.

- **Entry**: A5 = channel structure pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, A0, A1, A3, A5
- **Calls**: $030C8A: fm_init_channel $030CBA: fm_write_wrapper $030FB2: fm_set_volume
- **Confidence**: high
*Source: [fm_note_off_handler.asm](disasm/modules/68k/game/sound/fm_note_off_handler.asm)*

---

### Set Envelope Number ($0314F6–$0314FC, 6 bytes)

read envelope index from sequence Reads one byte from sequence pointer (A4), stores to channel envelope number at A5+$0A. Used to switch volume/frequency envelope mid-sequence.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: A4
- **Confidence**: high
*Source: [set_envelope_number.asm](disasm/modules/68k/game/sound/set_envelope_number.asm)*

---

### Set Instrument Index ($0314FC–$031502, 6 bytes)

read instrument number from sequence Reads one byte from sequence pointer (A4), stores to channel instrument index at A5+$0B. Used to switch FM instrument for TL register writes.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: A4
- **Confidence**: high
*Source: [set_instrument_index.asm](disasm/modules/68k/game/sound/set_instrument_index.asm)*

---

### Sequence Loop Counter ($03150E–$031528, 26 bytes)

decrement loop and skip on exhaust Reads loop index and initial count from sequence (A4). Manages loop counter at A5+$2A+index. If counter is zero, initializes from count. Decrements counter each call. If nonzero: branches to $031502 (continue loop body). If exhausted (zero): skips 2 bytes in sequence (past loop target address) and returns.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, D1, A4
- **Confidence**: medium
*Source: [sequence_loop_counter.asm](disasm/modules/68k/game/sound/sequence_loop_counter.asm)*

---

### Sequence Call/Return Stack ($031528–$03154E, 38 bytes)

push/pop sequence pointer Two entry points: $031528 (call): Reads stack pointer from A5+$0D, decrements by 4, pushes current A4 to stack at A5+offset. Updates stack pointer. Branches to $031502 to continue with new sequence address. $03153A (return): Reads stack pointer, pops A4 from stack, skips 2 bytes (past original call operand), increments stack pointer by 4. Stack grows downward in channel structure.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, A4
- **Confidence**: medium
*Source: [sequence_call_return_stack.asm](disasm/modules/68k/game/sound/sequence_call_return_stack.asm)*

---

### Set Channel Tempo ($03154E–$031554, 6 bytes)

read tempo byte from sequence Reads one byte from sequence pointer (A4), stores to channel tempo divider at A5+$02. Controls playback speed of the channel.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: A4
- **Confidence**: high
*Source: [set_channel_tempo.asm](disasm/modules/68k/game/sound/set_channel_tempo.asm)*

---

### FM SSG-EG Register Write ($031574–$031590, 28 bytes)

write 4 operator SSG-EG values Loads register table from $031590 (8 bytes: 4 pairs of SSG-EG register + reset register numbers). For each of 4 operators: reads value from sequence (A4), writes SSG-EG register via fm_conditional_write, then writes reset register with $1F.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer
- **Modifies**: D0, D1, D3, A1, A4
- **Calls**: $030CA2: fm_conditional_write
- **Confidence**: medium
*Source: [fm_ssg_eg_reg_write.asm](disasm/modules/68k/game/sound/fm_ssg_eg_reg_write.asm)*

---

### FM Register Table + Channel Pause ($031590–$0315F4, 100 bytes)

data and pause all active channels Data prefix ($031590-$031597): 8 FM register numbers for SSG-EG writes (used by fm_ssg_eg_reg_write). Code at $031598: Pauses all active sound channels. Reads pause mode from sequence; if zero, branches to $0315F4. Iterates DAC ($0040) then 6 FM channels ($0070, $30 stride): clears active (bit 7), sets pause flag (bit 0), writes panning $B4=$00 (mute), calls fm_init_channel. Then 3 PSG channels: same flags, calls fm_set_volume for silence. Restores A5 when done.

- **Entry**: A5 = channel structure pointer, A4 = sequence pointer; A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, A3, A5
- **Calls**: $030C8A: fm_init_channel $030CA2: fm_conditional_write $030FB2: fm_set_volume
- **Confidence**: high
*Source: [fm_reg_table_channel_pause.asm](disasm/modules/68k/game/sound/fm_reg_table_channel_pause.asm)*

---

### FM Channel Resume Panning ($0315F4–$031650, 92 bytes)

restore panning for paused channels Resumes paused channels by restoring panning registers. Iterates DAC ($0040) then 6 FM channels ($0070, $30 stride): if pause flag (bit 0) set, clears it, sets active (bit 7), writes panning register $B4 with stored value (A5+$27) via fm_conditional_write. Then 3 PSG channels: same flag swap (bit 0→bit 7) but no panning write needed. Restores A5 when done.

- **Entry**: A5 = channel structure pointer (saved/restored); A6 = sound driver state pointer
- **Modifies**: D0, D1, D3, D4, A3, A5
- **Calls**: $030CA2: fm_conditional_write
- **Confidence**: medium
*Source: [fm_channel_resume_panning.asm](disasm/modules/68k/game/sound/fm_channel_resume_panning.asm)*

---

### sequence_fade_rate_set ($031666–$031680, 26 bytes)

Sequence Fade Rate Set Sets fade rate parameters from sequence data. If channel is not already in fade state $02, writes state $01 to A6+$38 and reads two bytes from sequence pointer (A4)+ into A6+$3A (fade target) and A6+$3B (fade rate).

- **Entry**: A4 = sequence data pointer, A6 = channel struct pointer
- **Modifies**: A4, A6 Channel fields: +$38: fade state (0=idle, 1=fade active, 2=fade complete) +$3A: fade target level +$3B: fade rate
- **Confidence**: high
*Source: [sequence_fade_rate_set.asm](disasm/modules/68k/game/sound/sequence_fade_rate_set.asm)*

---

## Game / State

### system_boot_init ($0006BC–$000C5A, 1438 bytes)

System Boot Initialization Main system boot orchestrator. Performs full hardware initialization: 1. Clears 64KB work RAM ($FF0000-$FFFFFF) — 2048 iterations x 32 bytes 2. Initializes 32X adapter registers and clears all COMM channels 3. Waits for framebuffer access, clears framebuffer and CRAM 4. Checks COMM4 for warm boot magic ("SQER"/$53514552 or "SDER"/$53444552) 5. Cold boot: validates ROM checksum, restores registers from table 6. Waits for SH2 "M_OK"/"S_OK" handshake on COMM0/COMM4 7. Resets Z80 three times (loads halt program: $F3 $F3 $C3 $00 $00) 8. Silences PSG three times (4 channels: $FF, $DF, $BF, $9F) 9. Initializes sound driver via SRAM bank access 10. Sets up VDP, waits for DMA idle, launches main game loop

- **Modifies**: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A4, A5, A6, A7
- **Calls**: $000654: framebuffer_auto_fill_clear (BSR) $000694: cram_fill (BSR) $000C5A: register_restore_from_table (JSR PC-relative) $000C80: hardware_init (JSR PC-relative) $000D68: warm_boot_init (JSR PC-relative) $000DC4: sound_update_check (JSR PC-relative) $00203A: sh2_frame_sync (JSR PC-relative) $00263E: adapter_init (JSR PC-relative) Hardware: MARS_SYS_BASE ($A15100): 32X adapter control COMM0-COMM6: SH2 handshake registers Z80_BUSREQ/Z80_RESET/Z80_RAM: Z80 management PSG ($C00011): Sound chip silence VDP_CTRL/VDP_DATA: Video display processor
*Source: [system_boot_init.asm](disasm/modules/68k/game/state/system_boot_init.asm)*

---

### register_restore_from_table ($000C5A–$000C70, 22 bytes)

Register Restore from Table Loads all 68K registers (D0-D7, A0-A6) from a PC-relative data table at $000C70 (the start of hardware_init, whose first 16 bytes are register init values). Uses four MOVEM.L loads from the same base address A6.

- **Entry**: None (standalone initialization helper)
- **Returns**: D0-D7, A0-A6 loaded from table at $000C70
- **Modifies**: D0-D7, A0-A6
*Source: [register_restore_from_table.asm](disasm/modules/68k/game/state/register_restore_from_table.asm)*

---

### hardware_init ($000C70–$000D68, 248 bytes)

Hardware Initialization Data prefix ($000C70-$000C7F): Register initialization values read by register_restore_from_table via MOVEM.L (decoded as ORI.B #$00,D0 no-ops by disassembler). Code entry at $000C80: Performs hardware initialization sequence: 1. Resets Z80 (loads halt program: $F3 $F3 $C3 $00 $00) 2. Silences PSG (4 channels: $FF, $DF, $BF, $9F) 3. Clears work RAM ($C9A0-$FF00 range, $0D57+1 longwords) 4. Reads hardware version from $A10001 5. Detects expansion port and NTSC/PAL via version register bits 6-7 6. Initializes I/O ports and controller drivers

- **Entry**: Called from system_boot_init at $000C80
- **Modifies**: D0, D1, D7, A1
- **Calls**: $0018D8: io_port_init (JSR PC-relative) $00170C: controller_port_init (JSR PC-relative) Hardware: Z80_BUSREQ/Z80_RESET/Z80_RAM: Z80 management PSG ($C00011): Sound chip silence $A10001: Hardware version register
*Source: [hardware_init.asm](disasm/modules/68k/game/state/hardware_init.asm)*

---

### Double-Conditional Guard ($000DC4–$000DD2, 14 bytes)

Returns ONLY if $EF05 is nonzero AND $EF06 is zero. In all other cases (both zero, or $EF06 nonzero), falls through to the next function past $000DD2.

- **Entry**: none | Exit: returns or falls through
- **Modifies**: none
- **RAM**: $FFFFFFEF05 = work RAM flag A (byte, tested) $FFFFFFEF06 = work RAM flag B (byte, tested)
*Source: [double_cond_guard.asm](disasm/modules/68k/game/state/double_cond_guard.asm)*

---

### input_dispatch_table_and_controller_port_init ($0016B2–$00178E, 220 bytes)

Input Dispatch Table and Controller Port Init Data prefix ($0016B2-$00170B): Input handler dispatch table containing ROM subroutine addresses ($008819FE, $00881A6E, etc.) for various input processing routines. Final entry is RTE at $00170A. Code entry at $00170C (controller_port_init): Initializes controller port configuration for both player ports: 1. Clears port detection flags 2. Writes 16-byte controller config per port (TH/TR/TL pin modes) 3. Selects appropriate 8-byte port profile based on hardware version register bit 0 (domestic/overseas) and bit 1 (NTSC/PAL) 4. Copies selected profile to RAM at $FE94 (port config area)

- **Entry**: Called from hardware_init
- **Modifies**: D0, D7, A0, A1, A3, A4, A5
*Source: [input_dispatch_table_and_controller_port_init.asm](disasm/modules/68k/game/state/input_dispatch_table_and_controller_port_init.asm)*

---

### Controller Read + Button Remap (Port 1) ($00178E–$0017D6, 72 bytes)

Reads controller port 1 via Z80 bus, remaps buttons. Data prefix: 16-byte controller remap table (2 × 8 bytes). If $C810 != $0D → exits early (wrong mode). Loads P1 controller state from ($C86C), calls zbus_request and button_remap. If $C811 != $0D → clears $C86E (P2 byte A).

- **Modifies**: D0, D2, A0, A1, A2, A3
- **Calls**: $0017EE: button_remap $00185E: zbus_request
- **RAM**: $C810: controller mode P1 (byte, checked == $0D) $C811: controller mode P2 (byte, checked == $0D) $C86C: P1 controller state (long) $C86E: P2 controller byte A (byte, cleared if P2 inactive) $C970: controller work buffer (8 bytes)
*Source: [controller_read_button_remap.asm](disasm/modules/68k/game/state/controller_read_button_remap.asm)*

---

### Clear Input State Flags ($0017D6–$0017E4, 14 bytes)

Clears both input state flag bytes at $C86C and $C86E to zero. Called during initialization or state transitions.

- **Entry**: none | Exit: flags cleared | Uses: none
- **RAM**: $FFFFC86C = input state flag A (byte, cleared) $FFFFC86E = input state flag B (byte, cleared)
*Source: [clear_input_state_flags.asm](disasm/modules/68k/game/state/clear_input_state_flags.asm)*

---

### Controller Input Init ($0018D8–$001992, 186 bytes)

Reads controller IDs via BSR.W to external controller_id_read ($001992) for ports A/B/C. Sets up data direction registers, waits for port stabilization, then reads button states via zbus_request. Checks for 6-button pad type (ID = $0D). Output: ($FFFFC818).w = pad type/state bitmap bit 0: port A has controller bit 1: port B has controller bit 2: port A is NOT 6-button bit 3: port B is NOT 6-button

- **Modifies**: D0, D7, A1
- **Calls**: $001992: controller_id_read (BSR.W, external) $00185E: zbus_request (JSR PC-relative)
- **RAM**: $C810: port_a_id $C811: port_b_id $C812: port_c_id $C818: pad_type_flags
*Source: [controller_input_init.asm](disasm/modules/68k/game/state/controller_input_init.asm)*

---

### Set Communication Ready Flag ($00205E–$002066, 8 bytes)

Sets the communication flag at $C822 to $F0, signalling that the 68K is ready for SH2 communication. Called during frame sync and init.

- **Entry**: none | Exit: flag set | Uses: none
- **RAM**: $FFFFC822 = comm/input state flag (byte, set to $F0)
*Source: [set_communication_ready_flag.asm](disasm/modules/68k/game/state/set_communication_ready_flag.asm)*

---

### sound_update_disp ($0020D6–$0021EE, 280 bytes)

Sound Update Dispatcher Sound command update dispatcher with 7 entry points (one per game state variant). Each entry: 1. Checks if sound command is pending in RAM ($C874 area) 2. Copies command to active slot, clears pending flag 3. Saves A5/A6, calls sound driver at $008B0000, restores 4. Jumps to next handler (via JMP PC-relative) or returns Three variants handle different sound command sources: - Type A ($0020D6, $002154): Copies $C874 → $C876, checks pending flag - Type B ($00210A, $002180): Copies $C875, simpler pending check - Type C ($00212E, $0021A4, $0021CA): Reads command from $C862, clears all

- **Modifies**: D0, A5, A6
- **Calls**: $008B0000: sound_driver_update $00232E: next handler (JMP PC-relative) — entries 1-6 $00220C: next handler (JMP PC-relative) — entries 4-6
*Source: [sound_update_disp.asm](disasm/modules/68k/game/state/sound_update_disp.asm)*

---

### randomized_timer_decrement_a ($002294–$0022AA, 22 bytes)

Randomized Timer Decrement A If (A1) equals target value $1E00, generates a random number (0-15) and subtracts it from D1 to introduce jitter. Stores result to (A1). Used for V-INT frame timing with randomized variation.

- **Entry**: D1 = timer value, A1 = timer storage pointer
- **Returns**: D1 = adjusted timer, (A1) = updated
- **Modifies**: D0, D1, A1
- **Calls**: $00496E: random_number_gen (JSR PC-relative)
*Source: [randomized_timer_decrement_a.asm](disasm/modules/68k/game/state/randomized_timer_decrement_a.asm)*

---

### weighted_timer_average_a ($0022AA–$0022D6, 44 bytes)

Weighted Timer Average A Computes weighted average for frame timing smoothing: D1 = (D0/16) * ~1.8 + $1A5E, then average with (A1): D1 = (D1 + (A1))/2 Clamps result to range [$1A5E, $21D0]. Stores result to (A1). Used for adaptive V-INT timing (wider range variant).

- **Entry**: D0 = raw timing input, A1 = timer storage pointer
- **Returns**: D1 = smoothed timing value, (A1) = updated
- **Modifies**: D0, D1, A1
*Source: [weighted_timer_average_a.asm](disasm/modules/68k/game/state/weighted_timer_average_a.asm)*

---

### randomized_timer_decrement_b ($0022D6–$0022EC, 22 bytes)

Randomized Timer Decrement B If (A1) equals target value $21D0, generates a random number (0-15) and subtracts it from D1. Stores result to (A1). Paired with weighted_timer_average_a (wider range variant, target = upper bound).

- **Entry**: D1 = timer value, A1 = timer storage pointer
- **Returns**: D1 = adjusted timer, (A1) = updated
- **Modifies**: D0, D1, A1
- **Calls**: $00496E: random_number_gen (JSR PC-relative)
*Source: [randomized_timer_decrement_b.asm](disasm/modules/68k/game/state/randomized_timer_decrement_b.asm)*

---

### weighted_timer_average_b ($0022EC–$002314, 40 bytes)

Weighted Timer Average B Computes weighted average for frame timing smoothing: D1 = (D0/16) * ~1.5 + $1A5E, then average with (A1): D1 = (D1 + (A1))/2 Clamps result to range [$1A5E, $21A0]. Stores result to (A1). Narrower range variant (upper bound $21A0 vs $21D0 in weighted_timer_average_a).

- **Entry**: D0 = raw timing input, A1 = timer storage pointer
- **Returns**: D1 = smoothed timing value, (A1) = updated
- **Modifies**: D0, D1, A1
*Source: [weighted_timer_average_b.asm](disasm/modules/68k/game/state/weighted_timer_average_b.asm)*

---

### randomized_timer_decrement_c ($002314–$00232A, 22 bytes)

Randomized Timer Decrement C If (A1) equals target value $21A0, generates a random number (0-15) and subtracts it from D1. Stores result to (A1). Paired with weighted_timer_average_b (narrower range variant, target = upper bound).

- **Entry**: D1 = timer value, A1 = timer storage pointer
- **Returns**: D1 = adjusted timer, (A1) = updated
- **Modifies**: D0, D1, A1
- **Calls**: $00496E: random_number_gen (JSR PC-relative)
*Source: [randomized_timer_decrement_c.asm](disasm/modules/68k/game/state/randomized_timer_decrement_c.asm)*

---

### Object Enable Fields + State Dispatch ($002A72–$002AAA, 56 bytes)

Sets 5 enable fields on object (A1) to 1 ($00/+$14/+$28/+$3C/+$50). Then dispatches on object param_8a (A0+$8A): == 0: exits to $002AC4 (past fn) == 1: exits to $002AAA (past fn) >= 2: copies $C74C to A1+$24 (position), sets field +$64 based on velocity_x (A0+$8C): nonzero → $0000, zero → $0001.

- **Modifies**: D0, A0, A1
- **RAM**: $C74C: position value (long) Object (A0): +$8A: param_8a (word, dispatch key) +$8C: velocity_x (word) Object (A1): +$00/+$14/+$28/+$3C/+$50: enable flags (word, set to 1) +$24: position (long, set from $C74C) +$64: direction flag (word, 0 or 1)
*Source: [object_enable_fields_state_dispatch.asm](disasm/modules/68k/game/state/object_enable_fields_state_dispatch.asm)*

---

### Object Param 8A Dispatch (Variant A) ($002DCA–$002DF4, 42 bytes)

Reads object param_8a (A0+$8A) and dispatches: param=0 → branches forward to $002E14 (external handler) param=1 → branches forward to $002DF4 (external handler) param≥2 → copies longword from $C74C to obj1.field24 and obj2.field128, sets obj1.field64 based on velocity_x (A0+$8C): velocity_x=0 → field64=1, velocity_x≠0 → field64=0.

- **Entry**: A0 = source object, A1 = target object 1, A2 = target object 2
- **Modifies**: D0, A0, A1, A2
- **RAM**: $C74C: position/transform value (long)
- **Object fields**: A0+$8A: param_8a (word, dispatch key) A0+$8C: velocity_x (word) A1+$24: field24 (long, set from $C74C) A1+$64: field64 (word, 0 or 1) A2+$128: field128 (long, set from $C74C)
*Source: [object_param_8a_dispatch_002dca.asm](disasm/modules/68k/game/state/object_param_8a_dispatch_002dca.asm)*

---

### Object Param 8A Dispatch (Variant B) ($002E34–$002E5E, 42 bytes)

Reads object param_8a (A0+$8A) and dispatches: param=0 → branches forward to $002E7E (external handler) param=1 → branches forward to $002E5E (external handler) param≥2 → copies longword from $C760 to obj1.field24 and obj2.field128, sets obj1.field64 based on velocity_x (A0+$8C): velocity_x=0 → field64=1, velocity_x≠0 → field64=0. Identical structure to object_param_8a_dispatch_002dca but uses $C760 instead of $C74C.

- **Entry**: A0 = source object, A1 = target object 1, A2 = target object 2
- **Modifies**: D0, A0, A1, A2
- **RAM**: $C760: position/transform value (long)
- **Object fields**: A0+$8A: param_8a (word, dispatch key) A0+$8C: velocity_x (word) A1+$24: field24 (long, set from $C760) A1+$64: field64 (word, 0 or 1) A2+$128: field128 (long, set from $C760)
*Source: [object_param_8a_dispatch_002e34.asm](disasm/modules/68k/game/state/object_param_8a_dispatch_002e34.asm)*

---

### Object State Dispatcher (11-Entry Jump Table) ($0031A6–$003204, 94 bytes)

Dispatches via 11-entry longword jump table indexed by dispatch_idx ($C305) as byte. Jump table covers states $00-$28. States $08-$10 share handler at $31DE; states $18-$20 share $322A. State $08 handler (inline): if timer ($C04E) nonzero, loads object_ptr ($C258), sets object type=2, VDP flags $6950=3 and $6940=1, advances state by 4.

- **Modifies**: D0, D1, D4, A0, A1, A2, A6
- **RAM**: $C04E: timer (word) $C258: object_ptr (longword) $C305: dispatch_idx (byte, ×4 for table index)
*Source: [object_state_disp_0031a6.asm](disasm/modules/68k/game/state/object_state_disp_0031a6.asm)*

---

### Load Object Pointer + Clear Object State ($003250–$003272, 34 bytes)

Loads object pointer from $C258 into A1, sets object command byte (offset $00) to $02, then clears three state bytes: two SH2 shared ($FF6940, $FF6950) and flag byte $C305.

- **Entry**: none | Exit: object + state cleared | Uses: A1
- **RAM**: $FFFFC258 = object pointer (long, loaded into A1) $00FF6940 = SH2 shared object byte 1 (cleared) $00FF6950 = SH2 shared object byte 2 (cleared) $FFFFC305 = flag byte (byte, cleared)
*Source: [load_object_pointer_clear_object_state.asm](disasm/modules/68k/game/state/load_object_pointer_clear_object_state.asm)*

---

### Set Game State $34 ($0033E4–$0033EA, 8 bytes)

Sets game state byte at $C305 to $34.

- **Entry**: none
- **Modifies**: none
*Source: [set_state_0x34.asm](disasm/modules/68k/game/state/set_state_0x34.asm)*

---

### Calculate State from Flags ($0034D2–$0034E6, 22 bytes)

Calculates game state from bits 0-1 of flag byte at $C8AB. Maps: 0->$0C, 1->$10, 2->$14, 3->$18.

- **Entry**: none
- **Modifies**: D0
*Source: [calc_state_from_flags.asm](disasm/modules/68k/game/state/calc_state_from_flags.asm)*

---

### Object State Dispatcher (12-Entry Jump Table) ($0034E8–$003540, 88 bytes)

Dispatches via 12-entry longword jump table indexed by dispatch_idx ($C305) as byte. Jump table covers states $00-$2C. States $08-$14 share handler at $3524; states $18-$20 share $3580. Inline handler at $3524: if timer ($C04E) nonzero, sets VDP flags $6950=3 and $6940=1, advances state by 4.

- **Modifies**: D0, A1, A2, A3, A4
- **RAM**: $C04E: timer (word) $C305: dispatch_idx (byte, ×4 for table index)
*Source: [object_state_disp_0034e8.asm](disasm/modules/68k/game/state/object_state_disp_0034e8.asm)*

---

### Clear Object State Bytes ($00359C–$0035B4, 24 bytes)

Clears three object-related bytes: two in SH2 shared memory ($FF6940, $FF6950) and flag byte $C305 in 68K RAM.

- **Entry**: none | Exit: 3 bytes cleared | Uses: none
- **RAM**: $00FF6940 = SH2 shared object byte 1 (cleared) $00FF6950 = SH2 shared object byte 2 (cleared) $FFFFC305 = flag byte (byte, cleared)
*Source: [clear_object_state_bytes.asm](disasm/modules/68k/game/state/clear_object_state_bytes.asm)*

---

### Calculate State from Flags (Copy 2) ($0036C8–$0036DC, 22 bytes)

Identical to calc_state_from_flags. Second copy for different code path.

- **Entry**: none
- **Modifies**: D0
*Source: [calc_state_from_flags_2.asm](disasm/modules/68k/game/state/calc_state_from_flags_2.asm)*

---

### Conditional Return on Display Flag ($00385E–$003866, 8 bytes)

Tests the display control byte at $C80F. If nonzero, returns early (RTS). If zero, falls through to the next function in the section — acting as a conditional gate for the following code.

- **Entry**: none | Exit: returns if flag set, falls through if clear
- **Modifies**: condition codes
- **RAM**: $FFFFC80F = display control byte (tested for zero)
*Source: [conditional_return_on_disp_flag.asm](disasm/modules/68k/game/state/conditional_return_on_disp_flag.asm)*

---

### Reset Timer and Advance State ($003D9A–$003DA4, 12 bytes)

Resets the frame counter at $C8AA to zero and advances the state machine at $C8AC by 4. Inverse order variant of advance_clear_timer. MEMORY VARIABLES $FFFFC8AA  Frame counter (word, cleared to 0) $FFFFC8AC  State machine counter (word, advanced by 4)

- **Entry**: No register inputs
- **Returns**: Timer cleared, state advanced
- **Modifies**: (none modified beyond RAM writes)
*Source: [reset_timer_advance_state.asm](disasm/modules/68k/game/state/reset_timer_advance_state.asm)*

---

### Check Timeout (60 Frames) ($004168–$00417A, 20 bytes)

Checks if timer at $C8AA has reached 60 frames (1 second). If so, advances game phase at $C07C and resets timer.

- **Entry**: none
- **Modifies**: none (only modifies memory)
*Source: [check_timeout_60.asm](disasm/modules/68k/game/state/check_timeout_60.asm)*

---

### Timer Threshold Init (Sprite Setup) ($0042BA–$004300, 70 bytes)

Waits for frame counter > 20, then initializes a sprite at $FF6754 with position/attribute data, sets sound effect $95, advances state.

- **Entry**: none
- **Modifies**: A2
*Source: [timer_threshold_init.asm](disasm/modules/68k/game/state/timer_threshold_init.asm)*

---

### Timer Wait and Clear Sprite ($00432E–$00434A, 28 bytes)

Waits 60 frames, then advances state, resets counter, disables sprite.

- **Entry**: none
- **Modifies**: none (modifies memory only)
*Source: [timer_wait_clear.asm](disasm/modules/68k/game/state/timer_wait_clear.asm)*

---

### Advance State and Clear Timer ($004384–$004390, 12 bytes)

Advances the state machine at $C07C by 4 and resets the frame counter at $C8AA to zero. Common state transition helper. MEMORY VARIABLES $FFFFC07C  State machine counter (word, advanced by 4) $FFFFC8AA  Frame counter (word, cleared to 0)

- **Entry**: No register inputs
- **Returns**: State advanced, timer cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [advance_clear_timer.asm](disasm/modules/68k/game/state/advance_clear_timer.asm)*

---

### Timer Wait and Set Transition Flags ($004390–$0043BC, 44 bytes)

Waits for the frame counter at $C8AA to reach 40 ($0028). When the timer expires, advances the state machine at $C07C, clears the timer, and sets all transition control flags (C809, C80A, C80E bit 7, C802). MEMORY VARIABLES $FFFFC8AA  Frame counter (word, compared against $0028) $FFFFC07C  State machine counter (word, advanced by 4) $FFFFC809  Control flag A (byte, set to 1) $FFFFC80A  Control flag B (byte, set to 1) $FFFFC80E  Display control flags (bit 7 set) $FFFFC802  Control flag C (byte, set to 1)

- **Entry**: No register inputs
- **Returns**: If timer expired: state advanced, flags set
- **Modifies**: (none modified beyond RAM writes)
*Source: [timer_flag_set.asm](disasm/modules/68k/game/state/timer_flag_set.asm)*

---

### Game Init + State Dispatch 002 ($0043D0–$004460, 144 bytes)

Two entry points: Entry A ($0043D0): Game initialization — clears work buffers, resets state Entry B ($00442E): State dispatcher with 4-entry jump table

- **Modifies**: D0, A0, A1, A6
- **Calls**: $00B4CA: ai_scene_interpolation $002890: v_int_comm1_signal_handler (tail call via JMP)
- **RAM**: $C30E: race_flags $C260: position_buf_a $C200: work_buf_base $C80E: race_ctrl $C87E: game_state $C880: vdp_color_a $C882: vdp_color_b $C048: camera_state $C07C: input_state $C8AA: frame_counter $C800: race_init_flag
- **Confidence**: high
*Source: [game_init_state_dispatch_002.asm](disasm/modules/68k/game/state/game_init_state_dispatch_002.asm)*

---

### Flag Check and Advance State ($004498–$0044A6, 14 bytes)

Waits for SH2 processing to complete (bit 7 of $C80E clear), then advances state machine.

- **Entry**: none
- **Modifies**: none
*Source: [flag_check_advance.asm](disasm/modules/68k/game/state/flag_check_advance.asm)*

---

### Comprehensive State Reset ($0044A6–$0044E8, 66 bytes)

Full state reset clearing control flags, counters, display parameters, and setting the execution vector. Used during scene transitions. Clears bits 7,3 then bits 5,4,3 of the display control byte ($C80E), zeros multiple state counters, sets display size to $0020, resets the execution control byte, and writes the jump vector to $008909AE. MEMORY VARIABLES $FFFFC80E  Display control flags (bits 7,5,4,3 cleared) $FFFFC87E  State counter A (word, cleared to 0) $FFFFC8A8  State counter B (word, cleared to 0) $FFFFC880  State counter C (word, cleared via D0) $FFFFC882  State counter D (word, cleared via D0) $00FF0008  Display size (word, set to $0020) $FFFFC800  Execution control byte (byte, cleared to 0) $00FF0002  Jump vector (long, set to $008909AE)

- **Entry**: No register inputs
- **Returns**: All state variables reset, execution vector configured
- **Modifies**: D0
*Source: [state_reset_multi.asm](disasm/modules/68k/game/state/state_reset_multi.asm)*

---

### Display State Dispatcher (Two Jump Tables: 9 + 4 Entries) ($0044E8–$004538, 80 bytes)

Sets camera_active ($C048) = 1. Dispatches via 9-entry longword jump table A indexed by input_state ($C07C). Entry 7 handler ($451C): dispatches via 4-entry jump table B indexed by input_sub_state ($C882). Returns after dispatch.

- **Modifies**: D0, D2, A1, A2, A4, A6
- **RAM**: $C048: camera_active (word, set to 1) $C07C: input_state (word) $C8BE: input_sub_state (word)
*Source: [display_state_disp.asm](disasm/modules/68k/game/state/display_state_disp.asm)*

---

### Advance Input State ($004566–$00456C, 6 bytes)

Advances the input/controller state machine by one step (4 = one entry).

- **Entry**: none | Exit: state advanced | Uses: none
- **RAM**: $FFFFC07C = input state index (word)
*Source: [advance_input_state.asm](disasm/modules/68k/game/state/advance_input_state.asm)*

---

### Input State Dispatcher (4-Entry Jump Table + Init) ($00456C–$0045CE, 98 bytes)

Dispatches via 4-entry longword jump table indexed by input_state ($C819) × 4. State 0: initializes sprite block at $FF69E0 (type=7, $1AE, pattern $222EDB1A). Sets position $0402C000 (or $04038000 if A0=$9000). Increments state, advances $C07C by 4.

- **Modifies**: D0, A0, A1, A2, A6
- **RAM**: $C07C: state_dispatch_idx (word) $C819: input_state (byte) $C816: player_flags (byte)
*Source: [input_state_disp.asm](disasm/modules/68k/game/state/input_state_disp.asm)*

---

### Reset Step Counter to 3 ($004630–$004638, 8 bytes)

Resets step counter at $C819 to 3.

- **Entry**: none
- **Modifies**: none
*Source: [counter_reset_3.asm](disasm/modules/68k/game/state/counter_reset_3.asm)*

---

### Flag $96, Sprite Adjust, Advance ($00464A–$00465C, 18 bytes)

Sets effect code $96, moves sprite up by 6 pixels, advances state.

- **Entry**: none
- **Modifies**: none
*Source: [flag96_sprite_advance.asm](disasm/modules/68k/game/state/flag96_sprite_advance.asm)*

---

### Counter Check and Advance Secondary State ($004696–$0046AA, 20 bytes)

Checks if step counter equals 3; if so, advances secondary state at $C8BE and resets frame counter.

- **Entry**: none
- **Modifies**: none
*Source: [counter_check_advance.asm](disasm/modules/68k/game/state/counter_check_advance.asm)*

---

### Timer Complete with Conditional Flags ($0046AA–$0046EE, 68 bytes)

Waits for frame counter $C8AA to reach 40 ($0028). When expired, advances state at $C8BE, clears timer, selects a sound effect based on the position flag at $C816 ($AB or $AA), then sets all transition control flags. MEMORY VARIABLES $FFFFC8AA  Frame counter (word, compared against $0028) $FFFFC8BE  State counter (word, advanced by 4) $FFFFC8A5  Sound effect selector (byte, $AB or $AA) $FFFFC816  Position flag (byte, selects effect variant) $FFFFC800  Execution control (byte, set to 1) $FFFFC809  Control flag A (byte, set to 1) $FFFFC80A  Control flag B (byte, set to 1) $FFFFC80E  Display control flags (bit 7 set) $FFFFC802  Control flag C (byte, set to 1)

- **Entry**: No register inputs
- **Returns**: If timer expired: state advanced, effect selected, flags set
- **Modifies**: (none modified beyond RAM writes)
*Source: [timer_complete_flags.asm](disasm/modules/68k/game/state/timer_complete_flags.asm)*

---

### Game Logic Init + State Dispatch ($00471E–$0047CA, 172 bytes)

Two entry points: (1) init path — sets up VDP, sprite table, SH2 command handler, then jumps to external init routine; (2) dispatch path — sets camera position, reads state index from input_state, and dispatches via 4-entry jump table. State 0 activates game and clears scene_state. State 1 waits 40 frames then advances state.

- **Modifies**: D0, A1, A5
- **Calls**: $002890: game_init (JMP PC-relative) $00B25E: state_advance (JMP PC-relative)
- **RAM**: $C048: camera_position $C07C: input_state (jump table index: 0/4/8/12) $C260: sprite_table_init $C30E: state_flags $C800: game_active $C802: init_flag_a $C809: init_flag_b $C80A: init_flag_c $C80E: mode_flags $C87E: game_state $C880: vscroll_a $C882: vscroll_b $C8A8: state_timer $C8AA: scene_state
*Source: [game_logic_init_state_dispatch.asm](disasm/modules/68k/game/state/game_logic_init_state_dispatch.asm)*

---

### Flag Set, Sound Config, Advance ($0047CA–$0047E4, 26 bytes)

SH2 Gate Sets the process flag at $C048, then checks if the SH2 has completed (display bit 7 at $C80E). If display bit 7 is set, SH2 is still busy so we return early. Otherwise, writes sound/display config $F3 to $C822 and advances the state machine. MEMORY VARIABLES $FFFFC048  Process flag (word, set to 1) $FFFFC80E  Display control flags (bit 7 tested) $FFFFC822  Sound/display config (byte, set to $F3) $FFFFC07C  State machine counter (word, advanced by 4)

- **Entry**: No register inputs
- **Returns**: Process flag set; if SH2 idle: config written, state advanced
- **Modifies**: (none modified beyond RAM writes)
*Source: [flag_sound_advance_b.asm](disasm/modules/68k/game/state/flag_sound_advance_b.asm)*

---

### Full State Reset ($0047E4–$00482A, 70 bytes)

Race Mode Full state reset for race mode. Conditionally initializes the lap counter ($C260) if mode flag bit 5 is clear. Then clears all state counters/flags, sets display parameters, and configures the execution vector to $0088FB98. MEMORY VARIABLES $FFFFC30E  Mode flags (bit 5 tested for lap init gate) $FFFFC260  Lap counter (long, set to $60000000 if bit 5 clear) $FFFFC80E  Display control flags (bit 7 cleared) $FFFFC87E  State counter A (word, cleared to 0) $FFFFC880  State counter B (word, cleared via D0) $FFFFC882  State counter C (word, cleared via D0) $FFFFC8A8  State counter D (word, cleared to 0) $00FF0008  Display size (word, set to $0020) $FFFFC800  Execution control byte (byte, cleared to 0) $00FF0002  Jump vector (long, set to $0088FB98)

- **Entry**: No register inputs
- **Returns**: State reset for race mode, execution vector configured
- **Modifies**: D0
*Source: [full_state_reset_b.asm](disasm/modules/68k/game/state/full_state_reset_b.asm)*

---

### State Dispatcher (5-Entry Jump Table + 6 Subroutines, Data Prefix) ($004CB8–$004D00, 72 bytes)

Data prefix: 2 words ($A2A0, $A100) — RAM buffer addresses. Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, init ($0020D6), animation_update, frame_update ($00B02C), sprite_setup ($00B632), sprite_input_check, advances state by 4, writes $10 to SH2 COMM.

- **Modifies**: D0, D3, D7, A1, A2
- **Calls**: $0020D6: init handler $0028C2: VDPSyncSH2 $0058C8: sprite_input_check $00B02C: frame_update $00B09E: animation_update $00B632: sprite_setup
- **RAM**: $C87E: state_dispatch_idx (word)
*Source: [state_disp_004cb8.asm](disasm/modules/68k/game/state/state_disp_004cb8.asm)*

---

### State Dispatcher (5-Entry Jump Table + 8 Subroutines, Data Prefix) ($005020–$005070, 80 bytes)

Data prefix: 2 words ($A5A3, $A400) — RAM buffer addresses. Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, init ($002154), animation_update, frame_sync, display_update, frame_update ($00B03C), sprite_setup ($00B632), sprite_finalize ($00B646). Advances state by 4, writes $14 to SH2 COMM.

- **Modifies**: D0, D2, A0, A1, A6
- **Calls**: $002154: init handler $0028C2: VDPSyncSH2 $00B03C: frame_update $00B094: frame_sync $00B09E: animation_update $00B0DE: display_update $00B632: sprite_setup $00B646: sprite_finalize
- **RAM**: $C87E: state_dispatch_idx (word)
*Source: [state_disp_005020.asm](disasm/modules/68k/game/state/state_disp_005020.asm)*

---

### State Dispatcher (5-Entry Jump Table + 5 Subroutines) ($005308–$005348, 64 bytes)

Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, init ($0020D6), animation_update, frame_update ($00B02C), sprite_setup ($00B632), then advances state by 4 and writes $10 to SH2 COMM.

- **Modifies**: D0, A0, A1, A6
- **Calls**: $0020D6: init handler $0028C2: VDPSyncSH2 $00B02C: frame_update $00B09E: animation_update $00B632: sprite_setup
- **RAM**: $C87E: state_dispatch_idx (word)
*Source: [state_disp_005308.asm](disasm/modules/68k/game/state/state_disp_005308.asm)*

---

### State Dispatcher (4-Entry Jump Table) ($005586–$0055BA, 52 bytes)

Dispatches via 4-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, sfx_queue_process, sprite_input_check, then advances state by 4 and writes $10 to SH2 COMM register ($FF0008).

- **Modifies**: D0, A0, A1
- **Calls**: $0021CA: sfx_queue_process $0028C2: VDPSyncSH2 $0058C8: sprite_input_check
- **RAM**: $C87E: state_dispatch_idx (word)
*Source: [state_disp_005586.asm](disasm/modules/68k/game/state/state_disp_005586.asm)*

---

### State Dispatcher (5-Entry Jump Table + 4 Subroutines) ($005618–$005658, 64 bytes)

Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, sfx_queue_process, $0088BE, sprite_input_check, increments scene counter ($C886), advances state by 4, writes $10 to SH2 COMM.

- **Modifies**: D0, D6, A0, A1, A6
- **Calls**: $0021CA: sfx_queue_process $0028C2: VDPSyncSH2 $0058C8: sprite_input_check $0088BE: handler subroutine
- **RAM**: $C886: scene counter (byte, +1) $C87E: state_dispatch_idx (word)
*Source: [state_disp_005618.asm](disasm/modules/68k/game/state/state_disp_005618.asm)*

---

### Pause Menu Handler + Controller Check ($0056E4–$00573C, 88 bytes)

Three entry points: Entry 1 ($0056E4): BCLR bit 7 of $FDA8, tail-jump to $00D48A. Entry 2 ($0056EE): BSET bit 7 of $FDA8, tail-jump to $00D48A. Entry 3 ($0056F8): Reads P1 controller ($C86D), optionally ORs P2 ($C86F) if $C80E bit 4 set (2P mode). If bit 7 of result set AND $C800 == 0: writes mode flag to $FF69F0, calls SetDisplayParams, resets tick counter ($A510), sets sub_state ($C8C4) = $0C00, state_dispatch_idx ($C87E) = $10, writes $44 to SH2 COMM.

- **Modifies**: D0
- **Calls**: $0049AA: SetDisplayParams $00D48A: pause handler (tail-jump target)
- **RAM**: $A510: tick counter (byte, cleared) $C800: scene flag (byte, checked == 0) $C80E: control flags (byte, bit 4 = 2P mode) $C86D: P1 controller byte B (byte) $C86F: P2 controller byte B (byte) $C87E: state_dispatch_idx (word, set to $10) $C8C4: sub_state (word, set to $0C00) $FDA8: pause flag (byte, bit 7)
*Source: [pause_menu_handler_ctrl_check.asm](disasm/modules/68k/game/state/pause_menu_handler_ctrl_check.asm)*

---

### State Dispatcher (4-Entry Jump Table, Variant B) ($00573C–$005772, 54 bytes)

Calls sfx_queue_process, increments $A510 tick counter, then dispatches via 4-entry longword jump table indexed by sub_state ($C8C4). State 0 handler: calls VDPSyncSH2, advances sub_state by 4, writes $20 to SH2 COMM register ($FF0008).

- **Modifies**: D0, A0, A1
- **Calls**: $0021CA: sfx_queue_process $0028C2: VDPSyncSH2
- **RAM**: $A510: tick counter (byte, +1 per call) $C8C4: sub_state (byte, dispatch index)
*Source: [state_disp_00573c.asm](disasm/modules/68k/game/state/state_disp_00573c.asm)*

---

### State Dispatcher + Controller Poll + Sprite Update ($005780–$0057CA, 74 bytes)

Calls poll_controllers, advances sub_state ($C8C4) by 4, writes $44 to SH2 COMM. Dispatches via 6-entry longword jump table indexed by $C8C5 (frame sub-counter). After dispatch: calls sprite_update and tail-jumps to object_update ($00B684). Second entry point at $0057BC: increments $C886, writes $44 to SH2 COMM.

- **Modifies**: D0, D2, A0, A1, A2, A6
- **Calls**: $00179E: poll_controllers $00B684: object_update (tail-jump) $00B6DA: sprite_update
- **RAM**: $C886: scene counter (byte, +1) $C8C4: sub_state (byte, +4 per call) $C8C5: frame sub-counter (byte, dispatch index)
*Source: [state_disp_ctrl_poll_sprite_update.asm](disasm/modules/68k/game/state/state_disp_ctrl_poll_sprite_update.asm)*

---

### Advance Sub-Sequence Timer ($0057CA–$0057D0, 6 bytes)

Increments the sub-sequence timer byte at $C8C5 by 4.

- **Entry**: none | Exit: timer updated | Uses: none
- **RAM**: $FFFFC8C5 = sub-sequence timer value (byte, incremented by 4)
*Source: [advance_sub_seq_timer.asm](disasm/modules/68k/game/state/advance_sub_seq_timer.asm)*

---

### Controller Input Check + Start Button Handler ($0057D0–$00581A, 74 bytes)

Two entry points: Entry 1 ($0057D0): increments $C8C5 by 4, tail-jumps to $00246C. Entry 2 ($0057D8): checks $A510 bit 5 → writes 0 or 1 to $FF69F0. Reads P1 controller ($C86C byte), optionally ORs P2 ($C86E) if $C80E bit 4 set (2-player mode). If == $70 → exits to $005822. Then reads P1 byte 2 ($C86D), optionally ORs P2 byte 2 ($C86F). If bit 7 set → exits to $00581A. Otherwise RTS.

- **Modifies**: D0
- **RAM**: $A510: mode flags (byte, bit 5) $C80E: display control (byte, bit 4 = 2P mode) $C86C: P1 controller byte A (byte) $C86D: P1 controller byte B (byte) $C86E: P2 controller byte A (byte) $C86F: P2 controller byte B (byte) $C8C5: frame sub-counter (byte, +4 per call)
*Source: [controller_input_check_start_button_handler.asm](disasm/modules/68k/game/state/controller_input_check_start_button_handler.asm)*

---

### Set Timer Value (20) ($00581A–$005822, 8 bytes)

Sets timer/counter at $C8C5 to 20.

- **Entry**: none
- **Modifies**: none
*Source: [set_timer_val.asm](disasm/modules/68k/game/state/set_timer_val.asm)*

---

### Flag Check, VDP Init, Clear Display Mode ($00584A–$005866, 28 bytes)

Waits for SH2 completion, writes VDP register $8B00, clears display mode bytes, advances sub-state.

- **Entry**: A5 = VDP control port
- **Modifies**: D0
*Source: [flag_check_clear_init.asm](disasm/modules/68k/game/state/flag_check_clear_init.asm)*

---

### Object Bitmask Table + Button Flag Handler ($006BCA–$006C08, 62 bytes)

32-byte data table of 8 bitmask pairs (powers of 2 from 1-128), referenced by object_bitmask_table_lookup as lookup table. Code reads button flags from $C30E, masks bits 0+5 ($21): if any set → clears bit 4 of $C30E. if bit 5 set → copies $C098 to $C07A.

- **Modifies**: D0
- **RAM**: $C07A: bitmask table index (word, destination of copy) $C098: source parameter (word) $C30E: button/control flags (byte, bits 0/4/5)
*Source: [object_bitmask_table_button_flag_handler.asm](disasm/modules/68k/game/state/object_bitmask_table_button_flag_handler.asm)*

---

### Control Flag Check + Conditional Position Copy ($006C08–$006C26, 30 bytes)

Reads control flag ($C30E), checks bits 0 and 5. If neither set, falls through to next function. Otherwise clears bit 4 of $C30E. If bit 5 was set, copies state parameter from $C098 → $C07A before returning.

- **Entry**: none | Exit: flag processed | Uses: D0
- **RAM**: $FFFFC30E = control flag (byte, bits 0/4/5 tested/modified) $FFFFC098 = state parameter source (word, read) $FFFFC07A = state parameter dest (word, conditionally written)
*Source: [control_flag_check_cond_pos_copy.asm](disasm/modules/68k/game/state/control_flag_check_cond_pos_copy.asm)*

---

### Conditional Scroll State Init ($006C26–$006C46, 32 bytes)

Reads scroll trigger ($C050). If positive, returns. Otherwise sets bit 0 of control flag ($C30E), copies $C096 → $C07A (state parameter), sets input state ($C07C) to $0014, and clears the scroll trigger back to zero.

- **Entry**: none | Exit: scroll state initialized or no-op | Uses: D0
- **RAM**: $FFFFC050 = scroll trigger (word, tested, conditionally cleared) $FFFFC30E = control flag (byte, bit 0 set) $FFFFC096 = state parameter source (word, read) $FFFFC07A = state parameter dest (word, written) $FFFFC07C = input state (word, set to $0014)
*Source: [conditional_scroll_state_init.asm](disasm/modules/68k/game/state/conditional_scroll_state_init.asm)*

---

### Button Bit Dispatcher (7 Bit Tests) ($006C88–$006CDC, 84 bytes)

If SH2 buffer ($FF3000) == 0: calls sprite_table_init. Reads $C86E (P2 controller byte A) into D1, sets D0 = $30 (or $08 if bit 6 clear). Tests bits 2,3,1,0,4,5,7 of D1 and branches to individual handlers past this function for each set bit. Falls through to RTS if no bits set.

- **Modifies**: D0, D1
- **Calls**: $006C46: sprite_table_init Branch targets (all past fn): $006D38: bit 2 handler $006D3E: bit 3 handler $006D44: bit 1 handler $006D4A: bit 0 handler $006D50: bit 4 handler $006D6E: bit 5 handler $006D8C: bit 7 handler
- **RAM**: $C86E: P2 controller byte A (byte, tested bit-by-bit)
*Source: [button_bit_disp.asm](disasm/modules/68k/game/state/button_bit_disp.asm)*

---

### Position Table Lookup (Decrement Counter) ($006D6E–$006D8C, 30 bytes)

Decrements object frame counter at +$1C, then uses it as index into position table at ($C700) to update object X/Y position. Counter × 4 gives table offset (entries are 2 × word = 4 bytes). Identical to object_pos_table_lookup except uses SUBQ (decrement) instead of ADDQ.

- **Entry**: A0 = object pointer
- **Modifies**: D0, A2
- **RAM**: $C700: position table pointer (long)
- **Object fields**: +$1C: frame counter (word, decremented) +$30: x_position (word, updated from table) +$34: y_position (word, updated from table)
*Source: [position_table_lookup.asm](disasm/modules/68k/game/state/position_table_lookup.asm)*

---

### object_type_dispatch ($007A40–$007A8E, 78 bytes)

Object Type Dispatch Reads object type from A2+$18 (low 4 bits), multiplies by 4 for longword index, dispatches through 14-entry jump table. Each target returns a type classification code in D0 (1 or 2).

- **Entry**: A2 = object pointer (tile data)
- **Modifies**: D0, D5, A1, A2
- **Object fields**: +$18 type/flags
- **Confidence**: high
*Source: [object_type_dispatch.asm](disasm/modules/68k/game/state/object_type_dispatch.asm)*

---

### Increment Object Counter + Return $04 ($007A92–$007A9A, 8 bytes)

Increments the object pending counter at $C31A and returns D0 = $04. One of three related functions (038/039/040) returning different codes.

- **Entry**: none | Exit: D0 = $04 | Uses: D0
- **RAM**: $FFFFC31A = object pending counter (byte, incremented)
*Source: [increment_object_counter_return_04.asm](disasm/modules/68k/game/state/increment_object_counter_return_04.asm)*

---

### Increment Object Counter + Return $08 ($007A9A–$007AA2, 8 bytes)

Increments the object pending counter at $C31A and returns D0 = $08. One of three related functions (038/039/040) returning different codes.

- **Entry**: none | Exit: D0 = $08 | Uses: D0
- **RAM**: $FFFFC31A = object pending counter (byte, incremented)
*Source: [increment_object_counter_return_08.asm](disasm/modules/68k/game/state/increment_object_counter_return_08.asm)*

---

### Increment Object Counter + Return $10 ($007AA2–$007AAA, 8 bytes)

Increments the object pending counter at $C31A and returns D0 = $10. One of three related functions (038/039/040) returning different codes.

- **Entry**: none | Exit: D0 = $10 | Uses: D0
- **RAM**: $FFFFC31A = object pending counter (byte, incremented)
*Source: [increment_object_counter_return_10.asm](disasm/modules/68k/game/state/increment_object_counter_return_10.asm)*

---

### object_type_dispatch_b ($007BE4–$007C32, 78 bytes)

Object Type Dispatch B Reads object type from A2+$18 (low 4 bits), multiplies by 4 for longword index, dispatches through 14-entry jump table. Each target returns a type classification code in D0. Same structure as object_type_dispatch.

- **Entry**: A2 = object pointer (tile data)
- **Modifies**: D0, D6, A1, A2
- **Object fields**: +$18 type/flags
- **Confidence**: high
*Source: [object_type_dispatch_b.asm](disasm/modules/68k/game/state/object_type_dispatch_b.asm)*

---

### Conditional Return on State Match ($007EA4–$007EB2, 14 bytes)

Sets D1 = $14 (object type/size), then compares words at $C07A and $C098. Returns only if they are equal; falls through otherwise.

- **Entry**: none | Exit: D1 = $14, returns if match
- **Modifies**: D1, D4
- **RAM**: $FFFFC07A = state variable A (word, read) $FFFFC098 = state variable B (word, compared)
*Source: [conditional_return_on_state_match.asm](disasm/modules/68k/game/state/conditional_return_on_state_match.asm)*

---

### Clear Object Flags + Reset State ($007FDA–$007FEE, 20 bytes)

Clears bit 14 of the object flags at A0+$02, then zeroes out state variable $C04E and flag byte $C305.

- **Entry**: A0 = object pointer | Exit: flags/state reset | Uses: A0
- **RAM**: $FFFFC04E = state variable (word, cleared) $FFFFC305 = flag byte (byte, cleared)
*Source: [clear_object_flags_reset_state.asm](disasm/modules/68k/game/state/clear_object_flags_reset_state.asm)*

---

### Conditional Set State Byte from Object Comparison ($007FEE–$008004, 22 bytes)

Compares D0 with object+$2D. If they match AND object+$1C < $0064, sets $C8A4 to $BE. Otherwise does nothing.

- **Entry**: A0 = object pointer, D0 = comparison value
- **Returns**: $C8A4 optionally set | Uses: D0, A0
- **RAM**: $FFFFC8A4 = state byte (byte, conditionally set to $BE)
*Source: [conditional_set_state_byte_object_cmp.asm](disasm/modules/68k/game/state/conditional_set_state_byte_object_cmp.asm)*

---

### Object Position Compare + Flag Set ($008004–$008032, 46 bytes)

Compares object fields $2C/$2E (current/target position). If equal: compares $24 vs $28 (progress vs threshold). If $24 > $28: copies $24 → $28, checks $C319 sign bit, and if negative: sets bit 14 of obj.flags ($02) and writes $0050 to $C04E (timer/counter).

- **Entry**: A0 = object pointer
- **Modifies**: D0, A0
- **RAM**: $C319: control flag (byte, bit 7 = sign) $C04E: timer/counter (word, set to $0050)
- **Object fields**: A0+$02: flags (word, bit 14 set on trigger) A0+$24: progress value (word) A0+$28: threshold value (word) A0+$2C: current position (word) A0+$2E: target position (word)
*Source: [object_pos_compare_flag_set.asm](disasm/modules/68k/game/state/object_pos_compare_flag_set.asm)*

---

### Input Guard + Conditional Decrement ($008032–$008054, 34 bytes)

Guards against large position differences. If input_state is active or obj+$2C >= 20: returns immediately. If position difference (obj+$24 - obj+$26) > 100: decrements obj+$2E. If difference <= 100: falls through to next function (no return).

- **Entry**: A0 = object pointer
- **Modifies**: D0
- **RAM**: $C07C: input_state (word)
- **Object fields**: +$24: position value A (word) +$26: position value B (word) +$2C: guard threshold (word) +$2E: adjustment counter (word, decremented)
*Source: [input_guard_cond_dec.asm](disasm/modules/68k/game/state/input_guard_cond_dec.asm)*

---

### Triple-Guard Set State to $BE ($0080AE–$0080CC, 30 bytes)

Compares D0 with object+$2D. If mismatch, returns. Then checks $C08E against $C07A — if equal, returns. Then tests $C819 (display config flag) — if non-zero, returns. Only when all three conditions pass does it set $C8A4 to $BE.

- **Entry**: A0 = object, D0 = comparison value | Exit: state set | Uses: D0
- **RAM**: $FFFFC08E = position value (word, compared) $FFFFC07A = state parameter (word, compared) $FFFFC819 = display config flag (byte, tested) $FFFFC8A4 = state variable (byte, conditionally set to $BE)
*Source: [triple_guard_set_state_to_be.asm](disasm/modules/68k/game/state/triple_guard_set_state_to_be.asm)*

---

### Display State Timer + Flag Update ($008200–$008246, 70 bytes)

ANDs -(A4) with D4 (flag check); if result nonzero writes $BF to $C8A4 (SFX). Decrements timer ($C04E); when zero or $C8AB bit 2 set: writes D0 (0 or 1) to VDP display flag ($FF6960). If $C305 nonzero or $C04E != $3C: exits early (past fn). Otherwise checks object (A0) field +$02 bit 1: if set, clears bit 9 of field +$02 (ANDI #$FDFF).

- **Modifies**: D0, D4, A0, A4
- **RAM**: $C04E: display timer (word, decremented) $C305: sub-counter (byte, checked nonzero) $C8A4: SFX/sound command (byte) $C8AB: scene flags (byte, bit 2)
*Source: [display_state_timer_flag_update.asm](disasm/modules/68k/game/state/display_state_timer_flag_update.asm)*

---

### Object Flag Process + Conditional Clear ($008256–$008280, 42 bytes)

Data prefix (6 bytes: $85 $86 $87 $88 $89 $00), then object flag processing. Tests bit 6 of object+$02: if clear, falls through to next fn. Otherwise clears bit 6. Then tests bit 1: if clear, falls through. Otherwise clears $C04E and bit 9 of object+$02 before returning.

- **Entry**: A0 = object pointer | Exit: flags processed | Uses: A0
- **RAM**: $FFFFC04E = display/scroll value (word, conditionally cleared)
*Source: [object_flag_process_cond_clear.asm](disasm/modules/68k/game/state/object_flag_process_cond_clear.asm)*

---

### Timer Display Update 004 ($008280–$0082E0, 96 bytes)

Updates race timer display via num_to_decimal conversion Dispatches through jump table based on controller bits 6-7 Handles timer countdown with flag-based visibility

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, D1, D6, D7, A0, A1
- **Calls**: $00839A: num_to_decimal Jump table at digit_extraction_via_division Object fields (A0): +$02: flags
- **RAM**: $C319: controller_raw $C04E: timer_countdown $C305: race_phase $C8AB: scene_state_hi $C8AA: scene_state (cleared)
- **Confidence**: medium
*Source: [timer_disp_update_004.asm](disasm/modules/68k/game/state/timer_disp_update_004.asm)*

---

### write_status_code_to_ram ($0082E0–$0082E8, 8 bytes)

Write Status Code to RAM Stores D7 as the current status code at RAM $68F0. Used by the time display system to signal state changes (e.g., lap complete, countdown).

- **Entry**: D7 = status code value
- **Modifies**: D7
- **RAM**: $68F0 (status_code)
- **Confidence**: high
*Source: [write_status_code_to_ram.asm](disasm/modules/68k/game/state/write_status_code_to_ram.asm)*

---

### three_way_value_comparison_router ($008368–$00837A, 18 bytes)

Three-Way Value Comparison Router Compares D5 with longword at (A3). If equal: clears (A4), returns D0=0/D1=$0E. If less: falls through to object_state_assignment_00837a. If greater: branches to object_state_assignment_00838a. Routes to different state handlers based on comparison result.

- **Entry**: D5 = value to compare, A3 = reference pointer, A4 = state output
- **Modifies**: D0, D1, D5, A3, A4
- **Confidence**: high
*Source: [three_way_value_comparison_router.asm](disasm/modules/68k/game/state/three_way_value_comparison_router.asm)*

---

### object_state_assignment_00837a ($00837A–$00838A, 16 bytes)

Object State Assignment — Less-Than Case Less-than handler for the three-way comparison (three_way_value_comparison_router). Copies (A3) to (A4), stores D5 at +$04(A4), calls subroutine at $00B478, returns D0=2/D1=$0D.

- **Entry**: D5 = new speed value, A3 = source pointer, A4 = object pointer
- **Modifies**: D0, D1, D5, A3, A4
- **Object fields**: +$00 state, +$04 speed
- **Confidence**: high
*Source: [object_state_assignment_00837a.asm](disasm/modules/68k/game/state/object_state_assignment_00837a.asm)*

---

### object_state_assignment_00838a ($00838A–$00839A, 16 bytes)

Object State Assignment — Greater-Than Case Greater-than handler for the three-way comparison (three_way_value_comparison_router). Stores D5 at (A4), copies (A3) to +$04(A4), calls subroutine at $00B478, returns D0=1/D1=$0C. Reverse assignment order from object_state_assignment_00837a.

- **Entry**: D5 = new value, A3 = source pointer, A4 = object pointer
- **Modifies**: D0, D1, D5, A3, A4
- **Object fields**: +$00 state, +$04 speed
- **Confidence**: high
*Source: [object_state_assignment_00838a.asm](disasm/modules/68k/game/state/object_state_assignment_00838a.asm)*

---

### Object Spawn Counter + Table Setup ($0083C6–$0083E4, 30 bytes)

Loads and increments spawn counter ($A9E0), sets up table base addresses ($A9E3 → A1, $A800 → A2), then branches forward past this module to continue setup. The tail (BTST/BNE/RTS) is an alternate entry: tests object bit 6, falls through if set.

- **Entry**: A0 = object pointer | Exit: setup or guard | Uses: D0, A0-A2
- **RAM**: $FFFFA9E0 = spawn counter (byte, loaded then incremented) $FFFFA9E3 = table base offset (address loaded into A1) $FFFFA800 = object table base (address loaded into A2)
*Source: [object_spawn_counter_table_setup.asm](disasm/modules/68k/game/state/object_spawn_counter_table_setup.asm)*

---

### time_array_entry_comparison ($0084F4–$00850A, 22 bytes)

Time Array Entry Comparison Compares indexed longword entries from two arrays (A2, A3). Decrements and scales index D1 to access entries. Returns D0=0 if A3 entry is nonzero and A2 entry >= A3 entry. Falls through to return_success_flag (D0=1) otherwise. Used by the time display orchestrator (dual_time_display_orch).

- **Entry**: D1 = entry count, A2 = array 1 base, A3 = array 2 base
- **Modifies**: D0, D1, D4, D5, A2, A3
- **Confidence**: high
*Source: [time_array_entry_comparison.asm](disasm/modules/68k/game/state/time_array_entry_comparison.asm)*

---

### return_success_flag ($00850A–$00850E, 4 bytes)

Return Success Flag Returns D0=1 (success/true). Fallthrough target from time_array_entry_comparison when the array comparison condition is not met.

- **Modifies**: D0
- **Confidence**: high
*Source: [return_success_flag.asm](disasm/modules/68k/game/state/return_success_flag.asm)*

---

### fixed_point_threshold_state_marker ($00850E–$008522, 20 bytes)

Fixed-Point Threshold State Marker Compares D5 against fixed-point threshold $60000000. If below, falls through (no action). If at or above, writes sentinel $DDDD0DDD to (A4) and returns D0=1/D1=0. Marks object as exceeding the threshold.

- **Entry**: D5 = fixed-point value, A4 = object pointer
- **Modifies**: D0, D1, D5, A4
- **Confidence**: high
*Source: [fixed_point_threshold_state_marker.asm](disasm/modules/68k/game/state/fixed_point_threshold_state_marker.asm)*

---

### value_equality_check_with_state_clear ($008522–$008532, 16 bytes)

Value Equality Check with State Clear Compares D4 and D5. If not equal, branches past function to object_state_assignment_008532. If equal, clears (A4), returns D0=0/D1=$0E. Paired with object_state_assignment_008532 as the not-equal handler.

- **Entry**: D4, D5 = values to compare, A4 = state output pointer
- **Modifies**: D0, D1, D4, D5, A4
- **Confidence**: high
*Source: [value_equality_check_with_state_clear.asm](disasm/modules/68k/game/state/value_equality_check_with_state_clear.asm)*

---

### object_state_assignment_008532 ($008532–$008548, 22 bytes)

Object State Assignment — Not-Equal Case Not-equal handler paired with value_equality_check_with_state_clear. Entry at $008538 from BNE branch. Stores D5 at (A4), D4 at +$04(A4), calls subroutine at $00B478, returns D0=1/D1=$0C. First 6 bytes (CMPI.L) serve as alternate entry.

- **Entry**: D4, D5 = values to store, A4 = object pointer
- **Modifies**: D0, D1, D4, D5, A4
- **Object fields**: +$00 state, +$04 speed
- **Confidence**: high
*Source: [object_state_assignment_008532.asm](disasm/modules/68k/game/state/object_state_assignment_008532.asm)*

---

### Timer Decrement Multi (8 Entity Timers) ($008548–$00859A, 82 bytes)

Decrements 8 timer fields in entity (A0) if positive. Offsets: $98, $9A, $86, $80, $82, $84, $E6, $E8.

- **Entry**: A0 = entity
- **Modifies**: none (modifies entity fields)
*Source: [timer_decrement_multi.asm](disasm/modules/68k/game/state/timer_decrement_multi.asm)*

---

### State Handler Table + Init ($008B28–$008B9C, 116 bytes)

13-entry jump table for state handlers, followed by two 16-byte parameter blocks (data), then initialization code that clears camera/waypoint state and sets steering mode flags.

- **Modifies**: D0, D2, D5, D6, D7, A0, A2, A3
- **RAM**: $C0BA: waypoint_angle (cleared) $C0C6: camera_offset (cleared) $C313: steering_flags (bit 1 set, bit 3 cleared) $C896: ai_timer (cleared)
*Source: [state_handler_table_init.asm](disasm/modules/68k/game/state/state_handler_table_init.asm)*

---

### State Dispatcher + Register Copy Handler ($008CCE–$008D06, 56 bytes)

Reads state index from $C896, dispatches via PC-relative word-offset jump table (4 entries for states 0/2/4/6). After handler returns, jumps to $888DC0 (shared exit). State 0 handler (within this fn): copies 3 word pairs from $C0BA/$C0BC/$C0BE to $C8F8/$C892/$C894, sets $C8F6=5, advances state by 2. States 2/4/6 handlers are external (at $008D06/$008D12/$008D52).

- **Modifies**: D0
- **Calls**: $00888DC0: shared exit
- **RAM**: $C896: state index (byte, 0/2/4/6) $C0BA: source param A (word) $C0BC: source param B (word) $C0BE: source param C (word) $C892: target param B (word) $C894: target param C (word) $C8F6: counter/flag (byte, set to 5) $C8F8: target param A (word)
*Source: [state_disp_reg_copy_handler.asm](disasm/modules/68k/game/state/state_disp_reg_copy_handler.asm)*

---

### Counter Check Flag ($008D06–$008D12, 12 bytes)

Mode Advance Decrements a countdown counter at $C8F6. When it reaches zero, advances the mode counter at $C896 by 2. MEMORY VARIABLES $FFFFC8F6  Countdown counter (byte, decremented by 1) $FFFFC896  Mode counter (byte, advanced by 2 when countdown expires)

- **Entry**: No register inputs
- **Returns**: Counter decremented; mode advanced if counter reached zero
- **Modifies**: (none modified beyond RAM writes)
*Source: [counter_check_flag_8200.asm](disasm/modules/68k/game/state/counter_check_flag_8200.asm)*

---

### timer_decrement_and_rank_check_guard ($009E5A–$009E6E, 20 bytes)

Timer Decrement and Rank Check Guard Decrements timer +$A8 if nonzero. Then checks if entity rank +$2A equals 2; if so, falls through past RTS to continue processing. Otherwise returns. Guards subsequent code for 2nd-place entities.

- **Entry**: A0 = entity pointer
- **Modifies**: A0
- **Object fields**: +$2A rank, +$A8 countdown timer
- **Confidence**: high
*Source: [timer_decrement_and_rank_check_guard.asm](disasm/modules/68k/game/state/timer_decrement_and_rank_check_guard.asm)*

---

### Effect Timer Management ($00A350–$00A3B8, 106 bytes)

Manages animation effect timers using sine table lookups. When timer is active: reads sine value, decrements timer, advances index. When timer expires: checks flag bits 13/12 in A0+$2 to reinitialize.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A1 Fields accessed: A0+$02: Flag word (bits 13/12 = effect triggers) A0+$0E: Effect state A0+$14: Effect duration A0+$6A: Timer countdown A0+$6C: Sine table index A0+$6E: Current sine value (animation output)
*Source: [effect_timer_mgmt.asm](disasm/modules/68k/game/state/effect_timer_mgmt.asm)*

---

### Effect Countdown ($00AC3E–$00ACBE, 128 bytes)

Manages an effect countdown timer at ($C8AE). When timer expires, clears 4 RAM entries. Then checks multiple conditions (game state, flags, entity slot availability, entity countdown) before triggering an effect.

- **Entry**: A0 = object/entity pointer
- **Modifies**: D0, A1 Fields accessed: A0+$AC: Entity effect countdown (decremented) A0+$AE: Entity slot index
- **RAM**: ($C8AE).W: Effect duration timer ($C026).W: Effect active flag (set to $FFFF on expiry) ($C319).W: Game state (require & $3F == $0D) ($C30E).W: Flag byte (require & $21 == 0, bit 1 set on trigger) ($C05C).W: Slot table base pointer ($C312).W: Busy flag (require == 0) ($C8AA).W: Cleared on trigger ($C08E).W: Value copied to ($C07A).W ($C8A5).W: Set to $90 on trigger
*Source: [effect_countdown.asm](disasm/modules/68k/game/state/effect_countdown.asm)*

---

### Cascaded Frame Counter (Two Entry Points) ($00B094–$00B0DE, 74 bytes)

Two entry points (A0 selects counter block, D0 = flags byte): Entry 1 ($B094): A0 = $C813, D0 = $B4EE Entry 2 ($B09E): A0 = $C806, D0 = $C30E If D0 bit 4 set AND (A0) < $3C: Increments A0+2 (sub-tick). On rollover (→0): resets to $C4, checks D0 bits 0,1,5 and $C30D — if all clear, decrements $C050. Increments A0+1 (tick). On rollover: resets to $C4, increments A0+0 (main counter). Implements cascaded 3-byte timer with conditional $C050 decrement.

- **Modifies**: D0, A0
- **RAM**: $B4EE: input flags A (byte) $C050: work counter (word, decremented) $C30D: race sub-flag (byte) $C30E: race_flags (byte) Counter blocks (3 bytes each): $C806: counter B (+0=main, +1=tick, +2=sub-tick) $C813: counter A (+0=main, +1=tick, +2=sub-tick)
*Source: [cascaded_frame_counter.asm](disasm/modules/68k/game/state/cascaded_frame_counter.asm)*

---

### Conditional Return on Display Config Flag ($00B590–$00B598, 8 bytes)

Tests the display config flag at $C819. If nonzero, returns to caller. If zero, falls through to the next function (skip return).

- **Entry**: none | Exit: returns if flag set, falls through if clear
- **Modifies**: none
- **RAM**: $FFFFC819 = display config flag (byte, tested)
*Source: [conditional_return_on_disp_config_flag.asm](disasm/modules/68k/game/state/conditional_return_on_disp_config_flag.asm)*

---

### Triple Dispatch (3 Jump Tables by Controller Byte) ($00BA1A–$00BA5E, 68 bytes)

Three sequential dispatches, each loading a controller byte ($C86C/$C86D/$C86E), multiplying by 4 (D0×2×2), indexing into a longword jump table at $00894888/$894C88/$895088, and calling the target via JSR (A1).

- **Modifies**: D0, A1
- **RAM**: $C86C: controller byte A (byte, ×4 → jump table index) $C86D: controller byte B (byte, ×4 → jump table index) $C86E: controller byte C (byte, ×4 → jump table index) Jump tables (absolute long addresses): $00894888: dispatch table A $00894C88: dispatch table B $00895088: dispatch table C
*Source: [triple_dispatch.asm](disasm/modules/68k/game/state/triple_dispatch.asm)*

---

### Clear State + Copy Scroll Data from Object ($00BCDA–$00BD00, 38 bytes)

Clears scene_state and menu_substate, then copies 6 words from object data at A0+$02 to scroll/position registers. Same destination registers as backward_object_scan_copy_scroll_data.

- **Entry**: A0 = object pointer
- **Modifies**: A1
- **RAM**: $C8AA: scene_state (word, cleared) $C084: menu_substate (word, cleared) $C086: scroll register 1 (word) $C054: scroll register 2 (word) $C056: scroll register 3 (word) $C0AE: position register 1 (word) $C0B0: position register 2 (word) $C0B2: position register 3 (word)
*Source: [clear_state_copy_scroll_data_object.asm](disasm/modules/68k/game/state/clear_state_copy_scroll_data_object.asm)*

---

### Abort With Flag ($00BD9E–$00BDA6, 8 bytes)

Pops the caller's return address from stack (ADDQ #4,SP), sets flag ($C308).W = 1, then returns to grandparent caller. Effect: caller is skipped, flag is set.

- **Modifies**: (modifies SP)
- **RAM**: ($C308).W: Flag byte (set to 1)
*Source: [abort_with_flag.asm](disasm/modules/68k/game/state/abort_with_flag.asm)*

---

### Counter Init Check ($00BDC8–$00BDD4, 12 bytes)

Initializes counter ($A0F0).W to 1 if currently zero.

- **Modifies**: (none modified)
- **RAM**: ($A0F0).W: Counter (set to 1 if zero)
*Source: [counter_init_check.asm](disasm/modules/68k/game/state/counter_init_check.asm)*

---

### State Dispatcher (5-Entry Jump Table + 6 Subroutines) ($00C30A–$00C368, 94 bytes)

Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2, init ($0021CA), saves $C86C, forces $FF00 → $C86C. If $C81C bit 0 clear → calls sfx_queue_process ($88BE). Restores $C86C, calls sprite_input_check, increments scene_counter, advances state by 4, writes $10 to SH2 COMM.

- **Modifies**: D0, D1, D2, A0, A1, A6
- **Calls**: $0021CA: init handler $0028C2: VDPSyncSH2 $0058C8: sprite_input_check $0088BE: sfx_queue_process
- **RAM**: $C81C: scene_flags (byte, bit 0) $C86C: controller_state (word, saved/restored) $C87E: state_dispatch_idx (word) $C886: scene_counter (byte)
*Source: [state_disp_00c30a.asm](disasm/modules/68k/game/state/state_disp_00c30a.asm)*

---

### State Dispatcher + Controller Init (Jump Table) ($0143C6–$0143FA, 52 bytes)

Calls SH2 init ($882080), reads game_state ($C87E), dispatches via 3-entry longword jump table: State 0 → $008943E2 (controller poll + advance, within this fn) State 4 → $008943FA (external handler) State 8 → $00894400 (external handler) State 0 handler: polls controllers, calls $01440E, advances game_state, sets display mode $0020.

- **Modifies**: D0, A1
- **Calls**: $00882080: SH2 init $0088179E: controller_poll $01440E: input handler (via bsr.w)
- **RAM**: $C87E: game_state (word)
*Source: [state_disp_ctrl_init.asm](disasm/modules/68k/game/state/state_disp_ctrl_init.asm)*

---

## Game / Track

### Track Data Index Computation + Table Lookup ($0073E8–$00742C, 68 bytes)

Computes track segment index from D1/D2 velocity components and D3 base offset. Uses race_state ($C8A0) × 2 as table selector. Selects table base via A0+$E4 flag (normal at $742C or alternate at $745C). Loads segment data pointer from table[race_state], looks up word at segment[D3], then adds secondary table pointer. Returns A1 = computed track data address.

- **Modifies**: D0, D1, D2, D3, D4, D5, A0, A1, A2
- **RAM**: $C8A0: race_state (word) Object (A0): +$E4: table select flag (byte, 0=normal)
*Source: [track_data_index_calc_table_lookup.asm](disasm/modules/68k/game/track/track_data_index_calc_table_lookup.asm)*

---

### Track Data Extract 033 ($0076A2–$007700, 94 bytes)

Extracts signed byte pairs from 3D track data pages Reads from 3 pages ($800 apart) into work buffer fields

- **Entry**: D0 = track segment index (pre-shifted)
- **Modifies**: D0, D2, A1, A2
- **RAM**: $C268: track_data_ptr $C02E: track_work_buf Object fields (A2 → work buffer at $C02E): +$00, +$04: page 0 signed byte pair +$06, +$0A: page 1 signed byte pair +$0C, +$10: page 2 signed byte pair +$12, +$16: page 3 signed byte pair
- **Confidence**: high
*Source: [track_data_extract_033.asm](disasm/modules/68k/game/track/track_data_extract_033.asm)*

---

### Track Segment Load 031 ($00B990–$00BA18, 136 bytes)

Loads track segment data from ROM into work buffers Reads position pair via indexed table lookup Copies 5 longwords + 9 words from segment data to output buffer Initializes 5 segment counters to 1

- **Entry**: D0 = segment offset (added to base index)
- **Modifies**: D0, A1, A2
- **RAM**: $C744: segment_table_ptr $C8BC: segment_base_index $C303: segment_sub_index $C054: track_pos_hi $C056: track_pos_lo $C710-$C720: segment_data (5 longwords) $C734: segment_word_ptr $C04C: track_mode
- **Confidence**: medium
*Source: [track_segment_load_031.asm](disasm/modules/68k/game/track/track_segment_load_031.asm)*

---

### track_graphics_and_sound_loader ($00C7C2–$00C8E6, 292 bytes)

Track Graphics and Sound Loader Data prefix (animation frame table, 30 bytes). Loads track-specific graphics from ROM $0089B6AC/$0089B73C, copies palette data (54 longs), initializes sound/timing state variables. Second entry point loads track-specific overlay graphics from $00895488/$008954F4/$00895560 indexed by race mode. Configures display viewport and clears display list at $FF60C0-$FF60D0.

- **Modifies**: D0, D1, D3, D4, D7, A0, A1, A2
- **Calls**: $0048EA (data_copy), $004922 (FastCopy16)
- **Confidence**: high
*Source: [track_graphics_and_sound_loader.asm](disasm/modules/68k/game/track/track_graphics_and_sound_loader.asm)*

---

## Graphics

### Pixel Unpack 2 Pairs ($00247C–$0024AC, 50 bytes)

Unpacks 2 bytes into 4 pixels (4bpp packed pixel format). Each byte has two nibbles mapped to palette indices via D6 base offset.

- **Entry**: A0 = source data, A6 = VDP data port
- **Modifies**: D0, D1, D6, A0 (advances by 2)
*Source: [pixel_unpack_2pairs.asm](disasm/modules/68k/graphics/pixel_unpack_2pairs.asm)*

---

### Pixel Unpack 1 Pair ($0024AE–$0024C8, 28 bytes)

Unpacks 1 byte into 2 pixels (4bpp packed pixel format).

- **Entry**: A0 = source data, A6 = VDP data port
- **Modifies**: D0, D1, D6, A0 (advances by 1)
*Source: [pixel_unpack_1pair.asm](disasm/modules/68k/graphics/pixel_unpack_1pair.asm)*

---

### Sprite System Functions ($006C46 - $006D40) ($006C46–$006D40, 250 bytes)

Sprite table initialization and management. Creates the sprite attribute table structure in work RAM from ROM templates. SPRITE TABLE STRUCTURE Work RAM at $FF3000+: | Address    | Purpose                              | |------------|--------------------------------------| | $FF3000    | Sprite system initialized flag       | | $FF3002    | Sprite attribute pointers (6 entries)| | $FF301A    | Sprite chain pointers                | | $FF304A    | Sprite data storage                  | ROM DATA Sprite templates at $0089B844 contain predefined sprite configurations. Dependencies: Memory cleared before init Related: VDP operations Format: Proper mnemonics with original bytes in comments for verification

*Source: [sprite_system.asm](disasm/modules/68k/graphics/sprite_system.asm)*

---

### Screen Coordinate Calculation Functions ($0071A6 - $007246) ($0071A6–$007246, 160 bytes)

Calculates screen coordinates for 3D objects, mapping world positions to 2D screen locations for rendering. Called 9 times per frame. OBJECT STRUCTURE OFFSETS | Offset | Size | Name         | Purpose                         | |--------|------|--------------|--------------------------------| | $001D  | B    | obj_type     | Object type for table lookup    | | $0030  | W    | world_y      | World Y position                | | $0034  | W    | world_x      | World X position                | | $00CA  | W    | screen_idx   | Screen position index           | | $00CC  | W    | depth_val    | Depth value for perspective     | WORK RAM | Address    | Name           | Purpose                        | |------------|----------------|--------------------------------| | $FFFFC060  | VIEW_MODE      | Current view mode (word)       | | $FF6000    | COORD_BUFFER   | Screen coordinate buffer       | | $FF610E    | COORD_COUNT    | Number of calculated coords    | ROM TABLES | Address    | Name           | Purpose                        | |------------|----------------|--------------------------------| | $0089A0D4  | DEPTH_TABLE    | Depth-to-index lookup          | | $0089A434  | ALT_TABLE      | Alternative depth table        | | $007248    | MODE_TABLES    | View mode table pointers       | Dependencies: Object system, view setup Related: sprite_system.asm, object_system.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [screen_coord.asm](disasm/modules/68k/graphics/screen_coord.asm)*

---

## Hardware Regs

### MARS System Registers Init (13 Words) ($00263E–$002650, 20 bytes)

Copies 13 words from a data table (following this function) to MARS system registers at $A15100-$A15118.

- **Entry**: none (data table at PC+$12)
- **Modifies**: A1, A2, D7
*Source: [mars_regs_init_13.asm](disasm/modules/68k/hardware-regs/mars_regs_init_13.asm)*

---

### Hw Reg Init

*Source: [hw_reg_init.asm](disasm/modules/68k/hardware-regs/hw_reg_init.asm)*

---

## Input

### Controller Input Functions ($00170C - $0018FF) ($00170C–$0018FF, 499 bytes)

Controller initialization and polling for both Mega Drive controller ports. Supports standard 3-button and 6-button controllers. CONTROLLER PORTS | Address   | Name      | Purpose                     | |-----------|-----------|------------------------------| | $A10003   | MD_DATA1  | Controller 1 data port       | | $A10005   | MD_DATA2  | Controller 2 data port       | | $A10009   | MD_CTRL1  | Controller 1 control         | | $A1000B   | MD_CTRL2  | Controller 2 control         | CONTROLLER STATE MEMORY | Address | Name       | Purpose                       | |---------|------------|-------------------------------| | $C810   | CTRL_TYPE1 | Controller 1 type (byte)      | | $C811   | CTRL_TYPE2 | Controller 2 type (byte)      | | $C86C   | CTRL_STATE1| Controller 1 state (byte)     | | $C86E   | CTRL_STATE2| Controller 2 state (byte)     | | $C970   | INPUT_BUF1 | Input buffer 1 (long)         | | $C974   | INPUT_BUF2 | Input buffer 2 (long)         | | $FE82   | BTN_MAP    | Button remapping table        | | $FE92   | PORT_STATE1| Port 1 state                  | | $FE93   | PORT_STATE2| Port 2 state                  | | $FE94   | PORT_CFG   | Port configuration            | BUTTON MAPPING Standard 3-button: Up, Down, Left, Right, A, B, C, Start 6-button adds: X, Y, Z, Mode Button map values: $04 = A button $06 = B button $01 = C button $00 = Start $05 = X button $0A = Y button $09 = Z button $08 = Mode Dependencies: V-INT handler calls poll_controllers Related: vint_handler.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [controller.asm](disasm/modules/68k/input/controller.asm)*

---

### Joypad Process (Button Mapping + Edge Detection) ($0017E4–$00185C, 122 bytes)

Reads joypad via joypad_read_hw, maps raw button/direction bits to a standardized format using a configurable mapping table, and performs edge detection to identify newly pressed buttons.

- **Entry**: A0 = output buffer (2 bytes), A2 = state buffer (4 bytes) A3 = button mapping table (8 bytes)
- **Returns**: Button states written to (A0) and (A2)
- **Modifies**: D0-D2, D6, D7, A0-A3
- **Calls**: joypad_read_hw
*Source: [joypad_process.asm](disasm/modules/68k/input/joypad_process.asm)*

---

### Joypad Hardware Read (6-Button Protocol) ($00185E–$0018C6, 106 bytes)

Low-level Genesis/Mega Drive joypad hardware read using the standard TH-toggle protocol. Detects 6-button controllers and reads extra buttons. Requests Z80 bus during I/O access.

- **Entry**: A1 = joypad data port address (e.g., $A10003 or $A10005)
- **Returns**: D0 = button state word (1 = pressed) Format: ZYXM_SACBRLDU (6-btn) or 00000000_SACBRLDU (3-btn)
- **Modifies**: D0, D1, D5, D6, D7 Hardware: $A11100 (Z80 bus), A1 (joypad port)
*Source: [joypad_read_hw.asm](disasm/modules/68k/input/joypad_read_hw.asm)*

---

### Joypad 3-Button Fallback ($0018C8–$0018D6, 16 bytes)

3-button controller exit path. Masks result to low 8 bits (no ZYXM buttons), resets controller TH line, releases Z80 bus.

- **Entry**: D0 = raw button state, D5 = $00FF mask, D7 = $40 (TH=1) A1 = joypad data port
- **Returns**: D0 = masked button state (low 8 bits only)
*Source: [joypad_read_3btn.asm](disasm/modules/68k/input/joypad_read_3btn.asm)*

---

### Joypad Read Port (Generic Protocol) ($001992–$0019E8, 88 bytes)

Generic joypad port reader with configurable I/O protocol. Uses a 6-byte protocol table and a port address lookup table (both located after the RTS in the section data area). Reads 8 button bits via TH-toggle sequences.

- **Entry**: D0 = port index (0-2)
- **Returns**: D0 = 8-bit button data
- **Modifies**: D0, D1, D2, A0, A1 (D1/D2/A1 saved/restored) Hardware: $A11100 (Z80 bus), I/O ports
*Source: [joypad_read_port.asm](disasm/modules/68k/input/joypad_read_port.asm)*

---

### Input Clear ($0049AA–$0049C8, 30 bytes)

Both Players Clears input state for both players. Sets P1/P2 input words to $FF00 (preserving high byte, clearing low byte) and resets both extended input longs to $FFFF0000. MEMORY VARIABLES $FFFFC86C  P1 input state (word, set to $FF00) $FFFFC86E  P2 input state (word, set to $FF00) $FFFFC970  P1 extended input (long, set to $FFFF0000) $FFFFC974  P2 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: Both player inputs cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_clear_both.asm](disasm/modules/68k/input/input_clear_both.asm)*

---

### Input Clear ($0049C8–$0049DE, 22 bytes)

Both Players + P1 Extended Clears P1/P2 input words to $FF00 and resets P1 extended input only. MEMORY VARIABLES $FFFFC86C  P1 input state (word, set to $FF00) $FFFFC86E  P2 input state (word, set to $FF00) $FFFFC970  P1 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: P1/P2 inputs + P1 extended cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_clear_partial_a.asm](disasm/modules/68k/input/input_clear_partial_a.asm)*

---

### Input Clear ($0049DE–$0049EE, 16 bytes)

P2 + P2 Extended Clears P2 input word to $FF00 and resets P2 extended input only. MEMORY VARIABLES $FFFFC86E  P2 input state (word, set to $FF00) $FFFFC974  P2 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: P2 input + P2 extended cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_clear_partial_b.asm](disasm/modules/68k/input/input_clear_partial_b.asm)*

---

### Input Mask ($0049EE–$004A0C, 30 bytes)

Both Players Masks both player input words to retain only direction bits (AND with $FF80), then clears both extended input longs. Used to filter out button presses while preserving directional state. MEMORY VARIABLES $FFFFC86C  P1 input state (word, masked with $FF80) $FFFFC86E  P2 input state (word, masked with $FF80) $FFFFC970  P1 extended input (long, set to $FFFF0000) $FFFFC974  P2 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: Both inputs masked, extended cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_mask_both.asm](disasm/modules/68k/input/input_mask_both.asm)*

---

### Input Mask ($004A0C–$004A22, 22 bytes)

Both Players + P1 Extended Clear Masks P1/P2 input words to direction bits ($FF80) and clears P1 extended input only. MEMORY VARIABLES $FFFFC86C  P1 input state (word, masked with $FF80) $FFFFC86E  P2 input state (word, masked with $FF80) $FFFFC970  P1 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: Both inputs masked, P1 extended cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_mask_partial_a.asm](disasm/modules/68k/input/input_mask_partial_a.asm)*

---

### Input Mask ($004A22–$004A32, 16 bytes)

P2 + P2 Extended Clear Masks P2 input word to direction bits ($FF80) and clears P2 extended input only. MEMORY VARIABLES $FFFFC86E  P2 input state (word, masked with $FF80) $FFFFC974  P2 extended input (long, set to $FFFF0000)

- **Entry**: No register inputs
- **Returns**: P2 input masked, P2 extended cleared
- **Modifies**: (none modified beyond RAM writes)
*Source: [input_mask_partial_b.asm](disasm/modules/68k/input/input_mask_partial_b.asm)*

---

## Main Loop

### V-INT Handler ($001684-$0017EE) ($001684–$0017EE, 362 bytes)

The Vertical Interrupt handler is called every frame (~60Hz NTSC) during VBlank. It manages the main game state machine via a jump table dispatcher. STATE MACHINE Uses state flag at $FFC87A (also written as $C87A.W with signed offset). State 0 = idle/no work, handler exits immediately via RTE. Non-zero states dispatch through jump table at $0016B2. State | Address    | Handler Name           | Purpose ------+------------+------------------------+---------------------------------- 0   | $000819FE  | vint_state_common      | VDP sync + work RAM updates 1   | $000819FE  | vint_state_common      | (same) 2   | $000819FE  | vint_state_common      | (same) 4   | $00081A6E  | vint_state_minimal     | Quick VDP status read 5   | $00081A72  | vint_state_vdp_sync    | Full VDP synchronization 6   | $00081C66  | vint_state_fb_toggle   | Frame buffer toggle 7   | $00081ACA  | vint_state_sprite_cfg  | Sprite configuration 9   | $00081E42  | vint_state_fb_setup    | Frame buffer setup 10   | $00081B14  | vint_state_vdp_config  | VDP configuration 11   | $00081A64  | vint_state_transition  | Set next state 12   | $00081BA8  | vint_state_complex     | Complex VDP operations 13   | $00081E94  | vint_state_fb_palette  | FB + palette update 14   | $00081F4A  | vint_state_fb_dma      | Frame buffer DMA 15   | $00082010  | vint_state_cleanup     | Clear SH2 flags FRAME COUNTER $FFC964 (also $C964.W) is incremented every frame the handler runs. REGISTER USAGE All registers D0-D7/A0-A6 are saved on entry and restored on exit. Status register set to $2700 (interrupts disabled) during handler. TIMING CONSTRAINTS Must complete within VBlank period (~4500 68K cycles at 7.67MHz). Heavy processing deferred to state handlers after VBlank. Dependencies: State handlers in other modules Related: analysis/architecture/STATE_MACHINES.md Format: Proper mnemonics with original bytes in comments for verification

- **Entry**: Vector at $000078-$00007B points to $00001684 (vint_handler)
*Source: [vint_handler.asm](disasm/modules/68k/main-loop/vint_handler.asm)*

---

## Math

### Pseudo-Random Number Generator ($00496E–$004998, 42 bytes)

Linear congruential PRNG. State stored at ($EF00).W. Seed: $2A6D365A. Returns random value in D0.W.

- **Entry**: none
- **Returns**: D0.W = random value
- **Modifies**: D0 (D1 preserved)
*Source: [random_number_gen.asm](disasm/modules/68k/math/random_number_gen.asm)*

---

### Trigonometry Lookup Functions ($0070AA - $007148) ($0070AA–$007148, 158 bytes)

High-frequency sine/cosine lookup and velocity calculations for objects. Called 29 times per frame - the most frequently called function in the game. TRIG TABLE SYSTEM Two 1024-entry tables in ROM: - Sine table at $0093A02C (1024 words = 2KB) - Cosine table at $0093A42C (1024 words = 2KB) Each table covers 360 degrees in 1024 steps (0.35 degrees per step). Values are signed 16-bit fixed-point. OBJECT STRUCTURE OFFSETS (for this function) | Offset | Size | Purpose                              | |--------|------|--------------------------------------| | $0004  | W    | Scaling factor                       | | $003A  | W    | Cosine result                        | | $003E  | W    | Sine result                          | | $0044  | W    | Copied from $009E                    | | $0046  | W    | Calculated velocity component        | | $004A  | W    | Speed-adjusted value                 | | $004C  | W    | Final velocity component             | | $005A  | W    | Reference angle                      | | $005C  | W    | Y-axis angle                         | | $005E  | W    | X-axis angle                         | | $006E  | W    | Speed base value                     | | $008E  | W    | Rotation speed                       | | $0094  | W    | Velocity modifier                    | | $009E  | W    | Position offset                      | | $00A0  | W    | Mode flag                            | | $00A2  | W    | Acceleration factor                  | ALGORITHM 1. Calculate angle difference (obj+$5C - obj+$5A) 2. Look up sine, store at obj+$3E 3. Calculate angle difference (obj+$5E - obj+$5A) 4. Look up cosine, store at obj+$3A 5. Calculate velocity components using rotation and speed 6. Apply scaling and store final values Dependencies: Sine/cosine ROM tables Related: calc_steering, obj_velocity_y/x Format: Proper mnemonics with original bytes in comments for verification

*Source: [trig_lookup.asm](disasm/modules/68k/math/trig_lookup.asm)*

---

### Angle Normalize and BSP Visibility Test ($00748C–$0075C6, 316 bytes)

Normalizes viewing angles to a 512-step rotation system and performs BSP-style visibility testing for polygon culling. Two entry points: angle_normalize: checks visibility flag first, has outer D7 loop angle_normalize_alt: skips flag check, single-pass BSP test Angle system: 512 steps per full rotation, +$4000 offset, $01FF mask, x2 for word indexing, sign-extended to long. BSP traversal: reads plane selector words, tests 4 bits per word to determine comparison path (coefficient multiply vs direct compare), then branches based on signed comparison result.

- **Entry**: D1 = viewing angle 1, D2 = viewing angle 2, A1 = BSP data ptr
- **Returns**: D0 = 1 if visible, 0 if culled
- **Modifies**: D0-D7, A1-A2 Dependencies: None (pure math, no external calls)
*Source: [angle_normalize_bsp.asm](disasm/modules/68k/math/angle_normalize_bsp.asm)*

---

### Angle Normalization and Visibility Functions ($00748C - $0075D2) ($00748C–$0075D2, 326 bytes)

Normalizes angles to a 512-step rotation and performs BSP-style visibility testing for polygon culling. Two variants handle different test conditions. ANGLE SYSTEM The game uses a 512-step angle system: - Full rotation = 512 steps ($200) - Quarter rotation = 128 steps ($80) - The $4000 offset shifts the reference frame - $01FF mask keeps angle in 0-511 range INPUT PARAMETERS D1 = Viewing angle 1 (raw) D2 = Viewing angle 2 (raw) A1 = Polygon data pointer (BSP node structure) BSP NODE STRUCTURE | Offset | Size | Purpose                              | |--------|------|--------------------------------------| | +0     | W    | Flag word (negative = skip)          | | +2     | W    | Plane coefficient A                  | | +4     | W    | Plane coefficient B                  | | +6     | W    | Plane constant C                     | | ...    | ...  | Additional plane data                | ALGORITHM 1. Normalize input angles to 0-511 range, multiply by 2 2. Check polygon flag - if negative, return 0 (not visible) 3. For each of 10 BSP planes: a. Read plane coefficients from (A1)+ b. Compute: result = (D1 * A + C) >> 5 c. Compare result with D2 to determine side d. Follow appropriate BSP branch 4. Return 1 if visible, 0 if culled Dependencies: None (pure math) Related: sprite_list_process ($74A4), 3D rendering pipeline Format: Proper mnemonics with original bytes in comments for verification

*Source: [angle_visibility.asm](disasm/modules/68k/math/angle_visibility.asm)*

---

### Plane Evaluation Pair ($0075C8–$0075FD, 54 bytes)

Two BSP plane evaluation helpers for visibility testing. Computes: result = (D1*coef_A + D2*coef_B + C<<5) >> shift plane_eval: shift = 6 (direct entry) plane_eval_signed: checks sign at A2+$19, branches to plane_eval if positive, otherwise uses shift = 5

- **Entry**: D1 = normalized angle 1, D2 = normalized angle 2, A2 = plane data ptr
- **Returns**: D1 = evaluation result
- **Modifies**: D1, D2 Fields accessed: A2+$12: Plane coefficient A (word, used as MULS operand) A2+$14: Plane coefficient B (word, used as MULS operand) A2+$16: Plane constant C (word) A2+$19: Sign flag (byte, tested by signed variant)
*Source: [plane_eval_pair.asm](disasm/modules/68k/math/plane_eval_pair.asm)*

---

### Sine Table Lookup ($008F88–$008F9C, 20 bytes)

Looks up sine value from ROM table at $930000. Input angle offset by -$200 and negated.

- **Entry**: D0.W = angle
- **Returns**: D0.W = sine value
- **Modifies**: D0, A1
*Source: [sin_lookup.asm](disasm/modules/68k/math/sin_lookup.asm)*

---

### Cosine Table Lookup ($008F9C–$008FB0, 20 bytes)

Looks up cosine value from ROM table at $930000.

- **Entry**: D0.W = angle
- **Returns**: D0.W = cosine value
- **Modifies**: D0, A1
*Source: [cos_lookup.asm](disasm/modules/68k/math/cos_lookup.asm)*

---

### Sine Negated Lookup (3rd Quadrant) ($008FB0–$008FC6, 22 bytes)

Looks up negated sine value (offset by -$400).

- **Entry**: D0.W = angle
- **Returns**: D0.W = -sin(angle - $400)
- **Modifies**: D0, A1
*Source: [sin_neg_lookup.asm](disasm/modules/68k/math/sin_neg_lookup.asm)*

---

### Arctangent Calculation (Segmented Table Lookup) ($008FC8–$009040, 120 bytes)

Segmented arctangent calculation using 3 ROM lookup tables. Input in D0 (signed), returns angle in D0.W.

- **Entry**: D0.L = input value (signed)
- **Returns**: D0.W = angle result
- **Modifies**: D0, D1, D2, A1
*Source: [atan2_calc.asm](disasm/modules/68k/math/atan2_calc.asm)*

---

## Memory

### Block Copy 1KB with SH2 Check ($0046EE–$00471E, 48 bytes)

Copies 1024 bytes from $B400 to $A400 using MOVEM block copy. Only executes if SH2 is not busy. Queues sound $F3 on completion.

- **Entry**: none
- **Modifies**: D0-D6, A1-A3, D7
*Source: [block_copy_with_check.asm](disasm/modules/68k/memory/block_copy_with_check.asm)*

---

### Fast Memory Copy/Fill Functions ($004836 - $00496E) ($004836–$00496E, 312 bytes)

Highly optimized unrolled memory copy and fill routines. These functions are critical for performance, using loop unrolling to minimize branch overhead and maximize bus utilization. DESIGN PATTERN These functions use a "waterfall" entry point pattern: - Multiple JSR calls at the top cascade through the unrolled operations - Each entry point copies/fills a different number of bytes - Example: FastCopy20 copies 20 bytes, FastCopy16 copies 16 bytes REGISTER CONVENTIONS | Register | Purpose                                    | |----------|-------------------------------------------| | A1       | Source pointer (for copy)                  | | A2       | Destination pointer (increment mode)       | | A6       | Destination pointer (fixed mode, e.g. VDP) | | D1       | Fill value (long)                          | Dependencies: None (standalone utility functions) Related: VDP operations, sprite system, game logic Format: Proper mnemonics with original bytes in comments for verification

*Source: [fast_copy.asm](disasm/modules/68k/memory/fast_copy.asm)*

---

### Memory Fill and Copy Operations ($004836-$004996) ($004836–$004996, 352 bytes)

High-performance unrolled memory operations for buffer initialization and data transfer. All routines are optimized for speed using unrolled MOVE.L instructions. Fill Operations: - QuadMemoryFill: Waterfall entry for 4-level fill - UnrolledFill32: 8 MOVE.L ops = 32 bytes (to A6) - UnrolledFill60: 15 MOVE.L ops = 60 bytes (A1->A2 copy pattern) - UnrolledFill96: 24 MOVE.L ops = 96 bytes - UnrolledFill112: 28 MOVE.L ops = 112 bytes Copy Operations: - FastCopy16: 4 MOVE.L ops = 16 bytes (A1->A2) - FastCopy20: 5 MOVE.L ops = 20 bytes (A1->A2) Register Usage: D1 - Fill value (longword) A1 - Source/destination pointer (context-dependent) A2 - Destination pointer (copy operations) A6 - Destination pointer (UnrolledFill32) Called from: Multiple subsystems (display, game logic, init) Dependencies: None (standalone utilities) Originally at $004836-$004996 in sections/code_4200.asm

*Source: [fill_copy_operations.asm](disasm/modules/68k/memory/fill_copy_operations.asm)*

---

### Quad Memory Fill (JSR Cascade) ($004836–$004888, 82 bytes)

High-speed memory fill using JSR cascade trick. 4 cascading JSRs multiply the 32-word fill block.

- **Entry**: D1 = fill value, A1 = destination
- **Modifies**: A1 (advances), stack (cascade returns)
*Source: [quad_memory_fill.asm](disasm/modules/68k/memory/quad_memory_fill.asm)*

---

### Fast Fill 128 Bytes (Fixed Address) ($004888–$0048CA, 66 bytes)

Writes D1 to fixed address (A6) 32 times (128 bytes). A6 has no post-increment - suitable for FIFO/register writes.

- **Entry**: D1 = fill value, A6 = destination (fixed)
- **Modifies**: none
*Source: [fast_fill_128_fixed.asm](disasm/modules/68k/memory/fast_fill_128_fixed.asm)*

---

### Triple Memory Copy (JSR Cascade) ($0048CA–$00492C, 98 bytes)

High-speed memory copy using JSR cascade trick. 3 cascading JSRs + 1 skip-ahead JSR with 16+24 MOVE.L blocks.

- **Entry**: A1 = source, A2 = destination
- **Modifies**: A1, A2 (advance), stack (cascade returns)
*Source: [triple_memory_copy.asm](disasm/modules/68k/memory/triple_memory_copy.asm)*

---

### Fast Copy 128 Bytes to Fixed Address ($00492C–$00496E, 66 bytes)

Copies 32 longs from (A1)+ to fixed address (A6). Suitable for writing data to FIFO/register.

- **Entry**: A1 = source, A6 = destination (fixed)
- **Modifies**: A1 (advances)
*Source: [fast_copy_128_fixed.asm](disasm/modules/68k/memory/fast_copy_128_fixed.asm)*

---

## Object

### Entity Set Model (Type 0) ($002AC4–$002ADC, 26 bytes)

Sets entity model pointer from lookup table at $C710 and conditionally sets visibility based on mode flag at A0+$8C.

- **Entry**: A0 = source entity, A1 = destination entity
- **Modifies**: none (only modifies memory)
*Source: [entity_set_model_type0.asm](disasm/modules/68k/object/entity_set_model_type0.asm)*

---

### Object Visibility Functions ($002EC6 - $002F02) ($002EC6–$002F02, 60 bytes)

Functions for managing object visibility state. These check various flags to determine if an object should be rendered. OBJECT STRUCTURE OFFSETS | Offset | Name     | Purpose                              | |--------|----------|--------------------------------------| | $00E5  | OBJ_FLAG | Object flags (bit 3 = visibility)    | OUTPUT BUFFER OFFSETS (A1) | Offset | Purpose                                        | |--------|------------------------------------------------| | $0000  | Visibility slot 0                              | | $0014  | Visibility slot 1 ($14 = 20 bytes per slot)    | | $0028  | Visibility slot 2                              | | $003C  | Visibility slot 3                              | | $0050  | Visibility slot 4                              | | $0064  | Visibility slot 5                              | WORK RAM | Address    | Name           | Purpose                    | |------------|----------------|----------------------------| | $FFFFC31C  | VISIBILITY_FLAG| Global visibility control  | Dependencies: Object system initialization Related: obj_render_check, obj_transform_copy Format: Proper mnemonics with original bytes in comments for verification

*Source: [object_visibility.asm](disasm/modules/68k/object/object_visibility.asm)*

---

### Position Adjust Helpers ($006D30–$006D4E, 32 bytes)

Six tiny leaf functions for return values and position adjustment. Contiguous cluster used by object/entity processing.

- **Modifies**: D0, D1 (position helpers use D0 on A0 entity) Fields accessed: A0+$30: Position X A0+$34: Position Y
*Source: [position_adjust_helpers.asm](disasm/modules/68k/object/position_adjust_helpers.asm)*

---

### Counter Guard ($006FFA–$007006, 14 bytes)

Decrements a counter at A0+$92, tests object type field at A0+$06. If type is non-zero, branches to external handler at $A470. Otherwise returns.

- **Entry**: A0 = object pointer
- **Modifies**: none (only modifies A0+$92) Fields accessed: A0+$06: Object type field (tested) A0+$92: Counter (decremented)
*Source: [counter_guard.asm](disasm/modules/68k/object/counter_guard.asm)*

---

### Camera Position Smoothing ($007008–$007082, 124 bytes)

Smooths camera/entity position using interpolation and trig-based movement. Two paths based on slope direction ($72) vs stored direction ($68): Same direction: direct position update with 1/8 damping Different direction: 50% interpolation toward target Then applies rotation-based movement using external trig functions.

- **Entry**: A0 = entity/camera object
- **Modifies**: D0-D3, D6 Fields accessed: A0+$1E: Target position A0+$30: World position X (updated) A0+$34: World position Y (updated) A0+$3C: Intermediate position (updated) A0+$40: Display position (updated) A0+$64: Rotation offset (updated) A0+$66: Damping value A0+$68: Direction flag A0+$72: Slope direction
*Source: [camera_position_smooth.asm](disasm/modules/68k/object/camera_position_smooth.asm)*

---

### Position Velocity Update ($007084–$0070A8, 38 bytes)

Applies velocity components to object position fields. Updates both raw positions ($30, $34) and computed display position ($40).

- **Entry**: A0 = object pointer
- **Modifies**: D0 Fields accessed: A0+$30: Position X (updated) A0+$34: Position Y (updated) A0+$3C: Intermediate position A0+$40: Display position (written) A0+$4E: Velocity Z component A0+$50: Velocity Y component A0+$52: Velocity X component A0+$96: Position offset
*Source: [position_velocity_update.asm](disasm/modules/68k/object/position_velocity_update.asm)*

---

### Object Distance Calculation ($0075FE–$007622, 38 bytes)

Computes distance value and stores at A0+$CC. Two paths based on ($C04C).W flag: If zero: result = A0+$3C + A0+$96 If non-zero: result = A0+$3C + A0+$96 - A0+$46

- **Entry**: A0 = object pointer
- **Modifies**: D0 Fields accessed: A0+$3C: Base position A0+$46: Subtraction offset (used in non-zero path) A0+$96: Position offset A0+$CC: Distance result (written)
- **RAM**: ($C04C).W: Mode flag (zero = simple, non-zero = with offset)
*Source: [obj_distance_calc.asm](disasm/modules/68k/object/obj_distance_calc.asm)*

---

### Visibility Evaluation Caller ($007BAC–$007BE2, 56 bytes)

Loads object position, calls angle normalization and BSP visibility test. If visible, stores plane pointer in object, calls dispatch for type lookup, then evaluates signed plane. If result > 0, averages field $32.

- **Entry**: A0 = object pointer, A2 = BSP data pointer (set by caller)
- **Modifies**: D0-D2, A2 Fields accessed: A0+$30: Position X (angle input 1) A0+$32: Position Y / averaging field (read/updated) A0+$34: Position Z (angle input 2) A0+$55: Visibility result flag (set to 1 before test, updated) A0+$CE: BSP plane data pointer (stored if visible)
*Source: [visibility_eval_caller.asm](disasm/modules/68k/object/visibility_eval_caller.asm)*

---

### Multi-Flag Test ($007CD8–$007CEF, 24 bytes)

ANDs four flag bytes together and tests bit 1 of the result. Returns via RTS if bit 1 is set (all flags agree on bit 1). Falls through to next function if bit 1 is clear.

- **Entry**: A0 = object pointer
- **Modifies**: D0, D1 Fields accessed: A0+$56: Flag byte 1 A0+$57: Flag byte 2 A0+$58: Flag byte 3 A0+$59: Flag byte 4
*Source: [multi_flag_test.asm](disasm/modules/68k/object/multi_flag_test.asm)*

---

### Position Threshold Check ($007F50–$007F63, 20 bytes)

Compares difference of two position fields against threshold 100. If difference > 100, decrements counter at A0+$2E and returns. Otherwise falls through to next function.

- **Entry**: A0 = object pointer
- **Modifies**: D0 Fields accessed: A0+$24: Position value A A0+$26: Position value B A0+$2E: Counter (decremented if threshold exceeded)
*Source: [position_threshold_check.asm](disasm/modules/68k/object/position_threshold_check.asm)*

---

### Field Check Guard ($0080CC–$0080D5, 10 bytes)

Loads A0+$8C into D2. If non-zero, falls through to next function. If zero, returns immediately.

- **Entry**: A0 = object pointer
- **Returns**: D2 = field value (non-zero if falls through)
- **Modifies**: D2 Fields accessed: A0+$8C: Guard field (word)
*Source: [field_check_guard.asm](disasm/modules/68k/object/field_check_guard.asm)*

---

## Optimization

### Bank Register Probe

Identifies 68K access path to expansion ROM Location: Optimization area (code_1c200 section) The expansion ROM ($300000-$3FFFFF) contains 1MB of mostly-free space. This probe determines HOW the 68K can access it. Three paths tested: D = DIRECT:  68K reads $300000 as a normal ROM address A = BANK A:  $A130F1 (Genesis bank/SRAM register, byte write) B = BANK B:  $A15104 (32X Bank Set Register, word write, bits 0-1) For bank registers, bank 3 maps ROM $300000-$3FFFFF → $900000-$9FFFFF. EXPECTED VALUES ROM $000000: $01000000 (Initial SP from header — known good baseline) ROM $300000: $FFFFFFFF (expansion padding — 40 bytes of $FF) RESULTS ($FFFFF080, 32 bytes) +$00: $50524F42 ("PROB") — probe ran +$04: Direct read from $300000 +$08: Bank A, bank 0 → read $900000 +$0C: Bank A, bank 3 → read $900000 +$10: Bank B, bank 0 → read $900000 +$14: Bank B, bank 3 → read $900000 +$18: Winner byte: 'D'=$44, 'A'=$41, 'B'=$42, '?'=$3F +$19: Padding +$1A: $DEAD — probe completed without crash CALLING CONVENTION Called from: adapter_init (boot, interrupts disabled) Parameters: None

- **Returns**: Nothing Clobbers: D0-D1, A0
*Source: [bank_probe.asm](disasm/modules/68k/optimization/bank_probe.asm)*

---

### FPS Marker Hook - Size-neutral palette+marker wrapper

Location: Optimization area (code_1c200) Called from fn_200_041 in place of two PC-relative JSRs to palette copy routines at $0048D6 and $0048DA. Replaces 8 bytes (2x4-byte JSR d16,PC) with 8 bytes (6-byte JSR abs.l + 2-byte NOP). This function: 1. Calls the two original palette copy routines (preserving behavior) 2. Writes a minimal test marker to both frame buffers Context when called: - FM=0 (68K has frame buffer access, set by fn_200_041) - VBLK is active (confirmed by fn_200_041's busy-wait loop) - A1 = $00FF6E00 (palette data source in work RAM) - A2 = $00A15200 (CRAM base) Register contract: - A1, A2: passed through to palette routines (may be clobbered) - D0, A0: used as scratch for marker writes (saved/restored) - All other registers preserved Related: fn_200_041.asm, fps_vint_wrapper.asm

*Source: [fps_marker_hook.asm](disasm/modules/68k/optimization/fps_marker_hook.asm)*

---

### FPS Renderer - 2-Digit Frame Counter Display

Location: Optimization area ($89C208+, after fps_vint_wrapper) Renders the current FPS value (from fps_value at $FFFFF802) to both frame buffers using an embedded 4x5 pixel font. DISPLAY LAYOUT 14x7 pixel box at top-left (rows 3-9, columns 2-15): - 1px black border (top/bottom/left/right) - 2 digits: tens at cols 4-7, ones at cols 10-13 - 2px spacer between digits (cols 8-9) RENDERING METHOD Uses a 16-entry nibble-to-pixels LUT: each 4-bit font row maps to a longword of 4 pixel bytes. One MOVE.L per digit per row = fast rendering. Palette: CRAM[254]=$0000 (black BG), CRAM[255]=$7FFF (white FG). FM BIT PROTOCOL Called from V-INT epilogue. FM is likely 1 (SH2 owns VDP). Saves/restores FM state, temporarily clearing FM for 68K FB access. LINE TABLE Entries are WORD offsets (per 32XDK wiki). Must double to get byte offset. CALLING CONVENTION Parameters: None (reads fps_value via symbol)

- **Returns**: Nothing Clobbers: Nothing (all registers saved/restored) Cost: ~800 cycles (~0.6% of 68K frame budget)
*Source: [fps_render.asm](disasm/modules/68k/optimization/fps_render.asm)*

---

### FPS V-INT Wrapper - Frame Rate Measurement via FS Bit Tracking

Location: MUST be first module in optimization area ($89C208) Thin wrapper inserted before the original V-INT handler via vector redirect. Renders cached FPS value on no-work frames. ARCHITECTURE ALL FPS logic runs in vint_epilogue (after handler completes). Wrapper has ZERO cross-handler dependencies - just renders cached value. This eliminates all state-lifetime bugs. RAM LAYOUT (14 bytes at $FFFFF000-$FFFFF00D) $FFFFF000: fps_vint_tick    (word) - V-INT counter (0-59, 60 Hz time base) $FFFFF002: fps_value        (word) - Current FPS for display (0-99) $FFFFF004: fps_flip_counter (long) - Total buffer flip count $FFFFF008: fps_flip_last    (long) - Last sampled flip count $FFFFF00C: fps_fs_last      (word) - Last FS bit state (0 or 1) CALLING CONVENTION Called from: V-INT vector at ROM $000078 (redirected to $0089C208) Parameters: None (interrupt context) Related: fps_render.asm, vint_handler (code_200.asm)

- **Returns**: Jumps to original V-INT handler Clobbers: Nothing Cost: ~10 cycles work path, ~10 + fps_render cycles no-work path
*Source: [fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm)*

---

## Sh2

### MARS Communication Write ($002890–$0028C0, 50 bytes)

Writes a command to SH2 via communication registers (COMM0/COMM1). Implements spin-wait handshake protocol for 68K->SH2 command dispatch.

- **Entry**: Command bytes in $C8A8/$C8A9
- **Modifies**: none (only modifies MARS registers and RAM)
*Source: [mars_comm_write.asm](disasm/modules/68k/sh2/mars_comm_write.asm)*

---

### SH2 COMM Transfer Setup A (Horizontal World Data) ($00EFC2–$00F034, 114 bytes)

Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF2000-$FF2004, callback $222BDAE6. Signals SH2 via COMM registers.

- **Entry**: D0 = parameter value
- **Modifies**: A1
*Source: [comm_transfer_setup_a.asm](disasm/modules/68k/sh2/comm_transfer_setup_a.asm)*

---

### SH2 COMM Transfer Setup B (Secondary World Data) ($00F040–$00F0B2, 114 bytes)

Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF2006-$FF200A, callback $222BEA76. Signals SH2 via COMM registers.

- **Entry**: D0 = parameter value
- **Modifies**: A1
*Source: [comm_transfer_setup_b.asm](disasm/modules/68k/sh2/comm_transfer_setup_b.asm)*

---

### SH2 COMM Transfer Setup C (Third World Data) ($00F0BE–$00F130, 114 bytes)

Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF200C-$FF2010, callback $222BF710. Signals SH2 via COMM registers.

- **Entry**: D0 = parameter value
- **Modifies**: A1
*Source: [comm_transfer_setup_c.asm](disasm/modules/68k/sh2/comm_transfer_setup_c.asm)*

---

### SH2 Sync Wait and State Reset ($00F85C–$00F88C, 48 bytes)

Waits for SH2 to finish (polls $A15120), clears SH2 status, resets state counter, and selects function pointer based on ($A018) flag.

- **Modifies**: None (modifies memory only)
*Source: [sync_wait_reset.asm](disasm/modules/68k/sh2/sync_wait_reset.asm)*

---

### COMM Transfer Block (Command $2D) ($00FB36–$00FB98, 98 bytes)

Sends command $2D and transfers 28 words from buffer via FIFO. Waits for COMM0 clear, sets count, sends command, polls COMM1_LO bit 1 for ready, then copies 28 words from ($FF60C8) to MARS_FIFO.

- **Modifies**: D7, A1, A2
*Source: [comm_transfer_block.asm](disasm/modules/68k/sh2/comm_transfer_block.asm)*

---

### Virtua Racing Deluxe - SH2 Code Section

Module: 68k/sh2/section_24200.asm Address: $024200-$0261FF (8192 bytes) SH2 EXECUTABLE CODE This section contains SH2 code that is copied to SH2 SDRAM at runtime. The 68000 stores this as raw data which gets DMA'd to SH2 memory. SH2 Address Mapping: ROM offset $024200 -> SH2 SDRAM $02024200 (when loaded) Disassembly notes: - DC.W data preserved for byte-perfect builds - SH2 mnemonics shown in comments for reference - Entries marked "DW $xxxx" are embedded data or unrecognized opcodes

*Source: [section_24200.asm](disasm/modules/68k/sh2/section_24200.asm)*

---

### Virtua Racing Deluxe - SH2 Data Section

Module: 68k/sh2/section_26200.asm Address: $026200-$0281FF (8192 bytes) SINE/COSINE LOOKUP TABLE This section contains fixed-point trigonometric lookup tables used by the SH2 3D engine for rotation and transformation calculations. Format: Q2.14 fixed-point (14 fractional bits) - $4000 = 1.0 (16384 decimal) - $3FFF = 0.999939 (approx 1.0) - Values range from ~$3D2F to $4000 (sine wave pattern) Used for: - 3D rotation matrices - Camera angle calculations - Object orientation

*Source: [section_26200.asm](disasm/modules/68k/sh2/section_26200.asm)*

---

## Sound

### Sound Lookup and Play ($0033EC–$003402, 24 bytes)

Looks up a sound effect by index from entity data and plays it. Sound table at $008989EE, index from entity offset $2C.

- **Entry**: A0 = entity
- **Modifies**: D0, A1
*Source: [sound_lookup_play.asm](disasm/modules/68k/sound/sound_lookup_play.asm)*

---

### Tire Squeal Check (1-Player) ($0085C4–$008610, 76 bytes)

Checks lateral speed and triggers tire squeal sound effect. Manages cooldown timer, two threshold levels.

- **Entry**: A0 = entity
- **Modifies**: D0
*Source: [tire_squeal_check.asm](disasm/modules/68k/sound/tire_squeal_check.asm)*

---

### Tire Squeal Check (2-Player) ($008610–$008672, 98 bytes)

Two-player version of tire squeal check. Reads P1 speed from ($9094).W and P2 from ($9F94).W.

- **Entry**: none
- **Modifies**: D0, D2
*Source: [tire_squeal_check_2p.asm](disasm/modules/68k/sound/tire_squeal_check_2p.asm)*

---

### Sound Stream Load ($030200–$030218, 26 bytes)

Reads sequential bytes from a data stream (A0)+ into channel state fields at A5+$18/$19/$1A/$1B, with the last byte right-shifted by 1. Clears word at A5+$1C.

- **Entry**: A0 = data stream pointer, A5 = channel state pointer
- **Modifies**: D0 Fields written: A5+$18, A5+$19, A5+$1A, A5+$1B, A5+$1C
*Source: [sound_stream_load.asm](disasm/modules/68k/sound/sound_stream_load.asm)*

---

### Sound Timer Check ($030242–$030254, 20 bytes)

Tests bit 7 of A5+$0A. If clear, branches to RTS at $030290. If set, tests timer at A5+$18. If non-zero, decrements it and returns.

- **Entry**: A5 = channel state pointer
- **Modifies**: none Fields accessed: A5+$0A (bit test), A5+$18 (timer)
*Source: [sound_timer_check.asm](disasm/modules/68k/sound/sound_timer_check.asm)*

---

### Sound Timer Decrement ($030256–$03025C, 8 bytes)

Decrements counter at A5+$19. If result is zero, falls through to sound_state_reload. Otherwise returns.

- **Entry**: A5 = channel state pointer
- **Modifies**: none Fields accessed: A5+$19 (counter)
*Source: [sound_timer_dec.asm](disasm/modules/68k/sound/sound_timer_dec.asm)*

---

### Sound State Reload ($03025E–$030278, 28 bytes)

Reloads channel state from a pointer at A5+$14. Copies byte at (A0)+$01 to A5+$19. If A5+$1B is zero, also copies (A0)+$03 to A5+$1B and negates A5+$1A.

- **Entry**: A5 = channel state pointer
- **Modifies**: A0 Fields accessed: A5+$14 (pointer), A5+$19, A5+$1A, A5+$1B
*Source: [sound_state_reload.asm](disasm/modules/68k/sound/sound_state_reload.asm)*

---

### Sound Accumulate ($03027A–$030290, 24 bytes)

Decrements field $1B, then accumulates a signed byte from field $1A into the word at field $1C, and adds field $10 to the result in D6.

- **Entry**: A5 = channel state pointer
- **Returns**: D6 = accumulated value + field $10
- **Modifies**: D6 Fields accessed: A5+$1A, A5+$1B, A5+$1C, A5+$10
*Source: [sound_accumulate.asm](disasm/modules/68k/sound/sound_accumulate.asm)*

---

### Sound Field Test ($030292–$03029C, 12 bytes)

Tests word at A5+$10. If zero, sets bit 1 of (A5) and returns. If non-zero, branches to external handler at $0302A6.

- **Entry**: A5 = channel state pointer
- **Modifies**: D6 Fields accessed: A5+$10, (A5) bit 1
*Source: [sound_field_test.asm](disasm/modules/68k/sound/sound_field_test.asm)*

---

### Sound Counter Check ($030A72–$030A84, 20 bytes)

Reads A6+$04 status byte. If zero, returns immediately. If non-zero, reads counter at A6+$06. If zero, branches to external handler. Otherwise decrements counter and returns.

- **Entry**: A6 = sound state pointer
- **Modifies**: D0 Fields accessed: A6+$04 (status), A6+$06 (counter)
*Source: [sound_counter_check.asm](disasm/modules/68k/sound/sound_counter_check.asm)*

---

### Sound Overflow Scan ($030AF8–$030B1A, 36 bytes)

Reads byte from A6+$02, adds to A6+$01. If carry (overflow), scans 10 entries at A6+$40 (spaced $30 bytes apart), incrementing $0E(A0) for each entry where byte at (A0) has bit 7 set.

- **Entry**: A6 = sound state pointer
- **Modifies**: D0, D1, A0 Fields accessed: A6+$01, A6+$02, A6+$40+n*$30
*Source: [sound_overflow_scan.asm](disasm/modules/68k/sound/sound_overflow_scan.asm)*

---

### Sound Buffer Clear ($030BE0–$030BF4, 22 bytes)

Clears 120 longwords ($1E0 bytes) starting at A6+$40, then sets byte at A6+$09 to $80.

- **Entry**: A6 = sound state pointer
- **Modifies**: D0, A0 Fields written: A6+$40 through A6+$21F, A6+$09
*Source: [sound_buffer_clear.asm](disasm/modules/68k/sound/sound_buffer_clear.asm)*

---

### Z80 Bus Wait ($030D1C–$030D4C, 50 bytes)

Requests Z80 bus, waits for grant, then checks sound driver status at Z80 RAM $A00FFF bit 7. If set (busy), releases bus, waits with NOPs, and retries. Returns when sound driver is ready.

- **Entry**: none
- **Modifies**: none (all implicit via hardware registers) Hardware: $A11100 (Z80 bus request), $A00FFF (sound driver status)
*Source: [z80_bus_wait.asm](disasm/modules/68k/sound/z80_bus_wait.asm)*

---

### Z80 Sound Write ($030DF4–$030E1E, 44 bytes)

Requests Z80 bus, waits for grant, reads channel volume from A5+$09, shifts right 3 and masks to 4 bits, writes to Z80 RAM at $A00FFD, then releases the bus.

- **Entry**: A5 = channel state pointer
- **Modifies**: D0 Hardware: $A11100 (Z80 bus request), $A00FFD (Z80 sound parameter) Fields accessed: A5+$09 (channel volume)
*Source: [z80_sound_write.asm](disasm/modules/68k/sound/z80_sound_write.asm)*

---

### Sound Subtract Field ($0311A8–$0311B6, 16 bytes)

Reads an indexed word from A6 structure, subtracts it from A5+$1E, then clears the indexed byte. D0.W contains the index (pre-doubled).

- **Entry**: D0 = index*2, A5 = channel state, A6 = sound state
- **Modifies**: D1 Fields accessed: A6+$12+D0.W (word), A5+$1E, A6+$10+D0.W (byte)
*Source: [sound_subtract_field.asm](disasm/modules/68k/sound/sound_subtract_field.asm)*

---

### Sound Set Position ($0311D8–$0311E0, 10 bytes)

Reads a byte from stream (A4)+, sign-extends to word, and stores to A5+$1E (position field).

- **Entry**: A4 = data stream pointer, A5 = channel state
- **Modifies**: D0 Fields written: A5+$1E
*Source: [sound_set_position.asm](disasm/modules/68k/sound/sound_set_position.asm)*

---

### Sound Load Pair ($031240–$031248, 10 bytes)

Reads one byte from (A4) without increment to A5+$12, then reads (A4)+ with increment to A5+$13. Both reads are from the same address (same byte value).

- **Entry**: A4 = data stream pointer, A5 = channel state
- **Modifies**: none Fields written: A5+$12, A5+$13
*Source: [sound_load_pair.asm](disasm/modules/68k/sound/sound_load_pair.asm)*

---

### Sound Add Transpose ($0312AC–$0312B2, 8 bytes)

Reads a byte from stream (A4)+ and adds it to A5+$09 (transpose).

- **Entry**: A4 = data stream, A5 = channel state
- **Modifies**: D0 Fields modified: A5+$09
*Source: [sound_add_transpose.asm](disasm/modules/68k/sound/sound_add_transpose.asm)*

---

### Sound PSG Write ($0314DC–$0314F4, 26 bytes)

Sets A5+$01 to $E0 (PSG latch byte), reads stream byte to A5+$25, then if bit 2 of (A5) is clear, writes the byte to PSG port $C00011.

- **Entry**: A4 = data stream, A5 = channel state
- **Modifies**: none Fields modified: A5+$01, A5+$25 Hardware: $C00011 (PSG data port)
*Source: [sound_psg_write.asm](disasm/modules/68k/sound/sound_psg_write.asm)*

---

### Sound Stream Jump ($031502–$03150C, 12 bytes)

Reads a big-endian 16-bit word from the data stream (A4), adds it as a signed displacement to A4, then adjusts by -1. Effectively a relative jump within the sound data stream.

- **Entry**: A4 = data stream pointer
- **Modifies**: D0, A4 (repositioned)
*Source: [sound_stream_jump.asm](disasm/modules/68k/sound/sound_stream_jump.asm)*

---

### Sound Add Volume ($031554–$03155A, 8 bytes)

Reads a byte from stream (A4)+ and adds it to A5+$08 (volume).

- **Entry**: A4 = data stream, A5 = channel state
- **Modifies**: D0 Fields modified: A5+$08
*Source: [sound_add_volume.asm](disasm/modules/68k/sound/sound_add_volume.asm)*

---

### Sound Flag Set ($03155C–$031562, 8 bytes)

Sets bit 7 of field $0A at A5 (enables channel processing).

- **Entry**: A5 = channel state pointer
- **Modifies**: none Fields modified: A5+$0A (bit 7 set)
*Source: [sound_flag_set.asm](disasm/modules/68k/sound/sound_flag_set.asm)*

---

### Sound Flag Clear ($031564–$03156A, 8 bytes)

Clears bit 7 of field $0A at A5 (disables channel processing).

- **Entry**: A5 = channel state pointer
- **Modifies**: none Fields modified: A5+$0A (bit 7 cleared)
*Source: [sound_flag_clear.asm](disasm/modules/68k/sound/sound_flag_clear.asm)*

---

### Sound Channel Mute ($03156C–$031572, 8 bytes)

Clears byte at A6+$00 (mutes channel by zeroing status).

- **Entry**: A6 = sound state pointer
- **Modifies**: D0 Fields modified: A6+$00
*Source: [sound_channel_mute.asm](disasm/modules/68k/sound/sound_channel_mute.asm)*

---

### Sound Set All Channels ($031650–$031664, 22 bytes)

Reads a byte from stream (A4)+ and writes it to offset $02 of each of 10 channel entries (spaced $30 bytes apart) starting at A6+$40.

- **Entry**: A4 = data stream, A6 = sound state
- **Modifies**: D0, D1, D2, A0 Fields modified: A6+$40+n*$30+$02 for n=0..9
*Source: [sound_set_all_channels.asm](disasm/modules/68k/sound/sound_set_all_channels.asm)*

---

### Sound Master Flag ($031680–$031686, 8 bytes)

Sets byte at A6+$38 to $80 (master sound flag).

- **Entry**: A6 = sound state pointer
- **Modifies**: none Fields modified: A6+$38
*Source: [sound_master_flag.asm](disasm/modules/68k/sound/sound_master_flag.asm)*

---

### Z80 Commands

*Source: [z80_commands.asm](disasm/modules/68k/sound/z80_commands.asm)*

---

## Util

### LZSS Decompressor ($0013B4–$001452, 160 bytes)

LZSS/LZ77-variant decompression algorithm. Uses a 16-bit flag word to distinguish literal bytes from back-references. Supports 8-bit offsets (1-byte header) and 13-bit offsets (2-byte header) with variable-length match encoding via bitstream flags.

- **Entry**: A0 = compressed source, A1 = decompression destination
- **Modifies**: D0-D6, A0, A1 (A7 for 2-byte flag buffer) Preserves: A2-A6 (except A7 modified then restored)
*Source: [lzss_decompress.asm](disasm/modules/68k/util/lzss_decompress.asm)*

---

### Counter Increment and Flag Set ($002200–$00220A, 12 bytes)

Increments a byte counter at $C828 and sets bit 1 of the control flag byte at $C80B. Used to signal a state change after counter update. MEMORY VARIABLES $FFFFC828  Byte counter (incremented by 1) $FFFFC80B  Control flags (bit 1 set)

- **Entry**: No register inputs
- **Returns**: Counter incremented, flag bit set
- **Modifies**: (none modified beyond RAM writes)
*Source: [counter_decrement_flag_set.asm](disasm/modules/68k/util/counter_decrement_flag_set.asm)*

---

### Data Unpack Nibbles ($004280–$0042BA, 58 bytes)

Unpacks packed nibble data from (A1)+ into byte fields at A2+$09 through A2+$0F. Reads 2 bytes + 1 word, splits each byte into high/low nibbles.

- **Entry**: A1 = source data, A2 = destination structure
- **Modifies**: D0, A1 (advances)
*Source: [data_unpack_nibbles.asm](disasm/modules/68k/util/data_unpack_nibbles.asm)*

---

### Word Pack and Swap (VDP Command Format) ($00482A–$004836, 12 bytes)

Packs D0 value with VDP flag bit: shift left 2, shift low word right 2, set bit 14, swap words.

- **Entry**: D0 = value
- **Returns**: D0 = packed VDP command
- **Modifies**: D0
*Source: [word_pack_swap.asm](disasm/modules/68k/util/word_pack_swap.asm)*

---

### Nibble Unpack (4 bytes to 7 nibbles) ($00839A–$0083BC, 34 bytes)

Unpacks 4 bytes from (A4) into 7 nibble-separated bytes at (A1)+. Bytes 0,1,3 split into high/low nibbles; byte 2 stored as-is.

- **Entry**: A4 = source (4 bytes), A1 = destination (7 bytes)
- **Modifies**: D1, D2, A1 (advances)
*Source: [nibble_unpack.asm](disasm/modules/68k/util/nibble_unpack.asm)*

---

### Random Number Generation ($00496E)

Pseudo-random number generator using Linear Congruential Generator (LCG). The algorithm multiplies the seed by 41 using shifts and adds, then combines the high and low words for the output. ALGORITHM new_seed = old_seed * 41 output = (new_seed.low + new_seed.high) & $FFFF Multiplication by 41 is computed as: ((seed << 2) + seed) << 3) + seed = (5 << 3 + 1) * seed = 41 * seed MEMORY | Address | Name        | Purpose                    | |---------|-------------|----------------------------| | $EF00   | RANDOM_SEED | 32-bit seed storage        | - Seed of 0 is replaced with default $2A6D365A - D0 returns random value, D1 preserved - Called 6 times per frame Dependencies: None (standalone utility) Related: game_logic.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [random.asm](disasm/modules/68k/util/random.asm)*

---

### Utility Functions ($0049xx)

General-purpose utility functions used throughout the game: - Random number generation - V-blank synchronization - Display parameter initialization RANDOM NUMBER GENERATOR Uses a Linear Congruential Generator (LCG) stored at $EF00.W (4 bytes). Algorithm: seed = seed * 41 (via shifts and adds) Returns 16-bit random value in D0 V-BLANK SYNCHRONIZATION WaitForVBlank sets V-INT state to 4 and waits for the V-INT handler to process it, providing frame synchronization. Dependencies: V-INT handler Related: vint_handler.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [utilities.asm](disasm/modules/68k/util/utilities.asm)*

---

## Vdp

### VDP Data Fill ($0010C4–$0010DA, 24 bytes)

2D block transfer from RAM to VDP data port. Writes words from (A0)+ to VDP port (A6) in a nested loop, advancing the VDP address by $01000000 per outer iteration.

- **Entry**: A0 = source data, A5 = VDP control port, A6 = VDP data port D0 = VDP address command, D1 = inner count, D2 = outer count
- **Modifies**: D0, D1, D3, D4, A0
*Source: [vdp_data_fill.asm](disasm/modules/68k/vdp/vdp_data_fill.asm)*

---

### VDP Data Fill Constant ($0010DC–$0010F2, 24 bytes)

Fills VDP region with a constant word value D3. Same structure as vdp_data_fill but writes D3 instead of (A0)+.

- **Entry**: A5 = VDP control port, A6 = VDP data port D0 = VDP address command, D1 = inner count, D2 = outer count D3 = constant value to fill
- **Modifies**: D0, D1, D4, D5
*Source: [vdp_data_fill_constant.asm](disasm/modules/68k/vdp/vdp_data_fill_constant.asm)*

---

### VDP Register Write (Multi-Register Save) ($001454–$001480, 46 bytes)

Converts a linear VRAM address in D0 to VDP command format and writes it atomically to VDP control port (A5) with interrupts disabled. Saves/restores D0, D6, D7 via stack. VDP command format: bits 31-16 = address[13:0] | $4000, bits 15-0 = address[15:14]

- **Entry**: D0 = 24-bit VRAM address, A5 = VDP control port
- **Modifies**: D0, D6, D7 (saved/restored)
*Source: [vdp_reg_write_multi.asm](disasm/modules/68k/vdp/vdp_reg_write_multi.asm)*

---

### VDP Register Write (Simple) ($001482–$0014A0, 32 bytes)

Compact VDP VRAM write command builder. Converts D0 low 14 bits to VDP command format and writes atomically. Only saves/restores D0.

- **Entry**: D0 = VRAM address, A5 = VDP control port
- **Modifies**: D0 (saved/restored)
*Source: [vdp_reg_write_simple.asm](disasm/modules/68k/vdp/vdp_reg_write_simple.asm)*

---

### VDP CRAM Read Setup ($0014A2–$0014BC, 28 bytes)

Sets up VDP for CRAM read access. Masks address to 7 bits (CRAM has 128 bytes / 64 entries), adds $C000 read command prefix.

- **Entry**: D0 = CRAM address, A5 = VDP control port
- **Modifies**: D0 (saved/restored)
*Source: [vdp_reg_write_read.asm](disasm/modules/68k/vdp/vdp_reg_write_read.asm)*

---

### VDP Tile Expansion Functions ($00247C - $0024AC) ($00247C–$0024AC, 48 bytes)

Expands packed nibble tile data to VDP format. Each source byte contains two 4-bit tile indices that are expanded to 16-bit VDP tile references. Called 24 times per frame - highest frequency VDP function. MEMORY MAP | Address    | Name           | Purpose                        | |------------|----------------|--------------------------------| | $C00000    | VDP_DATA       | VDP data port (A6 register)    | | $C00004    | VDP_CTRL       | VDP control port (A5 register) | ALGORITHM For each input byte at (A0)+: 1. Extract high nibble (bits 7-4) → D0 2. Extract low nibble (bits 3-0) → D1 3. Add tile base ($E001) to each → VDP tile reference 4. Write both words to VDP data port TILE FORMAT VDP tile reference word: Bits 15-13: Priority, palette, V/H flip Bits 10-0:  Tile index in VRAM $E001 = 1110 0000 0000 0001 = Priority=1, Palette=3, VFlip=0, HFlip=0, Tile=1 Dependencies: VDP initialized, A5=VDP_CTRL, A6=VDP_DATA Related: vdp_handlers.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [tile_expand.asm](disasm/modules/68k/vdp/tile_expand.asm)*

---

### VDP Fill Frame Buffer ($00273C–$002778, 62 bytes)

Fills the entire 32X VDP frame buffer with zeros (screen clear). Uses hardware fill register with 256-pixel line stride for 256 lines.

- **Entry**: none
- **Modifies**: A2, A3, A4, D0, D1, D2, D7
*Source: [vdp_fill_framebuffer.asm](disasm/modules/68k/vdp/vdp_fill_framebuffer.asm)*

---

### VDP Clear Palette ($00277A–$002796, 30 bytes)

Clears all 256 CRAM palette entries to 0 (black).

- **Entry**: D0 = fill value (typically 0)
- **Modifies**: A2, D7
*Source: [vdp_clear_palette.asm](disasm/modules/68k/vdp/vdp_clear_palette.asm)*

---

### VDP Fill Line Table (Flat) ($002798–$0027B4, 30 bytes)

Fills VDP line table with constant value for all 224 display lines.

- **Entry**: none
- **Modifies**: A1, D2, D7
*Source: [vdp_fill_line_table_flat.asm](disasm/modules/68k/vdp/vdp_fill_line_table_flat.asm)*

---

### VDP Fill Line Table (Ramp) ($0027B6–$0027D8, 36 bytes)

Fills line table with incrementing addresses for linear scanline display.

- **Entry**: none
- **Modifies**: A1, D0, D1, D7
*Source: [vdp_fill_line_table_ramp.asm](disasm/modules/68k/vdp/vdp_fill_line_table_ramp.asm)*

---

### VDP Operations ($0027F8 - $002900) ($0027F8–$002900, 264 bytes)

VDP (Video Display Processor) access functions for the 32X. These functions use the MARS system registers at $A15100 to control the 32X VDP. 32X VDP REGISTERS (MARS) | Address   | Name           | Purpose                              | |-----------|----------------|--------------------------------------| | $A15100   | MARS_SYS_BASE  | System register base                 | | $A15184   | +$84           | VDP fill length                      | | $A15186   | +$86           | VDP fill address                     | | $A15188   | +$88           | VDP fill data                        | | $A1518B   | +$8B           | VDP status (bit 1 = busy)            | | $A15200   | CRAM_BASE      | Color RAM base (palette)             | FILL OPERATION VDP fill writes a pattern to VRAM. The process: 1. Set fill length at $A15184 2. Write address to $A15186 3. Write data to $A15188 4. Wait for busy bit to clear 5. Repeat for next address Dependencies: 32X adapter must be initialized Related: adapter_init.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [vdp_operations.asm](disasm/modules/68k/vdp/vdp_operations.asm)*

---

### VDP Fill Pattern ($00281E–$00284A, 46 bytes)

Fills a VDP region at address $1F00 with pattern $0101.

- **Entry**: none
- **Modifies**: A2, A3, A4, D0, D1
*Source: [vdp_fill_pattern.asm](disasm/modules/68k/vdp/vdp_fill_pattern.asm)*

---

### Palette Copy Full ($00284C–$002860, 22 bytes)

Copies 512 bytes from (A2) to CRAM palette (full 256 entries).

- **Entry**: A2 = source palette data
- **Modifies**: A2, A3, D7
*Source: [palette_copy_full.asm](disasm/modules/68k/vdp/palette_copy_full.asm)*

---

### Palette Copy Partial ($002862–$002876, 22 bytes)

Copies 128 bytes to CRAM starting at offset $40 (entries 32-63).

- **Entry**: A2 = source palette data
- **Modifies**: A2, A3, D7
*Source: [palette_copy_partial.asm](disasm/modules/68k/vdp/palette_copy_partial.asm)*

---

### Frame Buffer Setup ($007270–$00727E, 16 bytes)

Loads frame buffer base address into A2, calls a setup subroutine, then stores D4 to a frame buffer control register.

- **Entry**: D4 = value to store
- **Modifies**: A2
- **Calls**: Subroutine at $7280 (via BSR.S)
*Source: [framebuffer_setup.asm](disasm/modules/68k/vdp/framebuffer_setup.asm)*

---

## Vint

### V-INT (Vertical Interrupt) Handler Helpers ($002010 - $002038) ($002010–$002038, 40 bytes)

Helper functions called by the V-INT handler for cleanup and state management at the end of vertical blank processing. MEMORY MAP | Address    | Name              | Purpose                       | |------------|-------------------|-------------------------------| | $FFFFC87E  | VINT_STATE_FLAG   | V-INT state flag (word)       | | $FFFFC8C4  | COMM_DONE_FLAG    | Communication done flag       | | $FFFFC8C5  | CURRENT_STATE     | Current V-INT state byte      | MARS REGISTERS | Address    | Name              | Purpose                       | |------------|-------------------|-------------------------------| | $A15123    | MARS_COMM_CTRL    | COMM control (bit 0 = flag)   | Dependencies: V-INT handler, SH2 communication Related: frame_sync.asm, sh2_communication.asm Format: Proper mnemonics with original bytes in comments for verification

*Source: [vint_handlers.asm](disasm/modules/68k/vint/vint_handlers.asm)*

---

