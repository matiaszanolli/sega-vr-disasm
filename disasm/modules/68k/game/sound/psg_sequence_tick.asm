; ============================================================================
; PSG Sequence Tick — read frequency and write PSG tone registers
; ROM Range: $030ECE-$030F0E (64 bytes)
; ============================================================================
; Checks channel active (A5+$0A), mute (bit 1), key-off (bit 2). Calls
; fm_sequence_process to get frequency value in D6. Handles $E0 channel
; type (maps to $C0). Splits D6: low nibble → PSG latch byte (OR with
; channel command D0), bits 4-9 → PSG data byte (6 bits). Writes both
; bytes to PSG port ($C00011).
;
; Entry: A5 = PSG channel structure pointer
; Uses: D0, D1, D6, A5
; Calls:
;   $0302EE: fm_sequence_process
; Confidence: medium
; ============================================================================

psg_sequence_tick:
        TST.B  $000A(A5)                        ; $030ECE
        BEQ.S  .loc_003E                        ; $030ED2
        BTST    #1,(A5)                         ; $030ED4
        BNE.S  .loc_003E                        ; $030ED8
        BTST    #2,(A5)                         ; $030EDA
        BNE.S  .loc_003E                        ; $030EDE
        jsr     fm_sequence_data_reader(pc); $4EBA $F40C
        MOVE.B  $0001(A5),D0                    ; $030EE4
        CMPI.B  #$E0,D0                         ; $030EE8
        BNE.S  .loc_0024                        ; $030EEC
        MOVE.B  #$C0,D0                         ; $030EEE
.loc_0024:
        MOVE.W  D6,D1                           ; $030EF2
        ANDI.B  #$0F,D1                         ; $030EF4
        OR.B    D1,D0                           ; $030EF8
        LSR.W  #4,D6                            ; $030EFA
        ANDI.B  #$3F,D6                         ; $030EFC
        MOVE.B  D0,PSG                    ; $030F00
        MOVE.B  D6,PSG                    ; $030F06
.loc_003E:
        RTS                                     ; $030F0C
