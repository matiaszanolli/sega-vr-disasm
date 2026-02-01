; ============================================================================
; Fast Memory Copy/Fill Functions ($004836 - $00496E)
; ============================================================================
;
; PURPOSE
; -------
; Highly optimized unrolled memory copy and fill routines. These functions
; are critical for performance, using loop unrolling to minimize branch
; overhead and maximize bus utilization.
;
; DESIGN PATTERN
; --------------
; These functions use a "waterfall" entry point pattern:
; - Multiple JSR calls at the top cascade through the unrolled operations
; - Each entry point copies/fills a different number of bytes
; - Example: FastCopy20 copies 20 bytes, FastCopy16 copies 16 bytes
;
; REGISTER CONVENTIONS
; --------------------
; | Register | Purpose                                    |
; |----------|-------------------------------------------|
; | A1       | Source pointer (for copy)                  |
; | A2       | Destination pointer (increment mode)       |
; | A6       | Destination pointer (fixed mode, e.g. VDP) |
; | D1       | Fill value (long)                          |
;
; Dependencies: None (standalone utility functions)
; Related: VDP operations, sprite system, game logic
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

        org     $004836

; ============================================================================
; QuadMemoryFill ($004836) - Fill via 4 JSR Cascade
; Entry points: $4836 (fill 112B), $483A (fill 96B), $483E (80B), $4842 (64B)
; Parameters: A1 = destination pointer, D1 = fill value (long)
; Returns: A1 advanced by fill amount
;
; Uses JSR cascading to double/triple fill operations
; ============================================================================

QuadMemoryFill:
        jsr     MemoryFillWaterfall1(pc)        ; $004836: $4EBA $0002 - Cascade 1
MemoryFillWaterfall1:
        jsr     MemoryFillWaterfall2(pc)        ; $00483A: $4EBA $0002 - Cascade 2
MemoryFillWaterfall2:
        jsr     MemoryFill60A1(pc)              ; $00483E: $4EBA $0002 - Cascade 3
MemoryFill60A1:
        jsr     MemoryFill60A4(pc)              ; $004842: $4EBA $0002 - Cascade 4
MemoryFill60A4:
; Unrolled fill: 16 longwords = 64 bytes
        move.l  d1,(a1)+                        ; $004846: $22C1 - Fill word 1
        move.l  d1,(a1)+                        ; $004848: $22C1 - Fill word 2
        move.l  d1,(a1)+                        ; $00484A: $22C1 - Fill word 3
        move.l  d1,(a1)+                        ; $00484C: $22C1 - Fill word 4
        move.l  d1,(a1)+                        ; $00484E: $22C1 - Fill word 5
        move.l  d1,(a1)+                        ; $004850: $22C1 - Fill word 6
        move.l  d1,(a1)+                        ; $004852: $22C1 - Fill word 7
        move.l  d1,(a1)+                        ; $004854: $22C1 - Fill word 8
UnrolledFill96:
        move.l  d1,(a1)+                        ; $004856: $22C1 - Fill word 9
        move.l  d1,(a1)+                        ; $004858: $22C1 - Fill word 10
        move.l  d1,(a1)+                        ; $00485A: $22C1 - Fill word 11
        move.l  d1,(a1)+                        ; $00485C: $22C1 - Fill word 12
