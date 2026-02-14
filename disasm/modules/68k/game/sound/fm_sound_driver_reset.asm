; ============================================================================
; FM Sound Driver Reset — full/partial silence and state clear
; ROM Range: $030B90-$030BE0 (80 bytes)
; ============================================================================
; Two entry points:
;   $030B90 (full reset): Writes DAC enable ($2B=$80), key-off all ($27=$00),
;     clears entire driver state ($E4 longs = $390 bytes), sets command
;     sentinel $80, calls key-off+volume zero ($030B50), branches to $030FC8.
;   $030BBC (partial reset): Writes key-off all ($27=$00), clears $88 longs
;     ($220 bytes, preserves priority at A6+$00), sets command sentinel $80.
;
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, A0, A6
; Calls:
;   $030CBA: fm_write_wrapper
; Confidence: high
; ============================================================================

fm_sound_driver_reset:
        MOVEQ   #$2B,D0                         ; $030B90
        MOVE.B  #$80,D1                         ; $030B92
        jsr     fm_write_wrapper(pc)    ; $4EBA $0122
        MOVEQ   #$27,D0                         ; $030B9A
        MOVEQ   #$00,D1                         ; $030B9C
        jsr     fm_write_wrapper(pc)    ; $4EBA $011A
        MOVEA.L A6,A0                           ; $030BA2
        MOVE.W  #$00E3,D0                       ; $030BA4
.loc_0018:
        CLR.L  (A0)+                            ; $030BA8
        DBRA    D0,.loc_0018                    ; $030BAA
        MOVE.B  #$80,$0009(A6)                  ; $030BAE
        jsr     fm_key_off_volume_zero(pc); $4EBA $FF9A
        DC.W    $6000,$040E         ; BRA.W  $030FC8; $030BB8
        MOVEQ   #$27,D0                         ; $030BBC
        MOVEQ   #$00,D1                         ; $030BBE
        jsr     fm_write_wrapper(pc)    ; $4EBA $00F8
        MOVEA.L A6,A0                           ; $030BC4
        MOVE.B  $0000(A6),D1                    ; $030BC6
        MOVE.W  #$0087,D0                       ; $030BCA
.loc_003E:
        CLR.L  (A0)+                            ; $030BCE
        DBRA    D0,.loc_003E                    ; $030BD0
        MOVE.B  D1,$0000(A6)                    ; $030BD4
        MOVE.B  #$80,$0009(A6)                  ; $030BD8
        RTS                                     ; $030BDE
