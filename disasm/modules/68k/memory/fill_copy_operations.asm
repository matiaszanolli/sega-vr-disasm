; ============================================================================
; Memory Fill and Copy Operations ($004836-$004996)
; ============================================================================
; High-performance unrolled memory operations for buffer initialization
; and data transfer. All routines are optimized for speed using unrolled
; MOVE.L instructions.
;
; Fill Operations:
;   - QuadMemoryFill: Waterfall entry for 4-level fill
;   - UnrolledFill32: 8 MOVE.L ops = 32 bytes (to A6)
;   - UnrolledFill60: 15 MOVE.L ops = 60 bytes (A1->A2 copy pattern)
;   - UnrolledFill96: 24 MOVE.L ops = 96 bytes
;   - UnrolledFill112: 28 MOVE.L ops = 112 bytes
;
; Copy Operations:
;   - FastCopy16: 4 MOVE.L ops = 16 bytes (A1->A2)
;   - FastCopy20: 5 MOVE.L ops = 20 bytes (A1->A2)
;
; Register Usage:
;   D1 - Fill value (longword)
;   A1 - Source/destination pointer (context-dependent)
;   A2 - Destination pointer (copy operations)
;   A6 - Destination pointer (UnrolledFill32)
;
; Called from: Multiple subsystems (display, game logic, init)
; Dependencies: None (standalone utilities)
;
; Originally at $004836-$004996 in sections/code_4200.asm
; ============================================================================

        org     $004836

QuadMemoryFill:
        BSR.W   MemoryFillWaterfall1    ; $004836: JSR +4 (waterfall entry)

; --- Memory fill waterfall entry 1 ---
MemoryFillWaterfall1:
        BSR.W   MemoryFillWaterfall2    ; $00483A: JSR +4 (waterfall entry)

; --- Memory fill waterfall entry 2 ---
MemoryFillWaterfall2:
        BSR.W   MemoryFill60A1          ; $00483E: JSR +4 (waterfall entry)

; --- Memory fill 60 bytes (A1) ---
MemoryFill60A1:
        BSR.W   MemoryFill60A4          ; $004842: JSR +4 (waterfall entry)

; --- Memory fill 60 bytes (A4) ---
MemoryFill60A4:
        MOVE.L D1,(A1)+        ; $004846
        MOVE.L D1,(A1)+        ; $004848
        MOVE.L D1,(A1)+        ; $00484A
        MOVE.L D1,(A1)+        ; $00484C
        MOVE.L D1,(A1)+        ; $00484E
        MOVE.L D1,(A1)+        ; $004850
        MOVE.L D1,(A1)+        ; $004852
        MOVE.L D1,(A1)+        ; $004854

; --- Unrolled memory fill (96 bytes) ---
UnrolledFill96:
        MOVE.L D1,(A1)+        ; $004856
        MOVE.L D1,(A1)+        ; $004858
        MOVE.L D1,(A1)+        ; $00485A
        MOVE.L D1,(A1)+        ; $00485C

; --- Unrolled memory fill (112 bytes) ---
UnrolledFill112:
        MOVE.L D1,(A1)+        ; $00485E
        MOVE.L D1,(A1)+        ; $004860
        MOVE.L D1,(A1)+        ; $004862
        MOVE.L D1,(A1)+        ; $004864
        MOVE.L D1,(A1)+        ; $004866
        MOVE.L D1,(A1)+        ; $004868
        MOVE.L D1,(A1)+        ; $00486A
        MOVE.L D1,(A1)+        ; $00486C
        MOVE.L D1,(A1)+        ; $00486E
        MOVE.L D1,(A1)+        ; $004870
        MOVE.L D1,(A1)+        ; $004872
        MOVE.L D1,(A1)+        ; $004874
        MOVE.L D1,(A1)+        ; $004876
        MOVE.L D1,(A1)+        ; $004878
        MOVE.L D1,(A1)+        ; $00487A
        MOVE.L D1,(A1)+        ; $00487C
        MOVE.L D1,(A1)+        ; $00487E
        MOVE.L D1,(A1)+        ; $004880
        MOVE.L D1,(A1)+        ; $004882
        MOVE.L D1,(A1)+        ; $004884
        RTS        ; $004886
        MOVE.L D1,(A6)+        ; $004888
        MOVE.L D1,(A6)+        ; $00488A
        MOVE.L D1,(A6)+        ; $00488C
        MOVE.L D1,(A6)+        ; $00488E
        MOVE.L D1,(A6)+        ; $004890
        MOVE.L D1,(A6)+        ; $004892
        MOVE.L D1,(A6)+        ; $004894
        MOVE.L D1,(A6)+        ; $004896
        MOVE.L D1,(A6)+        ; $004898
        MOVE.L D1,(A6)+        ; $00489A
        MOVE.L D1,(A6)+        ; $00489C
        MOVE.L D1,(A6)+        ; $00489E
        MOVE.L D1,(A6)+        ; $0048A0
        MOVE.L D1,(A6)+        ; $0048A2
        MOVE.L D1,(A6)+        ; $0048A4
        MOVE.L D1,(A6)+        ; $0048A6
        MOVE.L D1,(A6)+        ; $0048A8
        MOVE.L D1,(A6)+        ; $0048AA
        MOVE.L D1,(A6)+        ; $0048AC
        MOVE.L D1,(A6)+        ; $0048AE
        MOVE.L D1,(A6)+        ; $0048B0
        MOVE.L D1,(A6)+        ; $0048B2
        MOVE.L D1,(A6)+        ; $0048B4
        MOVE.L D1,(A6)+        ; $0048B6

