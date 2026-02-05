; ============================================================================
; VDP Operations and Synchronization ($0027F8-$002982)
; ============================================================================
; Core VDP (Video Display Processor) functions for 32X frame buffer management,
; palette operations, and SH2 synchronization via COMM ports and FIFO.
;
; Functions:
;   - VDPFill: Auto-fill 16 blocks using MARS VDP fill hardware
;   - VDPPrep: Prepare VDP registers for fill operation
;   - VDPOp4: Copy palette data to VDP palette RAM (32 iterations)
;   - MemoryOp3: Copy data to COMM port area (8 iterations)
;   - PaletteRAMCopy: V-INT state 6 palette RAM copy with COMM sync
;   - VDPSyncSH2: Synchronize with SH2 via COMM ports, transfer data via FIFO
;
; Hardware Used:
;   - MARS_VDP_FILLADR: VDP auto-fill start address register
;   - MARS_VDP_FILLDATA: VDP auto-fill data register
;   - MARS_DREQ_LEN: DMA request length
;   - MARS_FIFO: FIFO data register for 68K<->SH2 transfer
;   - MARS_SYS_BASE: 32X system register base
;   - COMM ports: Communication with SH2 CPUs
;
; Dependencies: modules/shared/definitions.asm (hardware register equates)
;
; Originally at $0027F8-$002982 in sections/code_2200.asm
; ============================================================================

        org     $0027F8

VDPFill:
        MOVE.W #$000F,D7        ; $0027F8
        MOVE.W #$0101,D0        ; $0027FC
        MOVE.W #$0100,D2        ; $002800
        MOVE.W #$00FF,$0084(A4)        ; $002804
        MOVE.W D1,(A2)        ; $00280A
        MOVE.W D0,(A3)        ; $00280C
.wait_fifo:
        BTST #1,$008B(A4)        ; $00280E: Test FIFO full bit
        BNE.S .wait_fifo        ; $002814: Loop if full
        ADD.W D2,D1        ; $002816
        DBRA D7,.wait_fifo        ; $002818: Repeat 16 times
        RTS        ; $00281C

; --- VDP preparation ---
VDPPrep:
        LEA MARS_SYS_BASE,A4        ; $00281E
        LEA MARS_VDP_FILLADR,A2        ; $002824
        LEA MARS_VDP_FILLDATA,A3        ; $00282A
        MOVE.W #$1F00,D1        ; $002830
        MOVE.W #$0101,D0        ; $002834
        MOVE.W #$00FF,$0084(A4)        ; $002838
        MOVE.W D1,(A2)        ; $00283E
        MOVE.W D0,(A3)        ; $002840
.wait_fifo:
        BTST #1,$008B(A4)        ; $002842: Test FIFO full bit
        BNE.S .wait_fifo        ; $002848: Loop if full
        RTS        ; $00284A

; --- VDP operation 4 ---
VDPOp4:
        LEA $00A15200,A3        ; $00284C: Palette RAM
        MOVEQ #$1F,D7           ; $002852: 32 iterations
.loop:
        MOVE.L (A2)+,(A3)+        ; $002854
        MOVE.L (A2)+,(A3)+        ; $002856
        MOVE.L (A2)+,(A3)+        ; $002858
        MOVE.L (A2)+,(A3)+        ; $00285A
        DBRA D7,.loop           ; $00285C: Loop 32 times
        RTS        ; $002860

; --- Memory operation 3 ---
MemoryOp3:
        LEA $00A15240,A3        ; $002862: COMM port area
        MOVEQ #$07,D7           ; $002868: 8 iterations
.loop:
        MOVE.L (A2)+,(A3)+        ; $00286A
        MOVE.L (A2)+,(A3)+        ; $00286C
        MOVE.L (A2)+,(A3)+        ; $00286E
        MOVE.L (A2)+,(A3)+        ; $002870
        DBRA D7,.loop           ; $002872: Loop 8 times
        RTS        ; $002876

