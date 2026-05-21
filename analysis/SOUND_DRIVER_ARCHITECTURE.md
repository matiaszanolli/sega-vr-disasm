# Sound Driver Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

The sound system is a **68K-resident, per-frame tick-based sequencer** controlling three sound chips. Contrary to many Genesis/32X games, the 68K handles all FM and PSG synthesis directly — the Z80 only runs a tiny 653-byte DAC sample playback program.

**Key facts:**
- **ROM footprint:** $030000-$034200 (~17KB code + data)
- **RAM state:** $FF8500-$FF8890 (912 bytes, base in A6)
- **18 channels:** 1 DAC + 6 FM + 3 PSG + 6 SFX overlay + 2 special
- **Channel struct size:** $30 bytes (48 bytes) per channel
- **Sound chips:** YM2612 (FM), SN76489 (PSG), Z80-hosted DAC
- **95 source modules** across `disasm/modules/68k/sound/` (28) and `disasm/modules/68k/game/sound/` (67)

---

## 2. Hardware Interfaces

### YM2612 (FM Synthesis) — 6 channels

| Port | Address | Function |
|------|---------|----------|
| Port 0 addr | `$A04000` | Register address (channels 1-3) |
| Port 0 data | `$A04001` | Register data |
| Port 1 addr | `$A04002` | Register address (channels 4-6) |
| Port 1 data | `$A04003` | Register data |

All writes require: (1) Z80 bus ownership (`$A11100 = $0100`), (2) busy-wait on bit 7 of `$A04000`.

**Key FM registers:**

| Register | Purpose |
|----------|---------|
| `$28` | Key on/off (operator mask + channel) |
| `$27` | Timer / special mode control |
| `$2B` | DAC enable ($80 = on) |
| `$A0`/$A4` | Frequency LSB/MSB per channel |
| `$B0` | Feedback/algorithm per channel |
| `$B4` | L/R panning + LFO per channel |

**Write wrapper hierarchy:**
- `fm_write_wrapper` ($030CBA) — bus request + write + release
- `fm_write_cond` ($030CCC) — adds channel offset, checks key-off flag
- `fm_write_port_0_1` ($030CF4) — channel-offset write to port 1
- `fm_cond_write_with_bus` ($030CA2) — key-off check + bus acquire + write + release

### SN76489 (PSG) — 3 tone + 1 noise channel

Single write port at `$C00011`. Latch byte format: `{1, channel[1:0], type, data[3:0]}`.

Silence all: write `$9F`, `$BF`, `$DF`, `$FF` (max attenuation per channel).

128-entry frequency lookup table at ROM $030FE0 for note-to-frequency conversion.

### Z80 Communication

The Z80 runs independently. Three mailbox bytes in Z80 RAM:

| Address | Purpose | Direction |
|---------|---------|-----------|
| `$A00FFD` | DAC volume (4-bit) | 68K → Z80 |
| `$$A00FFE` | DAC sample select / command | 68K → Z80 |
| `$A00FFF` bit 7 | Z80 busy flag | Z80 → 68K |

**Bus protocol:** Request `$A11100=$0100`, poll bit 0 of `$A11100` until granted, check `$A00FFF` bit 7 (retry with NOP delay if busy), perform work, release `$A11100=$0000`.

---

## 3. Game-Level Sound Commands

Game code never calls the driver directly. It writes command bytes to RAM mailbox slots; frame dispatchers relay them.

### Three-Priority Mailbox System

| Priority | Mailbox | Purpose | De-dup |
|----------|---------|---------|--------|
| 1 (high) | `$C822` | Music commands (mode changes, race start) | Clears both $C822 and $C8A4 |
| 2 | `$C8A5` | SFX (collision, tire squeal, race events) | Skips if same as `$C8A7` (last sent) |
| 3 (low) | `$C8A4` | BGM / ambient (background effects) | Tracked in `$C8A6` |

**Dispatcher:** `sound_command_dispatch_sound_driver_call` at ROM $002080 (86 bytes)
- Source: [sound_command_dispatch_sound_driver_call.asm](disasm/modules/68k/game/race/sound_command_dispatch_sound_driver_call.asm)
- Reads mailboxes in priority order, copies to driver state `$8509`/`$850A`, calls `JSR $008B0000`

**Frame integration:** `sound_update_disp` at ROM $0020D6 (280 bytes) provides 7 entry points for different game states. All call `JSR $008B0000` then chain to engine sound frequency calculation.
- Source: [sound_update_disp.asm](disasm/modules/68k/game/state/sound_update_disp.asm)

**Engine sound:** After the driver tick, `audio_frequency_update` ($00220C) computes engine pitch via weighted shift average + base frequency `$1A5E`, clamped to `[$1A5E, $1E00]`, stored at `$8760`/`$8790`.

---

## 4. Sound Driver Core ($030000)

CPU address `$008B0000` (file offset `$030000`). Two entry points:

### Entry 1 — Main Tick ($030008)

Called once per frame. The complete tick loop:

```
1. LEA $FF8500,A6              // load driver state base
2. CLR.B A6+$0E                // clear tick phase flag
3. TST.B A6+$07                // mute-all flag?
4. If set → skip to $030482    // (silence, no processing)
5. JSR fm_fade_in_out_proc     // ($030D4E) fade processing
6. JSR fm_envelope_tick_update // ($030AF8) advance envelopes
7. JSR fm_full_silence         // ($030A72) handle silence state
8. Check A6+$0A → JSR fm_sound_priority_check ($030536)
9. JSR fm_sound_command_disp   // ($03056A) dispatch new command
10. DAC channel tick            // (A6+$40) → Z80 $A00FFE
11. FM channel loop ×6          // (A6+$70, stride $30)
    → sequence read → frequency → YM2612
