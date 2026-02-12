; ============================================================================
; Scroll Pan Calculation + VDP Write
; ROM Range: $009064-$00909C (56 bytes)
; ============================================================================
; Category: game
; Purpose: If $C313 bit 3 clear: reads obj.$CC, shifts right by 6, writes
;   to $8002. Reads $FF6108, shifts right by 8, clamps to [-8, 16],
;   subtracts 8, stores to $C882. Writes $FEC0 to $8000.
;   If $C313 bit 3 set → exits to $00909C.
;
; Entry: A0 = object pointer
; Uses: D0, A0
; Object fields:
;   A0+$CC: scroll source value (word)
; RAM:
;   $C313: control flags (byte, bit 3)
;   $C882: VDP pan offset (word)
;   $8000: VDP scroll A (word, set to $FEC0)
;   $8002: VDP scroll B (word, set from obj.$CC)
; ============================================================================

fn_8200_032:
        btst    #3,($FFFFC313).w               ; $009064  bit 3 set?
        dc.w    $6630                           ; $00906A  bne.s $00909C → exit (past fn)
        move.w  $00CC(A0),D0                    ; $00906C  D0 = scroll source
        asr.w   #6,D0                           ; $009070  D0 >>= 6
        move.w  D0,($FFFF8002).w               ; $009072  VDP scroll B = D0
        move.w  $00FF6108,D0                   ; $009076  D0 = pan input
        asr.w   #8,D0                           ; $00907C  D0 >>= 8
        cmpi.w  #$FFF8,D0                       ; $00907E  D0 < -8?
        bge.s   .check_max                      ; $009082  no → check max
        moveq   #-$08,D0                        ; $009084  clamp D0 = -8
.check_max:
        cmpi.w  #$0010,D0                       ; $009086  D0 > 16?
        ble.s   .store                          ; $00908A  no → store
        moveq   #$10,D0                         ; $00908C  clamp D0 = 16
.store:
        subq.w  #8,D0                           ; $00908E  D0 -= 8 (center offset)
        move.w  D0,($FFFFC882).w               ; $009090  store pan offset
        move.w  #$FEC0,($FFFF8000).w           ; $009094  VDP scroll A = $FEC0
        rts                                     ; $00909A