; --- Unrolled memory fill (32 bytes) ---
UnrolledFill32:
        MOVE.L D1,(A6)        ; $0048B8
        MOVE.L D1,(A6)        ; $0048BA
        MOVE.L D1,(A6)        ; $0048BC
        MOVE.L D1,(A6)        ; $0048BE
        MOVE.L D1,(A6)        ; $0048C0
        MOVE.L D1,(A6)        ; $0048C2
        MOVE.L D1,(A6)        ; $0048C4
        MOVE.L D1,(A6)        ; $0048C6
        RTS        ; $0048C8

; --- Triple memory fill dispatcher ---
TripleMemoryFill:
        BSR.W   MemoryFillWaterfall3    ; $0048CA: JSR +4 (waterfall entry)

; --- Memory fill waterfall entry 3 ---
MemoryFillWaterfall3:
        BSR.W   MemoryFillWaterfall4    ; $0048CE: JSR +4 (waterfall entry)

; --- Memory fill waterfall entry 4 ---
MemoryFillWaterfall4:
        BSR.W   .continue               ; $0048D2: JSR +4 (waterfall entry)
.continue:
        BSR.W   UnrolledFill60          ; $0048D6: JSR +4 (waterfall entry)
        MOVE.L (A1)+,(A2)+        ; $0048DA
        MOVE.L (A1)+,(A2)+        ; $0048DC
        MOVE.L (A1)+,(A2)+        ; $0048DE
        MOVE.L (A1)+,(A2)+        ; $0048E0
        MOVE.L (A1)+,(A2)+        ; $0048E2
        MOVE.L (A1)+,(A2)+        ; $0048E4
        MOVE.L (A1)+,(A2)+        ; $0048E6
        MOVE.L (A1)+,(A2)+        ; $0048E8
        MOVE.L (A1)+,(A2)+        ; $0048EA
        MOVE.L (A1)+,(A2)+        ; $0048EC
        MOVE.L (A1)+,(A2)+        ; $0048EE
        MOVE.L (A1)+,(A2)+        ; $0048F0
        MOVE.L (A1)+,(A2)+        ; $0048F2
        MOVE.L (A1)+,(A2)+        ; $0048F4
        MOVE.L (A1)+,(A2)+        ; $0048F6
        MOVE.L (A1)+,(A2)+        ; $0048F8
        MOVE.L (A1)+,(A2)+        ; $0048FA
        MOVE.L (A1)+,(A2)+        ; $0048FC

; --- Unrolled memory fill (60 bytes) ---
UnrolledFill60:
        MOVE.L (A1)+,(A2)+        ; $0048FE
        MOVE.L (A1)+,(A2)+        ; $004900
        MOVE.L (A1)+,(A2)+        ; $004902
        MOVE.L (A1)+,(A2)+        ; $004904
        MOVE.L (A1)+,(A2)+        ; $004906
        MOVE.L (A1)+,(A2)+        ; $004908
        MOVE.L (A1)+,(A2)+        ; $00490A
        MOVE.L (A1)+,(A2)+        ; $00490C
        MOVE.L (A1)+,(A2)+        ; $00490E
        MOVE.L (A1)+,(A2)+        ; $004910
        MOVE.L (A1)+,(A2)+        ; $004912
        MOVE.L (A1)+,(A2)+        ; $004914
        MOVE.L (A1)+,(A2)+        ; $004916
        MOVE.L (A1)+,(A2)+        ; $004918
        MOVE.L (A1)+,(A2)+        ; $00491A
        MOVE.L (A1)+,(A2)+        ; $00491C
        MOVE.L (A1)+,(A2)+        ; $00491E

