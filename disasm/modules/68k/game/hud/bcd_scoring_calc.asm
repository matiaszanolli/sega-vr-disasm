; ============================================================================
; BCD Scoring Calculation
; ROM Range: $00B25E-$00B2D8 (122 bytes)
; ============================================================================
; Category: game
; Purpose: Reads 4 seed bytes + 18 groups of 4 params from a RAM buffer at
;   $C200. For each group, performs chained ABCD (add with extend) to
;   accumulate a BCD score across D0/D1/D2/D6. Uses SBCD to check
;   overflow against a threshold in D7. Writes final 4-byte BCD result
;   back to $C260.
;
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $C200: bcd_input_buffer (4 seed bytes + 18×4 param bytes)
;   $C260: bcd_result (4 bytes output)
; ============================================================================

bcd_scoring_calc:
        moveq   #$12,D3                         ; $00B25E  D3 = 18 (loop counter)
        lea     ($FFFFC200).w,A1                    ; $00B260  A1 = bcd_input_buffer
        move.l  #$00010060,D7                   ; $00B264  threshold: hi=$0001, lo=$0060
; --- read 4 seed bytes ---
        moveq   #$00,D0                         ; $00B26A
        move.b  (A1)+,D0                        ; $00B26C  seed[0] → D0
        move.b  (A1)+,D1                        ; $00B26E  seed[1] → D1
        move.b  (A1)+,D2                        ; $00B270  seed[2] → D2
        move.b  (A1)+,D6                        ; $00B272  seed[3] → D6
; --- BCD accumulation loop (18 iterations) ---
.bcd_loop:
        swap    D3                              ; $00B274  save counter in hi word
        move.b  (A1)+,D3                        ; $00B276  param[0]
        move.b  (A1)+,D4                        ; $00B278  param[1]
        move.b  (A1)+,D5                        ; $00B27A  param[2]
        swap    D5                              ; $00B27C  save in hi word
        move.b  (A1)+,D5                        ; $00B27E  param[3]
        dc.w    $023C,$00EF                     ; $00B280  andi.b #$EF,CCR — clear extend
        dc.w    $CD05                           ; $00B284  abcd D5,D6
        swap    D5                              ; $00B286
        dc.w    $C505                           ; $00B288  abcd D5,D2
        cmpi.b  #$10,D2                         ; $00B28A
        blt.s   .no_carry                       ; $00B28E
        subi.b  #$10,D2                         ; $00B290  subtract carry threshold
        dc.w    $003C,$0010                     ; $00B294  ori.b #$10,CCR — set extend
.no_carry:
        dc.w    $C304                           ; $00B298  abcd D4,D1
        bcc.s   .no_overflow_a                  ; $00B29A
        dc.w    $C103                           ; $00B29C  abcd D3,D0
        bcs.s   .saturate                       ; $00B29E  overflow → saturate
        addi.b  #$40,D1                         ; $00B2A0
        bra.s   .check_limit                    ; $00B2A4
.no_overflow_a:
        dc.w    $C103                           ; $00B2A6  abcd D3,D0
        bcs.s   .saturate                       ; $00B2A8  overflow → saturate
.check_limit:
        cmp.b   D7,D1                           ; $00B2AA  D1 < D7.lo ($60)?
        bcs.s   .next_iter                      ; $00B2AC  yes → continue
        dc.w    $8307                           ; $00B2AE  sbcd D7,D1 (subtract threshold)
        swap    D7                              ; $00B2B0
        dc.w    $C107                           ; $00B2B2  abcd D7,D0 (add carry to hi)
        bcs.s   .saturate                       ; $00B2B4  overflow → saturate
        swap    D7                              ; $00B2B6
.next_iter:
        swap    D3                              ; $00B2B8  restore counter
        dbra    D3,.bcd_loop                    ; $00B2BA
        cmp.w   D7,D0                           ; $00B2BE  final overflow check
        bcs.s   .store_result                   ; $00B2C0
.saturate:
        moveq   #$60,D0                         ; $00B2C2  max BCD value
        moveq   #$00,D1                         ; $00B2C4
        moveq   #$00,D2                         ; $00B2C6
        moveq   #$00,D6                         ; $00B2C8
.store_result:
        lea     ($FFFFC260).w,A1                    ; $00B2CA  bcd_result
        move.b  D0,(A1)+                        ; $00B2CE
        move.b  D1,(A1)+                        ; $00B2D0
        move.b  D2,(A1)+                        ; $00B2D2
        move.b  D6,(A1)                         ; $00B2D4
        rts                                     ; $00B2D6
