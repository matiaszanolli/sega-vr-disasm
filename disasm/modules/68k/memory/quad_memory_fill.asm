; ============================================================================
; Quad Memory Fill (JSR Cascade)
; ROM Range: $004836-$004888 (82 bytes)
; ============================================================================
; High-speed memory fill using JSR cascade trick.
; 4 cascading JSRs multiply the 32-word fill block.
;
; Entry: D1 = fill value, A1 = destination
; Uses: A1 (advances), stack (cascade returns)
; ============================================================================

quad_memory_fill:
        jsr     .x8(pc)
.x8:
        jsr     .x4(pc)
.x4:
        jsr     .x2(pc)
.x2:
        jsr     .x1(pc)
.x1:
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        move.l  d1,(a1)+
        rts
