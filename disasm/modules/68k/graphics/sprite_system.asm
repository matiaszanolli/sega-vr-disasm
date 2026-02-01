; ============================================================================
; Sprite System Functions ($006C46 - $006D40)
; ============================================================================
;
; PURPOSE
; -------
; Sprite table initialization and management. Creates the sprite attribute
; table structure in work RAM from ROM templates.
;
; SPRITE TABLE STRUCTURE
; ----------------------
; Work RAM at $FF3000+:
; | Address    | Purpose                              |
; |------------|--------------------------------------|
; | $FF3000    | Sprite system initialized flag       |
; | $FF3002    | Sprite attribute pointers (6 entries)|
; | $FF301A    | Sprite chain pointers                |
; | $FF304A    | Sprite data storage                  |
;
; ROM DATA
; --------
; Sprite templates at $0089B844 contain predefined sprite configurations.
;
; Dependencies: Memory cleared before init
; Related: VDP operations
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Work RAM sprite addresses
SPRITE_FLAG     equ     $FF3000     ; Initialization flag
SPRITE_ATTR     equ     $FF3002     ; Attribute table base
SPRITE_CHAIN    equ     $FF301A     ; Chain pointer table
SPRITE_DATA     equ     $FF304A     ; Sprite data storage

; ROM sprite template
SPRITE_ROM_DATA equ     $0089B844   ; Sprite template in ROM

        org     $006C46

; ============================================================================
; sprite_table_init ($006C46) - Initialize Sprite Table from ROM
; Called by: Game initialization
; Parameters: None
; Returns: Populates sprite tables in work RAM
;
; Creates 6 sprite chains, each with data copied from ROM templates.
; Uses FastCopy16 ($004922) for efficient copying.
; ============================================================================

sprite_table_init:
        move.l  a4,-(sp)                        ; $006C46: $2F0C       - Save A4
        move.w  #$0001,SPRITE_FLAG              ; $006C48: $33FC $0001 $00FF $3000 - Set flag
        lea     SPRITE_ROM_DATA,a1              ; $006C50: $43F9 $0089 $B844 - ROM source
        lea     SPRITE_DATA,a2                  ; $006C56: $45F9 $00FF $304A - RAM dest
        lea     SPRITE_CHAIN,a3                 ; $006C5C: $47F9 $00FF $301A - Chain table
        lea     SPRITE_ATTR,a4                  ; $006C62: $49F9 $00FF $3002 - Attr table
        moveq   #5,d5                           ; $006C68: $7A05       - 6 sprites (0-5)
        moveq   #1,d6                           ; $006C6A: $7C01       - 2 chains per sprite
.sprite_loop:
        move.l  a2,(a3)+                        ; $006C6C: $26CA       - Store chain pointer
        move.w  (a1),d7                         ; $006C6E: $3E11       - Get count
.copy_chain:
        move.w  (a1)+,(a2)+                     ; $006C70: $34D9       - Copy word
        jsr     FastCopy16(pc)                  ; $006C72: $4EBA $DCAE - Copy 16 bytes
        dbra    d7,.copy_chain                  ; $006C76: $51CF $FFFA - Loop count
        dbra    d6,.sprite_loop                 ; $006C7A: $51CE $FFF0 - Next chain
        move.l  a2,(a4)+                        ; $006C7E: $28CA       - Store attr pointer
        dbra    d5,.sprite_loop-6               ; $006C80: $51CD $FFE8 - Next sprite
        movea.l (sp)+,a4                        ; $006C84: $285F       - Restore A4
        rts                                     ; $006C86: $4E75

; ============================================================================
; sprite_table_check ($006C88) - Check/Init Sprite Table
; Called by: Various graphics functions
; Parameters: None
; Returns: Ensures sprite table is initialized, handles input for modes
;
; If sprite system not initialized, calls sprite_table_init.
; Then processes controller input to determine display mode.
; ============================================================================

        org     $006C88

sprite_table_check:
        tst.w   SPRITE_FLAG                     ; $006C88: $4A79 $00FF $3000 - Check flag
        bne.s   .initialized                    ; $006C8E: $6604       - Skip if done
        jsr     sprite_table_init(pc)           ; $006C90: $4EBA $FFB4 - Initialize
.initialized:
        move.b  CTRL_STATE2.w,d1                ; $006C94: $1238 $C86E - Get controller 2
        moveq   #$30,d0                         ; $006C98: $7030       - Default mode
        btst    #6,d1                           ; $006C9A: $0801 $0006 - Check button A
        bne.s   .check_next                     ; $006C9E: $6602       - Skip if pressed
        moveq   #$08,d0                         ; $006CA0: $7008       - Alternate mode
.check_next:
        btst    #2,d1                           ; $006CA2: $0801 $0002 - Check button B
        bne.w   .mode_b                         ; $006CA6: $6600 $0090 - Handle mode B
        btst    #3,d1                           ; $006CAA: $0801 $0003 - Check button C
        bne.w   .mode_c                         ; $006CAE: $6600 $008E - Handle mode C
        ; Continue with default processing...
        rts                                     ; (placeholder)

.mode_b:
        ; Mode B handler at $006D38
        rts

.mode_c:
        ; Mode C handler at $006D3E
        rts

; Reference to FastCopy16
FastCopy16      equ     $004922

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function          | Address | Purpose
; ------------------+---------+----------------------------------------
; sprite_table_init | $006C46 | Create sprite tables from ROM template
; sprite_table_check| $006C88 | Ensure init + handle input modes
;
; Memory Usage:
;   $FF3000-$FF3001: Initialization flag
;   $FF3002-$FF3019: Sprite attribute pointers (6 × 4 bytes)
;   $FF301A-$FF3049: Sprite chain pointers
;   $FF304A+:        Sprite data storage
;
; ============================================================================
