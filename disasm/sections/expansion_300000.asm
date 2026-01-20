; ============================================================================
; ROM Section ($300000-$3FFFFF) - Official 4MB Cartridge Upper Region
; ============================================================================
;
; IMPORTANT: Virtua Racing Deluxe official spec is 32 Mbit (4MB), NOT 3MB!
;
; The original cartridge contained:
;   $000000-$2FFFFF (3MB)  - Game data (what ROM dumps contain)
;   $300000-$3FFFFF (1MB)  - Unused space (all 0xFF padding)
;
; ROM dumps are typically 3MB because trailing 0xFF bytes are trimmed.
; We restore the ROM to its official 4MB size and use the previously
; unused 1MB for Slave SH2 custom code - this is safe and correct.
;
; Memory Map:
;   $300000-$30FFFF (64KB)  - Reserved for Slave SH2 rendering code
;   $310000-$3FFFFF (960KB) - Padding (matches original cartridge)
;
; SH2 CPU Address: ROM $300000 = SH2 $02300000
;
; ============================================================================

        org     $300000

; ============================================================================
; SLAVE SH2 CODE AREA (64KB reserved)
; ============================================================================

slave_code_start:
        ; ===== Slave Work Check Function (from sh2_slave_work_compact.asm) =====
slave_work_check:                       ; $300000 (SH2: 0x06300000)
        dc.w    $D007        ; MOV.L comm4_addr,R0
        dc.w    $D108        ; MOV.L comm2_addr,R1
        dc.w    $6201        ; MOV.W @R0,R2
        dc.w    $2228        ; TST R2,R2
        dc.w    $8902        ; BT done
        dc.w    $6311        ; MOV.W @R1,R3
        dc.w    $7301        ; ADD #1,R3
        dc.w    $2131        ; MOV.W R3,@R1
        dc.w    $000B        ; RTS (done:)
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP (alignment)
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP
        dc.w    $2000        ; .long 0x20004028 (COMM4 address)
        dc.w    $4028
        dc.w    $2000        ; .long 0x20004024 (COMM2 address)
        dc.w    $4024

        ; ===== Master Work Dispatch Function (from sh2_master_work_dispatch.asm) =====
master_dispatch_work:                   ; $300028 (SH2: 0x06300028)
        dc.w    $D003        ; MOV.L comm4_addr2,R0
        dc.w    $E101        ; MOV #1,R1
        dc.w    $2011        ; MOV.W R1,@R0
        dc.w    $000B        ; RTS
        dc.w    $0009        ; NOP (delay slot)
        dc.w    $0009        ; NOP (alignment)
        dc.w    $2000        ; .long 0x20004028 (COMM4 address)
        dc.w    $4028

        ; ===== Slave Idle Wrapper (inline VDP wait + work check) =====
slave_idle_wrapper:                     ; $300038 (SH2: 0x02300038 or 0x06300038)
        dc.w    $DB04        ; MOV.L comm4_addr,R11 - load COMM4 address
        dc.w    $DC04        ; MOV.L comm2_addr,R12 - load COMM2 address
idle_wrapper_loop:
        ; === Inline VDP wait (original code from $02050C) ===
        dc.w    $E000        ; MOV #0,R0
        dc.w    $2106        ; MOV.W R0,@R1 (VDP register writes)
        dc.w    $2106        ; MOV.W R0,@R1
        dc.w    $2106        ; MOV.W R0,@R1
        dc.w    $2106        ; MOV.W R0,@R1
        dc.w    $4710        ; DT R1 (decrement loop counter)
        dc.w    $8BF9        ; BF (branch if false)
        ; === Check for work ===
        dc.w    $61B1        ; MOV.W @R11,R1 (R1 = COMM4)
        dc.w    $2118        ; TST R1,R1
        dc.w    $89F2        ; BT idle_wrapper_loop (no work, loop back)
        dc.w    $62C1        ; MOV.W @R12,R2 (R2 = COMM2)
        dc.w    $7201        ; ADD #1,R2
        dc.w    $2C21        ; MOV.W R2,@R12 (COMM2++)
        dc.w    $E100        ; MOV #0,R1
        dc.w    $2B11        ; MOV.W R1,@R11 (clear COMM4)
        dc.w    $AFED        ; BRA idle_wrapper_loop
        dc.w    $0009        ; NOP (delay slot)
        dc.w    $2000        ; .long 0x20004028 (COMM4)
        dc.w    $4028
        dc.w    $2000        ; .long 0x20004024 (COMM2)
        dc.w    $4024

        ; Fill remaining space with NOPs
        dcb.w   32716,$0009     ; Remaining NOPs ($300068-$30FFFF)

slave_code_end:

; ============================================================================
; PADDING TO 4MB
; ============================================================================
; Fill remaining space with $FF (erased flash pattern)

        org     $310000

        dcb.b   983040,$FF      ; 960KB padding to reach $400000

; ============================================================================
; End of ROM at $3FFFFF (4MB)
; ============================================================================
