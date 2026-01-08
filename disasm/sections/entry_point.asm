; ============================================================================
; EntryPoint ($03F0-$0831)
; ============================================================================
; Main 68K program entry point. Performs MARS adapter detection, Z80/PSG
; initialization, VDP setup, security handshake, and jumps to main code.
;
; Key functions:
;   $3F0: EntryPoint - Initial PC target, MARS detection
;   $4C0: RAM_InitCode - Copied to work RAM, enables ADEN
;   $4D4: VDP_InitTable - VDP register data
;   $4E8: Z80_InitData - Z80 boot code + PSG silence
;   $512: SecurityStrings - MARS security strings
;   $5A6: InitVDPRegs - VDP register init function
;   $5CE: ClearVDPRAM - Clear VDP memory function
;   $654: Init32XVDP - 32X VDP mode setup
;   $694: ClearFrameBuffer - Clear 32X frame buffer
;   $6BC: ClearWorkRAM - Clear 64KB work RAM
;   $6E4: SecurityLoop - Security delay loop
;   $6E8: MARSRegInit - MARS register initialization
;   $7EC: ErrorPath1 - Error handler path
;   $7FC: ErrorPath2 - Error handler path
; ============================================================================

        org     $0003F0

; ============================================================================
; EntryPoint - MARS Initial Entry Point
; ============================================================================
; Initial PC address (0x880000) for 68K CPU boot. Performs MARS signature
; verification, Z80/PSG initialization, VDP setup, and jumps to work RAM code.
;
; Entry: Called immediately upon 68K reset with PC = $880000
;
; Tasks:
;   1. Detect MARS adapter (signature check: "MARS")
;   2. Wait for MARS ready signal
;   3. Initialize Z80 and PSG (silence all sound)
;   4. Initialize VDP registers
;   5. Copy init code to work RAM ($FF0000)
;   6. Jump to work RAM code to continue boot
;
; MARS Registers Used:
;   $00A10000 - MARS base address
;   $00A15128 - Initialize register
;   $5101(A5) - Status register (bits 7, 0)
;
; Notes:
;   - Waits in loop for MARS status bit 7
;   - Copies Z80 code and PSG commands via COMM interface
;   - Calls InitVDPRegs and ClearVDPRAM routines
;   - Z80 init code and PSG data comes from ROM at $4E8
;   - Final JMP to work RAM starts execution
; ============================================================================
EntryPoint:
        movea.l #$FFFFFFC0,a4            ; 008803F0: Load offset into A4
        move.l  #$00000000,($00A15128).l ; 008803F6: Initialize MARS
        move.w  #$2700,sr                ; 00880400: Disable all interrupts
        lea     ($00A10000).l,a5         ; 00880404: Load MARS base
        moveq   #$01,d0                  ; 0088040A: Set D0 = 1
        cmpi.l  #$4D415253,($30EC,a5)    ; 0088040C: Check MARS signature
        bne.w   .error_mars              ; 00880414: Branch if not MARS
.wait_ready:
        btst    #$07,($5101,a5)          ; 00880418: Test MARS ready bit
        beq.s   .wait_ready              ; 0088041E: Wait if not ready
.check_status:
        tst.l   ($0008,a5)               ; 00880420: Check status
        beq.s   .check_ok                ; 00880424: Branch if okay
        tst.l   ($000C,a5)               ; 00880426: Check second status
        beq.s   .check_ok                ; 0088042A: Branch if okay
        btst    #$00,($5101,a5)          ; 0088042C: Test ready bit 0
        bne.w   .error_ready             ; 00880432: Branch if not set
.check_ok:
        move.b  ($0001,a5),d1            ; 00880436: Read status byte
        andi.b  #$000F,d1                ; 0088043A: Mask lower nibble
        beq.s   .init_vdp                ; 0088043E: Branch if zero
        move.l  d1,($055A).w             ; 00880440: Store to RAM
        clr.w   d0                       ; 00880444: Clear D0
.init_vdp:
        moveq   #$00,d1                  ; 00880446: Clear D1
        move.l  a1,d3                    ; 00880448: Copy A1
        movem.l a0-a0,a4                 ; 0088044A: Save A4
        lea     ($000004D4).l,a0         ; 0088044C: Load init table
        bsr.w   InitVDPRegs              ; 00880452: Call init
        bsr.w   ClearVDPRAM              ; 00880456: Clear VRAM
        lea     ($000004E8).l,a3         ; 0088045A: Load Z80 code
        lea     ($00A00000).l,a1         ; 00880460: SH2 address
        lea     ($00C00011).l,a2         ; 00880466: PSG address
