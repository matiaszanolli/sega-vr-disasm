; ============================================================================
; ascii_character_to_tile_index_mapper_012618 — ASCII Character to Tile Index Mapper (SH2)
; ROM Range: $012618-$0126A6 (142 bytes)
; ============================================================================
; Maps ASCII character code in D1 to a tile index, computes the ROM address
; of the tile at base $060207C0 + index × $C0, then sends it to the SH2
; via sh2_send_cmd with dimensions $000C × $0010.
;
; Character mapping:
;   $20 (space) → index $37 (blank tile)
;   $21 (!)     → index $35
;   $2E (.)     → index $34
;   $41-$5A (A-Z uppercase) → indices $00-$19
;   $61-$7A (a-z lowercase) → indices $00-$33 (via subtract $47)
;   default     → index $36 (placeholder)
;
; Entry: D1 = ASCII character code
; Uses: D0, D1, A0, A1
; Calls: $00E35A (sh2_send_cmd)
; ============================================================================

ascii_character_to_tile_index_mapper_012618:
        cmpi.b  #$60,D1                         ; $012618  if D1 > $60 (lowercase)
        bgt.w   .lowercase                      ; $01261C
        cmpi.b  #$40,D1                         ; $012620  if D1 > $40 (uppercase)
        bgt.w   .uppercase                      ; $012624
        cmpi.b  #$20,D1                         ; $012628  space → blank
        beq.w   .done                           ; $01262C
        cmpi.b  #$21,D1                         ; $012630  '!' → $35
        beq.w   .char_exclaim                   ; $012634
        cmpi.b  #$2E,D1                         ; $012638  '.' → $34
        beq.w   .char_period                    ; $01263C
        move.w  #$0036,D1                       ; $012640  default → $36
        bra.w   .compute_addr                   ; $012644
.lowercase:
        subi.b  #$47,D1                         ; $012648  a-z: subtract $47 → $1A-$33
        andi.w  #$00FF,D1                       ; $01264C
        cmpi.w  #$0033,D1                       ; $012650  clamp to $33
        ble.w   .compute_addr                   ; $012654
        move.w  #$0036,D1                       ; $012658  out of range → $36
        bra.w   .compute_addr                   ; $01265C
.uppercase:
        subi.b  #$41,D1                         ; $012660  A-Z: subtract $41 → $00-$19
        andi.w  #$00FF,D1                       ; $012664
        cmpi.w  #$0019,D1                       ; $012668  clamp to $19
        ble.w   .compute_addr                   ; $01266C
        move.w  #$0036,D1                       ; $012670  out of range → $36
        bra.s   .compute_addr                   ; $012674
.char_exclaim:
        move.w  #$0035,D1                       ; $012676
        bra.s   .compute_addr                   ; $01267A
.char_period:
        move.w  #$0034,D1                       ; $01267C
.compute_addr:
        lea     $060207C0,A0                    ; $012680  base tile address in SH2 ROM
        tst.w   D1                              ; $012686
        beq.s   .send_cmd                       ; $012688  index 0 → use base directly
        subq.w  #1,D1                           ; $01268A
.stride_loop:
        adda.l  #$000000C0,A0                   ; $01268C  stride = $C0 per tile
        dbra    D1,.stride_loop                 ; $012692
.send_cmd:
        move.w  #$000C,D0                       ; $012696  width = 12
        move.w  #$0010,D1                       ; $01269A  height = 16
        dc.w    $4EBA,$BCBA         ; jsr     $00E35A(pc)  ; sh2_send_cmd
.done:
        addq.l  #8,A1                           ; $0126A2  advance string pointer
        rts                                     ; $0126A4
