; ============================================================================
; fn_12200_002 — Byte Iterator (3-Byte Loop)
; ROM Range: $01260A-$012618 (14 bytes)
; ============================================================================
; Reads 3 bytes sequentially from (A2)+, calling the immediately following
; subroutine (BSR.S) for each byte. Used to process 3-component data (e.g.
; RGB or XYZ coordinates) one byte at a time.
;
; Entry: A2 = source data pointer, D1 = byte value (set per iteration)
; Exit: A2 advanced by 3
; Uses: D1, D2, A2
; ============================================================================

fn_12200_002:
        MOVE.W  #$0002,D2                       ; $01260A
.loc_0004:
        MOVE.B  (A2)+,D1                        ; $01260E
        DC.W    $6106               ; BSR.S  $012618; $012610
        DBRA    D2,.loc_0004                    ; $012612
        RTS                                     ; $012616
