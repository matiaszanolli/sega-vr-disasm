; ============================================================================
; ROM Expansion Section ($300000-$3FFFFF)
; Added to expand ROM from 3MB to 4MB for Slave SH2 code
; ============================================================================
;
; Memory Map:
;   $300000-$30FFFF (64KB)  - Reserved for Slave SH2 rendering code
;   $310000-$3FFFFF (960KB) - Padding/future expansion
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

        ; ===== Slave Idle Wrapper (from sh2_slave_idle_wrapper.asm) =====
        ; Wrapper that calls original VDP wait + checks for work
slave_idle_wrapper:                     ; $300038 (SH2: 0x06300038)
        dc.w    $DA07        ; MOV.L vdp_wait_addr,R10
        dc.w    $DB08        ; MOV.L comm4_addr,R11
        dc.w    $DC08        ; MOV.L comm2_addr,R12
idle_wrapper_loop:
        dc.w    $4A0B        ; JSR @R10 (call original VDP wait)
        dc.w    $0009        ; NOP
        dc.w    $61B1        ; MOV.W @R11,R1 (R1 = COMM4)
        dc.w    $2118        ; TST R1,R1
        dc.w    $89FA        ; BT idle_wrapper_loop (no work, loop)
        dc.w    $62C1        ; MOV.W @R12,R2 (R2 = COMM2)
        dc.w    $7201        ; ADD #1,R2
        dc.w    $2C21        ; MOV.W R2,@R12 (COMM2++)
        dc.w    $E100        ; MOV #0,R1
        dc.w    $2B11        ; MOV.W R1,@R11 (clear COMM4)
        dc.w    $AFF4        ; BRA idle_wrapper_loop
        dc.w    $0009        ; NOP
        dc.w    $0009        ; NOP (alignment)
        dc.w    $0602        ; .long 0x0602050C (VDP wait function)
        dc.w    $050C
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
