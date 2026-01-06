# 68000 Sound Driver Ver. 3.00

**Document Number:** MAR-61-E-040695

**PRELIMINARY VERSION**

**PROPERTY OF SEGA**

SEGA Enterprises, Ltd.

---

## Introduction

The 68000 Sound Driver Version 3.00 (hereinafter "V3") is designed to fully exploit the sound source that is incorporated into the SUPER32X.

---

## Sound Driver Specifications

### Target Sound Sources

- **FM:** 5 or 6-sound
- **PSG:** Tone × 3 + Noise × 1
- **PWM:** 4-sound
- **PCM:** 0-2 sound (8-bit linear or SEGA 4-bit delta format)

### Resource Requirements

| Resource | Value |
|----------|-------|
| **Driver size (68000)** | Approximately 3000H (including Z80 driver (*1)) |
| **Work size** | Approximately 0B00H |
| **CPU load (68000) - IDLE** | Approximately 1% |
| **CPU load (68000) - Music playing** | Approximately 9% |
| **CPU load (68000) - SE (per channel)** | Approximately 0.5% |
| **CPU load (Z80)** | 100% (exclusive use) |

(*1) If PCM is not used, the driver size decreases by approximately 1300H.

### Number of Tracks

- **Music:** 14-16 tracks (varies with the PCM driver)
- **SE:** 5 tracks

### Remarks

- A software envelope is provided as a PSG
- Two types of software vibrato functions are provided as an FM/PSG
- These resources endow the sound sources with the same "look and feel"
- A drum kit can be created as an FM sound source

---

## Activating the Sound Driver

The following procedures are used to control the Sound Driver:

1. **Use a system call** (described later)
2. **Call the starting address** (at each V-INT, approximately 16 ms)

See the system call column later in this chapter for a method for requesting sound data.

### Required Operations

- **Initialize** the Sound work space
- **Call Sound Driver** at each V-INT (approximately 16 ms)

---

## Memory Map

The Sound Driver operates under the following memory map:

### ROM Memory Map

```
┌─────────────────────────────────────────────┐
│ Sound Driver [approximately 3000H]          │
│   Sound Driver system unit                  │
├─────────────────────────────────────────────┤
│ Data vectors (offset address) [4x8 bytes]   │
├─────────────────────────────────────────────┤
│ PCM data [undefined]                        │
├─────────────────────────────────────────────┤
│ PWM data [undefined]                        │
├─────────────────────────────────────────────┤
│ Music data [undefined]                      │
├─────────────────────────────────────────────┤
│ SE data [undefined]                         │
├─────────────────────────────────────────────┤
│ Table envelope data                         │
│ (undefined, in units of 100H bytes)         │
├─────────────────────────────────────────────┤
│ Table vibrato data                          │
│ (undefined, in units of 100H bytes)         │
├─────────────────────────────────────────────┤
│ Rhythm kit data                             │
│ (undefined, in units of 8 bytes)            │
├─────────────────────────────────────────────┤
│ FM sound source data                        │
│ (undefined, in units of 25 bytes)           │
└─────────────────────────────────────────────┘
```

### RAM Memory Map

```
┌─────────────────────────────────────────────┐
│ Common work space                           │
│ [60-70H (varies with number of PCM sounds)] │
├─────────────────────────────────────────────┤
│ Channel work space                          │
│ [60H × channels (for all music and SE)]     │
├─────────────────────────────────────────────┤
│ YM-2612 write buffer [200H bytes]           │
└─────────────────────────────────────────────┘
```

---

## Fill-in Data

The Driver is filled with the following information at a distance of **0CH** from the starting address:

| Offset | Meaning | Size |
|--------|---------|------|
| +00H | Work space starting address | 4 bytes |
| +04H | Work space size | 4 bytes |
| +08H | PCM type (00H: none, 10H: linear, 20H: delta) | 1 byte |
| +09H | Number of sounds generated from PCM sound source | 1 byte |
| +0AH | Number of sounds generated from FM sound source | 1 byte |
| +0BH | Number of sounds generated from PSG sound source | 1 byte |
| +0CH | Number of sounds generated from PWM sound source | 1 byte |
| +0DH | Total number of tracks | 1 byte |
| +0EH | Total number of tracks per music | 1 byte |
| +0FH | Total number of tracks per SE | 1 byte |
| +10H | Driver version number | 1 byte |
| +11H | Reserved | 6 bytes |

