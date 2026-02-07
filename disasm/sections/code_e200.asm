; ============================================================================
; Code Section ($00E200-$0101FF)
; Translated assembly with byte-accurate dc.w verification
; ============================================================================

        include "disasm/modules/shared/vasm_macros.asm"

; 32X Communication Registers (per Hardware Manual - 2-byte spacing)
COMM0           equ     $A15120     ; COMM0 byte - Master SH2 ready flag
COMM0_HI        equ     $A15120     ; COMM0 high byte - Command flag (68K→SH2)
COMM0_LO        equ     $A15121     ; COMM0 low byte - Command code
COMM3           equ     $A15123     ; COMM3 byte - General purpose
COMM4           equ     $A15128     ; COMM4 word - Data pointer (hi), also longword base
COMM5           equ     $A1512A     ; COMM5 word - Data pointer (lo)
COMM6           equ     $A1512C     ; COMM6 word - Handshake flag

; SH2 Address Space Offset
SH2_ADDR_OFFSET equ     $02000000

; Command codes
CMD_21          equ     $21         ; Command $21
CMD_DIRECT      equ     $22         ; Direct command send
CMD_WAIT_SEND   equ     $25         ; Wait and send command
CMD_27          equ     $27         ; Command $27 (21 calls/frame)
CMD_EXTENDED    equ     $2F         ; Extended command

; Handshake values
HANDSHAKE_READY equ     $0101       ; Ready for next phase

        org     $00E200

; ============================================================================
; Counter increment with modulo ($00E200-$00E20A)
; Increments D0, wraps at 4, loops D3 times
; ============================================================================
CounterIncrementMod4:
        ADDQ.W  #1,D0           ; $00E200: Increment counter
        ANDI.W  #$0003,D0       ; $00E202: Modulo 4 (wrap 0-3)
        dc.w    $51CB,$FFC2     ; $00E206: DBRA D3,$E1CA (loop in code_c200)
        RTS                     ; $00E20A

; ============================================================================
; Data tables ($00E20C-$00E22A)
; ============================================================================
        dc.w    $0807        ; $00E20C
        dc.w    $0605        ; $00E20E
        dc.w    $0403        ; $00E210
        dc.w    $0201        ; $00E212
        dc.w    $1110        ; $00E214
        dc.w    $0F0E        ; $00E216
        dc.w    $0D0C        ; $00E218
        dc.w    $0B0A        ; $00E21A
        dc.w    $0403        ; $00E21C
        dc.w    $0201        ; $00E21E
        dc.w    $0807        ; $00E220
        dc.w    $0605        ; $00E222
        dc.w    $0D0C        ; $00E224
        dc.w    $0B0A        ; $00E226
        dc.w    $1110        ; $00E228
        dc.w    $0F0E        ; $00E22A

; ============================================================================
; sh2_graphics_cmd ($00E22C) - Build Graphics Command Data
; ============================================================================
; Called by: 14 locations per frame (sprite/graphics setup)
; Parameters:
;   A0 = Source data pointer
;   D0 = Flags/mode value
;   D1 = Initial offset
;   D2 = Row count parameter
;   D3 = Column count parameter
;   D4 = Vertical loop count
; Returns:
;   A0 = Restored to original value (via A1)
;   D6 = Last computed sprite index
;
; This function builds sprite command data for the SH2 to process.
; It calculates sprite indices based on input parameters and writes
; them to a buffer with $80-byte row stride.
;
; Algorithm:
;   1. Calculate base sprite index from D0/D1/D2
;   2. Build upper section (loop D4-3 times)
;   3. Build center row
;   4. Build lower section with mirrored indices
;   5. Restore A0 and return
; ============================================================================
sh2_graphics_cmd:
; Save original pointer
        movea.l a0,a1                           ; $00E22C: $2248       - Save A0 in A1

; Calculate table offset: D1 = D1*2 + D2*128 + base
        LSL.W   #1,D1                           ; $00E22E: D1 *= 2
        LSL.W   #7,D2                           ; $00E230: D2 *= 128
        add.w   d2,d1                           ; $00E232: D1 += D2
        lea     (a0,d1.w),a0                    ; $00E234: A0 += D1 (indexed)

; Build sprite base index from D0
        andi.w  #$0003,d0                       ; $00E238: Keep low 2 bits
        LSL.W   #8,D0                           ; $00E23C: D0 *= 256
        lsl.w   #5,d0                           ; $00E23E: D0 *= 32 (total *8192)
        addi.w  #$0100,d0                       ; $00E240: $0640 $0100 - Add base offset
        bclr    #11,d0                          ; $00E244: $0880 $000B - Clear bit 11
        bclr    #12,d0                          ; $00E248: $0880 $000C - Clear bit 12

; Initialize counters
        moveq   #0,d1                           ; $00E24C: $7200       - D1 = 0
        move.w  #$0006,d2                       ; $00E24E: $343C $0006 - D2 = 6
        add.w   d0,d2                           ; $00E252: $D440       - D2 += base index
        move.w  d2,(a0)                         ; $00E254: $3082       - Store first index
        adda.l  #$00000080,a0                   ; $00E256: $D1FC $0000 $0080 - Next row (+128)

; Build upper section rows
        move.w  #$0001,d2                       ; $00E25C: $343C $0001 - D2 = 1 (index offset)
        move.w  d4,d5                           ; $00E260: $3A04       - D5 = row count
        subq.w  #3,d5                           ; $00E262: $5745       - D5 -= 3 (loop count)

.upper_loop:
        dc.w    $4EBA,$007E                     ; $00E264: BSR.W sh2_sprite_calc
        move.w  d6,(a0)                         ; $00E268: $3086       - Store index
        adda.l  #$00000080,a0                   ; $00E26A: $D1FC $0000 $0080 - Next row
        dbra    d5,.upper_loop                  ; $00E270: $51CD $FFF2 - Loop

; Center row - special index
        move.w  #$0007,d2                       ; $00E274: $343C $0007 - D2 = 7
        dc.w    $4EBA,$006A                     ; $00E278: BSR.W sh2_sprite_calc
        move.w  d6,(a0)+                        ; $00E27C: $30C6       - Store and advance

; Build horizontal strip
        move.w  #$0003,d2                       ; $00E27E: $343C $0003 - D2 = 3
        move.w  d3,d5                           ; $00E282: $3A03       - D5 = column count
        subq.w  #3,d5                           ; $00E284: $5745       - D5 -= 3

.horiz_loop:
        dc.w    $4EBA,$005C                     ; $00E286: BSR.W sh2_sprite_calc
        move.w  d6,(a0)+                        ; $00E28A: $30C6       - Store and advance
        dbra    d5,.horiz_loop                  ; $00E28C: $51CD $FFF8 - Loop

; Set mirror bits for lower section
        bset    #11,d0                          ; $00E290: $08C0 $000B - Set bit 11
        bset    #12,d0                          ; $00E294: $08C0 $000C - Set bit 12

; End of center row
        move.w  #$0005,d2                       ; $00E298: $343C $0005 - D2 = 5
        dc.w    $4EBA,$0046                     ; $00E29C: BSR.W sh2_sprite_calc
        move.w  d6,(a0)                         ; $00E2A0: $3086       - Store index
        suba.l  #$00000080,a0                   ; $00E2A2: $91FC $0000 $0080 - Previous row

