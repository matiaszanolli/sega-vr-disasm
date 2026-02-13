; ============================================================================
; AI Digit Lookup + Best Lap
; ROM Range: $00B1B8-$00B25E (166 bytes)
; ============================================================================
; Category: game
; Purpose: Looks up 3 digit values from ROM tables and writes them to a
;   per-racer display buffer at ($C200 + racer*4). If racer #5, checks
;   for new best lap time and updates position marker.
;
; Entry: (none — reads racer index from $902C)
; Uses: D0, D3, A1, A3
; RAM:
;   $902C: racer_index (word)
;   $C200: racer_display_buffer (4 bytes per racer)
;   $C806: digit_index_0 (byte)
;   $C807: digit_index_1 (byte)
;   $C808: digit_index_2 (byte)
;   $C210: best_lap_current (longword)
;   $C254: best_lap_record (longword)
;   $C307: position_marker_offset (byte)
;   $C8A4: sound_trigger (byte)
; Calls:
;   $00B2EC, $00B422, $00B260
; ROM tables:
;   $00899884: digit_lookup_table (word entries, indexed by byte*2)
;   $0089980C: digit_lookup_wide (word entries)
; ============================================================================

ai_digit_lookup_best_lap:
        moveq   #$00,D0                         ; $00B1B8
        move.w  ($FFFF902C).w,D0                    ; $00B1BA  D0 = racer_index
        cmpi.w  #$0005,D0                       ; $00B1BE
        bne.s   .not_racer5                     ; $00B1C2
        subq.w  #1,D0                           ; $00B1C4  racer 5 → use slot 4
.not_racer5:
        lea     ($FFFFC200).w,A1                    ; $00B1C6  A1 = racer_display_buffer
        add.w   D0,D0                           ; $00B1CA  D0 *= 4 (2 bytes per word, 2 words)
        add.w   D0,D0                           ; $00B1CC
        move.w  D0,D3                           ; $00B1CE  D3 = racer offset (saved)
        adda.l  D0,A1                           ; $00B1D0  A1 += racer offset
; --- digit 0: direct index ---
        moveq   #$00,D0                         ; $00B1D2
        move.b  ($FFFFC806).w,D0                    ; $00B1D4  digit_index_0
        add.w   D0,D0                           ; $00B1D8  word index
        lea     $00899884,A3                    ; $00B1DA  digit_lookup_table
        move.w  $00(A3,D0.W),D0                 ; $00B1E0
        move.b  D0,(A1)+                        ; $00B1E4  store digit 0
; --- digit 1: offset by $C4 ---
        moveq   #$00,D0                         ; $00B1E6
        move.b  ($FFFFC807).w,D0                    ; $00B1E8  digit_index_1
        subi.b  #$C4,D0                         ; $00B1EC  subtract base offset
        add.w   D0,D0                           ; $00B1F0  word index
        lea     $00899884,A3                    ; $00B1F2
        move.w  $00(A3,D0.W),D0                 ; $00B1F8
        move.b  D0,(A1)+                        ; $00B1FC  store digit 1
; --- digit 2: offset by $C4, wide table ---
        moveq   #$00,D0                         ; $00B1FE
        move.b  ($FFFFC808).w,D0                    ; $00B200  digit_index_2
        subi.b  #$C4,D0                         ; $00B204
        add.w   D0,D0                           ; $00B208  word index
        lea     $0089980C,A3                    ; $00B20A  digit_lookup_wide
        move.w  $00(A3,D0.W),D0                 ; $00B210
        move.w  D0,(A1)                         ; $00B214  store digit 2 (word)
; --- call 3 subroutines ---
        dc.w    $4EBA,$00D4         ; jsr     $00B2EC(pc)         ; $00B216
        dc.w    $4EBA,$0206         ; jsr     $00B422(pc)         ; $00B21A
        moveq   #$03,D3                         ; $00B21E
        dc.w    $4EBA,$003E         ; jsr     $00B260(pc)         ; $00B220
; --- best lap check (racer #5 only) ---
        cmpi.w  #$0005,($FFFF902C).w                ; $00B224
        bne.s   .done                           ; $00B22A
        move.l  ($FFFFC210).w,D0                    ; $00B22C  best_lap_current
        cmp.l   ($FFFFC254).w,D0                    ; $00B230  compare to record
        bge.s   .done                           ; $00B234  not better → skip
        move.l  D0,($FFFFC254).w                    ; $00B236  new best lap record
        moveq   #$00,D0                         ; $00B23A
        move.b  ($FFFFC307).w,D0                    ; $00B23C  position_marker_offset
        lea     $00FF68D1,A1                    ; $00B240
        lea     $00(A1,D0.W),A1                 ; $00B246
        move.b  #$00,(A1)                       ; $00B24A  clear position marker
        move.b  #$50,($FFFFC307).w                  ; $00B24E  reset offset to $50
        move.b  #$01,$00FF6911                  ; $00B254  flag new best lap
.done:
        rts                                     ; $00B25C
