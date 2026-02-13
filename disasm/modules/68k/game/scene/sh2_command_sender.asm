; ============================================================================
; sh2_command_sender — SH2 Command Sender (Multi-Parameter)
; ROM Range: $011A70-$011B08 (152 bytes)
; ============================================================================
; Sends multiple parameters to the SH2 via COMM registers using a handshake
; protocol. After the data prefix, sends:
;   1. A1 pointer via COMM4 (with command $20)
;   2. D0 (COMM4) + D1 (COMM5) word pair
;   3. D2 via COMM4
;   4. A0 pointer via COMM4
; Each send waits for COMM6 acknowledgment from SH2.
;
; Data prefix: 40 bytes of structured parameter blocks.
;
; Entry: D0, D1, D2 = parameter words; A0, A1 = parameter pointers
; Uses: D0, D1, D2, A0, A1
; 32X registers: COMM0_HI, COMM0_LO, COMM4, COMM5, COMM6
; ============================================================================

sh2_command_sender:
; --- data prefix (20 words = 40 bytes) ----------------------------------------
        dc.w    $4400,$44A3,$4946,$4DE9         ; $011A70  block 0
        dc.w    $4400,$44A3,$4946,$4DE9         ; $011A78  block 1 (same as block 0)
        dc.w    $0000,$0000                     ; $011A80  separator
        dc.w    $0011,$0003,$0005,$0011          ; $011A84  parameter descriptors
        dc.w    $0006,$000A,$0012,$0008          ; $011A8C
        dc.w    $000F,$0013                     ; $011A94
; --- code starts here ---------------------------------------------------------
.wait_comm0_clear:
        tst.b   COMM0_HI                        ; $011A98  wait for 68K→SH2 channel clear
        bne.s   .wait_comm0_clear               ; $011A9E
        move.l  A1,COMM4                        ; $011AA0  send A1 pointer
        move.b  #$01,COMM6                      ; $011AA6  signal data ready
        move.b  #$20,COMM0_LO                   ; $011AAE  command $20
        move.b  #$01,COMM0_HI                   ; $011AB6  trigger SH2
.wait_ack1:
        tst.b   COMM6                           ; $011ABE  wait for SH2 acknowledgment
        bne.s   .wait_ack1                      ; $011AC4
        move.w  D0,COMM4                        ; $011AC6  send D0
        move.w  D1,COMM5                        ; $011ACC  send D1
        move.b  #$01,COMM6                      ; $011AD2  signal data ready
.wait_ack2:
        tst.b   COMM6                           ; $011ADA
        bne.s   .wait_ack2                      ; $011AE0
        move.w  D2,COMM4                        ; $011AE2  send D2
        move.b  #$01,COMM6                      ; $011AE8
.wait_ack3:
        tst.b   COMM6                           ; $011AF0
        bne.s   .wait_ack3                      ; $011AF6
        move.l  A0,COMM4                        ; $011AF8  send A0 pointer
        move.b  #$01,COMM6                      ; $011AFE
        rts                                     ; $011B06
