; ============================================================================
; Name Entry BCD Score Comparison
; ROM Range: $011B6A-$011C7E (276 bytes)
; ============================================================================
; Category: game
; Purpose: Compares player's score against high score table using BCD arithmetic.
;   Copies 1024 bytes from high score table ($B400) to comparison buffer ($C400).
;   Processes 20 BCD digit-pairs using ABCD/SBCD instructions.
;   Fills empty slots with sentinel $CCCC0CCC.
;   Sets ranking result: $A04E = 0 (new high), 1 (tied/lower), 2 (not placed).
;
; Uses: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3
; RAM:
;   $A058: saved score snapshot (long)
;   $A04A: BCD comparison buffer (long)
;   $A04E: ranking result (word, 0/1/2)
;   $B400: high score table source (1024 bytes)
;   $C200: BCD working buffer
;   $C260: current score (long)
;   $C400: comparison buffer destination
; ============================================================================

fn_10200_008:
        move.l  ($FFFFC260).w,D0                ; $011B6A  D0 = current score
        move.l  D0,($FFFFA058).w                ; $011B6E  save score snapshot
        lea     ($FFFFB400).w,A1                ; $011B72  A1 = high score table
        lea     ($FFFFC400).w,A2                ; $011B76  A2 = comparison buffer
        moveq   #$1F,D7                         ; $011B7A  copy 32 × 32 bytes = 1024
.copy_scores:
        movem.l (A1)+,D0/D1/D2/D3/D4/D5/D6/A3  ; $011B7C  load 32 bytes
        movem.l D0/D1/D2/D3/D4/D5/D6/A3,-(A2)  ; $011B80  store 32 bytes (descending)
        dbra    D7,.copy_scores                 ; $011B84
        clr.l   ($FFFFA04A).w                   ; $011B88  clear BCD buffer
        lea     ($FFFFA04A).w,A0                ; $011B8C  A0 = BCD buffer
        lea     ($FFFFC200).w,A1                ; $011B90  A1 = BCD working buffer
        move.w  #$0013,D2                       ; $011B94  process 20 digit-pairs
.bcd_loop:
        addi.b  #$00,D0                         ; $011B98  clear extend flag
        move.b  $0003(A0),D0                    ; $011B9C  D0 = buffer digit [3]
        move.b  $0003(A1),D1                    ; $011BA0  D1 = working digit [3]
        dc.w    $C101                           ; $011BA4  abcd d1,d0 — BCD add
        move.b  D0,$0003(A0)                    ; $011BA6  store result [3]
        move.b  $0002(A0),D0                    ; $011BAA  D0 = buffer digit [2]
        move.b  $0002(A1),D1                    ; $011BAE  D1 = working digit [2]
        dc.w    $C101                           ; $011BB2  abcd d1,d0 — BCD add with carry
        move.b  D0,D1                           ; $011BB4  save result
        andi.b  #$0F,D0                         ; $011BB6  mask low nibble
        move.b  D0,$0002(A0)                    ; $011BBA  store low nibble [2]
        lsr.b   #4,D1                           ; $011BBE  high nibble → low
        addi.b  #$00,D0                         ; $011BC0  clear extend flag
        move.b  $0001(A0),D0                    ; $011BC4  D0 = buffer digit [1]
        dc.w    $C101                           ; $011BC8  abcd d1,d0 — BCD add carry
        move.b  $0001(A1),D1                    ; $011BCA  D1 = working digit [1]
        dc.w    $C101                           ; $011BCE  abcd d1,d0 — BCD add
        bcc.w   .no_overflow                    ; $011BD0  no carry → check range
        addi.b  #$00,D0                         ; $011BD4  clear extend flag
        move.b  #$40,D1                         ; $011BD8  overflow → set minute carry
        dc.w    $C101                           ; $011BDC  abcd d1,d0 — add 40 (BCD adjust)
        move.b  #$01,D1                         ; $011BDE  D1 = 1 (carry to hours)
        bra.s   .store_digit1                   ; $011BE2
.no_overflow:
        clr.b   D1                              ; $011BE4  no carry
        cmpi.b  #$60,D0                         ; $011BE6  >= 60 (BCD minutes)?
        bcs.w   .store_digit1                   ; $011BEA  < 60 → store directly
        addi.b  #$00,D0                         ; $011BEE  clear extend flag
        move.b  #$60,D1                         ; $011BF2  subtract 60 (BCD adjust)
        dc.w    $8101                           ; $011BF6  sbcd d1,d0 — BCD subtract
        move.b  #$01,D1                         ; $011BF8  carry to hours
.store_digit1:
        move.b  D0,$0001(A0)                    ; $011BFC  store digit [1]
        addi.b  #$00,D0                         ; $011C00  clear extend flag
        move.b  (A0),D0                         ; $011C04  D0 = buffer digit [0]
        dc.w    $C101                           ; $011C06  abcd d1,d0 — BCD add carry
        move.b  (A1),D1                         ; $011C08  D1 = working digit [0]
        dc.w    $C101                           ; $011C0A  abcd d1,d0 — BCD add
        move.b  D0,(A0)                         ; $011C0C  store digit [0]
        addq.l  #4,A1                           ; $011C0E  next working entry
        dbra    D2,.bcd_loop                    ; $011C10
        tst.l   ($FFFFA04A).w                   ; $011C14  result non-zero?
        bne.s   .fill_empties                   ; $011C18  yes → fill empty slots
        move.l  #$CCCC0CCC,($FFFFA04A).w        ; $011C1A  set sentinel value
.fill_empties:
        lea     ($FFFFC200).w,A0                ; $011C22  A0 = working buffer
        move.w  #$0013,D0                       ; $011C26  scan 20 entries
.scan_loop:
        tst.l   (A0)                            ; $011C2A  entry empty?
        beq.w   .fill_entry                     ; $011C2C  yes → fill with sentinel
        addq.l  #4,A0                           ; $011C30  next entry
        dbra    D0,.scan_loop                   ; $011C32
        bra.s   .compare                        ; $011C36  all filled → compare
.fill_entry:
        move.l  #$CCCC0CCC,(A0)+               ; $011C38  fill with sentinel
        dbra    D0,.fill_entry                  ; $011C3E
.compare:
        move.w  #$0002,($FFFFA04E).w            ; $011C42  ranking = 2 (not placed)
        move.l  ($FFFFA058).w,D0                ; $011C48  D0 = saved score
        move.l  ($FFFFC260).w,D1                ; $011C4C  D1 = current score
        cmp.l   D0,D1                           ; $011C50  scores equal?
        beq.w   .done                           ; $011C52  yes → keep rank 2
        move.w  #$0001,($FFFFA04E).w            ; $011C56  ranking = 1 (tied)
        cmpi.l  #$CCCC0CCC,D0                   ; $011C5C  saved was sentinel?
        beq.s   .done                           ; $011C62  yes → keep rank 1
        clr.w   ($FFFFA04E).w                   ; $011C64  ranking = 0 (new high)
        cmpi.l  #$CCCC0CCC,D1                   ; $011C68  current is sentinel?
        beq.s   .done                           ; $011C6E  yes → rank 0
        cmp.l   D0,D1                           ; $011C70  current > saved?
        bhi.w   .done                           ; $011C72  yes → keep rank 0
        move.w  #$0001,($FFFFA04E).w            ; $011C76  no → rank 1
.done:
        rts                                     ; $011C7C