UnrolledFill112:
        move.l  d1,(a1)+                        ; $00485E: $22C1 - Fill word 13
        move.l  d1,(a1)+                        ; $004860: $22C1 - Fill word 14
        move.l  d1,(a1)+                        ; $004862: $22C1 - Fill word 15
        move.l  d1,(a1)+                        ; $004864: $22C1 - Fill word 16
        move.l  d1,(a1)+                        ; $004866: $22C1 - Extra 1
        move.l  d1,(a1)+                        ; $004868: $22C1 - Extra 2
        move.l  d1,(a1)+                        ; $00486A: $22C1 - Extra 3
        move.l  d1,(a1)+                        ; $00486C: $22C1 - Extra 4
        move.l  d1,(a1)+                        ; $00486E: $22C1 - Extra 5
        move.l  d1,(a1)+                        ; $004870: $22C1 - Extra 6
        move.l  d1,(a1)+                        ; $004872: $22C1 - Extra 7
        move.l  d1,(a1)+                        ; $004874: $22C1 - Extra 8
        move.l  d1,(a1)+                        ; $004876: $22C1 - Extra 9
        move.l  d1,(a1)+                        ; $004878: $22C1 - Extra 10
        move.l  d1,(a1)+                        ; $00487A: $22C1 - Extra 11
        move.l  d1,(a1)+                        ; $00487C: $22C1 - Extra 12
        move.l  d1,(a1)+                        ; $00487E: $22C1 - Extra 13
        move.l  d1,(a1)+                        ; $004880: $22C1 - Extra 14
        move.l  d1,(a1)+                        ; $004882: $22C1 - Extra 15
        move.l  d1,(a1)+                        ; $004884: $22C1 - Extra 16
        rts                                     ; $004886: $4E75

; ============================================================================
; MemoryFillA6 ($004888) - Fill to Fixed Address (e.g., VDP port)
; Entry points: Various based on count needed
; Parameters: A6 = destination (fixed), D1 = fill value (long)
; Returns: Nothing (A6 unchanged)
;
; Used for VDP fills where destination doesn't increment
; ============================================================================

MemoryFillA6_32:
        move.l  d1,(a6)                         ; $004888: $2C81 - Fill 1
        move.l  d1,(a6)                         ; $00488A: $2C81 - Fill 2
        move.l  d1,(a6)                         ; $00488C: $2C81 - Fill 3
        move.l  d1,(a6)                         ; $00488E: $2C81 - Fill 4
        move.l  d1,(a6)                         ; $004890: $2C81 - Fill 5
        move.l  d1,(a6)                         ; $004892: $2C81 - Fill 6
        move.l  d1,(a6)                         ; $004894: $2C81 - Fill 7
        move.l  d1,(a6)                         ; $004896: $2C81 - Fill 8
UnrolledFill32:
        move.l  d1,(a6)                         ; $004898: $2C81 - Fill 9
        move.l  d1,(a6)                         ; $00489A: $2C81 - Fill 10
        move.l  d1,(a6)                         ; $00489C: $2C81 - Fill 11
        move.l  d1,(a6)                         ; $00489E: $2C81 - Fill 12
        move.l  d1,(a6)                         ; $0048A0: $2C81 - Fill 13
        move.l  d1,(a6)                         ; $0048A2: $2C81 - Fill 14
        move.l  d1,(a6)                         ; $0048A4: $2C81 - Fill 15
        move.l  d1,(a6)                         ; $0048A6: $2C81 - Fill 16
        move.l  d1,(a6)                         ; $0048A8: $2C81 - Fill 17
        move.l  d1,(a6)                         ; $0048AA: $2C81 - Fill 18
        move.l  d1,(a6)                         ; $0048AC: $2C81 - Fill 19
        move.l  d1,(a6)                         ; $0048AE: $2C81 - Fill 20
        move.l  d1,(a6)                         ; $0048B0: $2C81 - Fill 21
        move.l  d1,(a6)                         ; $0048B2: $2C81 - Fill 22
        move.l  d1,(a6)                         ; $0048B4: $2C81 - Fill 23
        move.l  d1,(a6)                         ; $0048B6: $2C81 - Fill 24
        move.l  d1,(a6)                         ; $0048B8: $2C81 - Fill 25
        move.l  d1,(a6)                         ; $0048BA: $2C81 - Fill 26
        move.l  d1,(a6)                         ; $0048BC: $2C81 - Fill 27
        move.l  d1,(a6)                         ; $0048BE: $2C81 - Fill 28
        move.l  d1,(a6)                         ; $0048C0: $2C81 - Fill 29
        move.l  d1,(a6)                         ; $0048C2: $2C81 - Fill 30
        move.l  d1,(a6)                         ; $0048C4: $2C81 - Fill 31
        move.l  d1,(a6)                         ; $0048C6: $2C81 - Fill 32
        rts                                     ; $0048C8: $4E75