12. PSG channel loop ×3         // (A6+$190, stride $30)
    → sequence read → frequency → SN76489
13. SFX channel loops           // (A6+$220, 6 FM + PSG overlays)
14. Special channel loop ×2     // (A6+$340, A6+$370)
15. RTS
```

### Entry 2 — Z80 Upload + Reset ($030BF6)

Uploads Z80 program (653 bytes from ROM $031688) to Z80 RAM `$A00000`, DAC samples (4096 bytes from ROM $031915) to `$A01000`, resets Z80 via toggle, falls through to full silence.

---

## 5. Driver State ($FF8500)

### Global Header ($00-$3F, 64 bytes)

| Offset | Size | Name | Description |
|--------|------|------|-------------|
| `+$00` | byte | priority | Current music priority level |
| `+$01` | byte | speed | Playback speed |
| `+$02` | byte | tempo | Tempo multiplier |
| `+$04` | byte | frame_counter | Frames until envelope tick (init: 5) |
| `+$06` | byte | tick_rate | Reset to 1 each tick |
| `+$07` | byte | mute_all | Nonzero = skip entire driver tick |
| `+$08` | byte | cmd_sentinel | Cleared each tick, set to $80 after |
| `+$09` | byte | active_cmd | Active command ($80 = none) |
| `+$0A` | byte | new_cmd | Pending command from game |
| `+$0E` | byte | tick_phase | 0→$80 (music)→$40 (SFX) during tick |
| `+$0F` | byte | panning_mode | Nonzero = alternate panning table |
| `+$30` | long | seq_ptr | Master sequence data pointer |
| `+$34` | long | sfx_seq_ptr | SFX sequence data pointer |
| `+$38` | byte | fade_state | 0=off, 1=active, 2=complete |
| `+$39` | byte | dac_fade_rate | Per-frame DAC fade step |
| `+$3A` | byte | fm_fade_rate | Per-frame FM fade step |
| `+$3B` | byte | psg_fade_rate | Per-frame PSG fade step |

### Channel Map (18 channels, $30 bytes each)

| Offset | Count | Type | Hardware Target |
|--------|-------|------|----------------|
| `+$0040` | 1 | DAC | Z80 $A00FFD/$A00FFE |
| `+$0070` | 6 | FM | YM2612 channels 1-6 |
| `+$0190` | 3 | PSG | SN76489 tone channels 0-2 |
| `+$0220` | 6 | SFX-FM | YM2612 (overlays music FM channels) |
| `+$0340` | 1 | Special A | DAC overlay |
| `+$0370` | 1 | Special B | Noise overlay |

Total: 18 × $30 = $360 bytes. Global + channels = $3A0 (928 bytes).

### Per-Channel Structure ($30 = 48 bytes)

| Offset | Size | Name | Description |
|--------|------|------|-------------|
| `+$00` | byte | flags | bit7=active, bit4=sustain, bit2=key-off, bit1=mute |
| `+$01` | byte | reg_num | FM register / PSG channel ID |
| `+$02` | byte | tempo | Per-channel tempo divider |
| `+$03` | byte | multiplier | Pitch scaling factor |
| `+$04` | long | seq_ptr | Current sequence data pointer |
| `+$08` | word | init_freq | Initial/base frequency |
| `+$09` | byte | envelope | Envelope position / volume |
| `+$0A` | byte | instrument | Instrument index (bit 7 = special) |
| `+$0B` | byte | env_num | Envelope table index |
| `+$0C` | byte | env_counter | Envelope position counter |
| `+$0D` | byte | stride | Struct stride ($30, for iteration) |
| `+$0E` | byte | duration | Duration timer (ticks remaining) |
| `+$0F` | byte | dur_reload | Duration reload value |
| `+$10` | word | note_freq | Current note frequency |
| `+$18-$1B` | 4B | vibrato | Vibrato parameters |
| `+$1C` | word | vib_accum | Vibrato accumulator |
| `+$1E` | word | base_freq | Base frequency for reader |
| `+$20` | long | sub_seq | Sub-sequence pointer (call/return) |
| `+$25` | byte | psg_noise | PSG noise register value |
| `+$26` | byte | seq_pos | Sequence position counter |
| `+$27` | byte | panning | FM panning ($C0 = center stereo) |

---

## 6. FM Synthesis Engine

### Instrument Loading

**Music instruments ($81-$9F):** `fm_instrument_setup` at $03061C
- Source: [fm_instrument_setup.asm](disasm/modules/68k/game/sound/fm_instrument_setup.asm)
- Reads 6-byte header from table at $032AB8: `{seq_offset(word), fm_count(byte), psg_count(byte), tempo(byte), multiplier(byte)}`
- Sets up N FM channels (stride $30) with register assignments from table at $03078C
- Sets up M PSG channels at A6+$0190
- If `fm_count == 7`, enables DAC mode (register $2B = $80)
- Marks conflicting SFX channels for key-off

**SFX instruments ($A0-$D2):** `fm_channel_reg_map_instrument_loader_b` at $030798
- Uses SFX channel slots at A6+$0220
- Resolves target via pointer table at $030852
- Handles PSG noise ($C0 type) with direct writes

**Special SFX ($D6-$D7):** `fm_channel_pointer_table_sfx_loader` at $030892
- Uses special slots A6+$0340 (DAC) and A6+$0370 (noise)
- 2 entries in table at $008B921C

### TL Scaling

Table at $031352 (8 bytes, one per algorithm 0-7) determines which operators get volume scaling. This correctly implements YM2612 algorithm-dependent carrier volume control — only output operators are scaled, not modulators.

### Key-On/Off Protocol

- Key-on: write `channel_id | $F0` to register $28 (all 4 operators on)
- Key-off: write `channel_id | $00` to register $28
- Panning default: register $B4 = $C0 (stereo center, L+R)

---

## 7. PSG Engine

- 3 tone channels at A6+$0190 (stride $30)
- 128-entry frequency table at ROM $030FE0 (256 bytes), indexed by note + transpose
- Volume envelope tables via pointer table at ROM $0329FA
- Envelope special commands: $80=loop, $81=rewind, $82=set position, $83=reinit
- Writes: channel_id OR'd with `(volume + $10)`, direct to `$C00011`
- Noise channel at A6+$0370 uses channel byte from `+$25`

---

## 8. Sequence Engine

Both FM and PSG channels share a byte-stream sequence engine.

### Data Stream Format

Processed per-channel each frame from the pointer at channel+$04:

| Byte Range | Meaning |
|------------|---------|
| `$00-$7F` | Duration/rest value |
| `$80-$DF` | Note-on (stores to +$10, next byte = duration) |
| `$E0-$FF` | Special command (32-entry jump table at $031094) |

### Special Commands ($E0-$FF)

32 commands dispatched via jump table at $031094:

| Command | Purpose |
|---------|---------|
| `$E0` | Set tempo |
| `$E1` | Set transpose |
| `$E2` | Set vibrato parameters |
| `$E3` | Set portamento |
| `$E4` | Volume adjust |
| `$E5-$E7` | Envelope, instrument, pitch bend |
| `$E8-$EF` | Various channel control |
| `$F0-$FF` | Extended (secondary dispatch at $03111A): Z80 DAC, base frequency, pitch bend direction |

### Sequence Reader Special Bytes (at $0302EE)

| Byte | Effect |
|------|--------|
| `$80` | Restart (reset position to 0) |
| `$81` | Rewind 2 positions |
| `$82` | Set position from next data byte |
| `$83` | Reinit (key-on or PSG volume set) |
| `$84` | Add to pitch multiplier |

### Call/Return Stack

`sequence_call_return_stack` at $031528 supports nested sequence calls. The current sequence pointer (A4) is pushed to the channel struct, a new pointer is loaded, and on return the original is popped. Enables music phrases to be reused across channels.

### Loop Counter

`sequence_loop_counter` at $031528 area supports counted loops within sequences, decrementing a counter and branching back to a stored position.

---

## 9. Fade System

`fm_fade_in_out_proc` at $030D4E — called first in the main tick.

**State machine at A6+$38:**
- 0 = off (no fade active)
- 1 = active (fading)
- 2 = complete

**Separate rates:** DAC (+$39), FM (+$3A), PSG (+$3B). Each frame, the rate is subtracted from (fade out) or added to (fade in) each channel's envelope position.

Set by sequence command via `sequence_fade_rate_set` at $031666.

---

## 10. SFX Priority System

128-byte priority table at ROM $032B30 (one byte per command ID $00-$7F).

`fm_sound_priority_check` at $030536: new commands accepted only if `new_priority >= current_priority`. Values: $80 (highest, most instruments), $7E (SFX), lower values for ambient.

SFX channels (A6+$0220) overlay the music FM channels. When an SFX starts, it saves the music channel state; when SFX ends, music resumes (`fm_channel_resume_panning`).

---

## 11. Z80 DAC Subsystem

### Program Upload

`z80_sound_program_upload_fm_key_on` at $030BF6:
1. Request Z80 bus, assert Z80 reset
2. Copy 653 bytes from ROM $031688 → Z80 RAM $A00000
3. Copy 4096 bytes from ROM $031915 → Z80 RAM $A01000 (DAC samples)
4. Release Z80 reset (14 NOP delay for stabilization)
5. Release Z80 bus

### Z80 Program

- Size: 653 bytes ($28D)
- Location: ROM $031688, uploaded to Z80 $A00000
- Function: DAC sample playback loop
- NOT disassembled into Z80 mnemonics (raw dc.w data in `code_30200.asm`)
- Communication: polls $A00FFD (volume), $A00FFE (sample select), sets $A00FFF bit 7 (busy)

### DAC Sample Data

- Size: 4096 bytes ($1000)
- Location: ROM $031915, uploaded to Z80 $A01000
- Format: likely 8-bit unsigned PCM

---

## 12. ROM Data Tables

| ROM Offset | CPU Address | Size | Content |
|------------|-------------|------|---------|
| `$030000` | `$008B0000` | 8 | Two entry JMPs |
| `$030008` | `$008B0008` | ~$AE | Main tick loop |
| `$030FE0` | `$008B0FE0` | 256 | PSG 128-entry frequency table |
| `$031352` | `$008B1352` | 8 | TL scaling table (per algorithm) |
| `$031688` | `$008B1688` | 653 | Z80 DAC program |
| `$031915` | `$008B1915` | 4096 | DAC sample data |
| `$032AB8` | `$008B2AB8` | ~124 | Music instrument pointer table ($81-$9F) |
| `$032B30` | `$008B2B30` | 128 | Priority table (1 byte per command) |
| `$032936` | `$008B2936` | var | FM sequence pointer table |
| `$0329FA` | `$008B29FA` | var | PSG envelope data pointer table |
| `$008B9150` | — | var | SFX instrument pointer table ($A0-$D2) |
| `$008B921C` | — | var | Special SFX pointer table ($D6-$D7) |

---

## 13. Game Integration

### Data Flow

```
Game code writes: $C822 (high), $C8A5 (SFX), $C8A4 (low)
        │
        ▼
