; ============================================================================
; Triple Dispatch (3 Jump Tables by Controller Byte)
; ROM Range: $00BA1A-$00BA5E (68 bytes)
; ============================================================================
; Category: game
; Purpose: Three sequential dispatches, each loading a controller byte
;   ($C86C/$C86D/$C86E), multiplying by 4 (D0×2×2), indexing into
;   a longword jump table at $00894888/$894C88/$895088, and calling
;   the target via JSR (A1).
;
; Uses: D0, A1
; RAM:
;   $C86C: controller byte A (byte, ×4 → jump table index)
;   $C86D: controller byte B (byte, ×4 → jump table index)
;   $C86E: controller byte C (byte, ×4 → jump table index)
; Jump tables (absolute long addresses):
;   $00894888: dispatch table A
;   $00894C88: dispatch table B
;   $00895088: dispatch table C
; ============================================================================

triple_dispatch:
; --- dispatch A: indexed by $C86C ---
        moveq   #$00,D0                         ; $00BA1A  clear high bits
        move.b  ($FFFFC86C).w,D0               ; $00BA1C  D0 = controller byte A
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        lea     $00894888,A1                    ; $00BA24  A1 → jump table A
        movea.l $00(A1,D0.W),A1                ; $00BA2A  A1 = table_A[D0]
        jsr     (A1)                            ; $00BA2E  call handler A
; --- dispatch B: indexed by $C86D ---
        moveq   #$00,D0                         ; $00BA30  clear high bits
        move.b  ($FFFFC86D).w,D0               ; $00BA32  D0 = controller byte B
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        lea     $00894C88,A1                    ; $00BA3A  A1 → jump table B
        movea.l $00(A1,D0.W),A1                ; $00BA40  A1 = table_B[D0]
        jsr     (A1)                            ; $00BA44  call handler B
; --- dispatch C: indexed by $C86E ---
        moveq   #$00,D0                         ; $00BA46  clear high bits
        move.b  ($FFFFC86E).w,D0               ; $00BA48  D0 = controller byte C
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        lea     $00895088,A1                    ; $00BA50  A1 → jump table C
        movea.l $00(A1,D0.W),A1                ; $00BA56  A1 = table_C[D0]
        jsr     (A1)                            ; $00BA5A  call handler C
        rts                                     ; $00BA5C