; Build lower section rows (going backwards)
        move.w  #$0001,d2                       ; $00E2A8: $343C $0001 - D2 = 1
        move.w  d4,d5                           ; $00E2AC: $3A04       - D5 = row count
        subq.w  #3,d5                           ; $00E2AE: $5745       - D5 -= 3

.lower_loop:
        dc.w    $4EBA,$0032                     ; $00E2B0: BSR.W sh2_sprite_calc
        move.w  d6,(a0)                         ; $00E2B4: $3086       - Store
        suba.l  #$00000080,a0                   ; $00E2B6: $91FC $0000 $0080 - Previous row
        dbra    d5,.lower_loop                  ; $00E2BC: $51CD $FFF2 - Loop

; Final corner index
        move.w  #$0007,d2                       ; $00E2C0: $343C $0007 - D2 = 7
        dc.w    $4EBA,$001E                     ; $00E2C4: BSR.W sh2_sprite_calc
        move.w  d6,(a0)                         ; $00E2C8: $3086       - Store
        subq.l  #2,a0                           ; $00E2CA: $5588       - Back 2 bytes

; Build final horizontal strip (backwards)
        move.w  #$0003,d2                       ; $00E2CC: $343C $0003 - D2 = 3
        move.w  d3,d5                           ; $00E2D0: $3A03       - D5 = column count
        subq.w  #3,d5                           ; $00E2D2: $5745       - D5 -= 3

.final_loop:
        dc.w    $4EBA,$000E                     ; $00E2D4: BSR.W sh2_sprite_calc
        move.w  d6,(a0)                         ; $00E2D8: $3086       - Store
        subq.l  #2,a0                           ; $00E2DA: $5588       - Back 2 bytes
        dbra    d5,.final_loop                  ; $00E2DC: $51CD $FFF6 - Loop

; Restore original pointer and return
        movea.l a1,a0                           ; $00E2E0: $2049       - Restore A0
        rts                                     ; $00E2E2: $4E75
; ============================================================================
; sh2_sprite_calc ($00E2E4) - Calculate Sprite Index
; ============================================================================
; Called by: sh2_graphics_cmd (internal helper)
; Parameters:
;   D0 = Base sprite index
;   D1 = Offset accumulator
;   D2 = Index offset to add
; Returns:
;   D6 = Calculated sprite index (D0 + D1 + D2)
;   D1 = Bit 0 toggled (alternating pattern)
; ============================================================================
sh2_sprite_calc:
        move.w  d2,d6                           ; $00E2E4: $3C02       - D6 = D2
        add.w   d0,d6                           ; $00E2E6: $DC40       - D6 += D0 (base)
        add.w   d1,d6                           ; $00E2E8: $DC41       - D6 += D1 (offset)
        bchg    #0,d1                           ; $00E2EA: $0841 $0000 - Toggle D1 bit 0
        rts                                     ; $00E2EE: $4E75
; ============================================================================
; sh2_load_data ($00E2F0) - Transfer Data to VDP
; ============================================================================
; Called by: Graphics initialization, tile loading
; Parameters:
;   A0 = Source data pointer
;   A5 = VDP control port ($C00004)
;   A6 = VDP data port ($C00000)
; Returns:
;   Data copied to VDP, counter in D0
;
; This function sets up VDP VRAM write and copies tile data.
; Writes 32 longs (128 bytes) per row, then pads with zeros.
; Total: 28 rows × 64 longs = 1792 longs = 7168 bytes
; ============================================================================
sh2_load_data:
        dc.w    $2ABC,$6000,$0002               ; $00E2F0: MOVE.L #$60000002,(A5)+
        moveq   #$1B,d0                         ; $00E2F6: $701B               - D0 = 27 (28 rows)

.row_loop:
        move.w  #$001F,d1                       ; $00E2F8: $323C $001F         - D1 = 31 (32 longs)
.copy_loop:
        dc.w    $2C98                           ; $00E2FC: MOVE.L (A0)+,(A6)+
        dbra    d1,.copy_loop                   ; $00E2FE: $51C9 $FFFC         - Loop 32 times

        move.w  #$001F,d1                       ; $00E302: $323C $001F         - D1 = 31
.zero_loop:
        dc.w    $2CBC,$0000,$0000               ; $00E306: MOVE.L #$00000000,(A6)+
        dbra    d1,.zero_loop                   ; $00E30C: $51C9 $FFF8         - Loop 32 times

        dbra    d0,.row_loop                    ; $00E310: $51C8 $FFE6         - Loop 28 rows
        rts                                     ; $00E314: $4E75

; ============================================================================
; sh2_send_cmd_wait ($00E316) - Wait for Ready, Send Command
; ============================================================================
; Purpose: Waits for SH2 to be ready, then sends a command with data pointer
; Called by: Various graphics/3D functions
; Parameters:
;   A0 = 68K data pointer (converted to SH2 address space)
; Returns: Nothing (A0 preserved in A1)
;
; BLOCKING: Contains busy-wait loop at $00E316-$00E31C
; This is a PRIMARY BOTTLENECK FUNCTION
; ============================================================================
sh2_send_cmd_wait:
; --- BLOCKING WAIT LOOP ---
; Spins until COMM0 high byte == 0, preventing any other 68K work
.wait_ready:
        tst.b   COMM0_HI                        ; $00E316: $4A39 $00A1 $5120 - Test command flag
        bne.s   .wait_ready                     ; $00E31C: $66F8             - Loop until ready

