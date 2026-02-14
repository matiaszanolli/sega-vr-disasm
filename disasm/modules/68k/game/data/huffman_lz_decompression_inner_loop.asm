; ============================================================================
; huffman_lz_decompression_inner_loop — Huffman/LZ Decompression Inner Loop
; ROM Range: $001140-$0011C2 (130 bytes)
; ============================================================================
; Bit-level decoder for compressed data. Uses D5/D6 as a shift register,
; D4 as a nibble accumulator, D3 as output counter. Reads from (A0)+
; source stream, uses (A1) as Huffman/lookup table with 2-byte entries
; (+$00 = signed delta, +$01 = length/nibble pair).
;
; On completion, writes 32-bit decoded value via MOVE.L D4,(A4) and
; decrements tile counter A5; loops until A5 reaches zero.
;
; Entry: A0 = compressed data stream pointer
;        A1 = Huffman/lookup table
;        A3 = return address for completed values (JMP (A3))
;        A4 = output buffer pointer
;        A5 = tile counter
;        D3 = remaining nibbles to fill
;        D4 = nibble accumulator
;        D5 = bit shift register (16-bit)
;        D6 = remaining bits in shift register
; Uses: D0, D1, D3, D4, D5, D6, D7, A0
; ============================================================================

huffman_lz_decompression_inner_loop:
.decode_symbol:
        move.w  D6,D7                           ; $001140  bits remaining
        subq.w  #8,D7                           ; $001142  need 8 bits for lookup
        move.w  D5,D1                           ; $001144  shift register
        lsr.w   D7,D1                           ; $001146  extract top 8 bits
        cmpi.b  #$FC,D1                         ; $001148  escape code?
        bcc.s   .escape_code                    ; $00114C  yes → long symbol
        andi.w  #$00FF,D1                       ; $00114E  mask to byte
        add.w   d1,d1                   ; $D241
        move.b  $00(A1,D1.W),D0                 ; $001154  table[D1] = signed delta
        ext.w   D0                              ; $001158  sign-extend
        sub.w   d0,d6                   ; $9C40
        cmpi.w  #$0009,D6                       ; $00115C  need refill?
        bcc.s   .read_nibble_pair               ; $001160  no → continue
        addq.w  #8,D6                           ; $001162  refill 8 bits
        asl.w   #8,D5                           ; $001164
        move.b  (A0)+,D5                        ; $001166  read next byte
.read_nibble_pair:
        move.b  $01(A1,D1.W),D1                 ; $001168  table[D1+1] = length/nibble
        move.w  D1,D0                           ; $00116C
        andi.w  #$000F,D1                       ; $00116E  low nibble = repeat count
        andi.w  #$00F0,D0                       ; $001172  high nibble = value
.shift_nibble:
        lsr.w   #4,D0                           ; $001176  align value to low nibble
.accumulate_nibbles:
        lsl.l   #4,D4                           ; $001178  shift accumulator left
        or.b    d1,d4                   ; $8801
        subq.w  #1,D3                           ; $00117C  decrement output counter
        bne.s   .check_repeat                   ; $00117E  more nibbles needed
        jmp     (A3)                            ; $001180  value complete → return
.reset_accumulator:
        moveq   #$00,D4                         ; $001182  clear accumulator
        moveq   #$08,D3                         ; $001184  8 nibbles per 32-bit value
.check_repeat:
        dbra    D0,.accumulate_nibbles           ; $001186  repeat D0 times
        bra.s   .decode_symbol                  ; $00118A  next symbol
.escape_code:
        subq.w  #6,D6                           ; $00118C  consume 6 bits (escape prefix)
        cmpi.w  #$0009,D6                       ; $00118E  need refill?
        bcc.s   .escape_extract                 ; $001192
        addq.w  #8,D6                           ; $001194  refill
        asl.w   #8,D5                           ; $001196
        move.b  (A0)+,D5                        ; $001198
.escape_extract:
        subq.w  #7,D6                           ; $00119A  consume 7 more bits
        move.w  D5,D1                           ; $00119C  extract from register
        lsr.w   D6,D1                           ; $00119E
        move.w  D1,D0                           ; $0011A0
        andi.w  #$000F,D1                       ; $0011A2  low 4 bits = repeat
        andi.w  #$0070,D0                       ; $0011A6  bits 4-6 = value (3 bits)
        cmpi.w  #$0009,D6                       ; $0011AA  need refill?
        bcc.s   .shift_nibble                   ; $0011AE
        addq.w  #8,D6                           ; $0011B0  refill
        asl.w   #8,D5                           ; $0011B2
        move.b  (A0)+,D5                        ; $0011B4
        bra.s   .shift_nibble                   ; $0011B6
.store_and_loop:
        move.l  D4,(A4)                         ; $0011B8  write decoded longword
        subq.w  #1,A5                           ; $0011BA  decrement tile counter
        move.w  A5,D4                           ; $0011BC
        bne.s   .reset_accumulator              ; $0011BE  more tiles → continue
        rts                                     ; $0011C0
