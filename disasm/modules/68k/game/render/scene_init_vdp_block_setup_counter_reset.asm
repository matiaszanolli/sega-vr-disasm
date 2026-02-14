; ============================================================================
; Scene Init + VDP Block Setup + Counter Reset
; ROM Range: $00CFD6-$00D04C (118 bytes)
; ============================================================================
; Category: game
; Purpose: Loads scene data pointer from $00895BCC indexed by race_substate
;   ($C8CC), calls block_copy ($CFC2) 4× to copy to VDP buffers at
;   $FF6178/$FF627C/$FF63A8/$FF64AC. Second entry ($D00C): initializes
;   counter block $C806 to (0,$C4,$C4), sets $C076=$C200.
;   If $C80E bit 3 clear: sets work params $C254/$C260.
;   Reads race_active ($FDA9) as index into table at $D050 → $C051.
;
; Uses: D0, A1, A2, A3
; RAM:
;   $C051: track_param (byte, from table)
;   $C076: scene_type (word, set to $C200)
;   $C254: work_param_A (longword)
;   $C260: work_param_B (longword)
;   $C806: counter block (3 bytes)
;   $C80E: display_flags (byte, bit 3)
;   $C8CC: race_substate (word)
;   $FDA9: race_active (byte, table index)
; Calls:
;   $00CFC2: block_copy (4×)
; ============================================================================

scene_init_vdp_block_setup_counter_reset:
; --- VDP block setup (4 copies) ---
        move.w  ($FFFFC8CC).w,D0                ; $00CFD6  D0 = race_substate
        lea     $008955CC,A1                    ; $00CFDA  A1 → scene data table
        movea.l $00(A1,D0.W),A1                 ; $00CFE0  A1 = data[substate]
        movea.l A1,A3                           ; $00CFE4  A3 = save ptr
        lea     $00FF6178,A2                    ; $00CFE6  A2 → VDP buffer 1
        dc.w    $61D4                           ; $00CFEC  bsr.s $00CFC2 — block_copy [1]
        movea.l A3,A1                           ; $00CFEE  restore ptr
        lea     $00FF627C,A2                    ; $00CFF0  A2 → VDP buffer 2
        dc.w    $61CA                           ; $00CFF6  bsr.s $00CFC2 — block_copy [2]
        movea.l A3,A1                           ; $00CFF8  restore ptr
        lea     $00FF63A8,A2                    ; $00CFFA  A2 → VDP buffer 3
        dc.w    $61C0                           ; $00D000  bsr.s $00CFC2 — block_copy [3]
        movea.l A3,A1                           ; $00D002  restore ptr
        lea     $00FF64AC,A2                    ; $00D004  A2 → VDP buffer 4
        dc.w    $60B6                           ; $00D00A  bra.s $00CFC2 — block_copy [4] (tail)
; --- counter + scene init ---
        lea     ($FFFFC806).w,A1                ; $00D00C  A1 → counter block
        move.b  #$00,(A1)+                      ; $00D010  main = 0
        move.b  #$C4,(A1)+                      ; $00D014  tick = $C4
        move.b  #$C4,(A1)                       ; $00D018  sub-tick = $C4
        move.w  #$C200,($FFFFC076).w            ; $00D01C  scene_type = $C200
        btst    #3,($FFFFC80E).w                ; $00D022  display bit 3 set?
        bne.s   .load_track                     ; $00D028  yes → skip work params
        move.l  #$61000000,($FFFFC254).w        ; $00D02A  work_param_A
        move.l  #$60000000,($FFFFC260).w        ; $00D032  work_param_B
.load_track:
        lea     race_scene_init_jump_table_dispatch+4(pc),a1; $43FA $0014
        moveq   #$00,D0                         ; $00D03E  clear D0
        move.b  ($FFFFFDA9).w,D0                ; $00D040  D0 = race_active
        move.b  $00(A1,D0.W),($FFFFC051).w      ; $00D044  track_param = table[D0]
        rts                                     ; $00D04A

