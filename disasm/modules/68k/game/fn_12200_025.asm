; ============================================================================
; Camera DMA Transfer (Data Prefix)
; ROM Range: $012BFA-$012C9E (164 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix (144 bytes) containing sprite descriptors (6 entries
;   at $012BFA, 24 bytes each) and palette pointer table (6 longword
;   pointers at $012C72). Executable code at fn_12200_025_exec is
;   minimal: DMA transfer, display mode $0020, advance game_state.
;
; Uses: D0
; RAM:
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E52C: dma_transfer
; ============================================================================

fn_12200_025:
; --- data prefix (144 bytes: 6×24-byte sprite descriptors + 6 palette pointers) ---
        move.l  $5FF6(A3),D1                    ; $012BFA  (data: $222B $5FF6)
        move.l  $710A(A3),D1                    ; $012BFE  (data: $222B $710A)
        move.l  -$6EDE(A3),D1                   ; $012C02  (data: $222B $9122)
        move.l  -$5610(A3),D1                   ; $012C06  (data: $222B $A9F0)
        move.l  -$370C(A3),D1                   ; $012C0A  (data: $222B $C8F4)
        move.l  $5FF6(A3),D1                    ; $012C0E  (data: $222B $5FF6)
; --- sprite descriptor 0: Y=-$50, X=$60, size=$140, padding ---
        dc.w    $0000                           ; $012C12
        dc.w    $FFB0                           ; $012C14
        ori.w   #$0140,-(A0)                    ; $012C16  (data: $0060 $0140)
        ori.b   #$00,D0                         ; $012C1A  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C1E  (data: $0000 $0000)
; --- sprite descriptor 1: Y=-$50, X=$60, size=$140, padding ---
        dc.w    $0000                           ; $012C22
        dc.w    $FFB0                           ; $012C24
        ori.w   #$0140,-(A0)                    ; $012C26  (data: $0060 $0140)
        ori.b   #$00,D0                         ; $012C2A  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C2E  (data: $0000 $0000)
; --- sprite descriptor 2: Y=-$50, X=$70, size=$140, padding ---
        dc.w    $0000                           ; $012C32
        dc.w    $FFB0                           ; $012C34
        ori.w   #$0140,$00(A0,D0.W)             ; $012C36  (data: $0070 $0140)
        ori.b   #$00,D0                         ; $012C3C  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C40  (data: $0000 $0000)
; --- sprite descriptor 3: Y=-$60, X=$80, size=$180, padding ---
        dc.w    $FFA0                           ; $012C44
        ori.l   #$01800000,D0                   ; $012C46  (data: $0080 $0180 $0000)
        ori.b   #$00,D0                         ; $012C4C  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C50  (data: $0000 $0000)
; --- sprite descriptor 4: Y=-$F0, X=$50, size=$140, padding ---
        dc.w    $FF10                           ; $012C54
        ori.w   #$0140,(A0)                     ; $012C56  (data: $0050 $0140)
        ori.b   #$00,D0                         ; $012C5A  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C5E  (data: $0000 $0000)
; --- sprite descriptor 5: Y=-$50, X=$60, size=$140, padding ---
        dc.w    $0000                           ; $012C62
        dc.w    $FFB0                           ; $012C64
        ori.w   #$0140,-(A0)                    ; $012C66  (data: $0060 $0140)
        ori.b   #$00,D0                         ; $012C6A  (data: $0000 $0000)
        ori.b   #$00,D0                         ; $012C6E  (data: $0000 $0000)
; --- palette pointer table (6 longword pointers) ---
        dc.w    $008B                           ; $012C72  ptr[0] high
        cmpa.l  (A4)+,A5                        ; $012C74  ptr[0] low (raw: $BBDC → $008BBBDC)
        dc.w    $008B                           ; $012C76  ptr[1] high
        cmpa.w  (A4)+,A6                        ; $012C78  ptr[1] low (raw: $BCDC → $008BBCDC)
        dc.w    $008B                           ; $012C7A  ptr[2] high
        cmpa.l  (A4)+,A5                        ; $012C7C  ptr[2] low (raw: $BBDC → $008BBBDC)
        dc.w    $008B                           ; $012C7E  ptr[3] high
        cmpa.l  (A4)+,A6                        ; $012C80  ptr[3] low (raw: $BDDC → $008BBDDC)
        dc.w    $008B                           ; $012C82  ptr[4] high
        cmpa.w  (A4)+,A7                        ; $012C84  ptr[4] low (raw: $BEDC → $008BBEDC)
        dc.w    $008B                           ; $012C86  ptr[5] high
        cmpa.l  (A4)+,A5                        ; $012C88  ptr[5] low (raw: $BBDC → $008BBBDC)
; --- executable code ---
fn_12200_025_exec:
        clr.w   D0                              ; $012C8A  mode = 0
        dc.w    $6100,$B89E                     ; $012C8C  bsr.w dma_transfer ($00E52C)
        move.w  #$0020,$00FF0008                ; $012C90  display mode = $0020
        addq.w  #4,($FFFFC87E).w                ; $012C98  advance game_state
        rts                                     ; $012C9C
