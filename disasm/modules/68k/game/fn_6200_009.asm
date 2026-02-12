; ============================================================================
; Object Bitmask Table + Lookup
; ROM Range: $006B96-$006BCA (52 bytes)
; ============================================================================
; Category: game
; Purpose: 40-byte data table of 10 bitmask pairs (powers of 2 from 1-512),
;   followed by 3-instruction lookup: reads word index from $C07A, fetches
;   word from fn_6200_010's bitmask table ($006BCA) indexed by that value,
;   stores result to $C26C.
;
; Uses: D0
; RAM:
;   $C07A: bitmask table index (word)
;   $C26C: bitmask lookup result (word)
; ============================================================================

fn_6200_009:
; --- data: 10 bitmask pairs (referenced externally) ---
        dc.w    $0001,$0001                     ; $006B96  pair 0: bit 0
        dc.w    $0002,$0002                     ; $006B9A  pair 1: bit 1
        dc.w    $0004,$0004                     ; $006B9E  pair 2: bit 2
        dc.w    $0008,$0008                     ; $006BA2  pair 3: bit 3
        dc.w    $0010,$0010                     ; $006BA6  pair 4: bit 4
        dc.w    $0020,$0020                     ; $006BAA  pair 5: bit 5
        dc.w    $0040,$0040                     ; $006BAE  pair 6: bit 6
        dc.w    $0080,$0080                     ; $006BB2  pair 7: bit 7
        dc.w    $0100,$0100                     ; $006BB6  pair 8: bit 8
        dc.w    $0200,$0200                     ; $006BBA  pair 9: bit 9
; --- code: table lookup ---
        move.w  ($FFFFC07A).w,D0               ; $006BBE  D0 = table index
        move.w  $006BCA(PC,D0.W),($FFFFC26C).w ; $006BC2  result = table[D0]
        rts                                     ; $006BC8
