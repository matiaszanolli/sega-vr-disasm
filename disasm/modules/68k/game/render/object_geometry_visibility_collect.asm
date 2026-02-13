; ============================================================================
; Object Geometry Visibility Collect
; ROM Range: $00734E-$0073E8 (154 bytes)
; ============================================================================
; Category: game
; Purpose: Builds a visible-object list for the current viewpoint. Computes
;   a camera direction key from 32X frame registers, reads a track segment
;   table via racer_index, then iterates neighbour offsets collecting objects
;   whose pointers differ from a sentinel ($2207FFFE). Count stored to
;   $FF610E for the renderer.
;
; Entry: A0 = object pointer (reads +$CC for segment index)
; Uses: D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, A4
; RAM:
;   $C0BA: segment_table_select (word, nonzero = alternate table)
;   $C8A0: racer_index (word, ×4 into jump table)
; ROM tables:
;   $0089A5D2: segment_table_primary
;   $0089A0D4: segment_table_alternate
;   $007248 (PC-relative): racer_segment_ptr_table
; ============================================================================

object_geometry_visibility_collect:
        tst.w   ($FFFFC0BA).w                       ; $00734E  segment_table_select
        dc.w    $6700,$FE52         ; beq.w   $0071A6             ; $007352  zero → return (other module)
        move.l  A4,-(A7)                        ; $007356  save A4
; --- compute camera direction key ---
        move.w  #$0400,D1                       ; $007358  base direction = $0400
        move.w  $00FF6102,D2                    ; $00735C  32X frame reg X
        asr.w   #4,D2                           ; $007362  /16
        add.w   D1,D2                           ; $007364  D2 = base + X/16
        asr.w   #6,D2                           ; $007366  /64
        move.w  $00FF6106,D3                    ; $007368  32X frame reg Y
        asr.w   #4,D3                           ; $00736E  /16
        sub.w   D3,D1                           ; $007370  D1 = base - Y/16
        andi.w  #$FFC0,D1                       ; $007372  align to 64-unit grid
        asr.w   #1,D1                           ; $007376  /2
        add.w   D2,D1                           ; $007378  combine X+Y
        add.w   D1,D1                           ; $00737A  ×2
        add.w   D1,D1                           ; $00737C  ×4 (longword index)
; --- get segment from object ---
        moveq   #$00,D0                         ; $00737E
        move.w  $00CC(A0),D0                    ; $007380  segment index
        asl.l   #6,D0                           ; $007384
        swap    D0                              ; $007386
        andi.w  #$003C,D0                       ; $007388  longword-aligned offset
; --- select segment table ---
        lea     $0089A5D2,A3                    ; $00738C  segment_table_primary
        tst.w   ($FFFFC0BA).w                       ; $007392
        bne.s   .use_primary                    ; $007396
        lea     $0089A0D4,A3                    ; $007398  segment_table_alternate
.use_primary:
        movea.l $00(A3,D0.W),A3                 ; $00739E  A3 = segment data ptr
; --- get racer segment pointer table ---
        move.l  #$2207FFFE,D3                   ; $0073A2  sentinel value
        move.w  ($FFFFC8A0).w,D0                    ; $0073A8  racer_index
        dc.w    $43FA,$FE9A         ; lea     $007248(pc),A1      ; $0073AC  racer_segment_ptr_table
        movea.l $00(A1,D0.W),A1                 ; $0073B0  A1 = racer segment ptrs
; --- collect visible objects ---
        lea     $00FF6000,A2                    ; $0073B4  output list
        moveq   #$00,D4                         ; $0073BA  count = 0
        movea.l $00(A1,D1.W),A4                 ; $0073BC  first candidate
        cmpa.l  D3,A4                           ; $0073C0  == sentinel?
        beq.s   .skip_first                     ; $0073C2
        move.l  A4,(A2)+                        ; $0073C4  store in output list
        addq.w  #1,D4                           ; $0073C6  count++
.skip_first:
        move.w  (A3)+,D7                        ; $0073C8  neighbour count
.neighbour_loop:
        move.w  D1,D0                           ; $0073CA  direction key
        add.w   (A3)+,D0                        ; $0073CC  + neighbour offset
        movea.l $00(A1,D0.W),A4                 ; $0073CE  candidate object
        cmpa.l  D3,A4                           ; $0073D2  == sentinel?
        beq.s   .skip_neighbour                 ; $0073D4
        move.l  A4,(A2)+                        ; $0073D6  store
        addq.w  #1,D4                           ; $0073D8  count++
.skip_neighbour:
        dbra    D7,.neighbour_loop              ; $0073DA
        move.w  D4,$00FF610E                    ; $0073DE  visible_object_count
        movea.l (A7)+,A4                        ; $0073E4  restore A4
        rts                                     ; $0073E6