---

## System Calls

The V3 uses system calls to support driver controls. This enables the V3 to accommodate driver version upgrades, as well as work-space changes, without requiring a modification of the V3 itself.

Although it is possible to control the driver by directly rewriting the work space, as has been done in the past, to provide for future version upgrades it is **recommended that the driver be controlled by means of system calls**.

### How to Call

1. Set the desired system call number in register **DO**
2. Set register values as necessary
3. Call the address obtained by adding **8** to the starting address of the Sound Driver

### List of System Calls

| Number | Operation | Input Register | Output Register | Destroyed Register |
|--------|-----------|----------------|-----------------|-------------------|
| **00H** | Initialize Sound work space and hardware | DO.b, DL.b | - | - |
| **01H** | Request music | DO.b, DL.b | - | DO/AO |
| **02H** | Request SE | DO.b, DL.b | - | DO/AO |
| **03H** | Set fade-in/out | DO.b, DL.w | - | - |
| **04H** | Set music master volume | DO.b, DL.b | - | - |
| **05H** | Set SE master volume | DO.b, DL.b | - | - |
| **06H** | Set music master transpose | DO.b, DL.b | - | - |
| **07H** | Set SE master transpose | DO.b, DL.b | - | - |
| **08H** | Set pause | DO.b | - | - |
| **09H** | Reset pause | DO.b | - | - |
| **0AH** | Write communication data | DO.b, DL.b | - | - |
| **0BH** | Read communication data | DO.b | DL.b | - |
| **0CH** | Request to stop music | DO.b | - | DO/AO/A2 |
| **0DH** | Request to stop SE | DO.b | - | - |

---

## System Call Details

### 00H - Initialize Sound Driver

**Function:** Initialize the Sound Driver and the hardware around the Sound Driver.

**Input:**
- `DO.b` = 00H
- `DL.b` = Sets NTSC/PAL
  - `0` = Sets to NTSC
  - `2` = Sets to PAL

**Output:** None

**Destruction:** None

### 01H - Request Music

**Function:** Performs music.

**Input:**
- `DO.b` = 01H
- `DL.b` = Piece number

**Output:** None

**Destruction:** DO/AO

**Remarks:** Because of a 4-byte request buffer, sounds can be produced in a maximum of four simultaneous interrupts (common to the SE number). Some request numbers can cause SE to be performed (music numbers are not checked).

### 02H - Request SE

**Function:** Produces SE sounds.

**Input:**
- `DO.b` = 02H
- `DL.b` = SE number

**Output:** None

**Destruction:** DO/AO

**Remarks:** Because of a 4-byte request buffer, sounds can be produced in a maximum of four simultaneous interrupts (common to the music piece number). Some request numbers can cause music to be performed (music numbers are not checked).

### 03H - Fade Request

**Function:** Sets the fade-in/out option.

**Input:**
- `DO.b` = 03H
- `DL.w` = Fade value

**Fade Value Format:**
```
Bits 15-8: Fading depth
Bits  7-0: Fading speed
```

**Output:** None

**Destruction:** None

