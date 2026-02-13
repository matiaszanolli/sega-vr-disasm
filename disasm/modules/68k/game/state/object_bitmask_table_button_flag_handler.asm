; ============================================================================
; Object Bitmask Table + Button Flag Handler
; ROM Range: $006BCA-$006C08 (62 bytes)
; ============================================================================
; Category: game
; Purpose: 32-byte data table of 8 bitmask pairs (powers of 2 from 1-128),
;   referenced by object_bitmask_table_lookup as lookup table.
;   Code reads button flags from $C30E, masks bits 0+5 ($21):
;   if any set → clears bit 4 of $C30E.
;   if bit 5 set → copies $C098 to $C07A.
;
; Uses: D0
; RAM:
;   $C07A: bitmask table index (word, destination of copy)
;   $C098: source parameter (word)
;   $C30E: button/control flags (byte, bits 0/4/5)
; ============================================================================

object_bitmask_table_button_flag_handler:
; --- data: 8 bitmask pairs (referenced by object_bitmask_table_lookup) ---
        dc.w    $0001,$0001                     ; $006BCA  pair 0: bit 0
        dc.w    $0002,$0002                     ; $006BCE  pair 1: bit 1
        dc.w    $0004,$0004                     ; $006BD2  pair 2: bit 2
        dc.w    $0008,$0008                     ; $006BD6  pair 3: bit 3
        dc.w    $0010,$0010                     ; $006BDA  pair 4: bit 4
        dc.w    $0020,$0020                     ; $006BDE  pair 5: bit 5
        dc.w    $0040,$0040                     ; $006BE2  pair 6: bit 6
        dc.w    $0080,$0080                     ; $006BE6  pair 7: bit 7
; --- code: button flag handler ---
        move.b  ($FFFFC30E).w,D0               ; $006BEA  D0 = button flags
        andi.b  #$21,D0                         ; $006BEE  mask bits 0 + 5
        beq.s   .done                           ; $006BF2  none set → done
        bclr    #4,($FFFFC30E).w               ; $006BF4  clear bit 4 of flags
        btst    #5,D0                           ; $006BFA  bit 5 set?
        beq.s   .done                           ; $006BFE  no → done
        move.w  ($FFFFC098).w,($FFFFC07A).w    ; $006C00  copy param to index
.done:
        rts                                     ; $006C06