.z80_init_loop:
        move.w  #$0100,d7                ; 0088046C: Loop counter
        moveq   #$00,d0                  ; 00880470: Clear D0
        move.l  (a3)+,a1                 ; 00880472: Read from ROM
        move.l  (a3)+,a2                 ; 00880476: Read from ROM
        move.b  (a3)+,a1                 ; 0088047A: Write to interface
        bne.s   .z80_init_loop           ; 0088047E: Loop if not done
        moveq   #$25,d2                  ; 00880480: Init loop = 37
        move.b  (a3)+,(a1)+              ; 00880482: Copy Z80 byte
        dbra    d2,.z80_init_loop        ; 00880484: DBRA loop
.psg_init:
        move.l  (a1)+,a2                 ; 00880488: Load PSG address
        move.l  (a1)+,a3                 ; 0088048C: Load PSG address
        move.l  (a3)+,a2                 ; 00880490: Load PSG address
        move.b  (a3)+,(a2)               ; 00880494: PSG silence
        move.b  (a3)+,(a2)               ; 00880496: PSG silence
        move.b  (a3)+,(a2)               ; 00880498: PSG silence
        move.b  (a3)+,(a2)               ; 0088049A: PSG silence
.copy_to_ram:
        lea     ($000004C0).l,a0         ; 0088049C: Load RAM init code
        lea     ($00FF0000).l,a1         ; 008804A2: Load work RAM
        move.l  (a0)+,(a1)+              ; 008804A8: Copy longword
        move.l  (a0)+,(a1)+              ; 008804AA: Copy longword
        move.l  (a0)+,(a1)+              ; 008804AC: Copy longword
        move.l  (a0)+,(a1)+              ; 008804AE: Copy longword
        move.l  (a0)+,(a1)+              ; 008804B0: Copy longword
        move.l  (a0)+,(a1)+              ; 008804B2: Copy longword
        move.l  (a0)+,(a1)+              ; 008804B4: Copy longword
        move.l  (a0)+,(a1)+              ; 008804B6: Copy longword
        lea     ($00FF0000).l,a0         ; 008804B8: Jump target address
        jmp     (a0)                     ; 008804BE: Jump to work RAM
.error_mars:
        nop                              ; Error: No MARS adapter
.error_ready:
        nop                              ; Error: MARS not ready

; ============================================================================
; RAM_InitCode - Work RAM Initialization Code
; ============================================================================
; Code copied from ROM to work RAM ($FF0000) during EntryPoint boot.
; Enables ADEN (32X adapter) and jumps to main code at $6BC.
;
; Location: Copied to $00FF0000 by EntryPoint
; Used by: EntryPoint initialization
; ============================================================================
RAM_InitCode:
        move.b  #$01,($5101).w           ; 008804C0: Enable 32X ADEN
        lea     ($000006BC).l,a0         ; 008804C6: Load main code address
        add.l   #$00880000,d0            ; 008804CC: Add ROM base offset
        jmp     (a0)                     ; 008804D2: Jump to main code

; ============================================================================
; VDP_InitTable - VDP Register Initialization Data
; ============================================================================
; 19 bytes of VDP register configuration data for Genesis video setup.
; Loaded by InitVDPRegs during boot sequence.
;
; Register values for standard Genesis VDP mode (240-line, standard colors)
; ============================================================================
VDP_InitTable:
        dc.w    $0404                    ; 008804D4: VDP mode 1/2 setup
        dc.w    $303C                    ; 008804D6: Pattern table config
        dc.w    $076C                    ; 008804D8: Sprite attr table
        dc.w    $0000                    ; 008804DA: HScroll table
        dc.w    $0000                    ; 008804DC: Window V position
        dc.w    $FF00                    ; 008804DE: VScroll mode, DMA fill
        dc.w    $8137                    ; 008804E0: Display enable, hints
        dc.w    $0002                    ; 008804E2: V28/H40 cell mode
        dc.w    $0100                    ; 008804E4: Horizontal scroll mode
        dc.w    $0000                    ; 008804E6: Window H position