; ============================================================================
; TripleMemoryFill ($0048CA) - Fill via 3 JSR Cascade
; Entry points: $48CA (triple), $48CE (double), $48D2 (single)
; Parameters: A1 = source, A2 = destination
; Returns: Both pointers advanced
; ============================================================================

TripleMemoryFill:
        jsr     MemoryFillWaterfall3(pc)        ; $0048CA: $4EBA $0002 - Cascade 1
MemoryFillWaterfall3:
        jsr     MemoryFillWaterfall4(pc)        ; $0048CE: $4EBA $0002 - Cascade 2
MemoryFillWaterfall4:
        jsr     UnrolledCopy72(pc)              ; $0048D2: $4EBA $0022 - Cascade 3

; (Continues with copy operations...)

        org     $0048F8

UnrolledCopy72:
; Unrolled copy: 18 longwords = 72 bytes
        move.l  (a1)+,(a2)+                     ; $0048F8: $24D9 - Copy 1
        move.l  (a1)+,(a2)+                     ; $0048FA: $24D9 - Copy 2
        move.l  (a1)+,(a2)+                     ; $0048FC: $24D9 - Copy 3
UnrolledFill60:
        move.l  (a1)+,(a2)+                     ; $0048FE: $24D9 - Copy 4
        move.l  (a1)+,(a2)+                     ; $004900: $24D9 - Copy 5
        move.l  (a1)+,(a2)+                     ; $004902: $24D9 - Copy 6
        move.l  (a1)+,(a2)+                     ; $004904: $24D9 - Copy 7
        move.l  (a1)+,(a2)+                     ; $004906: $24D9 - Copy 8
        move.l  (a1)+,(a2)+                     ; $004908: $24D9 - Copy 9
        move.l  (a1)+,(a2)+                     ; $00490A: $24D9 - Copy 10
        move.l  (a1)+,(a2)+                     ; $00490C: $24D9 - Copy 11
        move.l  (a1)+,(a2)+                     ; $00490E: $24D9 - Copy 12
        move.l  (a1)+,(a2)+                     ; $004910: $24D9 - Copy 13
        move.l  (a1)+,(a2)+                     ; $004912: $24D9 - Copy 14
        move.l  (a1)+,(a2)+                     ; $004914: $24D9 - Copy 15
        move.l  (a1)+,(a2)+                     ; $004916: $24D9 - Copy 16
        move.l  (a1)+,(a2)+                     ; $004918: $24D9 - Copy 17
        move.l  (a1)+,(a2)+                     ; $00491A: $24D9 - Copy 18
        rts                                     ; $00491C: $4E75
        nop                                     ; $00491E: $4E71 - Padding

; ============================================================================
; FastCopy20 ($004920) - Copy 20 Bytes (5 longs)
; Entry points: $4920 (20B), $4922 (16B), $4924 (12B), etc.
; Parameters: A1 = source, A2 = destination
; Returns: Both pointers advanced by copy amount
;
; Most commonly used copy function in the game
; ============================================================================

        org     $004920

FastCopy20:
        move.l  (a1)+,(a2)+                     ; $004920: $24D9 - Copy 1 (4 bytes)
FastCopy16:
        move.l  (a1)+,(a2)+                     ; $004922: $24D9 - Copy 2 (4 bytes)
FastCopy12:
        move.l  (a1)+,(a2)+                     ; $004924: $24D9 - Copy 3 (4 bytes)
FastCopy8:
        move.l  (a1)+,(a2)+                     ; $004926: $24D9 - Copy 4 (4 bytes)
FastCopy4:
        move.l  (a1)+,(a2)+                     ; $004928: $24D9 - Copy 5 (4 bytes)
        rts                                     ; $00492A: $4E75

; ============================================================================
; FastCopyA6 ($00492C) - Copy to Fixed Address
; Parameters: A1 = source, A6 = destination (fixed)
; Returns: A1 advanced, A6 unchanged
;
; Used for VDP data writes
; ============================================================================

