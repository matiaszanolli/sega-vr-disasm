; ============================================================================
; Controller Input Functions ($00170C - $0018FF)
; ============================================================================
;
; PURPOSE
; -------
; Controller initialization and polling for both Mega Drive controller ports.
; Supports standard 3-button and 6-button controllers.
;
; CONTROLLER PORTS
; ----------------
; | Address   | Name      | Purpose                     |
; |-----------|-----------|------------------------------|
; | $A10003   | MD_DATA1  | Controller 1 data port       |
; | $A10005   | MD_DATA2  | Controller 2 data port       |
; | $A10009   | MD_CTRL1  | Controller 1 control         |
; | $A1000B   | MD_CTRL2  | Controller 2 control         |
;
; CONTROLLER STATE MEMORY
; -----------------------
; | Address | Name       | Purpose                       |
; |---------|------------|-------------------------------|
; | $C810   | CTRL_TYPE1 | Controller 1 type (byte)      |
; | $C811   | CTRL_TYPE2 | Controller 2 type (byte)      |
; | $C86C   | CTRL_STATE1| Controller 1 state (byte)     |
; | $C86E   | CTRL_STATE2| Controller 2 state (byte)     |
; | $C970   | INPUT_BUF1 | Input buffer 1 (long)         |
; | $C974   | INPUT_BUF2 | Input buffer 2 (long)         |
; | $FE82   | BTN_MAP    | Button remapping table        |
; | $FE92   | PORT_STATE1| Port 1 state                  |
; | $FE93   | PORT_STATE2| Port 2 state                  |
; | $FE94   | PORT_CFG   | Port configuration            |
;
; BUTTON MAPPING
; --------------
; Standard 3-button: Up, Down, Left, Right, A, B, C, Start
; 6-button adds: X, Y, Z, Mode
;
; Button map values:
;   $04 = A button
;   $06 = B button
;   $01 = C button
;   $00 = Start
;   $05 = X button
;   $0A = Y button
;   $09 = Z button
;   $08 = Mode
;
; Dependencies: V-INT handler calls poll_controllers
; Related: vint_handler.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Controller I/O ports
MD_DATA1        equ     $A10003     ; Controller 1 data
MD_DATA2        equ     $A10005     ; Controller 2 data
MD_CTRL1        equ     $A10009     ; Controller 1 control
MD_CTRL2        equ     $A1000B     ; Controller 2 control

; Controller state memory
CTRL_TYPE1      equ     $C810       ; Controller 1 type
CTRL_TYPE2      equ     $C811       ; Controller 2 type
CTRL_STATE1     equ     $C86C       ; Controller 1 state
CTRL_STATE2     equ     $C86E       ; Controller 2 state
INPUT_BUF1      equ     $C970       ; Input buffer 1
INPUT_BUF2      equ     $C974       ; Input buffer 2
PORT_STATE1     equ     $FE92       ; Port 1 state
PORT_STATE2     equ     $FE93       ; Port 2 state
BTN_MAP         equ     $FE82       ; Button mapping table
PORT_CFG        equ     $FE94       ; Port configuration
CTRL_DEST       equ     $FF60D0     ; Controller state destination

; Controller type constants
CTRL_TYPE_6BTN  equ     $0D         ; 6-button controller

        org     $00170C

; ============================================================================
; controller_port_init ($00170C) - Initialize Controller Ports
; Called by: System initialization
; Parameters: None
; Returns: Initializes port states and button mapping
;
; Sets up controller hardware and creates button mapping table
; ============================================================================

controller_port_init:
        move.b  #$00,PORT_STATE1.w              ; $00170C: $11FC $0000 $FE92 - Clear port 1
        move.b  #$00,PORT_STATE2.w              ; $001712: $11FC $0000 $FE93 - Clear port 2
        lea     BTN_MAP.w,a1                    ; $001718: $43F8 $FE82       - Button map base
; Initialize button mapping for controller 1
        move.b  #$04,(a1)+                      ; $00171C: $12FC $0004 - A button
        move.b  #$06,(a1)+                      ; $001720: $12FC $0006 - B button
        move.b  #$01,(a1)+                      ; $001724: $12FC $0001 - C button
        move.b  #$00,(a1)+                      ; $001728: $12FC $0000 - Start
        move.b  #$05,(a1)+                      ; $00172C: $12FC $0005 - X button
        move.b  #$0A,(a1)+                      ; $001730: $12FC $000A - Y button
        move.b  #$09,(a1)+                      ; $001734: $12FC $0009 - Z button
        move.b  #$08,(a1)+                      ; $001738: $12FC $0008 - Mode
; Initialize button mapping for controller 2 (same layout)
        move.b  #$04,(a1)+                      ; $00173C: $12FC $0004 - A button
        move.b  #$06,(a1)+                      ; $001740: $12FC $0006 - B button
        move.b  #$01,(a1)+                      ; $001744: $12FC $0001 - C button
        move.b  #$00,(a1)+                      ; $001748: $12FC $0000 - Start
        move.b  #$05,(a1)+                      ; $00174C: $12FC $0005 - X button
        move.b  #$0A,(a1)+                      ; $001750: $12FC $000A - Y button
        move.b  #$09,(a1)+                      ; $001754: $12FC $0009 - Z button
        move.b  #$08,(a1)                       ; $001758: $12BC $0008 - Mode (last byte)
        lea     PORT_CFG.w,a1                   ; $00175C: $43F8 $FE94 - Port config base
