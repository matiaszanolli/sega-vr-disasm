; ============================================================================
; Track Segment Load 031
; ROM Range: $00B990-$00BA18 (136 bytes)
; ============================================================================
; Category: game
; Purpose: Loads track segment data from ROM into work buffers
;   Reads position pair via indexed table lookup
;   Copies 5 longwords + 9 words from segment data to output buffer
;   Initializes 5 segment counters to 1
;
; Entry: D0 = segment offset (added to base index)
; Uses: D0, A1, A2
; RAM:
;   $C744: segment_table_ptr
;   $C8BC: segment_base_index
;   $C303: segment_sub_index
;   $C054: track_pos_hi
;   $C056: track_pos_lo
;   $C710-$C720: segment_data (5 longwords)
;   $C734: segment_word_ptr
;   $C04C: track_mode
; Confidence: medium
; ============================================================================

track_segment_load_031:
        movea.l ($FFFFC744).w,A1                ; $00B990  A1 → segment table
        add.w   ($FFFFC8BC).w,D0                ; $00B994  D0 += segment_base_index
        movea.l $00(A1,D0.W),A1                 ; $00B998  A1 = segment_table[D0]
        moveq   #$00,D0                         ; $00B99C  D0 = 0
        move.b  ($FFFFC303).w,D0                ; $00B99E  D0 = segment_sub_index
        dc.w    $D040                           ; $00B9A2  ADD.W D0,D0 — D0 *= 2
        dc.w    $D040                           ; $00B9A4  ADD.W D0,D0 — D0 *= 2 (total *4)
        move.l  $00(A1,D0.W),D0                 ; $00B9A6  D0 = position longword
        move.w  D0,($FFFFC056).w                ; $00B9AA  track_pos_lo = D0.w
        swap    D0                              ; $00B9AE  swap hi/lo
        move.w  D0,($FFFFC054).w                ; $00B9B0  track_pos_hi = D0.w
; --- copy 5 longwords from segment data ---
        move.l  ($FFFFC710).w,$0010(A2)         ; $00B9B4
        move.l  ($FFFFC714).w,$0024(A2)         ; $00B9BA
        move.l  ($FFFFC718).w,$0038(A2)         ; $00B9C0
        move.l  ($FFFFC71C).w,$004C(A2)         ; $00B9C6
        move.l  ($FFFFC720).w,$0060(A2)         ; $00B9CC
; --- copy 9 words from segment word data ---
        movea.l ($FFFFC734).w,A1                ; $00B9D2  A1 → segment word ptr
        move.w  (A1)+,$0016(A2)                 ; $00B9D6
        move.w  (A1)+,$0018(A2)                 ; $00B9DA
        move.w  (A1)+,$001A(A2)                 ; $00B9DE
        move.w  (A1)+,$002A(A2)                 ; $00B9E2
        move.w  (A1)+,$002C(A2)                 ; $00B9E6
        move.w  (A1)+,$002E(A2)                 ; $00B9EA
        move.w  (A1)+,$003E(A2)                 ; $00B9EE
        move.w  (A1)+,$0040(A2)                 ; $00B9F2
        move.w  (A1),$0042(A2)                  ; $00B9F6
; --- initialize segment counters ---
        move.w  #$0000,($FFFFC04C).w            ; $00B9FA  track_mode = 0
        moveq   #$01,D0                         ; $00BA00  D0 = 1
        move.w  D0,$0000(A2)                    ; $00BA02  counter[0] = 1
        move.w  D0,$0014(A2)                    ; $00BA06  counter[1] = 1
        move.w  D0,$0028(A2)                    ; $00BA0A  counter[2] = 1
        move.w  D0,$0050(A2)                    ; $00BA0E  counter[3] = 1 (note: not +$3C)
        move.w  D0,$003C(A2)                    ; $00BA12  counter[4] = 1
        rts                                     ; $00BA16