; ============================================================================
; Z80_InitData - Z80 Boot Code + PSG Silence Commands
; ============================================================================
; Z80 CPU initialization code (Z80 ASM opcodes) and PSG register silence.
; Loaded by EntryPoint into Z80 memory space via SH2 interface.
;
; Z80 code initializes Z80 RAM and disables PSG sound output.
; PSG commands follow Z80 init code to silence the FM chip.
; ============================================================================
Z80_InitData:
        dc.w    $AF01                    ; 008804E8: Z80: XOR A / DEC BC
        dc.w    $D91F                    ; 008804EA: Z80: PUSH DE / RRA
        dc.w    $1127                    ; 008804EC: Z80: DEC BC / DCX D
        dc.w    $0021                    ; 008804EE: Z80: NOP / LD HL
        dc.w    $2600                    ; 008804F0: Z80: INC H / LD B
        dc.w    $F977                    ; 008804F2: Z80: LD A,(HL+) / JP Z
        dc.w    $EDB0                    ; 008804F4: Z80: LDIR / NOP
        dc.w    $DDE1                    ; 008804F6: Z80: PUSH IX / POP HL
        dc.w    $FDE1                    ; 008804F8: Z80: PUSH IY / POP HL
        dc.w    $ED47                    ; 008804FA: Z80: LD I,A / NOP
        dc.w    $ED4F                    ; 008804FC: Z80: LD R,A / NOP
        dc.w    $D1E1                    ; 008804FE: Z80: POP DE / POP HL
        dc.w    $F108                    ; 00880500: Z80: RET CC / ADD A
        dc.w    $D9C1                    ; 00880502: Z80: EXX / POP BC
        dc.w    $D1E1                    ; 00880504: Z80: POP DE / POP HL
        dc.w    $F1F9                    ; 00880506: Z80: POP AF / LD SP
        dc.w    $F3ED                    ; 00880508: Z80: DI / NOP
        dc.w    $5636                    ; 0088050A: Z80: PSG1 config
        dc.w    $E9E9                    ; 0088050C: Z80: JP (HL) / NOP
        dc.w    $9FBF                    ; 0088050E: Z80: PSG2 silence
        dc.w    $DFFF                    ; 00880510: Z80: RST 18H / RST 38H

; ============================================================================
; SecurityStrings - MARS Security Strings and Messages
; ============================================================================
; Security strings and copyright notice required by SEGA for cartridge
; authentication. Displayed during startup in MARS mode.
; ============================================================================
SecurityStrings:
        dc.w    $4D41                    ; 00880512: dc.w $4D41
        dc.w    $5253                    ; 00880514: dc.w $5253
        dc.w    $2049                    ; 00880516: dc.w $2049
        dc.w    $6E69                    ; 00880518: BGT.S $00880583
        dc.w    $7469                    ; 0088051A: MOVEQ #$69,D2
        dc.w    $616C                    ; 0088051C: BSR.S $0088058A
        dc.w    $2026                    ; 0088051E: dc.w $2026
        dc.w    $2053                    ; 00880520: dc.w $2053
        dc.w    $6563                    ; 00880522: BCS.S $00880587
        dc.w    $7572                    ; 00880524: dc.w $7572
        dc.w    $6974                    ; 00880526: BVS.S $0088059C
        dc.w    $7920                    ; 00880528: dc.w $7920
        dc.w    $5072                    ; 0088052A: dc.w $5072
        dc.w    $6F67                    ; 0088052C: BLE.S $00880595
        dc.w    $7261                    ; 0088052E: MOVEQ #$61,D1
        dc.w    $6D20                    ; 00880530: BLT.S $00880552
        dc.w    $2020                    ; 00880532: dc.w $2020
        dc.w    $2020                    ; 00880534: dc.w $2020
        dc.w    $2020                    ; 00880536: dc.w $2020
        dc.w    $2020                    ; 00880538: dc.w $2020
        dc.w    $2043                    ; 0088053A: dc.w $2043
        dc.w    $6172                    ; 0088053C: BSR.S $008805B0
        dc.w    $7472                    ; 0088053E: MOVEQ #$72,D2
        dc.w    $6964                    ; 00880540: BVS.S $008805A6
        dc.w    $6765                    ; 00880542: BEQ.S $008805A9
        dc.w    $2056                    ; 00880544: dc.w $2056
        dc.w    $6572                    ; 00880546: BCS.S $008805BA
        dc.w    $7369                    ; 00880548: dc.w $7369
        dc.w    $6F6E                    ; 0088054A: BLE.S $008805BA
        dc.w    $2020                    ; 0088054C: dc.w $2020
        dc.w    $2020                    ; 0088054E: dc.w $2020
        dc.w    $436F                    ; 00880550: dc.w $436F
        dc.w    $7079                    ; 00880552: MOVEQ #$79,D0
        dc.w    $7269                    ; 00880554: MOVEQ #$69,D1
        dc.w    $6768                    ; 00880556: BEQ.S $008805C0
        dc.w    $7420                    ; 00880558: MOVEQ #$20,D2
        dc.w    $5345                    ; 0088055A: dc.w $5345
        dc.w    $4741                    ; 0088055C: dc.w $4741
        dc.w    $2045                    ; 0088055E: dc.w $2045
        dc.w    $4E54                    ; 00880560: dc.w $4E54
        dc.w    $4552                    ; 00880562: dc.w $4552
        dc.w    $5052                    ; 00880564: dc.w $5052
        dc.w    $4953                    ; 00880566: dc.w $4953
        dc.w    $4553                    ; 00880568: dc.w $4553
        dc.w    $2C4C                    ; 0088056A: dc.w $2C4C
        dc.w    $5444                    ; 0088056C: dc.w $5444
        dc.w    $2E20                    ; 0088056E: dc.w $2E20
        dc.w    $3139                    ; 00880570: dc.w $3139
        dc.w    $3934                    ; 00880572: dc.w $3934
        dc.w    $2020                    ; 00880574: dc.w $2020
        dc.w    $2020                    ; 00880576: dc.w $2020
        dc.w    $2020                    ; 00880578: dc.w $2020
        dc.w    $2020                    ; 0088057A: dc.w $2020
        dc.w    $2020                    ; 0088057C: dc.w $2020
        dc.w    $2020                    ; 0088057E: dc.w $2020
        dc.w    $2020                    ; 00880580: dc.w $2020
        dc.w    $2020                    ; 00880582: dc.w $2020
        dc.w    $2020                    ; 00880584: dc.w $2020
        dc.w    $2020                    ; 00880586: dc.w $2020
        dc.w    $2020                    ; 00880588: dc.w $2020
        dc.w    $2020                    ; 0088058A: dc.w $2020
        dc.w    $2020                    ; 0088058C: dc.w $2020
        dc.w    $2020                    ; 0088058E: dc.w $2020
        dc.w    $2020                    ; 00880590: dc.w $2020
        dc.w    $2020                    ; 00880592: dc.w $2020
        dc.w    $2020                    ; 00880594: dc.w $2020
        dc.w    $524F                    ; 00880596: dc.w $524F
        dc.w    $4D20                    ; 00880598: dc.w $4D20
        dc.w    $5665                    ; 0088059A: dc.w $5665
        dc.w    $7273                    ; 0088059C: MOVEQ #$73,D1
        dc.w    $696F                    ; 0088059E: BVS.S $0088060F
        dc.w    $6E20                    ; 008805A0: BGT.S $008805C2
        dc.w    $312E                    ; 008805A2: dc.w $312E
        dc.w    $3000                    ; 008805A4: dc.w $3000