FastCopyA6_64:
        move.l  (a1)+,(a6)                      ; $00492C: $2C99 - Copy 1
        move.l  (a1)+,(a6)                      ; $00492E: $2C99 - Copy 2
        move.l  (a1)+,(a6)                      ; $004930: $2C99 - Copy 3
        move.l  (a1)+,(a6)                      ; $004932: $2C99 - Copy 4
        move.l  (a1)+,(a6)                      ; $004934: $2C99 - Copy 5
        move.l  (a1)+,(a6)                      ; $004936: $2C99 - Copy 6
        move.l  (a1)+,(a6)                      ; $004938: $2C99 - Copy 7
        move.l  (a1)+,(a6)                      ; $00493A: $2C99 - Copy 8
        move.l  (a1)+,(a6)                      ; $00493C: $2C99 - Copy 9
        move.l  (a1)+,(a6)                      ; $00493E: $2C99 - Copy 10
        move.l  (a1)+,(a6)                      ; $004940: $2C99 - Copy 11
        move.l  (a1)+,(a6)                      ; $004942: $2C99 - Copy 12
        move.l  (a1)+,(a6)                      ; $004944: $2C99 - Copy 13
        move.l  (a1)+,(a6)                      ; $004946: $2C99 - Copy 14
        move.l  (a1)+,(a6)                      ; $004948: $2C99 - Copy 15
        move.l  (a1)+,(a6)                      ; $00494A: $2C99 - Copy 16
        rts                                     ; $00494C: $4E75

; ============================================================================
; FastCopyA6_60 ($00494E) - Copy 60 Bytes to Fixed Address
; Parameters: A1 = source, A6 = destination (fixed)
; Returns: A1 advanced by 60 bytes, A6 unchanged
;
; Alternative entry for 60-byte VDP copies (15 longwords)
; ============================================================================

FastCopyA6_60:
        move.l  (a1)+,(a6)                      ; $00494E: $2C99 - Copy 1
        move.l  (a1)+,(a6)                      ; $004950: $2C99 - Copy 2
        move.l  (a1)+,(a6)                      ; $004952: $2C99 - Copy 3
        move.l  (a1)+,(a6)                      ; $004954: $2C99 - Copy 4
        move.l  (a1)+,(a6)                      ; $004956: $2C99 - Copy 5
        move.l  (a1)+,(a6)                      ; $004958: $2C99 - Copy 6
        move.l  (a1)+,(a6)                      ; $00495A: $2C99 - Copy 7
        move.l  (a1)+,(a6)                      ; $00495C: $2C99 - Copy 8
        move.l  (a1)+,(a6)                      ; $00495E: $2C99 - Copy 9
        move.l  (a1)+,(a6)                      ; $004960: $2C99 - Copy 10
        move.l  (a1)+,(a6)                      ; $004962: $2C99 - Copy 11
        move.l  (a1)+,(a6)                      ; $004964: $2C99 - Copy 12
        move.l  (a1)+,(a6)                      ; $004966: $2C99 - Copy 13
        move.l  (a1)+,(a6)                      ; $004968: $2C99 - Copy 14
        move.l  (a1)+,(a6)                      ; $00496A: $2C99 - Copy 15
        rts                                     ; $00496C: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function           | Address | Bytes Copied | Entry Points
; -------------------+---------+--------------+------------------
; QuadMemoryFill     | $004836 | 112/96/80/64 | Waterfall cascade
; MemoryFillA6       | $004888 | 32-128       | VDP fill
; TripleMemoryFill   | $0048CA | Variable     | Triple cascade
; FastCopy20         | $004920 | 20/16/12/8/4 | Most common
; FastCopyA6_64      | $00492C | 64           | VDP copy (16 longs)
; FastCopyA6_60      | $00494E | 60           | VDP copy (15 longs)
;
; These unrolled loops are critical for performance:
; - move.l takes 20 cycles (word moves take 12 each = 24 for same data)
; - Removing loop overhead saves 10+ cycles per iteration
; - Bus-optimized for 68000's 16-bit bus
;
; ============================================================================