sound_command_dispatch ($002080)
  ├── Copies to $8509/$850A (driver state)
  └── JSR $008B0000
        │
        ▼
sound_driver_tick ($030008)
  1. Fade processing
  2. Envelope advance
  3. Priority check + command dispatch
  4. Per-channel: sequence → hardware
     ├── DAC: → Z80 $A00FFD/$A00FFE
     ├── FM:  → YM2612 $A04000-$A04003
     └── PSG: → SN76489 $C00011
  5. RTS
        │
        ▼
audio_frequency_update ($00220C)
  └── Engine sound pitch calculation (post-driver)
```

### Command Byte Ranges

| Range | Handler | Purpose |
|-------|---------|---------|
| `$00` | $030BF6 | Stop + Z80 reset |
| `$01-$7F` | $030B90 | Note-on |
| `$80` | — | Sentinel (no-op) |
| `$81-$9F` | $03061C | Music instruments (table at $032AB8) |
| `$A0-$D2` | $030798 | SFX instruments (table at $008B9150) |
| `$D6-$D7` | $030892 | Special SFX (table at $008B921C) |
| `$D3-$D5, $D8-$EF` | RTS | Ignored |
| `$F0` | $030A5C | Full silence + stop |
| `$F1` | $03094E | Channel stop + SFX cleanup |
| `$F2` | $0309F2 | Special channel cleanup |
| `$F3-$FE` | $030B90 | Full driver reset |

### Game-Side RAM Variables

| Address | Purpose |
|---------|---------|
| `$C822` | High-priority sound command |
| `$C823` | Audio trigger flag |
| `$C8A2` | Tire squeal cooldown timer |
| `$C8A4` | Low-priority sound command |
| `$C8A5` | SFX command |
| `$C8A6` | Last sent SFX B (tracking) |
| `$C8A7` | Last sent SFX A (de-duplication) |
| `$8509` | Driver state: Z80 command A |
| `$850A` | Driver state: Z80 command B |
| `$8760` | Engine sound: channel A frequency |
| `$8790` | Engine sound: channel B frequency |