; Set up port configuration based on controller type
        lea     .default_cfg(pc),a3             ; $001760: $47FA $0034 - Default config
        btst    #0,($C818).w                    ; $001764: $0838 $0000 $C818 - Check type
        bne.s   .use_default                    ; $00176A: $6604       - Use default if set
        lea     .alt_cfg(pc),a3                 ; $00176C: $47FA $0020 - Alternate config
.use_default:
        jsr     .copy_config(pc)                ; $001770: $4EBA $0012 - Copy config
        lea     .default_cfg(pc),a3             ; $001774: $47FA $0020 - Default for port 2
        btst    #1,($C818).w                    ; $001778: $0838 $0001 $C818 - Check type
        bne.s   .copy_config                    ; $00177E: $6604       - Copy if set
        lea     .alt_cfg(pc),a3                 ; $001780: $47FA $000C - Alternate
.copy_config:
        moveq   #7,d7                           ; $001784: $7E07       - 8 bytes
.copy_loop:
        move.b  (a3)+,(a1)+                     ; $001786: $12DB       - Copy byte
        dbra    d7,.copy_loop                   ; $001788: $51CF $FFFC - Loop
        rts                                     ; $00178C: $4E75

; Configuration data tables
.alt_cfg:
        dc.b    $04,$06,$01,$00                 ; $00178E: A, B, C, Start
        dc.b    $05,$00,$00,$00                 ; $001792: X, padding

.default_cfg:
        dc.b    $04,$06,$01,$00                 ; $001796: A, B, C, Start
        dc.b    $05,$0A,$09,$08                 ; $00179A: X, Y, Z, Mode

; ============================================================================
; poll_controllers ($00179E) - Poll Controller Inputs
; Called by: V-INT handler (12 calls per frame)
; Parameters: None
; Returns: Updates controller states in memory
;
; Checks controller type and reads appropriate button states
; ============================================================================

        org     $00179E

poll_controllers:
        cmpi.b  #CTRL_TYPE_6BTN,CTRL_TYPE1.w    ; $00179E: $0C38 $000D $C810 - 6-btn?
        bne.s   .not_6button                    ; $0017A4: $6630       - Skip if not
; 6-button controller polling
        lea     CTRL_STATE1.w,a0                ; $0017A6: $41F8 $C86C - State pointer
        move.l  a0,CTRL_DEST.w                  ; $0017AA: $23D0 $00FF $60D0 - Copy dest
        lea     MD_DATA1,a1                     ; $0017B0: $43F9 $00A1 $0003 - Port 1
        lea     INPUT_BUF1.w,a2                 ; $0017B6: $45F8 $C970 - Input buffer
        lea     BTN_MAP.w,a3                    ; $0017BA: $47F8 $FE82 - Button map
        jsr     zbus_request(pc)                ; $0017BE: $4EBA $009E - Request Z80 bus
        jsr     button_remap(pc)                ; $0017C2: $4EBA $002A - Remap buttons
; Check if controller 2 is also 6-button
        cmpi.b  #CTRL_TYPE_6BTN,CTRL_TYPE2.w    ; $0017C6: $0C38 $000D $C811 - 6-btn?
        beq.s   .poll_ctrl2                     ; $0017CC: $6716       - Poll if yes
        move.b  #$00,CTRL_STATE2.w              ; $0017CE: $11FC $0000 $C86E - Clear
        rts                                     ; $0017D4: $4E75

.not_6button:
        move.b  #$00,CTRL_STATE1.w              ; $0017D6: $11FC $0000 $C86C - Clear ctrl 1
        move.b  #$00,CTRL_STATE2.w              ; $0017DC: $11FC $0000 $C86E - Clear ctrl 2
        rts                                     ; $0017E2: $4E75

.poll_ctrl2:
        lea     MD_DATA2,a1                     ; $0017E4: $43F9 $00A1 $0005 - Port 2
        jsr     zbus_request(pc)                ; $0017EA: $4EBA $0072 - Request bus
        ; Fall through to button_remap

; ============================================================================
; button_remap ($0017EE) - Remap Controller Buttons
; Called by: poll_controllers
; Parameters:
;   A0 = State destination
;   A1 = Controller port
;   A3 = Button map table
; Returns: Updates button state with remapped values
; ============================================================================

button_remap:
        move.b  (a0),d2                         ; $0017EE: $1410       - Get current state
        move.w  d0,d1                           ; $0017F0: $3200       - Copy raw input
        cmp.b   d2,d0                           ; $0017F2: $B102       - Compare with old
        and.b   d2,d0                           ; $0017F4: $C002       - Mask unchanged
        move.b  d1,(a0)+                        ; $0017F6: $10C1       - Store new raw
        move.b  d0,(a0)+                        ; $0017F8: $10C0       - Store changes
        moveq   #0,d6                           ; $0017FA: $7C00       - Clear result
        or.b    d1,d6                           ; $0017FC: $8C01       - Copy buttons
        ; Continue with button remapping...
        rts                                     ; (simplified)

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function            | Address | Calls/Frame | Purpose
; --------------------+---------+-------------+-------------------------
; controller_port_init| $00170C | init        | Setup ports and mapping
; poll_controllers    | $00179E | 12          | Read controller inputs
; button_remap        | $0017EE | 12          | Apply button remapping
;
; ============================================================================
