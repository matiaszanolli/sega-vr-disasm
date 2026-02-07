; ============================================================================
; Fm Init Channel 001 (auto-analyzed)
; ROM Range: $03021A-$03023A (32 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Calls: fm_init_channel
;   Object (A5): +$01, +$12 (timer_12)
;
; Entry: A5 = object/entity pointer
; Uses: A5
; Calls:
;   $030C8A: fm_init_channel
; Object fields:
;   +$01: [unknown]
;   +$12: timer_12
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