; --- VDP register init function ---
InitVDPRegs:
        dc.w    $48E7, $C040            ; 008805A6: MOVEM.L regs,-(SP)
        dc.w    $43F9, $00C0, $0004    ; 008805AA: LEA $00C00004,A1
        dc.w    $3011                    ; 008805B0: dc.w $3011
        dc.w    $303C                    ; 008805B2: dc.w $303C
        dc.w    $8000                    ; 008805B4: dc.w $8000
        dc.w    $323C                    ; 008805B6: dc.w $323C
        dc.w    $0100                    ; 008805B8: dc.w $0100
        dc.w    $3E3C                    ; 008805BA: dc.w $3E3C
        dc.w    $0012                    ; 008805BC: dc.w $0012
        dc.w    $1018                    ; 008805BE: dc.w $1018
        dc.w    $3280                    ; 008805C0: dc.w $3280
        dc.w    $D041                    ; 008805C2: dc.w $D041
        dc.w    $51CF, $FFF8            ; 008805C4: DBRA D7,$008805BE
        dc.w    $4CDF, $0203            ; 008805C8: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 008805CC: RTS

; --- Clear Genesis VDP memory ---
ClearVDPRAM:
        dc.w    $48E7, $81C0            ; 008805CE: MOVEM.L regs,-(SP)
        dc.w    $41F9, $0000, $063E    ; 008805D2: LEA $0000063E,A0
        dc.w    $43F9, $00C0, $0004    ; 008805D8: LEA $00C00004,A1
        dc.w    $3298                    ; 008805DE: dc.w $3298
        dc.w    $3298                    ; 008805E0: dc.w $3298
        dc.w    $3298                    ; 008805E2: dc.w $3298
        dc.w    $3298                    ; 008805E4: dc.w $3298
        dc.w    $3298                    ; 008805E6: dc.w $3298
        dc.w    $3298                    ; 008805E8: dc.w $3298
        dc.w    $3298                    ; 008805EA: dc.w $3298
        dc.w    $2298                    ; 008805EC: dc.w $2298
        dc.w    $3341                    ; 008805EE: dc.w $3341
        dc.w    $FFFC                    ; 008805F0: dc.w $FFFC
        dc.w    $3011                    ; 008805F2: dc.w $3011
        dc.w    $0800                    ; 008805F4: dc.w $0800
        dc.w    $0001                    ; 008805F6: dc.w $0001
        dc.w    $66F8                    ; 008805F8: BNE.S $008805F2
        dc.w    $3298                    ; 008805FA: dc.w $3298
        dc.w    $3298                    ; 008805FC: dc.w $3298
        dc.w    $7000                    ; 008805FE: MOVEQ #$00,D0
        dc.w    $22BC                    ; 00880600: dc.w $22BC
        dc.w    $C000                    ; 00880602: dc.w $C000
        dc.w    $0000                    ; 00880604: dc.w $0000
        dc.w    $7E0F                    ; 00880606: MOVEQ #$0F,D7
        dc.w    $3340                    ; 00880608: dc.w $3340
        dc.w    $FFFC                    ; 0088060A: dc.w $FFFC
        dc.w    $3340                    ; 0088060C: dc.w $3340
        dc.w    $FFFC                    ; 0088060E: dc.w $FFFC
        dc.w    $3340                    ; 00880610: dc.w $3340
        dc.w    $FFFC                    ; 00880612: dc.w $FFFC
        dc.w    $3340                    ; 00880614: dc.w $3340
        dc.w    $FFFC                    ; 00880616: dc.w $FFFC
        dc.w    $51CF, $FFEE            ; 00880618: DBRA D7,$00880608
        dc.w    $22BC                    ; 0088061C: dc.w $22BC
        dc.w    $4000                    ; 0088061E: dc.w $4000
        dc.w    $0010                    ; 00880620: dc.w $0010
        dc.w    $7E09                    ; 00880622: MOVEQ #$09,D7
        dc.w    $3340                    ; 00880624: dc.w $3340
        dc.w    $FFFC                    ; 00880626: dc.w $FFFC
        dc.w    $3340                    ; 00880628: dc.w $3340
        dc.w    $FFFC                    ; 0088062A: dc.w $FFFC
        dc.w    $3340                    ; 0088062C: dc.w $3340
        dc.w    $FFFC                    ; 0088062E: dc.w $FFFC
        dc.w    $3340                    ; 00880630: dc.w $3340
        dc.w    $FFFC                    ; 00880632: dc.w $FFFC
        dc.w    $51CF, $FFEE            ; 00880634: DBRA D7,$00880624
        dc.w    $4CDF, $0381            ; 00880638: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 0088063C: RTS
        dc.w    $8114                    ; 0088063E: dc.w $8114
        dc.w    $8F01                    ; 00880640: dc.w $8F01
        dc.w    $93FF                    ; 00880642: dc.w $93FF
        dc.w    $94FF                    ; 00880644: dc.w $94FF
        dc.w    $9500                    ; 00880646: dc.w $9500
        dc.w    $9600                    ; 00880648: dc.w $9600
        dc.w    $9780                    ; 0088064A: dc.w $9780
        dc.w    $4000                    ; 0088064C: dc.w $4000
        dc.w    $0080                    ; 0088064E: dc.w $0080
        dc.w    $8104                    ; 00880650: dc.w $8104
        dc.w    $8F02                    ; 00880652: dc.w $8F02

