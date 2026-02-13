; ============================================================================
; FM Channel Timer Check — decrement timer and reinit on expiry
; ROM Range: $03021A-$03023A (32 bytes)
; ============================================================================
; Checks FM sound channel timer at A5+$12. If zero, returns (branches to
; caller's RTS). Decrements timer; if not yet zero, returns. On expiry
; (timer reaches 0): sets bit 1 flag at (A5), checks channel sign at
; A5+$01. If positive, calls fm_init_channel to restart the channel and
; pops return address (skips caller's remaining code).
;
; Entry: A5 = FM channel structure pointer (+$01=sign, +$12=timer)
; Uses: A5, A7 (stack pop)
; Calls:
;   $030C8A: fm_init_channel
; Confidence: medium
; ============================================================================

fn_30200_001:
        TST.B  $0012(A5)                        ; $03021A
        DC.W    $6720               ; BEQ.S  $030240; $03021E
        SUBQ.B  #1,$0012(A5)                    ; $030220
        DC.W    $661A               ; BNE.S  $030240; $030224
        BSET    #1,(A5)                         ; $030226
        TST.B  $0001(A5)                        ; $03022A
        DC.W    $6B00,$000A         ; BMI.W  $03023A; $03022E
        DC.W    $4EBA,$0A56         ; JSR     $030C8A(PC); $030232
        ADDQ.W  #4,A7                           ; $030236
        RTS                                     ; $030238