; --- Fast 20-byte memory copy (A1->A2) ---
FastCopy20:
        MOVE.L (A1)+,(A2)+        ; $004920

; --- Fast 16-byte copy (variant entry) ---
FastCopy16:
        MOVE.L (A1)+,(A2)+        ; $004922
        MOVE.L (A1)+,(A2)+        ; $004924
        MOVE.L (A1)+,(A2)+        ; $004926
        MOVE.L (A1)+,(A2)+        ; $004928
        RTS        ; $00492A
        MOVE.L (A1)+,(A6)+        ; $00492C
        MOVE.L (A1)+,(A6)+        ; $00492E
        MOVE.L (A1)+,(A6)+        ; $004930
        MOVE.L (A1)+,(A6)+        ; $004932
        MOVE.L (A1)+,(A6)+        ; $004934
        MOVE.L (A1)+,(A6)+        ; $004936
        MOVE.L (A1)+,(A6)+        ; $004938
        MOVE.L (A1)+,(A6)+        ; $00493A
        MOVE.L (A1)+,(A6)+        ; $00493C
        MOVE.L (A1)+,(A6)+        ; $00493E
        MOVE.L (A1)+,(A6)+        ; $004940
        MOVE.L (A1)+,(A6)+        ; $004942
        MOVE.L (A1)+,(A6)+        ; $004944
        MOVE.L (A1)+,(A6)+        ; $004946
        MOVE.L (A1)+,(A6)+        ; $004948
        MOVE.L (A1)+,(A6)+        ; $00494A
        MOVE.L (A1)+,(A6)+        ; $00494C
        MOVE.L (A1)+,(A6)+        ; $00494E
        MOVE.L (A1)+,(A6)+        ; $004950
        MOVE.L (A1)+,(A6)+        ; $004952
        MOVE.L (A1)+,(A6)+        ; $004954
        MOVE.L (A1)+,(A6)+        ; $004956
        MOVE.L (A1)+,(A6)+        ; $004958
        MOVE.L (A1)+,(A6)+        ; $00495A
        MOVE.L (A1)+,(A6)+        ; $00495C
        MOVE.L (A1)+,(A6)+        ; $00495E
        MOVE.L (A1)+,(A6)+        ; $004960
        MOVE.L (A1)+,(A6)+        ; $004962
        MOVE.L (A1)+,(A6)+        ; $004964
        MOVE.L (A1)+,(A6)+        ; $004966
        MOVE.L (A1)+,(A6)+        ; $004968
        MOVE.L (A1)+,(A6)+        ; $00496A
        RTS        ; $00496C

; --- Unknown function (possibly coordinate/address calculation) ---
UnknownCalcFunction:
        MOVE.L  D1,-(A7)                ; $00496E: Save D1
        MOVE.L  ($EF00).W,D1            ; $004970: Load from work RAM
        BNE.S   .skip_default           ; $004974: Branch if non-zero
        MOVE.L  #$2A6D365A,D1           ; $004976: Default value
.skip_default:
        MOVE.L  D1,D0                   ; $00497C: Copy to D0
        LSL.L   #2,D1                   ; $00497E: D1 * 4
        ADD.L   D0,D1                   ; $004980: D1 = D1 * 5
        LSL.L   #3,D1                   ; $004982: D1 * 8
        ADD.L   D0,D1                   ; $004984: D1 = D1 * 9 total (*45)
        MOVE.W  D1,D0                   ; $004986: Low word to D0
        SWAP    D1                      ; $004988: Swap D1 halves
        ADD.W   D1,D0                   ; $00498A: Add high word
        MOVE.W  D0,D1                   ; $00498C: Result to D1 low
        SWAP    D1                      ; $00498E: Restore D1
        MOVE.L  D1,($EF00).W            ; $004990: Store result
        MOVE.L  (A7)+,D1                ; $004994: Restore D1
        RTS                             ; $004996
