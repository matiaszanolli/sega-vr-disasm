; ============================================================================
; Camera Demo Palette + SH2 Setup
; ROM Range: $012A72-$012BFA (392 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer, palette setup, SH2 object configuration.
;   Decrements rotation counter ($A036) and applies angular offset ($A038).
;   Loads palette from ROM table indexed by $A019 (×4 for pointer, ×16 for data).
;   Configures SH2 objects at $FF6100 with camera/position parameters.
;   For mode 5 ($A019=5), enables special flag $FF60D4.
;   Sends camera data via COMM0/COMM1 to SH2, then reads back $82 words
;   from adapter register $A15112. Updates circular buffer at $A014.
;
; Uses: D0, D1, D7, A0, A1, A2
; RAM:
;   $A014: circular buffer offset (long)
;   $A019: palette/mode index (byte)
;   $A020: cursor/animation data (long)
;   $A022: display scroll position (word)
;   $A024: velocity/speed value (long)
;   $A028: deceleration counter (word)
;   $A02C: SH2 object flags (word)
;   $A02E: SH2 object param A (word)
;   $A030: SH2 object param B (word)
;   $A032: SH2 object param C (word)
;   $A034: SH2 object param D (word)
;   $A036: rotation counter (word)
;   $A038: angular offset (word)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E52C: dma_transfer
; ============================================================================

camera_demo_palette_sh2_setup:
        clr.w   D0                              ; $012A72  mode = 0
        dc.w    $6100,$BAB6                     ; $012A74  bsr.w dma_transfer ($00E52C)
        subq.w  #1,($FFFFA036).w                ; $012A78  decrement rotation counter
        bcc.w   .load_palette                   ; $012A7C  no underflow → continue
        move.w  #$0001,($FFFFA036).w            ; $012A80  reset counter
        subi.w  #$0080,($FFFFA038).w            ; $012A86  reduce angular offset
        andi.w  #$1FFF,($FFFFA038).w            ; $012A8C  mask to 13 bits
.load_palette:
        lea     $00FF6E00,A0                    ; $012A92  A0 = CRAM base
        lea     $00892C72,A1                    ; $012A98  A1 = palette pointer table
        clr.w   D0                              ; $012A9E
        move.b  ($FFFFA019).w,D0                ; $012AA0  D0 = palette index
        dc.w    $D040                           ; $012AA4  add.w d0,d0 — D0 × 2
        dc.w    $D040                           ; $012AA6  add.w d0,d0 — D0 × 4
        movea.l $00(A1,D0.W),A1                 ; $012AA8  A1 = palette data pointer
        move.w  #$007F,D0                       ; $012AAC  copy 128 entries
.copy_palette:
        move.w  (A1)+,(A0)+                     ; $012AB0  copy entry
        dbra    D0,.copy_palette                ; $012AB2
        lea     $00892C12,A0                    ; $012AB6  A0 = SH2 param table
        lea     ($FFFFA02C).w,A1                ; $012ABC  A1 = SH2 object params
        clr.l   D0                              ; $012AC0
        move.b  ($FFFFA019).w,D0                ; $012AC2  D0 = mode index
        lsl.w   #4,D0                           ; $012AC6  D0 × 16
        adda.l  D0,A0                           ; $012AC8  A0 += mode offset
        move.w  #$0004,D1                       ; $012ACA  copy 5 words
.copy_params:
        move.w  (A0)+,(A1)+                     ; $012ACE  copy param
        dbra    D1,.copy_params                 ; $012AD0
        move.b  #$00,$00FF60D4                  ; $012AD4  clear special flag
        lea     $00FF6100,A1                    ; $012ADC  A1 = SH2 object base
        move.w  #$0001,$0000(A1)                ; $012AE2  enable object
        move.w  ($FFFFA02C).w,$0002(A1)         ; $012AE8  flags
        move.w  ($FFFFA02E).w,$0004(A1)         ; $012AEE  param A → velocity
        move.w  ($FFFFA030).w,$0006(A1)         ; $012AF4  param B → speed
        move.l  ($FFFFA014).w,D0                ; $012AFA  D0 = buffer offset
        move.w  D0,$000A(A1)                    ; $012AFE  → object field $0A
        move.w  ($FFFFA032).w,$0008(A1)         ; $012B02  param C
        move.w  ($FFFFA034).w,$000C(A1)         ; $012B08  param D
        move.w  #$0000,$000E(A1)                ; $012B0E  clear field $0E
        lea     $00892BFA,A0                    ; $012B14  A0 = handler table
        clr.w   D1                              ; $012B1A
        move.b  ($FFFFA019).w,D1                ; $012B1C  D1 = mode index
        cmpi.b  #$05,D1                         ; $012B20  mode 5?
        bne.s   .set_handler                    ; $012B24  no → normal
        move.b  #$01,$00FF60D4                  ; $012B26  enable special flag
.set_handler:
        dc.w    $D241                           ; $012B2E  add.w d1,d1 — D1 × 2
        dc.w    $D241                           ; $012B30  add.w d1,d1 — D1 × 4
        move.l  $00(A0,D1.W),$0010(A1)          ; $012B32  handler = table[mode]
        adda.l  #$00000014,A1                   ; $012B38  A1 += $14 (next object)
        move.w  #$0000,$0000(A1)                ; $012B3E  disable second object
        cmpi.b  #$01,($FFFFA019).w              ; $012B44  mode 1?
        bne.s   .send_comm                      ; $012B4A  no → send COMM
        move.w  #$0001,$0000(A1)                ; $012B4C  enable second object
        move.w  ($FFFFA038).w,$000A(A1)         ; $012B52  angular offset → $0A
        move.w  #$0000,$000E(A1)                ; $012B58  clear field $0E
        move.l  #$222B90F8,$0010(A1)            ; $012B5E  handler = $222B90F8
.send_comm:
        move.w  #$0041,$00A15110                ; $012B66  adapter register
        move.b  #$04,$00A15107                  ; $012B6E  set transfer mode
        clr.b   COMM1_LO                        ; $012B76  clear COMM1 low
        move.b  #$2B,COMM0_LO                   ; $012B7C  cmd = $2B
        move.b  #$01,COMM0_HI                   ; $012B84  trigger command
.wait_ack:
        btst    #1,COMM1_LO                    ; $012B8C  SH2 acknowledged?
        beq.s   .wait_ack                       ; $012B94  no → wait
        bclr    #1,COMM1_LO                    ; $012B96  clear ack bit
        lea     $00FF60C8,A1                    ; $012B9E  A1 = camera data dest
        lea     $00A15112,A2                    ; $012BA4  A2 = adapter data register
        move.w  #$0040,D7                       ; $012BAA  read 65 words
.read_data:
        btst    #7,$00A15107                    ; $012BAE  FIFO ready?
        bne.s   .read_data                      ; $012BB6  no → wait
        move.w  (A1)+,(A2)                      ; $012BB8  write to adapter
        dbra    D7,.read_data                   ; $012BBA
        move.l  ($FFFFA014).w,D0                ; $012BBE  D0 = buffer offset
        addi.l  #$00000080,D0                   ; $012BC2  advance by $80
        andi.l  #$0000FFFF,D0                   ; $012BC8  mask to 16 bits
        move.l  D0,($FFFFA014).w                ; $012BCE  store new offset
        clr.l   D0                              ; $012BD2
        add.l   ($FFFFA024).w,D0                ; $012BD4  D0 = velocity
        add.l   D0,($FFFFA020).w                ; $012BD8  update position
        subq.w  #4,($FFFFA028).w                ; $012BDC  decrement decel counter
        bcc.w   .advance_state                  ; $012BE0  still running → advance
        move.l  #$00000000,($FFFFA024).w        ; $012BE4  clear velocity (stopped)
.advance_state:
        addq.w  #4,($FFFFC87E).w                ; $012BEC  advance game_state
        move.w  #$0020,$00FF0008                ; $012BF0  display mode = $0020
        rts                                     ; $012BF8
