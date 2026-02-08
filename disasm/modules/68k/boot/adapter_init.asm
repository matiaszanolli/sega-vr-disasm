; ============================================================================
; 32X Adapter Initialization ($000838-$000C59)
; ============================================================================
;
; PURPOSE
; -------
; Initializes the 32X adapter hardware after ROM entry point. This includes:
; - Setting up the adapter control register at $A15100
; - Configuring VDP access mode
; - Establishing communication registers with SH2 processors
; - Setting up interrupt vectors for 32X mode
;
; ENTRY POINT
; -----------
; Called from entry_point ($000200) via JMP $00880838 (after 32X address remap)
;
; HARDWARE REGISTERS USED
; -----------------------
; $A15100 - Adapter control register (FM/CART enable, reset control)
;   Bit 0: FM (enable 32X mode)
;   Bit 1: CART (enable 32X ROM access)
;   Bit 7: ADEN (adapter enable)
;
; $A15104 - Interrupt mask register
; $A1512C - COMM3 (SH2 ready flag)
;
; MEMORY MAPPING
; --------------
; After adapter_init:
;   $000000-$3FFFFF = Cartridge ROM (via 32X)
;   $880000-$8FFFFF = Cartridge ROM (68K direct, same as $000000-$07FFFF)
;   $A00000-$A0FFFF = Z80 area
;   $A10000-$A1001F = I/O ports
;   $A15100-$A1512F = 32X registers
;   $C00000-$C0001F = VDP
;   $FF0000-$FFFFFF = Work RAM
;
; FLOW
; ----
; 1. Check adapter presence (bit test at $A15101)
; 2. If not in 32X mode, loop waiting for FM enable
; 3. Configure VDP for 32X compatibility
; 4. Set up communication registers
; 5. Initialize interrupt vectors
; 6. Jump to main initialization
;
; Dependencies: None (first code to run after reset)
; Related: ROM header ($000100-$0001FF), entry_point ($000200)
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; 32X Adapter registers
ADAPTER_BASE    equ     $A15100 ; Adapter control register base
ADAPTER_CTRL    equ     $A15100 ; Control register
ADAPTER_STATUS  equ     $A15101 ; Status register (read FM bit here)
ADAPTER_BANK    equ     $A1510A ; Bank select register
ADAPTER_BANKDAT equ     $A1510C ; Bank data register
COMM3           equ     $A1512C ; COMM3 - SH2 ready flag

; VDP registers
VDP_CTRL        equ     $C00000 ; VDP control port
VDP_DATA        equ     $C00004 ; VDP data port

; Work RAM locations
VINT_STATE      equ     $C87A   ; V-INT state flag
VINT_FLAG2      equ     $C87C   ; Secondary V-INT flag

; ROM addresses
VDP_INIT_TABLE  equ     $008808EE ; VDP register initialization table

        org     $000838

; ============================================================================
; adapter_init ($000838) - 32X Adapter Hardware Initialization
; Called by: entry_point ($000200) via exception vector
; Parameters: None
; Returns: Never (continues to main init)
; ============================================================================

adapter_init:
        lea     ADAPTER_BASE,a4                 ; $000838: $49F9 $00A1 $5100 - Load adapter base
        btst    #0,$0001(a4)                    ; $00083E: $082C $0000 $0001 - Test FM bit
        beq.w   loc_0009BA                      ; $000844: $6700 $0174       - Not in 32X mode?
        clr.l   VINT_STATE.w                    ; $000848: $42B8 $C87A       - Clear state flags
        lea     VDP_CTRL.w,a0                   ; $00084C: $41F8 $C000       - VDP control base
        move.l  a0,d2                           ; $000850: $2408             - Save for later
        addi.l  #4,d2                           ; $000852: $0682 $0000 $0004 - D2 = $C004 (data port)
        movea.l d0,a0                           ; $000858: $2040             - A0 = VDP control
        movea.l d2,a1                           ; $00085A: $2242             - A1 = VDP data
        movea.w #$FFFE,a0                       ; $00085C: $307C $FFFE       - Stack init
        move.w  #0,VINT_STATE.w                 ; $000860: $33FC $0000 $C87A - State = 0
        move.w  #0,VINT_FLAG2.w                 ; $000866: $33FC $0000 $C87C - Flag2 = 0