; --- Palette RAM copy (V-INT state 6) ---
PaletteRAMCopy:
        TST.B   ($C821).W           ; $002878: Check V-INT state flag
        BEQ.S   .skip_copy          ; $00287C: Skip if zero
        LEA $00FF6E00,A1        ; $00287E: Source buffer
        LEA $00A15200,A2        ; $002884: Palette RAM
        BSR.W   VDPOp4              ; $00288A: Copy palette (jumps forward)
.skip_copy:
        RTS        ; $00288E

; --- SH2 communication sync ---
sh2_comm_sync:
.wait_ready:
        BTST    #0,($A15123).L      ; $002890: Test COMM ready bit
        BEQ.S   .wait_ready         ; $002898: Loop until ready
        BCLR    #0,($A15123).L      ; $00289A: Clear ready bit
        MOVE.W  #0,($C8A8).W        ; $0028A2: Clear counter
        MOVE.B  ($C810).W,($A15123).L ; $0028A8: Write command byte 1
        MOVE.B  ($C8A9).W,($A15121).L ; $0028AA: Write command byte 2
        MOVE.B  ($C8A8).W,($A15120).L ; $0028B0: Write counter
        MOVE.B  #0,($A15123).L      ; $0028B8: Clear COMM
        RTS                         ; $0028C0

; --- VDP/SH2 COMM synchronization ---
VDPSyncSH2:
        MOVE.W  #$0500,MARS_DREQ_LEN    ; $0028C2: Set DMA length
        MOVE.B  #4,($A15107).L          ; $0028CA: Write to COMM control
        MOVE.B  ($C8A9).W,($A15121).L   ; $0028D2: Write COMM1
        MOVE.B  ($C8A8).W,($A15120).L   ; $0028DA: Write COMM0
.wait_ack:
        BTST    #1,$00A15123            ; $0028E2: Test ack bit
        BEQ.S   .wait_ack               ; $0028EA: Loop until set
        BCLR    #1,$00A15123            ; $0028EC: Clear ack bit
        LEA $00FF6000,A1        ; $0028F4
        LEA MARS_FIFO,A2        ; $0028FA
        JSR $008988EC        ; $002900
        JSR $008988EC        ; $002906
        JSR $008988EC        ; $00290C
        JSR $008988EC        ; $002912
        JSR $008988EC        ; $002918
        JSR $008988EC        ; $00291E
        JSR $008988EC        ; $002924
        JSR $008988EC        ; $00292A
        JSR $008988EC        ; $002930
        JMP $008988EC        ; $002936

; --- Clear frame buffer function ---
ClearFrameBuffer:
        LEA MARS_SYS_BASE,A4        ; $00293C
        MOVE.B  $0000(A4,D0.W),D4   ; $002942: Read palette index
        LEA MARS_VDP_FILLADR,A2     ; $002946
        LEA MARS_VDP_FILLDATA,A3    ; $00294C
        MOVE.W #$00BF,D7            ; $002952: 192 iterations
        MOVEQ #$00,D0               ; $002956
        MOVE.W #$3000,D1            ; $002958: Start address
        MOVE.W #$0100,D2            ; $00295C: Increment
        MOVE.W #$009F,$0084(A4)     ; $002960: Set fill length
        MOVE.W D1,(A2)              ; $002966: Write address
        MOVE.W D0,(A3)              ; $002968: Write fill value
        MOVEQ #$6F,D0               ; $00296A: Divisor
.fill_loop:
        DIVS    #$81FC,D0           ; $00296C: Calculate offset
.wait_fill:
        BTST #1,$008B(A4)           ; $002970: Test FIFO full
        BNE.S .wait_fill            ; $002976: Loop if full
        ADD.W D2,D1                 ; $002978: Next address
        DBRA D7,.fill_loop          ; $00297A: Loop 192 times
        MOVE.B  $0000(A4,D0.W),D4   ; $00297E: Read palette again
        RTS                         ; $002982
