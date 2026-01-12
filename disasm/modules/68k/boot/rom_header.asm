; ============================================================================
; Virtua Racing Deluxe - ROM Header and Exception Vectors
; Module: modules/68k/boot/rom_header.asm
; Address: $000000-$0001FF (512 bytes)
; ============================================================================
;
; 68000 Exception Vector Table ($000-$0FF)
; Sega 32X ROM Header ($100-$1FF)
;
; Key Entry Points:
;   Reset Vector:    $00880832 (main init sequence)
;   V-INT Handler:   $00881684 (vertical blank interrupt)
;   H-INT Handler:   $0088170A (horizontal interrupt)
;
; ============================================================================

        org     $000000

; ============================================================================
; Exception Vector Table ($000-$0FF)
; ============================================================================

vectors:
        DC.W    $0100,$0000             ; $000: Initial SSP ($01000000) BTST    D0,D0 ; BTST    #0,D0
        DC.W    $0000,$03F0             ; $004: Reset PC (MARS security jump) BTST    #0,D0
        DC.W    $0088,$0832             ; $008: Bus Error -> main_init BCLR    #136,A0
        DC.W    $0088,$0832             ; $00C: Address Error -> main_init BCLR    #136,A0
        DC.W    $0088,$0832             ; $010: Illegal Instruction BCLR    #136,A0
        DC.W    $0088,$0832             ; $014: Divide by Zero BCLR    #136,A0
        DC.W    $0088,$0832             ; $018: CHK Instruction BCLR    #136,A0
        DC.W    $0088,$0832             ; $01C: TRAPV Instruction BCLR    #136,A0
        DC.W    $0088,$0832             ; $020: Privilege Violation BCLR    #136,A0
        DC.W    $0088,$0832             ; $024: Trace BCLR    #136,A0
        DC.W    $0088,$0832             ; $028: Line 1010 Emulator BCLR    #136,A0
        DC.W    $0088,$0832             ; $02C: Line 1111 Emulator BCLR    #136,A0

        ; Reserved vectors ($030-$05F) - all zero
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $030 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $040 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $050 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0

        ; Interrupt Vectors ($060-$07F)
        DC.W    $0088,$0832             ; $060: Spurious Interrupt BCLR    #136,A0
        DC.W    $0088,$0832             ; $064: IRQ1 (External) BCLR    #136,A0
        DC.W    $0088,$0832             ; $068: IRQ2 (External) BCLR    #136,A0
        DC.W    $0088,$0832             ; $06C: IRQ3 (External) BCLR    #136,A0
        DC.W    $0088,$170A             ; $070: IRQ4 - H-INT Handler BCLR    #136,A0
        DC.W    $0088,$0832             ; $074: IRQ5 (External) BCLR    #136,A0
        DC.W    $0088,$1684             ; $078: IRQ6 - V-INT Handler BCLR    #136,A0
        DC.W    $0088,$0832             ; $07C: IRQ7 (NMI) BCLR    #136,A0

        ; TRAP Vectors ($080-$0BF)
        DC.W    $0088,$0832,$0088,$0832,$0088,$0832,$0088,$0832  ; $080: TRAP #0-3 BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0
        DC.W    $0088,$0832,$0088,$0832,$0088,$0832,$0088,$0832  ; $090: TRAP #4-7 BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0
        DC.W    $0088,$0832,$0088,$0832,$0088,$0832,$0088,$0832  ; $0A0: TRAP #8-11 BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0
        DC.W    $0088,$0832,$0088,$0832,$0088,$0832,$0088,$0832  ; $0B0: TRAP #12-15 BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0

        ; Reserved ($0C0-$0FF) - all zero
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $0C0 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $0D0 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $0E0 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000  ; $0F0 BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0

; ============================================================================
; Sega 32X ROM Header ($100-$1FF)
; ============================================================================

sega_header:
        DC.W    $5345,$4741,$2033,$3258,$2055,$2020,$2020,$2020  ; $100: "SEGA 32X U      " DC.W    $5345  ; Unknown ; DC.W    $4741  ; Unknown ; MOVE.L  <EA:33>,D0 ; MOVEA.W (A0)+,A1 ; MOVEA.L (A5),A0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2843,$2953,$4547,$4120,$3139,$3934,$2E53,$4550  ; $110: "(C)SEGA 1994.SEP" MOVEA.L D3,A4 ; MOVE.L  (A3),$2953(A4) ; DC.W    $4120  ; Unknown ; MOVE.W  $31393934,-(A0) ; DC.W    $4550  ; Unknown
        DC.W    $562E,$522E,$4458,$2020,$2020,$2020,$2020,$2020  ; $120: "V.R.DX          " SUBQ.B  #3,$562E(A6) ; NEG.W  (A0)+ ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $130: (domestic name cont.) MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $140 MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $562E,$522E,$4458,$2020,$2020,$2020,$2020,$2020  ; $150: "V.R.DX          " SUBQ.B  #3,$562E(A6) ; NEG.W  (A0)+ ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $160: (overseas name cont.) MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $170 MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $474D,$204D,$4B2D,$3834,$3630,$312D,$3030,$1E4D  ; $180: "GM MK-84601-00" + checksum DC.W    $474D  ; Unknown ; MOVEA.L A5,A0 ; DC.W    $4B2D  ; Unknown ; MOVE.W  <EA:34>,D4 ; MOVE.W  <EA:30>,D3 ; MOVE.W  $312D(A5),-(A0) ; MOVE.B  A5,A7
        DC.W    $4A36,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $190: "J6" (I/O support) TST.B  <EA:36> ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $0000,$0000,$002F,$FFFF,$00FF,$0000,$00FF,$FFFF  ; $1A0: ROM/RAM addresses BTST    #0,D0 ; BTST    #47,$FFFF(A7) ; BTST    #0,D0 ; DC.W    $FFFF  ; Unknown
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $1B0: SRAM info (none) MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $1C0: Modem info (none) MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $1D0: Memo MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $2020,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $1E0 MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0
        DC.W    $5520,$2020,$2020,$2020,$2020,$2020,$2020,$2020  ; $1F0: "U" (region) DC.W    $5520  ; Unknown ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0 ; MOVE.L  -(A0),D0

; ============================================================================
; End of ROM Header - Total: 512 bytes ($200)
; ============================================================================