; Wait for SH2 ready (polls COMM3 until non-zero)
.wait_sh2_ready:
        tst.b   COMM3-ADAPTER_BASE(a4)          ; $00086C: $4A2C $002C       - COMM3 ready?
        beq.s   .wait_sh2_ready                 ; $000870: $67FA             - Loop if not ready
        clr.b   COMM3-ADAPTER_BASE(a4)          ; $000872: $422C $002C       - Acknowledge

; Initialize async command queue ring buffer (Phase 1)
        bsr.w   ring_buffer_init                ; Initialize ring buffer in SDRAM

; Test async command queue (Phase 1 Step 6 - single test command)
        jsr     test_async_single_cmd           ; Test harness (uses absolute JSR)
        jsr     sh2_wait_queue_empty            ; Wait for command to process

; VDP initialization - load register values from ROM table
        lea     VDP_CTRL,a1                     ; $000876: $43F9 $00C0 $0000 - VDP control
        lea     $0004(a1),a2                    ; $00087C: $45E9 $0004       - VDP data
        lea     VDP_INIT_TABLE,a3               ; $000880: $47F9 $0088 $08EE - Init table
        moveq   #$17,d7                         ; $000886: $7E17             - 24 entries
.vdp_init_loop:
        move.w  (a3)+,(a1)                      ; $000888: $32DB             - Write VDP reg
        dbra    d7,.vdp_init_loop               ; $00088A: $51CF $FFFC       - Loop

; Configure 32X adapter bank registers
; This sets up the ROM banking for 32X mode
        move.b  #$01,ADAPTER_BANK-ADAPTER_BASE(a4) ; $00088E: $197C $0001 $000A - Bank 1
        move.w  $0002(a4),ADAPTER_BANKDAT-ADAPTER_BASE(a4) ; $000894: $396C $0002 $000C
        move.b  #$02,ADAPTER_BANK-ADAPTER_BASE(a4) ; $00089A: $197C $0002 $000A - Bank 2
        move.w  $0002(a4),ADAPTER_BANKDAT-ADAPTER_BASE(a4) ; $0008A0: $396C $0002 $000C
        move.b  #$03,ADAPTER_BANK-ADAPTER_BASE(a4) ; $0008A6: $197C $0003 $000A - Bank 3
        move.w  $0002(a4),ADAPTER_BANKDAT-ADAPTER_BASE(a4) ; $0008AC: $396C $0002 $000C
        move.b  #$00,ADAPTER_BANK-ADAPTER_BASE(a4) ; $0008B2: $197C $0000 $000A - Bank 0
        move.w  $0002(a4),ADAPTER_BANKDAT-ADAPTER_BASE(a4) ; $0008B8: $396C $0002 $000C

; VDP mode configuration
        move.w  #$8000,VDP_DATA.w               ; $0008BE: $33FC $8000 $C004 - VDP flag
        move.w  #$8134,VDP_DATA.w               ; $0008C4: $33FC $8134 $C004 - Mode register
        jsr     $00880C86                       ; $0008CA: $4EB9 $0088 $0C86 - Sub init routine
        clr.w   $00FFC80C                       ; $0008D0: $4279 $00FF $C80C - Clear RAM
        clr.w   $00FFC80E                       ; $0008D6: $4279 $00FF $C80E
        clr.w   $00FFC82A                       ; $0008DC: $4279 $00FF $C82A
        jmp     $00880920                       ; $0008E2: $4EF9 $0088 $0920 - Continue init

; VDP initialization table data (24 register values)
; Format: $8nXX where n = register number, XX = value
vdp_init_data:
        dc.w    $8004,$8134                     ; $0008E8: Mode 1, Mode 2
        dc.w    $8230,$8328                     ; $0008EC: Scroll A, Window
        dc.w    $8407,$8578                     ; $0008F0: Scroll B, Sprite
        dc.w    $8600,$8700                     ; $0008F4: BG color, Mode 3
        dc.w    $8800,$8900                     ; $0008F8: Mode 4, H-Int
        dc.w    $8A00,$8B00                     ; $0008FC: Mode 5, ???
        dc.w    $8C81,$8D3F                     ; $000900: H40 mode, HScroll
        dc.w    $8E00,$8F02                     ; $000904: ???, Auto-inc
        dc.w    $9000,$9100                     ; $000908: Scroll size, Window X
        dc.w    $9200,$93FF                     ; $00090C: Window Y, DMA length L
        dc.w    $9400,$9500                     ; $000910: DMA length H, DMA src L
        dc.w    $9600,$9700                     ; $000914: DMA src M, DMA src H
        dc.w    $0000,$0000                     ; $000918: (padding)
        dc.w    $0000                           ; $00091C

