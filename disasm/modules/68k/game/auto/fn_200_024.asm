; ============================================================================
; fn_200_024 — Nametable Copy Dispatcher
; ROM Range: $00154E-$001586 (56 bytes)
; ============================================================================
; Data prefix ($00154E-$00155D): 16 bytes of initialization data (decoded
; as ORI.B #$00,D0 no-ops by disassembler).
;
; Code entry at $00155E: Dispatches up to 4 nametable copy operations
; packed in D1 (one byte per job). Iterates 4 times (D2=3), extracting
; each byte via ROR.L #8. For each non-zero byte: multiplies by 10
; ($000A) as index into parameter table at $001586, loads source address,
; dest address, and row count, then calls nametable copy at $001236.
;
; Entry: D1 = 4 packed job IDs (one per byte)
; Uses: D0, D1, D2, D3, A0, A1
; Calls:
;   $001236: nametable_decompressor (JSR PC-relative)
; ============================================================================

fn_200_024:
        ORI.B  #$00,D0                          ; $00154E
        ORI.B  #$00,D0                          ; $001552
        ORI.B  #$00,D0                          ; $001556
        ORI.B  #$00,D0                          ; $00155A
        MOVEQ   #$03,D2                         ; $00155E
.loc_0012:
        MOVEQ   #$00,D0                         ; $001560
        MOVE.B  D1,D0                           ; $001562
        BEQ.S  .loc_002C                        ; $001564
        MULU    #$000A,D0                       ; $001566
        LEA     $001586(PC,D0.W),A0             ; $00156A
        MOVE.W  -(A0),D0                        ; $00156E
        MOVEA.L -(A0),A1                        ; $001570
        MOVE.L  -(A0),D3                        ; $001572
        MOVEA.L D3,A0                           ; $001574
        DC.W    $4EBA,$FCBE         ; JSR     $001236(PC); $001576
.loc_002C:
        ROR.L  #8,D1                            ; $00157A
        DBRA    D2,.loc_0012                    ; $00157C
        MOVE    #$2300,SR                       ; $001580
        RTS                                     ; $001584
