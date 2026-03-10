; ============================================================================
; tile_block_dma_setup — Tile Block DMA Setup
; ROM Range: $006C46-$006C88 (66 bytes)
; Sets up tile block data for DMA transfers. Initializes 6 groups of tile
; block entries, reading source sizes from ROM table at $89B844, writing
; destination pointers to $FF3000 region, and calling FastCopy16 for each
; tile row. Used during scene setup for background tile loading.
;
; Entry: Called during scene initialization
; Uses: D5, D6, D7, A1, A2, A3, A4
; Confidence: high
; ============================================================================

tile_block_dma_setup:
        MOVE.L  A4,-(A7)                        ; $006C46
        MOVE.W  #$0001,$00FF3000                ; $006C48
        LEA     $0089B844,A1                    ; $006C50
        LEA     $00FF304A,A2                    ; $006C56
        LEA     $00FF301A,A3                    ; $006C5C
        LEA     $00FF3002,A4                    ; $006C62
        MOVEQ   #$05,D5                         ; $006C68
.group_loop:
        MOVEQ   #$01,D6                         ; $006C6A
.row_loop:
        MOVE.L  A2,(A3)+                        ; $006C6C
        MOVE.W  (A1),D7                         ; $006C6E
        MOVE.W  (A1)+,(A2)+                     ; $006C70
.copy_row_loop:
        jsr     triple_memory_copy+88(pc); $4EBA $DCAE
        DBRA    D7,.copy_row_loop                    ; $006C76
        DBRA    D6,.row_loop                    ; $006C7A
        MOVE.L  A2,(A4)+                        ; $006C7E
        DBRA    D5,.group_loop                    ; $006C80
        MOVEA.L (A7)+,A4                        ; $006C84
        RTS                                     ; $006C86
