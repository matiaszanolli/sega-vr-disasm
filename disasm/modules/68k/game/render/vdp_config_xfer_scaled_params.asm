; ============================================================================
; VDP Config Transfer + Scaled Parameters
; ROM Range: $003160-$0031A6 (70 bytes)
; ============================================================================
; Category: game
; Purpose: Writes $0001 to VDP control ($FF6100). Computes display offset
;   D0 = $70 + $C0C6 → writes to $FF60CE. If $C0BA nonzero:
;   writes $0002 to $FF6100, copies 3 words directly from $C0BA to
;   $FF6102, then copies 3 more words with ASR #3 (÷8 scaling).
;
; Uses: D0, A1, A2
; RAM:
;   $C0BA: VDP parameter block (6 words)
;   $C0C6: display offset delta (word)
; ============================================================================

vdp_config_xfer_scaled_params:
        move.w  #$0001,$00FF6100               ; $003160  VDP control = 1
        moveq   #$70,D0                         ; $003168  base offset = $70
        add.w   ($FFFFC0C6).w,D0               ; $00316A  D0 += delta
        move.w  D0,$00FF60CE                   ; $00316E  write display offset
        tst.w   ($FFFFC0BA).w                  ; $003174  params active?
        beq.s   .done                           ; $003178  no → done
        move.w  #$0002,$00FF6100               ; $00317A  VDP control = 2
        lea     ($FFFFC0BA).w,A1               ; $003182  A1 → param source
        lea     $00FF6102,A2                   ; $003186  A2 → VDP dest
        move.w  (A1)+,(A2)+                     ; $00318C  copy word 0
        move.w  (A1)+,(A2)+                     ; $00318E  copy word 1
        move.w  (A1)+,(A2)+                     ; $003190  copy word 2
        move.w  (A1)+,D0                        ; $003192  D0 = word 3
        asr.w   #3,D0                           ; $003194  D0 /= 8
        move.w  D0,(A2)+                        ; $003196  write scaled word 3
        move.w  (A1)+,D0                        ; $003198  D0 = word 4
        asr.w   #3,D0                           ; $00319A  D0 /= 8
        move.w  D0,(A2)+                        ; $00319C  write scaled word 4
        move.w  (A1)+,D0                        ; $00319E  D0 = word 5
        asr.w   #3,D0                           ; $0031A0  D0 /= 8
        move.w  D0,(A2)                         ; $0031A2  write scaled word 5
.done:
        rts                                     ; $0031A4
