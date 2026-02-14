; ============================================================================
; ascii_character_to_tile_index_mapper_010674 — ASCII Character to Tile Index Mapper (SH2, Alternate)
; ROM Range: $010674-$01071C (168 bytes)
; ============================================================================
; Maps ASCII/special character code in D0 to a tile index, computes the ROM
; address at base $06024000 + index × 192 ($C0), then sends to SH2 via
; sh2_send_cmd with dimensions $0018 × $0028.
;
; Character mapping:
;   $20 (space) → index $37
;   $08 (BS)    → index $38
;   $03 (ETX)   → index $39
;   $2E (.)     → index $34
;   $21 (!)     → index $35
;   $3F (?)     → index $36
;   $41-$5A (A-Z) → indices $00-$19 (subtract $41)
;   $61-$7A (a-z) → indices $1A-$33 (subtract $47)
;   default     → index $36
;
; Address computation: index × 192 via shift+add chain:
;   D0 × 64 → D1, then D0 = D0×128 + D1×2 + D1×4 = index × 192 + ... × 192
;
; Entry: D0 = character code
; Uses: D0, D1, A0
; Calls: $00E35A (sh2_send_cmd)
; ============================================================================

ascii_character_to_tile_index_mapper_010674:
        cmpi.w  #$0020,D0                       ; $010674
        beq.w   .char_space                     ; $010678
        cmpi.w  #$0008,D0                       ; $01067C
        beq.w   .char_bs                        ; $010680
        cmpi.w  #$0003,D0                       ; $010684
        beq.w   .char_etx                       ; $010688
        cmpi.w  #$002E,D0                       ; $01068C
        beq.w   .char_period                    ; $010690
        cmpi.w  #$0021,D0                       ; $010694
        beq.w   .char_exclaim                   ; $010698
        cmpi.w  #$003F,D0                       ; $01069C
        beq.w   .char_default                   ; $0106A0
        cmpi.w  #$005A,D0                       ; $0106A4  Z
        ble.w   .uppercase                      ; $0106A8
        cmpi.w  #$007A,D0                       ; $0106AC  z
        ble.w   .lowercase                      ; $0106B0
.char_default:
        move.w  #$0036,D0                       ; $0106B4
        bra.w   .compute_addr                   ; $0106B8
.char_space:
        move.w  #$0037,D0                       ; $0106BC
        bra.w   .compute_addr                   ; $0106C0
.char_bs:
        move.w  #$0038,D0                       ; $0106C4
        bra.w   .compute_addr                   ; $0106C8
.char_etx:
        move.w  #$0039,D0                       ; $0106CC
        bra.w   .compute_addr                   ; $0106D0
.char_period:
        move.w  #$0034,D0                       ; $0106D4
        bra.w   .compute_addr                   ; $0106D8
.char_exclaim:
        move.w  #$0035,D0                       ; $0106DC
        bra.w   .compute_addr                   ; $0106E0
.uppercase:
        subi.w  #$0041,D0                       ; $0106E4
        bra.w   .compute_addr                   ; $0106E8
.lowercase:
        subi.w  #$0047,D0                       ; $0106EC
.compute_addr:
        andi.l  #$0000FFFF,D0                   ; $0106F0  zero-extend to longword
        lsl.l   #6,D0                           ; $0106F6  D0 = index × 64
        move.l  D0,D1                           ; $0106F8  D1 = index × 64
        lsl.l   #1,D0                           ; $0106FA  D0 = index × 128
        add.l   d0,d1                   ; $D280
        lsl.l   #1,D0                           ; $0106FE  (unused intermediate)
        add.l   d0,d1                   ; $D280
        lsl.l   #1,D0                           ; $010702
        add.l   d1,d0                   ; $D081
        movea.l #$06024000,A0                   ; $010706  base tile address in SH2 ROM
        adda.l  D0,A0                           ; $01070C  A0 = base + offset
        move.w  #$0018,D0                       ; $01070E  width = 24
        move.w  #$0028,D1                       ; $010712  height = 40
        dc.w    $4EBA,$DC42         ; jsr     $00E35A(pc)  ; sh2_send_cmd
        rts                                     ; $01071A
