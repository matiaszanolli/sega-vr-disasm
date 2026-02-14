; ============================================================================
; Object Bitmask Table + Lookup
; ROM Range: $006B96-$006BCA (52 bytes)
; ============================================================================
; Category: game
; Purpose: 40-byte data table of 10 bitmask pairs (powers of 2 from 1-512),
;   followed by 3-instruction lookup: reads word index from $C07A, fetches
;   word from object_bitmask_table_button_flag_handler's bitmask table ($006BCA) indexed by that value,
;   stores result to $C26C.
;
; Uses: D0
; RAM:
;   $C07A: bitmask table index (word)
;   $C26C: bitmask lookup result (word)
; ============================================================================

object_bitmask_table_lookup:
; --- data: 10 bitmask pairs (referenced externally) ---
        ori.b  #$01,d1                  ; $0001 $0001
        ori.b  #$02,d2                  ; $0002 $0002
        ori.b  #$04,d4                  ; $0004 $0004
        dc.w    $0008,$0008                     ; $006BA2  pair 3: bit 3
        ori.b  #$10,(a0)                ; $0010 $0010
        ori.b  #$20,-(a0)               ; $0020 $0020
        ori.w  #$0040,d0                ; $0040 $0040
        dc.w    $0080,$0080                     ; $006BB2  pair 7: bit 7
        dc.w    $0100,$0100                     ; $006BB6  pair 8: bit 8
        dc.w    $0200,$0200                     ; $006BBA  pair 9: bit 9
; --- code: table lookup ---
        move.w  ($FFFFC07A).w,D0               ; $006BBE  D0 = table index
        move.w  $006BCA(PC,D0.W),($FFFFC26C).w ; $006BC2  result = table[D0]
        rts                                     ; $006BC8
