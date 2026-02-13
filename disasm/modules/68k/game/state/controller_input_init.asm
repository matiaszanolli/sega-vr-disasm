; ============================================================================
; Controller Input Init
; ROM Range: $0018D8-$001992 (186 bytes)
; ============================================================================
; Reads controller IDs via BSR.W to external controller_id_read
; ($001992) for ports A/B/C. Sets up data direction registers,
; waits for port stabilization, then reads button states via
; zbus_request. Checks for 6-button pad type (ID = $0D).
;
; Output: ($FFFFC818).w = pad type/state bitmap
;   bit 0: port A has controller
;   bit 1: port B has controller
;   bit 2: port A is NOT 6-button
;   bit 3: port B is NOT 6-button
;
; Uses: D0, D7, A1
; RAM:
;   $C810: port_a_id
;   $C811: port_b_id
;   $C812: port_c_id
;   $C818: pad_type_flags
; Calls:
;   $001992: controller_id_read (BSR.W, external)
;   $00185E: zbus_request (JSR PC-relative)
; ============================================================================

controller_input_init:
; --- read controller IDs for all 3 ports ---
        moveq   #$00,d0                         ; port index 0
        dc.w    $6100,$00B6                      ; bsr.w controller_id_read → $001992
        move.b  d0,($FFFFC810).w                ; store port A ID
        moveq   #$01,d0                         ; port index 1
        dc.w    $6100,$00AC                      ; bsr.w controller_id_read → $001992
        move.b  d0,($FFFFC811).w                ; store port B ID
        moveq   #$02,d0                         ; port index 2
        dc.w    $6100,$00A2                      ; bsr.w controller_id_read → $001992
        move.b  d0,($FFFFC812).w                ; store port C ID
; --- request Z80 bus ---
        move.w  #$0100,Z80_BUSREQ
.wait_z80:
        btst    #0,Z80_BUSREQ
        bne.s   .wait_z80
; --- set controller data direction ---
        moveq   #$40,d0                         ; TH=output, rest=input
        move.b  d0,$00A10009                    ; port A ctrl
        move.b  d0,$00A1000B                    ; port B ctrl
        move.b  d0,$00A1000D                    ; port C ctrl
; --- set initial TH/TR output ---
        move.w  #$00C0,d0                       ; TH=1, TR=1
        move.b  d0,$00A10003                    ; port A data
        move.b  d0,$00A10005                    ; port B data
        move.b  d0,$00A10007                    ; port C data
; --- release Z80 bus ---
        move.w  #$0000,Z80_BUSREQ
; --- delay for port stabilization ---
        move.w  #$1400,d7
.delay:
        dbra    d7,.delay
; --- read port A buttons ---
        move.b  #$00,($FFFFC818).w              ; clear pad type flags
        lea     $00A10003,a1                    ; port A data register
        dc.w    $4EBA,$FF0E                      ; jsr zbus_request(pc) → $00185E
        btst    #15,d0                          ; controller present?
        beq.s   .read_port_b
        bset    #0,($FFFFC818).w                ; set: port A connected
; --- read port B buttons ---
.read_port_b:
        lea     $00A10005,a1                    ; port B data register
        dc.w    $4EBA,$FEF8                      ; jsr zbus_request(pc) → $00185E
        btst    #15,d0                          ; controller present?
        beq.s   .check_id_a
        bset    #1,($FFFFC818).w                ; set: port B connected
; --- check 6-button pad IDs ---
.check_id_a:
        cmpi.b  #$0D,($FFFFC810).w             ; port A: 6-button pad?
        beq.s   .check_id_b                     ; yes → skip flag
        bset    #2,($FFFFC818).w                ; set: port A not 6-button
.check_id_b:
        cmpi.b  #$0D,($FFFFC811).w             ; port B: 6-button pad?
        beq.s   .done                            ; yes → skip flag
        bset    #3,($FFFFC818).w                ; set: port B not 6-button
.done:
        rts
