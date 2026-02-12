; ============================================================================
; Backward Object Scan + Copy Scroll Data
; ROM Range: $00BD00-$00BD2A (42 bytes)
; ============================================================================
; Category: game
; Purpose: Scans backward through 16-byte object entries starting from A0,
;   skipping entries with type byte $0C. Copies 6 words from the first
;   non-$0C entry to scroll/position registers.
;   Same destination registers as fn_a200_036.
;
; Entry: A0 = object pointer (scan start)
; Uses: A1
; RAM:
;   $C086: scroll register 1 (word)
;   $C054: scroll register 2 (word)
;   $C056: scroll register 3 (word)
;   $C0AE: position register 1 (word)
;   $C0B0: position register 2 (word)
;   $C0B2: position register 3 (word)
; ============================================================================

fn_a200_037:
        lea     $0002(A0),A1                    ; $00BD00  A1 = A0+2 (skip type word)
.scan_back:
        lea     -$0010(A1),A1                   ; $00BD04  back up one 16-byte entry
        cmpi.b  #$0C,-$0002(A1)                 ; $00BD08  check entry type byte
        beq.s   .scan_back                      ; $00BD0E  skip type-$0C entries
        move.w  (A1)+,($FFFFC086).w             ; $00BD10  copy word 1 → scroll reg 1
        move.w  (A1)+,($FFFFC054).w             ; $00BD14  copy word 2 → scroll reg 2
        move.w  (A1)+,($FFFFC056).w             ; $00BD18  copy word 3 → scroll reg 3
        move.w  (A1)+,($FFFFC0AE).w             ; $00BD1C  copy word 4 → position reg 1
        move.w  (A1)+,($FFFFC0B0).w             ; $00BD20  copy word 5 → position reg 2
        move.w  (A1)+,($FFFFC0B2).w             ; $00BD24  copy word 6 → position reg 3
        rts                                     ; $00BD28