; ============================================================================
; Main initialization continues ($000920)
; ============================================================================

loc_000920:
        move    #$2700,sr                       ; $000920: $46FC $2700       - Disable interrupts
        lea     ADAPTER_BASE,a5                 ; $000924: $4BF9 $00A1 $5100 - Adapter base in A5
        lea     VDP_CTRL,a6                     ; $00092A: $4DF9 $00C0 $0000 - VDP base in A6
.wait_sh2:
        tst.b   COMM3-ADAPTER_BASE(a5)          ; $000930: $4A2D $002C       - SH2 ready?
        beq.s   .wait_sh2                       ; $000934: $67FA             - Loop

; Initialize work RAM ($FFC800-$FFEFFF)
        lea     $00FFC800,a1                    ; $000936: $43F9 $00FF $C800 - Work RAM start
        moveq   #0,d0                           ; $00093C: $7000             - Zero value
        move.w  #$1F3F,d7                       ; $00093E: $3E3C $1F3F       - 8000 longwords
.clear_ram:
        move.l  d0,(a1)+                        ; $000942: $22C0             - Clear 4 bytes
        dbra    d7,.clear_ram                   ; $000944: $51CF $FFFC       - Loop

; System initialization calls
        jsr     $0088170C                       ; $000948: $4EB9 $0088 $170C - controller_port_init
        move.w  #$02,VDP_MODE.w                 ; $00094E: $33FC $0002 $C816 - (approximate)
        move.w  #$01,VDP_MODE2.w                ; $000954: $33FC $0001 $C818
        jsr     $008818D8                       ; $00095A: $4EB9 $0088 $18D8 - io_port_init
        jsr     $00880F12                       ; $000960: $4EB9 $0088 $0F12 - VDP setup
        move.w  #$8174,VDP_DATA.w               ; $000966: $33FC $8174 $C004 - VDP mode
        jsr     $00880FEA                       ; $00096C: $4EB9 $0088 $0FEA - z80_bus_vdp_init
        move.w  #$8134,VDP_DATA.w               ; $000972: $33FC $8134 $C004 - VDP mode

; Sound and final init
        jsr     $008814BE                       ; $000978: $4EB9 $0088 $14BE - fm_write
        jsr     $0088091E                       ; $00097E: $4EB9 $0088 $091E - Additional init
        move.w  #$4000,VDP_DATA.w               ; $000984: $33FC $4000 $C004 - VDP control
        move.w  #$0002,$C00C.w                  ; $00098A: $33FC $0002 $C00C - VDP test reg

; Enable interrupts and enter main polling loop
        move    #$2300,sr                       ; $000990: $46FC $2300       - Enable V-INT
        move.w  #$01,VINT_STATE.w               ; $000994: $33FC $0001 $C87A - Start state machine
.main_loop:
        tst.w   VINT_STATE.w                    ; $00099A: $4A78 $C87A       - Work pending?
        beq.s   .main_loop                      ; $00099E: $67FA             - Wait for V-INT
        jsr     $00880DA2                       ; $0009A0: $4EB9 $0088 $0DA2 - Main game work
        bra.s   .main_loop                      ; $0009A6: $60F4             - Forever

; Placeholder for non-32X mode handler
loc_0009BA:
        ; (Handles case when FM bit not set - loops or resets)
        rts

; Additional constants
VDP_MODE        equ     $C816   ; VDP mode storage
VDP_MODE2       equ     $C818   ; Secondary mode storage

; ============================================================================
; Ring Buffer Initialization (Phase 1 - Async Command Queue)
; ============================================================================
        include "modules/68k/boot/ring_buffer_init.asm"

; ============================================================================
; End of adapter_init module
; Note: Addresses $0009A8-$000C59 contain additional initialization code
; including save_all_registers ($000C5A) documented in function reference.
; ============================================================================
