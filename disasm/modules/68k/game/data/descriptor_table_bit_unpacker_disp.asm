; ============================================================================
; descriptor_table_bit_unpacker_disp — Descriptor Table + Bit Unpacker Dispatcher
; ROM Range: $001586-$001610 (138 bytes)
; ============================================================================
; Contains a 10-entry descriptor table (100 bytes) followed by code that
; iterates 4 bytes of D0 (via ROR.L #8), using each byte as an index to
; look up source/destination pointer pairs and call bit_unpack_loop.
;
; Descriptor table format: 10 entries × 5 words each
;   {$0090, address, $00FF, $1000, $0011}
; Entries 1-2 are zeroed (unused). Valid addresses reference compressed
; data sources elsewhere in ROM.
;
; Entry: D0 = packed 4-byte index (each byte selects a descriptor)
; Uses: D0, D1, D2, A0, A1, A2, A4, A5
; Calls: $0013B4 (bit_unpack_loop)
; ============================================================================

descriptor_table_bit_unpacker_disp:
; --- descriptor table (10 entries × 5 words = 100 bytes) ----------------------
        dc.w    $0090,$0000,$00FF,$1000,$0011   ; $001586  entry 0 (addr=$0000)
        dc.w    $0000,$0000,$0000,$0000,$0000   ; $001590  entry 1 (unused)
        dc.w    $0000,$0000,$0000,$0000,$0000   ; $00159A  entry 2 (unused)
        dc.w    $0090,$23A4,$00FF,$1000,$0011   ; $0015A4  entry 3 (addr=$23A4)
        dc.w    $0090,$05B2,$00FF,$1000,$0011   ; $0015AE  entry 4 (addr=$05B2)
        dc.w    $0090,$0A7C,$00FF,$1000,$0011   ; $0015B8  entry 5 (addr=$0A7C)
        dc.w    $0090,$102A,$00FF,$1000,$0011   ; $0015C2  entry 6 (addr=$102A)
        dc.w    $0090,$3A74,$00FF,$1000,$0011   ; $0015CC  entry 7 (addr=$3A74)
        dc.w    $0090,$3ADE,$00FF,$1000,$0011   ; $0015D6  entry 8 (addr=$3ADE)
        dc.w    $0090,$3B3C,$00FF,$1000,$0011   ; $0015E0  entry 9 (addr=$3B3C)
; --- code starts here ---------------------------------------------------------
        moveq   #$03,D2                         ; $0015EA  4 iterations (bytes of D0)
.next_byte:
        moveq   #$00,D1                         ; $0015EC
        move.b  D0,D1                           ; $0015EE  D1 = low byte of D0
        beq.s   .skip_unpack                    ; $0015F0  zero → skip
        lsl.w   #3,D1                           ; $0015F2  D1 × 8 (pointer pair offset)
        movea.l $001608(PC,D1.W),A0             ; $0015F4  source pointer
        movea.l $00160C(PC,D1.W),A1             ; $0015F8  destination pointer
        movem.l D0/D2,-(A7)                     ; $0015FC  save loop state
        dc.w    $4EBA,$FDB2         ; jsr     $0013B4(pc)  ; bit_unpack_loop
        movem.l (A7)+,D0/D2                     ; $001604  restore loop state
.skip_unpack:
        ror.l   #8,D0                           ; $001608  rotate to next byte
        dbra    D2,.next_byte                   ; $00160A
        rts                                     ; $00160E