; --- 32X VDP mode setup ---
Init32XVDP:
        dc.w    $48E7, $C140            ; 00880654: MOVEM.L regs,-(SP)
        dc.w    $43F9, $00A1, $5180    ; 00880658: LEA $00A15180,A1
        dc.w    $08A9                    ; 0088065E: dc.w $08A9
        dc.w    $0007                    ; 00880660: dc.w $0007
        dc.w    $FF80                    ; 00880662: dc.w $FF80
        dc.w    $66F8                    ; 00880664: BNE.S $0088065E
        dc.w    $3E3C                    ; 00880666: dc.w $3E3C
        dc.w    $00FF                    ; 00880668: dc.w $00FF
        dc.w    $7000                    ; 0088066A: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088066C: MOVEQ #$00,D1
        dc.w    $337C                    ; 0088066E: dc.w $337C
        dc.w    $00FF                    ; 00880670: dc.w $00FF
        dc.w    $0004                    ; 00880672: dc.w $0004
        dc.w    $3341                    ; 00880674: dc.w $3341
        dc.w    $0006                    ; 00880676: dc.w $0006
        dc.w    $3340                    ; 00880678: dc.w $3340
        dc.w    $0008                    ; 0088067A: dc.w $0008
        dc.w    $4E71                    ; 0088067C: NOP
        dc.w    $0829, $0001, $000B    ; 0088067E: BTST #1,$000B(A1)
        dc.w    $66F8                    ; 00880684: BNE.S $0088067E
        dc.w    $0641                    ; 00880686: dc.w $0641
        dc.w    $0100                    ; 00880688: dc.w $0100
        dc.w    $51CF, $FFE8            ; 0088068A: DBRA D7,$00880674
        dc.w    $4CDF, $0283            ; 0088068E: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 00880692: RTS

