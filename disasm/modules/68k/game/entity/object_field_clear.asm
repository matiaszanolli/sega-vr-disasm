; ============================================================================
; Object Field Clear (Conditional)
; ROM Range: $002EC6-$002EEE (40 bytes)
; ============================================================================
; Category: game
; Purpose: If $C31C is nonzero and obj.field_E5 bit 3 is set:
;   clears 7 fields of target object (A1) at offsets
;   $00/$14/$28/$3C/$50/$64 to zero. Otherwise exits to $002EEE.
;
; Entry: A0 = source object, A1 = target object
; Uses: D0, A0, A1
; Object fields:
;   A0+$E5: control flags (byte, bit 3)
;   A1+$00/$14/$28/$3C/$50/$64: animation fields (word, cleared)
; RAM:
;   $C31C: enable flag (byte)
; ============================================================================

object_field_clear:
        tst.b   ($FFFFC31C).w                   ; $002EC6  flag active?
        dc.w    $6722                           ; $002ECA  beq.s $002EEE → exit (past fn)
        btst    #3,$00E5(A0)                    ; $002ECC  obj.flags bit 3 set?
        dc.w    $671A                           ; $002ED2  beq.s $002EEE → exit (past fn)
        moveq   #$00,D0                         ; $002ED4  D0 = 0
        move.w  D0,(A1)                         ; $002ED6  clear field $00
        move.w  D0,$0014(A1)                    ; $002ED8  clear field $14
        move.w  D0,$0028(A1)                    ; $002EDC  clear field $28
        move.w  D0,$003C(A1)                    ; $002EE0  clear field $3C
        move.w  D0,$0050(A1)                    ; $002EE4  clear field $50
        move.w  D0,$0064(A1)                    ; $002EE8  clear field $64
        rts                                     ; $002EEC
