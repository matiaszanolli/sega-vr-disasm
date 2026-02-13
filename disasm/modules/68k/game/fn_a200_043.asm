; ============================================================================
; fn_a200_043 — Display Entry Builder (5 Racers)
; ROM Range: $00BEFC-$00BF9E (162 bytes)
; ============================================================================
; Builds 5 display entries at $FF6900 from racer data in RAM table ($EF08)
; and ROM data at $0088C05C (fn_a200_048 data prefix). Each entry includes
; counter, racer fields, nibble-extracted speed digits, and position data.
;
; The 6 MOVE.L instructions at the start form a dispatch table — external
; code jumps to fn_a200_043 + index×4 to select which A6-relative value
; to load into D1 before falling through to the main code.
;
; Entry: A6 = base pointer for dispatch table offsets
; Uses: D0, D1, D2, D3, A1, A2, A3
; RAM: $A0EA (buffer_write_index), $A0EE (entry_counter),
;      $C89C (sh2_comm_state), $C8CA (race_substate_read),
;      $C8CC (race_substate), $EF08 (racer_data_table)
; ============================================================================

fn_a200_043:
; --- dispatch table (6 entries, jumped into by index) -------------------------
        move.l  $35E0(A6),D1                    ; $00BEFC  entry 0
        move.l  $3CE4(A6),D1                    ; $00BF00  entry 1
        move.l  $43E8(A6),D1                    ; $00BF04  entry 2
        move.l  $4A6C(A6),D1                    ; $00BF08  entry 3
        move.l  $5070(A6),D1                    ; $00BF0C  entry 4
        move.l  $35E0(A6),D1                    ; $00BF10  entry 5 (default/wraparound)
; --- main code ----------------------------------------------------------------
        lea     $00FF6900,A1                    ; $00BF14  display entry buffer
        lea     ($FFFFEF08).w,A2                ; $00BF1A  racer data table
        lea     $0088C05C,A3                    ; $00BF1E  ROM data (fn_a200_048 prefix)
        move.w  ($FFFFA0EE).w,D0                ; $00BF24  entry counter
        move.w  D0,D1                           ; $00BF28
        addq.w  #1,D1                           ; $00BF2A  D1 = counter + 1 (racer ID)
        asl.w   #3,D0                           ; $00BF2C  D0 × 8 (entry size)
        lea     $00(A2,D0.W),A2                 ; $00BF2E  index into racer table
        move.w  ($FFFFC89C).w,D0                ; $00BF32  sh2_comm_state
        add.w   ($FFFFC8CA).w,D0                ; $00BF36  + race_substate_read
        add.w   ($FFFFC8CC).w,D0                ; $00BF3A  + race_substate
        lsl.w   #5,D0                           ; $00BF3E  × 32
        move.w  D0,D2                           ; $00BF40
        dc.w    $D442                ; add.w   D2,D2  ; × 64
        dc.w    $D442                ; add.w   D2,D2  ; × 128
        dc.w    $D042                ; add.w   D2,D0  ; × 160 (32 + 128)
        adda.w  D0,A2                           ; $00BF48  offset into racer table
        moveq   #$04,D0                         ; $00BF4A  5 entries
.build_entry:
        clr.w   (A1)+                           ; $00BF4C  entry[0-1] = 0
        move.b  D1,(A1)+                        ; $00BF4E  entry[2] = racer ID
        move.b  $0003(A2),(A1)+                 ; $00BF50  entry[3] = racer field +$03
        move.l  (A3)+,(A1)+                     ; $00BF54  entry[4-7] = ROM data
        clr.w   (A1)+                           ; $00BF56  entry[8-9] = 0
        move.b  $0004(A2),(A1)+                 ; $00BF58  entry[10] = speed_index
        move.b  $0005(A2),D2                    ; $00BF5C  speed digit pair 1
        move.b  D2,D3                           ; $00BF60
        lsr.w   #4,D3                           ; $00BF62  high nibble
        move.b  D3,(A1)+                        ; $00BF64  entry[11]
        andi.b  #$0F,D2                         ; $00BF66  low nibble
        move.b  D2,(A1)+                        ; $00BF6A  entry[12]
        move.b  $0006(A2),(A1)+                 ; $00BF6C  entry[13] = speed
        move.b  $0007(A2),D2                    ; $00BF70  speed digit pair 2
        move.b  D2,D3                           ; $00BF74
        lsr.w   #4,D3                           ; $00BF76  high nibble
        move.b  D3,(A1)+                        ; $00BF78  entry[14]
        andi.b  #$0F,D2                         ; $00BF7A  low nibble
        move.b  D2,(A1)+                        ; $00BF7E  entry[15]
        move.l  (A2),D2                         ; $00BF80  position longword
        andi.l  #$FFFFFF00,D2                   ; $00BF82  mask low byte
        move.l  D2,(A1)+                        ; $00BF88  entry[16-19]
        addq.w  #1,D1                           ; $00BF8A  next racer ID
        lea     $0008(A2),A2                    ; $00BF8C  next racer entry
        dbra    D0,.build_entry                 ; $00BF90
        addq.w  #4,($FFFFA0EA).w               ; $00BF94  advance buffer index
        addq.w  #5,($FFFFA0EE).w               ; $00BF98  advance entry counter
        rts                                     ; $00BF9C