; --- Clear 32X frame buffer ---
ClearFrameBuffer:
        dc.w    $48E7, $8180            ; 00880694: MOVEM.L regs,-(SP)
        dc.w    $41F9, $00A1, $5200    ; 00880698: LEA $00A15200,A0
        dc.w    $08A8                    ; 0088069E: dc.w $08A8
        dc.w    $0007                    ; 008806A0: dc.w $0007
        dc.w    $FF00                    ; 008806A2: dc.w $FF00
        dc.w    $66F8                    ; 008806A4: BNE.S $0088069E
        dc.w    $3E3C                    ; 008806A6: dc.w $3E3C
        dc.w    $001F                    ; 008806A8: dc.w $001F
        dc.w    $20C0                    ; 008806AA: dc.w $20C0
        dc.w    $20C0                    ; 008806AC: dc.w $20C0
        dc.w    $20C0                    ; 008806AE: dc.w $20C0
        dc.w    $20C0                    ; 008806B0: dc.w $20C0
        dc.w    $51CF, $FFF6            ; 008806B2: DBRA D7,$008806AA
        dc.w    $4CDF, $0181            ; 008806B6: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 008806BA: RTS

; --- Clear 64KB work RAM ---
ClearWorkRAM:
        dc.w    $41F9, $00FF, $0000    ; 008806BC: LEA $00FF0000,A0
        dc.w    $3E3C                    ; 008806C2: dc.w $3E3C
        dc.w    $07FF                    ; 008806C4: dc.w $07FF
        dc.w    $7000                    ; 008806C6: MOVEQ #$00,D0
        dc.w    $20C0                    ; 008806C8: dc.w $20C0
        dc.w    $20C0                    ; 008806CA: dc.w $20C0
        dc.w    $20C0                    ; 008806CC: dc.w $20C0
        dc.w    $20C0                    ; 008806CE: dc.w $20C0
        dc.w    $20C0                    ; 008806D0: dc.w $20C0
        dc.w    $20C0                    ; 008806D2: dc.w $20C0
        dc.w    $20C0                    ; 008806D4: dc.w $20C0
        dc.w    $20C0                    ; 008806D6: dc.w $20C0
        dc.w    $51CF, $FFEE            ; 008806D8: DBRA D7,$008806C8
        dc.w    $3B7C                    ; 008806DC: dc.w $3B7C
        dc.w    $0000                    ; 008806DE: dc.w $0000
        dc.w    $1200                    ; 008806E0: dc.w $1200
        dc.w    $7E0A                    ; 008806E2: MOVEQ #$0A,D7

; --- Security delay loop ---
SecurityLoop:
        dc.w    $51CF, $FFFE            ; 008806E4: DBRA D7,$008806E4