**Remarks:**
- Fade-in operations can be performed by setting the fading depth to a negative number (2's complement)
- Allowable range of fading speed: 00H-7FH (in units of V-int)

### 04H - Set Master Music Volume

**Function:** Sets the volume for the entire music.

**Input:**
- `DO.b` = 04H
- `DL.b` = Volume

**Output:** None

**Destruction:** None

**Remarks:** Allowable range of volume: 00H-7FH, where 00H indicates maximum volume, and 7FH indicates mute.

### 05H - Set Master SE Volume

**Function:** Sets the volume for the entire SE.

**Input:**
- `DO.b` = 05H
- `DL.b` = Volume

**Output:** None

**Destruction:** None

**Remarks:** Allowable range of volume: 00H-7FH, where 00H indicates maximum volume, and 7FH indicates mute.

### 06H - Set Master Music Transpose

**Function:** Transposes the entire music.

**Input:**
- `DO.b` = 06H
- `DL.b` = Transposition value

**Output:** None

**Destruction:** None

**Remarks:** A transposition value can be a negative value (2's complement).

### 07H - Set Master SE Transpose

**Function:** Transposes the entire SE.

**Input:**
- `DO.b` = 07H
- `DL.b` = Transposition value

**Output:** None

**Destruction:** None

**Remarks:** A transposition value can be a negative value (2's complement).

### 08H - Request Pause

**Function:** Sets a pause.

**Input:**
- `DO.b` = 08H

**Output:** None

**Destruction:** None

**Remarks:** Because PWM sound sources lack a function for stopping sound production on a channel-by-channel basis, once sound production is started it cannot be stopped.

### 09H - Reset Pause

**Function:** Resets a pause.

**Input:**
- `DO.b` = 09H

**Output:** None

**Destruction:** None

### 0AH - Write Communication Data

**Function:** Writes communication data to sound work space.

**Input:**
- `DO.b` = 0AH
- `DL.b` = Data

**Output:** None

**Destruction:** None

**Remarks:** This is a processing action viewed from the main system. Currently data cannot be read in the Driver. Therefore, writing data from the main system will not alter the processing.

### 0BH - Read Communication Data

**Function:** Reads communication data from sound work space.

**Input:**
- `DO.b` = 0BH

**Output:**
- `DL.b` = Data

**Destruction:** None

**Remarks:** This is a processing action viewed from the main system.

### 0CH - Request to Stop Music

**Function:** Terminates music.

**Input:**
- `DO.b` = 0CH

**Output:** None

**Destruction:** DO/AO/A2

**Remarks:** Because PWM sound sources lack a function for stopping sound production on a channel-by-channel basis, once sound production is started it cannot be stopped.

### 0DH - Request to Stop SE

**Function:** Terminates an SE.

**Input:**
- `DO.b` = 0DH

**Output:** None

**Destruction:** None

**Remarks:** Because PWM sound sources lack a function for stopping sound production on a channel-by-channel basis, once sound production is started it cannot be stopped.

---

## Data Request Numbers

For various pieces of data (music and SEs), the following range of request numbers can be specified:

| Type | Range |
|------|-------|
| **Music** | 01H-7FH |
| **SE** | 80H-EFH |

### Effect Commands

The following effect commands can be requested:

| Number | Effect Name | Effect |
|--------|-------------|--------|
| **F0H** | Fade-in | Produces a fade-in effect |
| **F1H** | Fade-out | Produces a fade-out effect |
| **F2H** | Music stop | Stops the music being played |
| **F3H** | Stopping SEs | Stops all SEs from which sounds are being produced |
| **F4H** | Pausing | Pauses music |
| **F5H** | Resetting pause | Resets music from a pause state |
| **F6H** | Music master transposing up | Raises the music's master transposition by a halftone |
| **F7H** | Music master transposing down | Lowers the music's master transposition by a halftone |
| **F8H** | SE master transposing up | Raises the SE's master transposition by a halftone |
| **F9H** | SE master transposing down | Lowers the SE's master transposition by a halftone |
| **FAH** | Music master volume up | Increases the master volume for music by 1 |
| **FBH** | Music master volume down | Reduces the master volume for music by 1 |
| **FCH** | SE master volume up | Increases the master volume for SE by 1 |
| **FDH** | SE master volume down | Reduces the master volume for SE by 1 |
| **FEH/FFH** | Sound Driver initialization | Initialize the Sound Driver |

---

## Sound Data Structures

This section describes the internal structure of sound data. For address specification, "address" refers to a relative address from the starting address.

### Top Vector

A top vector stores an offset address of data (4 bytes per address):

| Offset | Contents |
|--------|----------|
| +00H | Address of PCM information |
| +04H | Address of PWM information table |
| +08H | Address of music information |
| +0CH | Address of SE information table |
| +10H | Address of table envelope data |
| +14H | Address of table vibrato data |
| +18H | Address of FM rhythm kit data |
| +1CH | Address of FM sound source timbre data |

### PCM Data

PCM data stores addresses for PCM information. Any two-byte data relating to PCM is stored in terms of little-endian.

**Structure:**
```
Playback speed (simply a numerical value, not as playback rate) [1 byte]
Reserved by the system [1 byte]
Reserved area [2 bytes]
Address of the top address [4 bytes]
Data size [2 bytes]
```

### Music Information Data

This data codes the information necessary for playing back a piece of music (tempo, address to sequence data).

**Structure:**
```
NTSC/PAL tempo (in the order of NTSC and PAL) [2×2 bytes]
Address of PCM sound source/0CH sequence data [2 bytes]
PCM sound source, 0CH, master transpose [1 byte]
PCM sound source, 0CH master volume [1 byte]
(PCM sound source, 1CH, by driver selection) [4 bytes]
FM sound sources 0-5 (FM 5CH currently not available) [4×6 bytes]
PSG sound sources 0-2+1 (noise channels) [4×4 bytes]
PWM sound sources 0-3 [4×4 bytes]
```

### SE Information

This field provides the data (number of required channels, etc.) necessary for producing SE sounds.

**Structure:**
```
Number of required channels [1 byte]
Priority [1 byte]
Sound source ID for track (*1) [2 bytes]
Sequence data address for track [2 bytes]
Transpose for track [1 byte]
Volume level for track [1 byte]
```

(*1) See the section on "Identifying sound sources".

### Table Vibrato/Table Envelope

These tables require a minimum size of **100H per table** (fixed). Both data and commands are coded in numerical values.

- **Vibrato data:** Expressed in 2's complements as 7FH (maximum positive) ← 00H (neutral) → 80H (maximum negative)
- **Envelope data:** Only values 00H-7FH can be used

**Commands (80H-84H):**

| Command | Function |
|---------|----------|
| **80H** | Returns to the beginning of the table |
| **81H** | Retains the last value |
| **82H** | Moves to a specified table position |
| **83H** | Vibrato: moves to neutral position<br>Envelope: stops the sound-generation operator |

### FM Drum Kit

The data sequence number is used as a key number during sequencing.

**Structure (8 bytes):**

| Offset | Parameter |
|--------|-----------|
| 00H | Timbre number |
| 01H | Volume |
| 02H | Musical interval |
| 03H | Pan-pot |
| 04H | Table vibrato number |
| 05H-07H | System reserve |

### FM Sound Source Parameters

FM sound source timbre data is in a partially packed format so that it can be written directly into a register.

**Structure (25 bytes):**

| Offset | Parameter |
|--------|-----------|
| 00H | Connection/Feedback |
| 01H | Detune/Multiple (slots 1, 3, 2, 4) [4 bytes] |
| 05H | Key Scaling/Attack Rate (slots 1, 3, 2, 4) [4 bytes] |
| 09H | AM/Decay Rate (slots 1, 3, 2, 4) [4 bytes] |
| 0DH | Sustain Rate (slots 1, 3, 2, 4) [4 bytes] |
| 11H | Sustain Level/Release Rate (slots 1, 3, 2, 4) [4 bytes] |
| 15H | Total Level (slots 1, 3, 2, 4) [4 bytes] |

---

## Sequence Commands

The following sequence commands can be used in music and SEs:

### 01H-7FH - Tone Length

**Function:** Sets the tone length. Given a musical interval, a sound can be produced solely on the basis of its length.

### 80H - Pause Code

**Function:** Sets the pause code. Suspends reading data for a specified interval of time.

### 81H-8CH - Scale

**Scale values:** C, C#, D, D#, E, F, F#, G, G#, A, A#, B

**Function:** Specifies a musical interval in an octave range. Given a tone length, a sound can be produced solely on the basis of its musical interval.

### C0H, data.b - Write Communication Data

**Function:** Writes communication data.

### C1H, number.b - Request SE

**Function:** Requests an SE.

### C2H, offset.w, byte-count, data.b, ... - Write Workspace

**Function:** Writes a specified byte count to the offset for a specified sound workspace.

**Remarks:** The Sound Driver does not provide for malfunction that may occur as a result of using this command to rewrite the work space.

### C3H, number.b - Set SSG Envelope

**Function:** Sets the FM sound source envelope to the SSG type.

**Remarks:** For details, see the "YM-2612 Application Manual".

### C4H, PMS/AMS data.b - Set PMS/AMS

**Function:** Sets a PMS/AMS.

### C5H, bank.b, register_number.b, data.b - Write FM Register

**Function:** Directly rewrites the register for an FM sound source.

**Remarks:** For details, see the "YM-2612 Application Manual". The Sound Driver does not provide for malfunction that may occur as a result of using this command to rewrite the work space.

### C6H, mode.b - Change FM Production Method

**Function:** Changes FM source sound production methods.

**Remarks:**
- Mode 0: Ordinary sound production mode
- Non-0 mode: DRUM mode
- For a description of the DRUM mode, see the "Tone Editor Manual"

### D0H-DFH - Set Velocity

**Function:** Sets the velocity.

**Remarks:** Velocities are converted and added to the sound volume level.

### E0H, number.b - Change Timbre and Envelope

**Function:** Changes timbres and envelopes.

### E1H, absolute_volume.b - Set Absolute Volume

**Function:** Sets the absolute volume. The higher the numerical value, the smaller the volume.

**Remarks:** The absolute volume is specified in a 00H-7FH range for all sound sources.

### E2H, relative_volume.b - Set Relative Volume

**Function:** Sets the relative volume. The higher the numerical value, the smaller the volume.

**Remarks:** The absolute volume is specified in a 00H-7FH range for all sound sources. The function does not check for an overflow.

### E3H, point.b - Set Pan-Pot

**Function:** Sets the pan-pot. If the Qsound is used on a PWM sound source, the command sets a Qsound point in MIDI-standard-based numerical values (00H-40H-7FH).

**Remarks:** This command is applicable only to FM and PWM sound sources.

### E4H, tune.b - Set Detune

**Function:** Sets the detune option in units of 1/32 halftone.

### E5H, delay.b, stay.b, increment.b, limit.b - Set Portamento

**Function:** After a sound is produced, waits for a time interval equal to a delay interrupt; adds the increment for each stay, and changes the sign when the limit is reached.

**Diagram:**
```
       Limit
         ↑
    Tune |    /\
(1/32    |   /  \
halftone)|  /    \
         | /      \
         |/________\________
         ←Delay→←Stay→
         Time (1/60 units)
```

### E6H, transpose.b - Perform Transpose

**Function:** Performs a transpose. Negative values (2's complements) can also be used in this command.

### E7H, bend_value.w - Pitch Bend

**Function:** Performs a bend. Actually, the bending operation is the 16-bit version of the detuning operation.

**Remarks:** Because of a 3-bit left shift that is performed internally, the actual resolution is 13 bits.

### E8H, number.b - Set Table Vibrato

**Function:** Sets the table vibrato.

**Remarks:** The value specified in the number field resets the vibrato.

### E9H, switch.b - Vibrato Switch

**Function:** Temporarily resets the vibrato. 0 resets, non-zero sets the vibrato.

**Remarks:** This command is required in order to enable the commands E5H/E8H.

### EAH, octave.b - Set Absolute Octave

**Function:** Sets the octave in an absolute value.

### EBH - Increase Octave

**Function:** Increases the octave by one.

**Remarks:** Does not check for an overflow.

### ECH - Decrease Octave

**Function:** Decreases the octave by one.

**Remarks:** Does not check for an overflow.

### EEH, mode.b[, data...] - Sound Source Specific Commands

**Function:** This command performs different operations depending on the sound source involved:

| Sound Source | Operation | Data Byte Count |
|--------------|-----------|-----------------|
| **FM (2CH)** | Sets the sound effect mode. Specify the immediate value to be written to the register, followed by Block/F-Number (2 bytes per slot) | 5 bytes |
| **FM (5CH)** | Select whether channel is to be used as PCM or FM sound source. Specify immediate value to be written to register | 1 byte |
| **PSG** | Sets a noise. Specify the immediate value to be written to the register | 1 byte |
| **PWM** | Switches the Qsound. 0 = off, non-0 = on | 1 byte |

**Remarks:** For details, see the respective sound source manuals.

### F0H, NTSC.w, PAL.w - Set Tempo

**Function:** Sets the tempo.

**Remarks:**
- "NTSC" stores the value determined according to the following formula:
  `((tempo/150) × $100 + (remainder of tempo/150) × $100/150).w`
- The value of PAL is NTSC value × 6/5
- This command is not applicable to the SE (the tempo is fixed at 150)

### F1H - Disable Note Off

**Function:** Disables turning the next note off.

### F2H, gate_value.b - Set Gate

**Function:** Sets the gate.

### F3H, address.w - Jump to Address

**Function:** Stores the current address in a work space and moves it to a specified position.

**Remarks:** An address (including a header) is a relative value from the beginning of music data.

### F4H - Return from Subroutine

**Function:** Moves a given address to a stored address, discarding the stored address.

**Remarks:** Fetches addresses on a first-in, first-out basis.

### F5H-F7H, count.b - Repeat Loop

**Function:** Moves to an address specified by F8H-FDH, a specified number of times.

**Remarks:** This is a repeat function. There are three commands of this type. Consequently, a maximum of three nesting levels can be used.

### F8H-FAH - End Repeat

**Function:** Terminates the repeat count specified by F5H-F7H, and moves to the data following F5H-F7H.

### FBH-FDH - Save Repeat Position

**Function:** Saves the starting repeat position.

**Remarks:** This command is meaningful only if used in conjunction with the commands F5H-F7H.

### FEH - Save Current Address

**Function:** Saves the current address.

**Remarks:** This command is meaningful only if 1 is specified in FFH.

### FFH, mode.b - End of Track

**Function:** This command indicates the end of track data. If a non-0 mode is in effect, control moves to the data following FEH.

**Remarks:** In the case of a non-0 mode, use FEH to set a move-to point.

---

## Identifying Sound Sources

The following IDs are assigned to various sound sources:

| Sound Source | ID |
|--------------|-----|
| **FM0** | 00H |
| **FM1** | 01H |
| **FM2** | 02H |
| **FM3** | 04H |
| **FM4** | 05H |
| **FM5** | 06H |
| **PSG0** | 80H |
| **PSG1** | A0H |
| **PSG2** | C0H |
| **PSGN** (Noise) | E0H |
| **PCM0** | 40H |
| **PCM1** | 41H |
| **PWM0** | 08H |
| **PWM1** | 0AH |
| **PWM2** | 0CH |
| **PWM3** | 0EH |

---

## Notes

The following ranges of data can be used as pseudo-V3:

| Item | Range | Remarks |
|------|-------|---------|
| **Key** | 00H-7FH | For note data keys, the octave and the scale are set separately. Keys are defined according to MIDI standards. Keys that cannot be implemented in hardware (e.g., octaves 1 and 9) cannot be played correctly. |
| **Volume** | 00H-7FH | The maximum allowable volume is 00H, the minimum 7FH. The sound sources are implemented according to their hardware specifications without the balancing of volume levels. In some sound sources, other than the FM sound source, a specified volume level cannot be produced because of hardware/software limitations. |
| **Timbre** | - | The timbre parameter is not applicable to PCM or PWM. For PSG, a timbre is treated as a software envelope number. |
| **Pan-pot** | 00H-7FH | The allowable range of numeric values for the pan-pot category is based on MIDI standards. This range is not applicable to sound sources (i.e., PCM and PSG) that do not have a pan-pot due to hardware/software limitations. |
| **Address** | - | Any address that is executable by the 68000 is allowed. |
| **Tempo** | - | This is fixed as a general rule, and cannot be modified. |
| **Maximum number of sounds produced** | 15-16 | This number varies with the particular PCM driver selected. |
| **Number of SE tracks** | 5 | This is fixed as a general rule, and cannot be modified. |
| **Switching between FM5 and D/A** | - | Switching between FM and DA can be performed either by not entering any data in the FM5 or by using the command EEH. |
| **YM-2612 write-in data buffer** | 200H | This is fixed as a general rule, and cannot be modified. |

---

## Usage Example

```assembly
; Initialize sound driver
moveq   #0, d0          ; System call 00H
moveq   #0, d1          ; NTSC mode
jsr     SoundDriver+8

; Request music track 5
moveq   #1, d0          ; System call 01H
moveq   #5, d1          ; Music number 5
jsr     SoundDriver+8

; Set master volume
moveq   #4, d0          ; System call 04H
moveq   #$20, d1        ; Volume level
jsr     SoundDriver+8

; Play sound effect
moveq   #2, d0          ; System call 02H
moveq   #$80, d1        ; SE number 80H
jsr     SoundDriver+8

; Fade out
moveq   #3, d0          ; System call 03H
move.w  #$0810, d1      ; Depth=08H, Speed=10H
jsr     SoundDriver+8

; Stop music
moveq   #$0C, d0        ; System call 0CH
jsr     SoundDriver+8
```

---

**Document End**
