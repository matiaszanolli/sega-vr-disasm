; ============================================================================
; Table Lookup — Object Field to Race State Byte
; ROM Range: $008246-$008256 (16 bytes)
; ============================================================================
; Uses the word at object+$2C as an index into a lookup table
; immediately following this function ($008256+), and stores the
; resulting byte into $C8A5.
;
; Memory:
;   $FFFFC8A5 = race/mode state byte (byte, written from table)
; Entry: A0 = object pointer | Exit: table value stored
; Uses: D0, A0, A1
; ============================================================================

table_lookup_object_field_to_race_state_byte:
        move.w  $002C(a0),d0                    ; $008246: $3028 $002C — load index from object+$2C
        dc.w    $43FA,$000A                     ; LEA $008256(PC),A1 ; $00824A: — table base
        move.b  $00(a1,d0.w),($FFFFC8A5).w    ; $00824E: $11F1 $0000 $C8A5 — table[index] → $C8A5
        rts                                     ; $008254: $4E75