; --- MARS register initialization ---
MARSRegInit:
        dc.w    $43F9, $00A1, $5100    ; 008806E8: LEA $00A15100,A1
        dc.w    $7000                    ; 008806EE: MOVEQ #$00,D0
        dc.w    $2340                    ; 008806F0: dc.w $2340
        dc.w    $0020                    ; 008806F2: dc.w $0020
        dc.w    $2340                    ; 008806F4: dc.w $2340
        dc.w    $0024                    ; 008806F6: dc.w $0024
        dc.w    $1B7C                    ; 008806F8: dc.w $1B7C
        dc.w    $0003                    ; 008806FA: dc.w $0003
        dc.w    $5101                    ; 008806FC: dc.w $5101
        dc.w    $2E79                    ; 008806FE: dc.w $2E79
        dc.w    $0088                    ; 00880700: dc.w $0088
        dc.w    $0000                    ; 00880702: dc.w $0000
        dc.w    $0891                    ; 00880704: dc.w $0891
        dc.w    $0007                    ; 00880706: dc.w $0007
        dc.w    $66FA                    ; 00880708: BNE.S $00880704
        dc.w    $7000                    ; 0088070A: MOVEQ #$00,D0
        dc.w    $3340                    ; 0088070C: dc.w $3340
        dc.w    $0002                    ; 0088070E: dc.w $0002
        dc.w    $3340                    ; 00880710: dc.w $3340
        dc.w    $0004                    ; 00880712: dc.w $0004
        dc.w    $3340                    ; 00880714: dc.w $3340
        dc.w    $0006                    ; 00880716: dc.w $0006
        dc.w    $2340                    ; 00880718: dc.w $2340
        dc.w    $0008                    ; 0088071A: dc.w $0008
        dc.w    $2340                    ; 0088071C: dc.w $2340
        dc.w    $000C                    ; 0088071E: dc.w $000C
        dc.w    $3340                    ; 00880720: dc.w $3340
        dc.w    $0010                    ; 00880722: dc.w $0010
        dc.w    $3340                    ; 00880724: dc.w $3340
        dc.w    $0030                    ; 00880726: dc.w $0030
        dc.w    $3340                    ; 00880728: dc.w $3340
        dc.w    $0032                    ; 0088072A: dc.w $0032
        dc.w    $3340                    ; 0088072C: dc.w $3340
        dc.w    $0038                    ; 0088072E: dc.w $0038
        dc.w    $3340                    ; 00880730: dc.w $3340
        dc.w    $0080                    ; 00880732: dc.w $0080
        dc.w    $3340                    ; 00880734: dc.w $3340
        dc.w    $0082                    ; 00880736: dc.w $0082
        dc.w    $08A9                    ; 00880738: dc.w $08A9
        dc.w    $0000                    ; 0088073A: dc.w $0000
        dc.w    $008B                    ; 0088073C: dc.w $008B
        dc.w    $66F8                    ; 0088073E: BNE.S $00880738
        dc.w    $6100, $FF12            ; 00880740: BSR.W $00880654
        dc.w    $08E9                    ; 00880744: dc.w $08E9
        dc.w    $0000                    ; 00880746: dc.w $0000
        dc.w    $008B                    ; 00880748: dc.w $008B
        dc.w    $67F8                    ; 0088074A: BEQ.S $00880744
        dc.w    $6100, $FF06            ; 0088074C: BSR.W $00880654
        dc.w    $08A9                    ; 00880750: dc.w $08A9
        dc.w    $0000                    ; 00880752: dc.w $0000
        dc.w    $008B                    ; 00880754: dc.w $008B
        dc.w    $6100, $FF3C            ; 00880756: BSR.W $00880694
        dc.w    $303C                    ; 0088075A: dc.w $303C
        dc.w    $0040                    ; 0088075C: dc.w $0040
        dc.w    $2229                    ; 0088075E: dc.w $2229
        dc.w    $0020                    ; 00880760: dc.w $0020
        dc.w    $0C81                    ; 00880762: dc.w $0C81
        dc.w    $5351                    ; 00880764: dc.w $5351
        dc.w    $4552                    ; 00880766: dc.w $4552
        dc.w    $6700, $0092            ; 00880768: BEQ.W $008807FC
        dc.w    $303C                    ; 0088076C: dc.w $303C
        dc.w    $0080                    ; 0088076E: dc.w $0080
        dc.w    $2229                    ; 00880770: dc.w $2229
        dc.w    $0020                    ; 00880772: dc.w $0020
        dc.w    $0C81                    ; 00880774: dc.w $0C81
        dc.w    $5344                    ; 00880776: dc.w $5344
        dc.w    $4552                    ; 00880778: dc.w $4552
        dc.w    $6700, $0080            ; 0088077A: BEQ.W $008807FC
        dc.w    $21FC                    ; 0088077E: dc.w $21FC
        dc.w    $0088                    ; 00880780: dc.w $0088
        dc.w    $02A2                    ; 00880782: dc.w $02A2
        dc.w    $0070                    ; 00880784: dc.w $0070
        dc.w    $303C                    ; 00880786: dc.w $303C
        dc.w    $0002                    ; 00880788: dc.w $0002
        dc.w    $7200                    ; 0088078A: MOVEQ #$00,D1
        dc.w    $122D                    ; 0088078C: dc.w $122D
        dc.w    $0001                    ; 0088078E: dc.w $0001
        dc.w    $1429                    ; 00880790: dc.w $1429
        dc.w    $0080                    ; 00880792: dc.w $0080
        dc.w    $E14A                    ; 00880794: dc.w $E14A
        dc.w    $8242                    ; 00880796: dc.w $8242
        dc.w    $0801                    ; 00880798: dc.w $0801
        dc.w    $000F                    ; 0088079A: dc.w $000F
        dc.w    $660A                    ; 0088079C: BNE.S $008807A8
        dc.w    $0801                    ; 0088079E: dc.w $0801
        dc.w    $0006                    ; 008807A0: dc.w $0006
        dc.w    $6700, $0058            ; 008807A2: BEQ.W $008807FC
        dc.w    $6008                    ; 008807A6: BRA.S $008807B0
        dc.w    $0801                    ; 008807A8: dc.w $0801
        dc.w    $0006                    ; 008807AA: dc.w $0006
        dc.w    $6600, $004E            ; 008807AC: BNE.W $008807FC
        dc.w    $7020                    ; 008807B0: MOVEQ #$20,D0
        dc.w    $41F9, $0088, $0000    ; 008807B2: LEA $00880000,A0
        dc.w    $3C28                    ; 008807B8: dc.w $3C28
        dc.w    $018E                    ; 008807BA: dc.w $018E
        dc.w    $4A46                    ; 008807BC: dc.w $4A46
        dc.w    $6700, $0010            ; 008807BE: BEQ.W $008807D0
        dc.w    $3429                    ; 008807C2: dc.w $3429
        dc.w    $0028                    ; 008807C4: dc.w $0028
        dc.w    $0C42                    ; 008807C6: dc.w $0C42
        dc.w    $0000                    ; 008807C8: dc.w $0000
        dc.w    $67F6                    ; 008807CA: BEQ.S $008807C2
        dc.w    $B446                    ; 008807CC: dc.w $B446
        dc.w    $662C                    ; 008807CE: BNE.S $008807FC
        dc.w    $7000                    ; 008807D0: MOVEQ #$00,D0
        dc.w    $2340                    ; 008807D2: dc.w $2340
        dc.w    $0028                    ; 008807D4: dc.w $0028
        dc.w    $2340                    ; 008807D6: dc.w $2340
        dc.w    $002C                    ; 008807D8: dc.w $002C
        dc.w    $3E14                    ; 008807DA: dc.w $3E14
        dc.w    $2C7C, $FFFF, $FFC0    ; 008807DC: MOVEA.L #$FFFFFFC0,A6
        dc.w    $4CD6                    ; 008807E2: dc.w $4CD6
        dc.w    $7FF9                    ; 008807E4: dc.w $7FF9
        dc.w    $44FC                    ; 008807E6: dc.w $44FC
        dc.w    $0000                    ; 008807E8: dc.w $0000
        dc.w    $6014                    ; 008807EA: BRA.S $00880800