; Convert 68K address to SH2 address space
        adda.l  #SH2_ADDR_OFFSET,a0             ; $00E31E: $D1FC $0200 $0000 - A0 += $02000000
        move.l  a0,COMM4                        ; $00E324: $23C8 $00A1 $5128 - Write data pointer (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E32A: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_WAIT_SEND,COMM0_LO         ; $00E332: $13FC $0025 $00A1 $5121 - Command $25
        move.b  #$01,COMM0_HI                   ; $00E33A: $13FC $0001 $00A1 $5120 - Trigger command
        ; Falls through to sh2_wait_response

; ============================================================================
; sh2_wait_response ($00E342) - Wait for SH2 Response
; ============================================================================
; Purpose: Blocks until SH2 clears handshake, then sets up next transfer
; Called by: sh2_send_cmd_wait (fall-through), other command functions
; Parameters:
;   A1 = Secondary data pointer
; Returns: Nothing
;
; BLOCKING: Contains busy-wait loop at $00E342-$00E348
; This is a PRIMARY BOTTLENECK FUNCTION
; ============================================================================
sh2_wait_response:
; --- BLOCKING WAIT LOOP ---
; Spins until COMM6 high byte == 0, preventing any other 68K work
.wait_ack:
        tst.b   COMM6                           ; $00E342: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_ack                       ; $00E348: $66F8             - Loop until cleared

; Set up secondary pointer for next phase
        move.l  a1,COMM4                        ; $00E34A: $23C9 $00A1 $5128 - Write secondary ptr (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E350: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E358: $4E75             - Return

; ============================================================================
; sh2_send_cmd ($00E35A) - Direct Command Send
; ============================================================================
; Purpose: Sends a command directly with multiple parameters
; Called by: text_render, various graphics functions
; Parameters:
;   A0 = Data pointer
;   A1 = Secondary pointer
;   D0 = Parameter 1 (width/count)
;   D1 = Parameter 2 (height/type)
; Returns: Nothing
;
; BLOCKING: Contains THREE busy-wait loops
; This function has the MOST BLOCKING WAITS of all comm functions
; ============================================================================
sh2_send_cmd:
; --- BLOCKING WAIT 1 ---
.wait_ready:
        tst.b   COMM0_HI                        ; $00E35A: $4A39 $00A1 $5120 - Test command flag
        bne.s   .wait_ready                     ; $00E360: $66F8             - Loop until ready

; Send secondary pointer
        move.l  a1,COMM4                        ; $00E362: $23C9 $00A1 $5128 - Write A1 (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E368: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_DIRECT,COMM0_LO            ; $00E370: $13FC $0022 $00A1 $5121 - Command $22
        move.b  #$01,COMM0_HI                   ; $00E378: $13FC $0001 $00A1 $5120 - Trigger command

; --- BLOCKING WAIT 2 ---
.wait_phase1:
        tst.b   COMM6                           ; $00E380: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_phase1                    ; $00E386: $66F8             - Loop until cleared

; Send parameters D0/D1
        move.w  d0,COMM4                        ; $00E388: $33C0 $00A1 $5128 - Write D0
        move.w  d1,COMM5                        ; $00E38E: $33C1 $00A1 $512A - Write D1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E394: $33FC $0101 $00A1 $512C - Signal ready

; --- BLOCKING WAIT 3 ---
.wait_phase2:
        tst.b   COMM6                           ; $00E39C: $4A39 $00A1 $512C - Test handshake
        bne.s   .wait_phase2                    ; $00E3A2: $66F8             - Loop until cleared

; Send data pointer
        move.l  a0,COMM4                        ; $00E3A4: $23C8 $00A1 $5128 - Write A0 (COMM4+COMM5)
        move.w  #HANDSHAKE_READY,COMM6          ; $00E3AA: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E3B2: $4E75             - Return

; ============================================================================
; sh2_cmd_27 ($00E3B4) - Command $27 (Most frequent: 21 calls/frame)
; ============================================================================
; Purpose: Sends command $27 with data pointer and 3 parameters
; Called by: 3D rendering, polygon processing
; Parameters:
;   A0 = Data pointer (68K address, written directly)
;   D0 = Parameter 1
;   D1 = Parameter 2
;   D2 = Parameter 3
; Returns: Nothing
;
; BLOCKING: Contains TWO busy-wait loops
; This is a HIGH-FREQUENCY BOTTLENECK FUNCTION (21 calls/frame)
;
; Protocol:
;   Phase 1: Send A0 pointer, command $27, wait for ack
;   Phase 2: Send D0/D1, wait for ack
;   Phase 3: Send D2, return (no wait - SH2 processes async)
; ============================================================================
sh2_cmd_27:
; Phase 1: Send data pointer and command
        move.l  a0,COMM4                        ; $00E3B4: $23C8 $00A1 $5128 - Write pointer
        move.w  #HANDSHAKE_READY,COMM6          ; $00E3BA: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_27,COMM0_LO                ; $00E3C2: $13FC $0027 $00A1 $5121 - Command $27
        move.b  #$01,COMM0_HI                   ; $00E3CA: $13FC $0001 $00A1 $5120 - Trigger
; --- BLOCKING WAIT 1 ---
.cmd27_wait_phase1:
        tst.b   COMM6                           ; $00E3D2: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd27_wait_phase1              ; $00E3D8: $66F8             - Loop until clear

; Phase 2: Send parameters D0 and D1
        move.w  d0,COMM4                        ; $00E3DA: $33C0 $00A1 $5128 - Write D0
        move.w  d1,COMM5                        ; $00E3E0: $33C1 $00A1 $512A - Write D1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E3E6: $33FC $0101 $00A1 $512C - Signal ready
; --- BLOCKING WAIT 2 ---
.cmd27_wait_phase2:
        tst.b   COMM6                           ; $00E3EE: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd27_wait_phase2              ; $00E3F4: $66F8             - Loop until clear

; Phase 3: Send parameter D2 (no wait - SH2 processes after return)
        move.w  d2,COMM4                        ; $00E3F6: $33C2 $00A1 $5128 - Write D2
        move.w  #HANDSHAKE_READY,COMM6          ; $00E3FC: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E404: $4E75             - Return

; ============================================================================
; sh2_cmd_2F ($00E406) - Extended Command with 4 Parameters
; ============================================================================
; Purpose: Sends command $2F with data pointer and 4 parameters (D0-D3)
; Called by: Complex graphics operations
; Parameters:
;   A0 = Data pointer (68K address, written directly)
;   D0 = Parameter 1
;   D1 = Parameter 2
;   D2 = Parameter 3
;   D3 = Parameter 4
; Returns: Nothing
;
; BLOCKING: Contains THREE busy-wait loops
; Similar to sh2_cmd_27 but with an additional parameter phase
;
; Protocol:
;   Phase 1: Wait for ready, send A0 pointer, command $2F, wait for ack
;   Phase 2: Send D0/D1, wait for ack
;   Phase 3: Send D2/D3, return (SH2 processes async)
; ============================================================================
sh2_cmd_2F:
; Phase 1: Wait for SH2 ready, then send pointer and command
.cmd2F_wait_ready:
        tst.b   COMM0_HI                        ; $00E406: $4A39 $00A1 $5120 - Test command flag
        bne.s   .cmd2F_wait_ready               ; $00E40C: $66F8             - Loop until ready
        move.l  a0,COMM4                        ; $00E40E: $23C8 $00A1 $5128 - Write pointer
        move.w  #HANDSHAKE_READY,COMM6          ; $00E414: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_EXTENDED,COMM0_LO          ; $00E41C: $13FC $002F $00A1 $5121 - Command $2F
        move.b  #$01,COMM0_HI                   ; $00E424: $13FC $0001 $00A1 $5120 - Trigger

; Phase 2: Wait for ack, send D0/D1
.cmd2F_wait_phase1:
        tst.b   COMM6                           ; $00E42C: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd2F_wait_phase1              ; $00E432: $66F8             - Loop until clear
        move.w  d0,COMM4                        ; $00E434: $33C0 $00A1 $5128 - Write D0
        move.w  d1,COMM5                        ; $00E43A: $33C1 $00A1 $512A - Write D1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E440: $33FC $0101 $00A1 $512C - Signal ready

; Phase 3: Wait for ack, send D2/D3 (no final wait - SH2 processes async)
.cmd2F_wait_phase2:
        tst.b   COMM6                           ; $00E448: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd2F_wait_phase2              ; $00E44E: $66F8             - Loop until clear
        move.w  d2,COMM4                        ; $00E450: $33C2 $00A1 $5128 - Write D2
        move.w  d3,COMM5                        ; $00E456: $33C3 $00A1 $512A - Write D3
        move.w  #HANDSHAKE_READY,COMM6          ; $00E45C: Signal ready
        rts                                     ; $00E464: Return

; ============================================================================
; Byte processing loop ($00E466-$00E49E)
; ============================================================================
; Reads bytes from (A2), extracts nibbles, calls helper for each
; Parameters: A1 = destination pointer, A2 = source data
; ============================================================================
ByteProcessLoop:
        MOVE.B  (A2)+,D1                        ; $00E466: Read byte
        ANDI.W  #$000F,D1                       ; $00E468: Mask low nibble
        BSR.W   DigitToASCII                    ; $00E46C: Process (+$4E)
        ADDQ.L  #8,A1                           ; $00E470: Advance pointer
        MOVE.W  #$000A,D1                       ; $00E472: D1 = 10
        BSR.W   DigitToASCII                    ; $00E476: Process (+$44)
        ADDQ.L  #8,A1                           ; $00E47A: Advance pointer
        MOVE.B  (A2)+,D2                        ; $00E47C: Read next byte
        BSR.W   $00E4A0                         ; $00E47E: Bit manip helper (+$20)
        MOVE.W  #$000B,D1                       ; $00E482: D1 = 11
        BSR.W   DigitToASCII                    ; $00E486: Process (+$34)
        ADDQ.L  #8,A1                           ; $00E48A: Advance pointer
        MOVE.B  (A2)+,D1                        ; $00E48C: Read byte
        ANDI.W  #$000F,D1                       ; $00E48E: Mask low nibble
        BSR.W   DigitToASCII                    ; $00E492: Process (+$28)
        ADDQ.L  #8,A1                           ; $00E496: Advance pointer
        MOVE.B  (A2)+,D2                        ; $00E498: Read next byte
        BSR.W   $00E4A0                         ; $00E49A: Bit manip helper (+$4)
        RTS                                     ; $00E49E

; ============================================================================
; Helper function ($00E4A0-$00E4BA)
; ============================================================================
; Bit manipulation and conditional branching helper
; Parameters: D2 = input value, A1 = pointer
; ============================================================================
        move.b  d2,d1                           ; $00E4A0: $1202       - D1 = D2 (byte)
        lsr.b   #4,d1                           ; $00E4A2: $E809       - D1 >>= 4 (high nibble)
        andi.w  #$000F,d1                       ; $00E4A4: $0241 $000F - Mask to 4 bits
        dc.w    $6100,$0012                     ; $00E4A8: BSR.W DigitToASCII (+18)
        addq.l  #8,a1                           ; $00E4AC: $5089       - A1 += 8
        move.w  d2,d1                           ; $00E4AE: $3202       - D1 = D2 (word)
        andi.w  #$000F,d1                       ; $00E4B0: $0241 $000F - Mask to 4 bits (low nibble)
        dc.w    $6100,$0006                     ; $00E4B4: BSR.W DigitToASCII (+6)
        addq.l  #8,a1                           ; $00E4B8: $5089       - A1 += 8
        rts                                     ; $00E4BA: $4E75

; ============================================================================
; Digit conversion helper ($00E4BC-$00E4D8)
; ============================================================================
; Converts digit to ASCII and stores it
; Parameters: D1 = digit value (0-15), A1 = destination pointer
; Uses: D0, A0
; ============================================================================
DigitToASCII:
        lsl.w   #6,d1                           ; $00E4BC: D1 <<= 6 (multiply by 64)
        move.w  d1,d0                           ; $00E4BE: D0 = D1
        lsl.w   #1,d1                           ; $00E4C0: D1 <<= 1 (D1 *= 128)
        add.w   d0,d1                           ; $00E4C2: D1 += D0 (D1 *= 192)
        movea.l #$0603DA00,a0                   ; $00E4C4: Load table base
        add.w   d1,a0                           ; $00E4CA: A0 += D1 (offset)
        move.w  #$000C,d0                       ; $00E4CC: D0 = 12 (width)
        move.w  #$0010,d1                       ; $00E4D0: D1 = 16 (height)
        dc.w    $4EBA,$FE84                     ; $00E4D4: BSR.W sh2_send_cmd_wait
        rts                                     ; $00E4D8

; ============================================================================
; sh2_cmd_21 ($00E4DA-$00E52A) - Command $21
; ============================================================================
; Purpose: Sends command $21 with secondary pointer and 2 parameters
; Called by: Graphics/rendering functions
; Parameters:
;   A0 = Data pointer
;   A1 = Secondary pointer
;   D0 = Parameter 1
;   D1 = Parameter 2
; Returns: Nothing
;
; BLOCKING: Contains TWO busy-wait loops
; Similar protocol to sh2_cmd_27
; ============================================================================
sh2_cmd_21:
; Phase 1: Send secondary pointer and command
        move.l  a1,COMM4                        ; $00E4DA: $23C9 $00A1 $5128 - Write A1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E4E0: $33FC $0101 $00A1 $512C - Signal ready
        move.b  #CMD_21,COMM0_LO                ; $00E4E8: $13FC $0021 $00A1 $5121 - Command $21
        move.b  #$01,COMM0_HI                   ; $00E4F0: $13FC $0001 $00A1 $5120 - Trigger

; --- BLOCKING WAIT 1 ---
.cmd21_wait_phase1:
        tst.b   COMM6                           ; $00E4F8: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd21_wait_phase1              ; $00E4FE: $66F8             - Loop until clear

; Phase 2: Send parameters D0 and D1
        move.w  d0,COMM4                        ; $00E500: $33C0 $00A1 $5128 - Write D0
        move.w  d1,COMM5                        ; $00E506: $33C1 $00A1 $512A - Write D1
        move.w  #HANDSHAKE_READY,COMM6          ; $00E50C: $33FC $0101 $00A1 $512C - Signal ready

; --- BLOCKING WAIT 2 ---
.cmd21_wait_phase2:
        tst.b   COMM6                           ; $00E514: $4A39 $00A1 $512C - Check handshake
        bne.s   .cmd21_wait_phase2              ; $00E51A: $66F8             - Loop until clear

; Phase 3: Send data pointer (no wait - SH2 processes async)
        move.l  a0,COMM4                        ; $00E51C: $23C8 $00A1 $5128 - Write A0
        move.w  #HANDSHAKE_READY,COMM6          ; $00E522: $33FC $0101 $00A1 $512C - Signal ready
        rts                                     ; $00E52A: $4E75             - Return

; ============================================================================
; Memory initialization ($00E52C-$00E5AA)
; ============================================================================
; Initializes three memory regions based on D0 parameter
; Parameters: D0 = selector (0, 1, or other)
; Uses: A0, A1, A2, A3, D1, D2
; ============================================================================
MemoryInit:
        dc.w    $41F8,$84A2                     ; $00E52C: LEA $84A2.W,A0
        dc.w    $43F8,$84C2                     ; $00E530: LEA $84C2.W,A1
        dc.w    $45F8,$84E2                     ; $00E534: LEA $84E2.W,A2

        clr.w   d2                              ; $00E538: $4242       - D2 = 0
        move.w  #$0007,d1                       ; $00E53A: $323C $0007 - D1 = 7 (loop counter)

.clear_loop:
        dc.w    $31BC,$0000,$2000               ; $00E53E: MOVE.W #$0000,$2000(A0)
        dc.w    $33BC,$0000,$2000               ; $00E544: MOVE.W #$0000,$2000(A1)
        dc.w    $35BC,$0000,$2000               ; $00E54A: MOVE.W #$0000,$2000(A2)
        addq.w  #2,d2                           ; $00E550: $5442       - D2 += 2
        dbra    d1,.clear_loop                  ; $00E552: $51C9 $FFEA - Loop 8 times

; Select address based on D0
        tst.w   d0                              ; $00E556: Test D0
        bne.s   .check_one                      ; $00E558: Branch if != 0
        dc.w    $41F8,$84A2                     ; $00E55A: LEA $84A2.W,A0
        dc.w    $6000,$0016                     ; $00E55E: BRA.W .setup_table

.check_one:
        cmpi.w  #$0001,d0                       ; $00E562: Compare D0 with 1
        dc.w    $6600,$000A                     ; $00E566: BNE.W .use_addr3
        dc.w    $41F8,$84C2                     ; $00E56A: LEA $84C2.W,A0
        dc.w    $6000,$0006                     ; $00E56E: BRA.W .setup_table

.use_addr3:
        dc.w    $41F8,$84E2                     ; $00E572: LEA $84E2.W,A0

.setup_table:
        lea     ($0088E5AC).l,a3                ; $00E576: $47F9 $0088 $E5AC - Load table address
        moveq   #0,d1                           ; $00E57C: $7200       - D1 = 0

.copy_loop:
        dc.w    $3238,$A012                     ; $00E57E: MOVE.W ($A012).W,D1
        dc.w    $D241                           ; $00E582: ADD.W D1,D1
        dc.w    $D7C1                           ; $00E584: ADDA.W D1,A3
        clr.w   d2                              ; $00E586: $4242       - D2 = 0
        move.w  #$0007,d1                       ; $00E588: $323C $0007 - D1 = 7 (loop counter)

.inner_loop:
        dc.w    $319B,$2000                     ; $00E58C: MOVE.W (A3)+,$2000(A0)
        addq.w  #2,d2                           ; $00E590: $5442       - D2 += 2
        dbra    d1,.inner_loop                  ; $00E592: $51C9 $FFF8 - Loop 8 times
; ============================================================================
; VDP register manipulation ($00E596-$00E5AA)
; ============================================================================
; Reads VDP control register, shifts and validates value, then writes back
; Parameters: None
; Uses: D1, VDP control port ($A012)
; ============================================================================
VDPRegManipulate:
        dc.w    $3238,$A012                     ; $00E596: MOVE.W ($A012).W,D1
        dc.w    $5241                           ; $00E59A: ADDQ.W #1,D1
        cmpi.w  #$0007,d1                       ; $00E59C: Compare with 7
        dc.w    $6F00,$0004                     ; $00E5A0: BLE.W .store_value
        clr.w   d1                              ; $00E5A4: Clear D1
.store_value:
        dc.w    $31C1,$A012                     ; $00E5A6: MOVE.W D1,($A012).W
        rts                                     ; $00E5AA
        include "modules/68k/game/fn_e200_001.asm"
        include "modules/68k/game/fn_e200_002.asm"
        dc.w    $4400        ; $00E88C
        dc.w    $44A3        ; $00E88E
        dc.w    $4946        ; $00E890
        dc.w    $4DE9        ; $00E892
        dc.w    $1C00        ; $00E894
        dc.w    $28A3        ; $00E896
        dc.w    $3546        ; $00E898
        dc.w    $41E9        ; $00E89A
        dc.w    $7FFF        ; $00E89C
        dc.w    $7FFF        ; $00E89E
        dc.w    $7FFF        ; $00E8A0
        dc.w    $7FFF        ; $00E8A2
        dc.w    $1C00        ; $00E8A4
        dc.w    $28A3        ; $00E8A6
        dc.w    $3546        ; $00E8A8
        dc.w    $41E9        ; $00E8AA
        dc.w    $4400        ; $00E8AC
        dc.w    $44A3        ; $00E8AE
        dc.w    $4946        ; $00E8B0
        dc.w    $4DE9        ; $00E8B2
        dc.w    $7FFF        ; $00E8B4
        dc.w    $63F5        ; $00E8B6
        dc.w    $7FFF        ; $00E8B8
        dc.w    $7FFF        ; $00E8BA
        dc.w    $0010        ; $00E8BC
        dc.w    $14AF        ; $00E8BE
        dc.w    $294E        ; $00E8C0
        dc.w    $3DED        ; $00E8C2
        dc.w    $7FFF        ; $00E8C4
        dc.w    $7FFF        ; $00E8C6
        dc.w    $7FFF        ; $00E8C8
        dc.w    $7FFF        ; $00E8CA
        dc.w    $77BA        ; $00E8CC
        dc.w    $7BBC        ; $00E8CE
        dc.w    $779A        ; $00E8D0
        dc.w    $77BC        ; $00E8D2
        dc.w    $6B36        ; $00E8D4
        dc.w    $6B37        ; $00E8D6
        dc.w    $6F58        ; $00E8D8
        dc.w    $6F79        ; $00E8DA
        dc.w    $739A        ; $00E8DC
        dc.w    $61E8        ; $00E8DE
        dc.w    $7FFF        ; $00E8E0
        dc.w    $7FFF        ; $00E8E2
        dc.w    $7FFF        ; $00E8E4
        dc.w    $7FFF        ; $00E8E6
        dc.w    $7FFF        ; $00E8E8
        dc.w    $7FFF        ; $00E8EA
        dc.w    $7FBC        ; $00E8EC
        dc.w    $7F7A        ; $00E8EE
        dc.w    $7FDE        ; $00E8F0
        dc.w    $7F9B        ; $00E8F2
        dc.w    $4445        ; $00E8F4
        dc.w    $512B        ; $00E8F6
        dc.w    $6212        ; $00E8F8
        dc.w    $6EF8        ; $00E8FA
        dc.w    $7FFF        ; $00E8FC
        dc.w    $031F        ; $00E8FE
        dc.w    $7FFF        ; $00E900
        dc.w    $7FFF        ; $00E902
        dc.w    $7FFF        ; $00E904
        dc.w    $7FFF        ; $00E906
        dc.w    $7FFF        ; $00E908
        dc.w    $7FFF        ; $00E90A

; ============================================================================
; Function: Jump Table Dispatcher ($00E90C-$00E926)
; ============================================================================
; Calls initialization function, loads an index from ($C87E), and dispatches
; to one of three handler functions via indexed jump table.
;
; Jump Table:
;   Index 0 ($00E91C): $0088E93A
;   Index 4 ($00E920): $0088EDDA
;   Index 8 ($00E924): $0088EEF2
;
; Uses: D0 (jump table index), A1 (target address)
; ============================================================================
        dc.w    $4EB9        ; $00E90C
        dc.w    $0088        ; $00E90E
        dc.w    $2080        ; $00E910
        dc.w    $3038        ; $00E912
        dc.w    $C87E        ; $00E914
        dc.w    $227B        ; $00E916
        dc.w    $0004        ; $00E918
        dc.w    $4ED1        ; $00E91A
        dc.w    $0088        ; $00E91C
        dc.w    $E93A        ; $00E91E
        dc.w    $0088        ; $00E920
        dc.w    $EDDA        ; $00E922
        dc.w    $0088        ; $00E924
        dc.w    $EEF2        ; $00E926

; ============================================================================
; Function: Post-Dispatch Callback ($00E928-$00E938)
; ============================================================================
; Called after handler completion. Checks bit 6 of ($C80E); if clear,
; advances ($C87E) by 4 bytes.
;
; Uses: None (bit test and conditional increment only)
; ============================================================================
post_dispatch_callback:
        dc.w    $4EBA,$CD5A                     ; $00E928: JSR (PC),$CD5A -> $00B684
        dc.w    $0838,$0006,$C80E               ; $00E92C: BTST #$06,($C80E).W - Test bit 6
        bne.s   .skip_advance                   ; $00E932 - Skip if set
        dc.w    $5878,$C87E                     ; $00E934: ADDQ.W #4,($C87E).W - Advance index
.skip_advance:
        rts                                     ; $00E938
        include "modules/68k/game/fn_e200_003.asm"
        dc.w    $0088        ; $00EAC2
        dc.w    $EFC2        ; $00EAC4
        dc.w    $0088        ; $00EAC6
        dc.w    $F040        ; $00EAC8
        dc.w    $0088        ; $00EACA
        dc.w    $F0BE        ; $00EACC
        dc.w    $0088        ; $00EACE
        dc.w    $EADA        ; $00EAD0
        dc.w    $0088        ; $00EAD2
        dc.w    $EBDA        ; $00EAD4
        dc.w    $0088        ; $00EAD6
        dc.w    $ECDA        ; $00EAD8
        dc.w    $0000        ; $00EADA
        dc.w    $8000        ; $00EADC
        dc.w    $8421        ; $00EADE
        dc.w    $8842        ; $00EAE0
        dc.w    $8C63        ; $00EAE2
        dc.w    $9084        ; $00EAE4
        dc.w    $94A5        ; $00EAE6
        dc.w    $98C6        ; $00EAE8
        dc.w    $9CE7        ; $00EAEA
        dc.w    $A108        ; $00EAEC
        dc.w    $A529        ; $00EAEE
        dc.w    $A94A        ; $00EAF0
        dc.w    $AD6B        ; $00EAF2
        dc.w    $B18C        ; $00EAF4
        dc.w    $B5AD        ; $00EAF6
        dc.w    $B9CE        ; $00EAF8
        dc.w    $BDEF        ; $00EAFA
        dc.w    $C210        ; $00EAFC
        dc.w    $C631        ; $00EAFE
        dc.w    $CA52        ; $00EB00
        dc.w    $CE73        ; $00EB02
        dc.w    $D294        ; $00EB04
        dc.w    $D6B5        ; $00EB06
        dc.w    $DAD6        ; $00EB08
        dc.w    $DEF7        ; $00EB0A
        dc.w    $E318        ; $00EB0C
        dc.w    $E739        ; $00EB0E
        dc.w    $EB5A        ; $00EB10
        dc.w    $EF7B        ; $00EB12
        dc.w    $F39C        ; $00EB14
        dc.w    $F7BD        ; $00EB16
        dc.w    $FBDE        ; $00EB18
        dc.w    $FFFF        ; $00EB1A
        dc.w    $800A        ; $00EB1C
        dc.w    $800B        ; $00EB1E
        dc.w    $800C        ; $00EB20
        dc.w    $800D        ; $00EB22
        dc.w    $800E        ; $00EB24
        dc.w    $800F        ; $00EB26
        dc.w    $8010        ; $00EB28
        dc.w    $8011        ; $00EB2A
        dc.w    $8012        ; $00EB2C
        dc.w    $8432        ; $00EB2E
        dc.w    $8C73        ; $00EB30
        dc.w    $9094        ; $00EB32
        dc.w    $98D4        ; $00EB34
        dc.w    $A536        ; $00EB36
        dc.w    $BC00        ; $00EB38
        dc.w    $C800        ; $00EB3A
        dc.w    $D800        ; $00EB3C
        dc.w    $E000        ; $00EB3E
        dc.w    $E063        ; $00EB40
        dc.w    $E484        ; $00EB42
        dc.w    $E4C6        ; $00EB44
        dc.w    $E4E7        ; $00EB46
        dc.w    $E929        ; $00EB48
        dc.w    $F2B5        ; $00EB4A
        dc.w    $F718        ; $00EB4C
        dc.w    $8000        ; $00EB4E
        dc.w    $8000        ; $00EB50
        dc.w    $8000        ; $00EB52
        dc.w    $8000        ; $00EB54
        dc.w    $8000        ; $00EB56
        dc.w    $8000        ; $00EB58
        dc.w    $8000        ; $00EB5A
        dc.w    $8000        ; $00EB5C
        dc.w    $8000        ; $00EB5E
        dc.w    $8000        ; $00EB60
        dc.w    $8000        ; $00EB62
        dc.w    $8000        ; $00EB64
        dc.w    $94A0        ; $00EB66
        dc.w    $8840        ; $00EB68
        dc.w    $8000        ; $00EB6A
        dc.w    $8840        ; $00EB6C
        dc.w    $9080        ; $00EB6E
        dc.w    $98C1        ; $00EB70
        dc.w    $A103        ; $00EB72
        dc.w    $A945        ; $00EB74
; Padding: 94 bytes (47 words) of zeros from $EB76-$EBD2
        dcb.w   47, $0000
        dc.w    $0000        ; $00EBD4
        dc.w    $0000        ; $00EBD6
        dc.w    $0000        ; $00EBD8
        dc.w    $0000        ; $00EBDA
        dc.w    $8000        ; $00EBDC
        dc.w    $8421        ; $00EBDE
        dc.w    $8842        ; $00EBE0
        dc.w    $8C63        ; $00EBE2
        dc.w    $9084        ; $00EBE4
        dc.w    $94A5        ; $00EBE6
        dc.w    $98C6        ; $00EBE8
        dc.w    $9CE7        ; $00EBEA
        dc.w    $A108        ; $00EBEC
        dc.w    $A529        ; $00EBEE
        dc.w    $A94A        ; $00EBF0
        dc.w    $AD6B        ; $00EBF2
        dc.w    $B18C        ; $00EBF4
        dc.w    $B5AD        ; $00EBF6
        dc.w    $B9CE        ; $00EBF8
        dc.w    $BDEF        ; $00EBFA
        dc.w    $C210        ; $00EBFC
        dc.w    $C631        ; $00EBFE
        dc.w    $CA52        ; $00EC00
        dc.w    $CE73        ; $00EC02
        dc.w    $D294        ; $00EC04
        dc.w    $D6B5        ; $00EC06
        dc.w    $DAD6        ; $00EC08
        dc.w    $DEF7        ; $00EC0A
        dc.w    $E318        ; $00EC0C
        dc.w    $E739        ; $00EC0E
        dc.w    $EB5A        ; $00EC10
        dc.w    $EF7B        ; $00EC12
        dc.w    $F39C        ; $00EC14
        dc.w    $F7BD        ; $00EC16
        dc.w    $FBDE        ; $00EC18
        dc.w    $FFFF        ; $00EC1A
        dc.w    $9060        ; $00EC1C
        dc.w    $9481        ; $00EC1E
        dc.w    $9CC3        ; $00EC20
        dc.w    $A4E4        ; $00EC22
        dc.w    $AD26        ; $00EC24
        dc.w    $AC61        ; $00EC26
        dc.w    $B082        ; $00EC28
        dc.w    $B4A3        ; $00EC2A
        dc.w    $B8C4        ; $00EC2C
        dc.w    $BCE5        ; $00EC2E
        dc.w    $C106        ; $00EC30
        dc.w    $800A        ; $00EC32
        dc.w    $800C        ; $00EC34
        dc.w    $800E        ; $00EC36
        dc.w    $8010        ; $00EC38
        dc.w    $8431        ; $00EC3A
        dc.w    $8C72        ; $00EC3C
        dc.w    $94B3        ; $00EC3E
        dc.w    $9CF4        ; $00EC40
        dc.w    $8000        ; $00EC42
        dc.w    $8000        ; $00EC44
        dc.w    $8000        ; $00EC46
        dc.w    $8000        ; $00EC48
        dc.w    $8000        ; $00EC4A
        dc.w    $8000        ; $00EC4C
        dc.w    $8000        ; $00EC4E
        dc.w    $8000        ; $00EC50
        dc.w    $8000        ; $00EC52
        dc.w    $8000        ; $00EC54
        dc.w    $8000        ; $00EC56
        dc.w    $8000        ; $00EC58
        dc.w    $8000        ; $00EC5A
        dc.w    $8000        ; $00EC5C
        dc.w    $8000        ; $00EC5E
        dc.w    $8000        ; $00EC60
        dc.w    $8000        ; $00EC62
        dc.w    $8000        ; $00EC64
        dc.w    $8C60        ; $00EC66
        dc.w    $8840        ; $00EC68
        dc.w    $8000        ; $00EC6A
        dc.w    $8840        ; $00EC6C
        dc.w    $9080        ; $00EC6E
        dc.w    $98C1        ; $00EC70
        dc.w    $A103        ; $00EC72
        dc.w    $A945        ; $00EC74
; Padding: 72 bytes (36 words) of zeros from $EC76-$ECBC
        dcb.w   36, $0000
        include "modules/68k/game/fn_e200_004.asm"

; ============================================================================
; Function: SH2 Status Check and ROM Vector Setup ($00EEF2-$00EF30)
; ============================================================================
; Waits for SH2 Master CPU ready (COMM0 clear), clears COMM3, resets index
; at ($C87E), and writes ROM function pointers to ($FF0002) based on VINT
; enable flags.
;
; Memory writes:
;   ($C87E).W = $0000                    - Reset jump table index
;   ($FF0002).L = ROM function pointer   - Selected based on VINT flags
;
; BLOCKING: Polls COMM0 until clear (Master SH2 ready signal)
; Uses: A0 (scratch)
; ============================================================================
sh2_status_check_and_vector_setup:
.wait_master:
        tst.b   COMM0                           ; $00EEF2 - Test Master ready
        bne.s   .wait_master                    ; $00EEF8 - Loop until clear

        clr.b   COMM3                           ; $00EEFA - Clear COMM3
        dc.w    $31FC,$0000,$C87E               ; $00EF00: MOVE.W #$0000,($C87E).W - Reset index

        ; Write first ROM vector ($008926D2)
        dc.w    $23FC,$0089,$26D2,$00FF,$0002   ; $00EF06: MOVE.L #$008926D2,($FF0002).W

        ; Check VINT enable flags and conditionally write alternate vectors
        dc.w    $4A38,$A018                     ; $00EF10: TST.B ($A018).W - Test VINT enable 1
        dc.w    $661A                           ; $00EF14: BNE.S .done (+$1A)

        dc.w    $23FC,$0088,$D4A4,$00FF,$0002   ; $00EF16: MOVE.L #$0088D4A4,($FF0002).W - Alternate vector 1

.check_second_flag:
        dc.w    $4A38,$A01F                     ; $00EF20: TST.B ($A01F).W - Test VINT enable 2
        dc.w    $660A                           ; $00EF24: BNE.S .done (+$0A)

        dc.w    $23FC,$0088,$D48A,$00FF,$0002   ; $00EF26: MOVE.L #$0088D48A,($FF0002).W - Alternate vector 2

.done:
        rts                                     ; $00EF30

; ============================================================================
; Function: Table-Based Dual Dispatch with COMM Sync ($00EF32-$00EFA2)
; ============================================================================
; Selects data from two different tables based on flags, then dispatches to
; rendering functions. Each table entry contains a 4-byte address and a 2-byte
; parameter (6 bytes total). Index is computed as byte_value * 3 (for 6-byte
; entries accessed as longword + word).
;
; First dispatch:  Uses table at $0088EFA4, calls function at $00E9B4
; Second dispatch: Uses table at $0088EFB6, calls sh2_cmd_27 after COMM sync
;
; Parameters loaded from tables and passed to dispatch functions:
;   A0 = Longword from table[index*6]
;   D0 = Word from table[index*6 + 4]
;   D1 = Width parameter (#$0030 or #$0018)
;   D2 = Height parameter (#$0010)
;
; BLOCKING: Waits for COMM0 clear before second dispatch
; Uses: D0-D2, A0-A1
; ============================================================================
table_dual_dispatch:
        ; ---- First table dispatch ----
        moveq   #$00,d0                         ; $00EF32 - Clear D0
        dc.w    $4A38,$A01A                     ; $00EF34: TST.B ($A01A).W - Test flag 1
        bne.s   .use_alt1_index                 ; $00EF38 - Branch if set
        dc.w    $1038,$A019                     ; $00EF3A: MOVE.B ($A019).W,D0 - Load index A
        bra.s   .dispatch1                      ; $00EF3E
.use_alt1_index:
        dc.w    $1038,$A01E                     ; $00EF40: MOVE.B ($A01E).W,D0 - Load index B

.dispatch1:
        lea     $0088EFA4.l,a1                  ; $00EF44 - Load table 1 base
        add.w   d0,d0                           ; $00EF4A - D0 *= 2
        move.w  d0,d1                           ; $00EF4C - D1 = D0
        add.w   d0,d0                           ; $00EF4E - D0 *= 2 (now *= 4)
        add.w   d1,d0                           ; $00EF50 - D0 = D0 + D1 (now *= 6)
        movea.l (a1,d0.w),a0                    ; $00EF52 - Load address from table
        move.w  ($04,a1,d0.w),d0                ; $00EF56 - Load word param
        move.w  #$0030,d1                       ; $00EF5A - Width = $30
        move.w  #$0010,d2                       ; $00EF5E - Height = $10
        dc.w    $4EBA,$F450                     ; $00EF62: JSR (PC),$F450 -> $00E3B4

        ; ---- Second table dispatch ----
        moveq   #$00,d0                         ; $00EF66 - Clear D0
        dc.w    $4A38,$A01A                     ; $00EF68: TST.B ($A01A).W - Test flag 1
        beq.s   .use_alt2_index                 ; $00EF6C - Branch if clear
        dc.w    $1038,$A019                     ; $00EF6E: MOVE.B ($A019).W,D0 - Load index A
        bra.s   .dispatch2                      ; $00EF72
.use_alt2_index:
        dc.w    $1038,$A01D                     ; $00EF74: MOVE.B ($A01D).W,D0 - Load index B

.dispatch2:
        lea     $0088EFB6.l,a1                  ; $00EF78 - Load table 2 base
        add.w   d0,d0                           ; $00EF7E - D0 *= 2
        move.w  d0,d1                           ; $00EF80 - D1 = D0
        add.w   d0,d0                           ; $00EF82 - D0 *= 4
        add.w   d1,d0                           ; $00EF84 - D0 *= 6
        movea.l (a1,d0.w),a0                    ; $00EF86 - Load address from table
        move.w  ($04,a1,d0.w),d0                ; $00EF8A - Load word param
        move.w  #$0018,d1                       ; $00EF8E - Width = $18
        move.w  #$0010,d2                       ; $00EF92 - Height = $10

.wait_comm_ready:
        tst.b   COMM0                           ; $00EF96 - Check COMM0 clear
        bne.s   .wait_comm_ready                ; $00EF9C - Wait until clear

        dc.w    $4EBA,$F414                     ; $00EF9E: JSR (PC),$F414 -> sh2_cmd_27
        rts                                     ; $00EFA2
        dc.w    $0401        ; $00EFA4
        dc.w    $2010        ; $00EFA6
        dc.w    $0060        ; $00EFA8
        dc.w    $0401        ; $00EFAA
        dc.w    $206F        ; $00EFAC
        dc.w    $0061        ; $00EFAE
        dc.w    $0401        ; $00EFB0
        dc.w    $20CF        ; $00EFB2
        dc.w    $0061        ; $00EFB4
        dc.w    $0401        ; $00EFB6
        dc.w    $B010        ; $00EFB8
        dc.w    $0091        ; $00EFBA
        dc.w    $0401        ; $00EFBC
        dc.w    $B0A0        ; $00EFBE
        dc.w    $0090        ; $00EFC0
        include "modules/68k/sh2/comm_transfer_setup_a.asm"
        dc.w    $2228        ; $00F034
        dc.w    $1450        ; $00F036
        dc.w    $2228        ; $00F038
        dc.w    $155A        ; $00F03A
        dc.w    $2228        ; $00F03C
        dc.w    $1664        ; $00F03E
        include "modules/68k/sh2/comm_transfer_setup_b.asm"
        dc.w    $2228        ; $00F0B2
        dc.w    $4FAA        ; $00F0B4
        dc.w    $2228        ; $00F0B6
        dc.w    $506C        ; $00F0B8
        dc.w    $2228        ; $00F0BA
        dc.w    $512E        ; $00F0BC
        include "modules/68k/sh2/comm_transfer_setup_c.asm"
        include "modules/68k/game/fn_e200_005.asm"
        include "modules/68k/game/fn_e200_006.asm"
        include "modules/68k/game/fn_e200_007.asm"
        include "modules/68k/game/fn_e200_008.asm"
        dc.w    $0603        ; $00F838
        dc.w    $D780        ; $00F83A
        dc.w    $0400        ; $00F83C
        dc.w    $4C68        ; $00F83E
        dc.w    $0070        ; $00F840
        dc.w    $0010        ; $00F842
        dc.w    $0603        ; $00F844
        dc.w    $DE80        ; $00F846
        dc.w    $0400        ; $00F848
        dc.w    $EC2C        ; $00F84A
        dc.w    $0048        ; $00F84C
        dc.w    $0010        ; $00F84E
        dc.w    $0603        ; $00F850
        dc.w    $F200        ; $00F852
        dc.w    $0400        ; $00F854
        dc.w    $ECC4        ; $00F856
        dc.w    $0048        ; $00F858
        dc.w    $0010        ; $00F85A
        include "modules/68k/sh2/sync_wait_reset.asm"
        include "modules/68k/display/palette_table_init.asm"
        include "modules/68k/game/fn_e200_009.asm"
        dc.w    $0400        ; $00FB24
        dc.w    $7010        ; $00FB26
        dc.w    $0060        ; $00FB28
        dc.w    $0400        ; $00FB2A
        dc.w    $706F        ; $00FB2C
        dc.w    $0061        ; $00FB2E
        dc.w    $0400        ; $00FB30
        dc.w    $70CF        ; $00FB32
        dc.w    $0061        ; $00FB34
        include "modules/68k/sh2/comm_transfer_block.asm"
        include "modules/68k/game/fn_e200_010.asm"
        include "modules/68k/game/fn_e200_011.asm"
        dc.w    $4240        ; $01017A
        dc.w    $6100        ; $01017C
        dc.w    $E3AE        ; $01017E
        dc.w    $4EBA        ; $010180
        dc.w    $B502        ; $010182
        dc.w    $6100        ; $010184
        dc.w    $0596        ; $010186
        dc.w    $207C        ; $010188
        dc.w    $0601        ; $01018A
        dc.w    $AA00        ; $01018C
        dc.w    $227C        ; $01018E
        dc.w    $2400        ; $010190
        dc.w    $C060        ; $010192
        dc.w    $303C        ; $010194
        dc.w    $0038        ; $010196
        dc.w    $323C        ; $010198
        dc.w    $0010        ; $01019A
        dc.w    $4EBA        ; $01019C
        dc.w    $E1BC        ; $01019E
        dc.w    $43F9        ; $0101A0
        dc.w    $2402        ; $0101A2
        dc.w    $C0A0        ; $0101A4
        dc.w    $45F8        ; $0101A6
        dc.w    $A032        ; $0101A8
        dc.w    $6100        ; $0101AA
        dc.w    $045A        ; $0101AC
        dc.w    $0838        ; $0101AE
        dc.w    $0001        ; $0101B0
        dc.w    $A014        ; $0101B2
        dc.w    $661A        ; $0101B4
        dc.w    $207C        ; $0101B6
        dc.w    $0601        ; $0101B8
        dc.w    $AD80        ; $0101BA
        dc.w    $227C        ; $0101BC
        dc.w    $2400        ; $0101BE
        dc.w    $E050        ; $0101C0
        dc.w    $303C        ; $0101C2
        dc.w    $0048        ; $0101C4
        dc.w    $323C        ; $0101C6
        dc.w    $0010        ; $0101C8
        dc.w    $4EBA        ; $0101CA
        dc.w    $E18E        ; $0101CC
        dc.w    $6018        ; $0101CE
        dc.w    $207C        ; $0101D0
        dc.w    $0601        ; $0101D2
        dc.w    $B200        ; $0101D4
        dc.w    $227C        ; $0101D6
        dc.w    $2400        ; $0101D8
        dc.w    $E038        ; $0101DA
        dc.w    $303C        ; $0101DC
        dc.w    $0068        ; $0101DE
        dc.w    $323C        ; $0101E0
        dc.w    $0010        ; $0101E2
        dc.w    $4EBA        ; $0101E4
        dc.w    $E174        ; $0101E6
        dc.w    $43F9        ; $0101E8
        dc.w    $2402        ; $0101EA
        dc.w    $E0A0        ; $0101EC
        dc.w    $45F8        ; $0101EE
        dc.w    $C254        ; $0101F0
        dc.w    $6100        ; $0101F2
        dc.w    $0412        ; $0101F4
        dc.w    $207C        ; $0101F6
        dc.w    $0601        ; $0101F8
        dc.w    $B880        ; $0101FA
        dc.w    $227C        ; $0101FC - MOVEA.L #$24011050,A1 (partial)
        dc.w    $2401        ; $0101FE
