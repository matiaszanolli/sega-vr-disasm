; ============================================================================
; FM Register Table + Channel Pause — data and pause all active channels
; ROM Range: $031590-$0315F4 (100 bytes)
; ============================================================================
; Data prefix ($031590-$031597): 8 FM register numbers for SSG-EG writes
; (used by fn_30200_060). Code at $031598: Pauses all active sound
; channels. Reads pause mode from sequence; if zero, branches to $0315F4.
; Iterates DAC ($0040) then 6 FM channels ($0070, $30 stride): clears
; active (bit 7), sets pause flag (bit 0), writes panning $B4=$00 (mute),
; calls fm_init_channel. Then 3 PSG channels: same flags, calls
; fm_set_volume for silence. Restores A5 when done.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, D3, D4, A3, A5
; Calls:
;   $030C8A: fm_init_channel
;   $030CA2: fm_conditional_write
;   $030FB2: fm_set_volume
; Confidence: high
; ============================================================================

fn_30200_061:
        SUB.W  (A0),D0                          ; $031590
        SUB.W  (A0)+,D4                         ; $031592
        SUB.W  (A4),D2                          ; $031594
        SUB.W  (A4)+,D6                         ; $031596
        MOVEQ   #$30,D3                         ; $031598
        MOVE.B  (A4)+,D0                        ; $03159A
        DC.W    $6756               ; BEQ.S  $0315F4; $03159C
        MOVEA.L A5,A3                           ; $03159E
        LEA     $0040(A6),A5                    ; $0315A0
        BTST    #7,(A5)                         ; $0315A4
        BEQ.S  .loc_0022                        ; $0315A8
        BCLR    #7,(A5)                         ; $0315AA
        BSET    #0,(A5)                         ; $0315AE
.loc_0022:
        MOVEQ   #$05,D4                         ; $0315B2
.loc_0024:
        ADDA.W  D3,A5                           ; $0315B4
        BTST    #7,(A5)                         ; $0315B6
        BEQ.S  .loc_0042                        ; $0315BA
        BCLR    #7,(A5)                         ; $0315BC
        BSET    #0,(A5)                         ; $0315C0
        MOVE.B  #$B4,D0                         ; $0315C4
        MOVEQ   #$00,D1                         ; $0315C8
        DC.W    $4EBA,$F6D6         ; JSR     $030CA2(PC); $0315CA
        DC.W    $4EBA,$F6BA         ; JSR     $030C8A(PC); $0315CE
.loc_0042:
        DBRA    D4,.loc_0024                    ; $0315D2
        MOVEQ   #$02,D4                         ; $0315D6
.loc_0048:
        ADDA.W  D3,A5                           ; $0315D8
        BTST    #7,(A5)                         ; $0315DA
        BEQ.S  .loc_005C                        ; $0315DE
        BCLR    #7,(A5)                         ; $0315E0
        BSET    #0,(A5)                         ; $0315E4
        DC.W    $4EBA,$F9C8         ; JSR     $030FB2(PC); $0315E8
.loc_005C:
        DBRA    D4,.loc_0048                    ; $0315EC
        MOVEA.L A3,A5                           ; $0315F0
        RTS                                     ; $0315F2