; --- Error handler path ---
ErrorPath1:
        dc.w    $43F9, $00A1, $5100    ; 008807EC: LEA $00A15100,A1
        dc.w    $3340                    ; 008807F2: dc.w $3340
        dc.w    $0006                    ; 008807F4: dc.w $0006
        dc.w    $303C                    ; 008807F6: dc.w $303C
        dc.w    $8000                    ; 008807F8: dc.w $8000
        dc.w    $6004                    ; 008807FA: BRA.S $00880800

; --- Error handler path ---
ErrorPath2:
        dc.w    $44FC                    ; 008807FC: dc.w $44FC
        dc.w    $0001                    ; 008807FE: dc.w $0001
        dc.w    $6528                    ; 00880800: BCS.S $0088082A
        dc.w    $41F9, $00A1, $5120    ; 00880802: LEA $00A15120,A0
        dc.w    $0C90                    ; 00880808: dc.w $0C90
        dc.w    $4D5F                    ; 0088080A: dc.w $4D5F
        dc.w    $4F4B                    ; 0088080C: dc.w $4F4B
        dc.w    $66F8                    ; 0088080E: BNE.S $00880808
        dc.w    $0CA8, $535F, $4F4B, $0004  ; 00880810: CMPI.L #$535F4F4B,$0004(A0)
        dc.w    $66F6                    ; 00880818: BNE.S $00880810
        dc.w    $20BC                    ; 0088081A: dc.w $20BC
        dc.w    $0000                    ; 0088081C: dc.w $0000
        dc.w    $0000                    ; 0088081E: dc.w $0000
        dc.w    $0800                    ; 00880820: dc.w $0800
        dc.w    $000F                    ; 00880822: dc.w $000F
        dc.w    $6612                    ; 00880824: BNE.S $00880838
        dc.w    $6000, $0260            ; 00880826: BRA.W $00880A88
        dc.w    $0800                    ; 0088082A: dc.w $0800
        dc.w    $0005                    ; 0088082C: dc.w $0005
        dc.w    $6600, $0678            ; 0088082E: BNE.W $00880EA8

