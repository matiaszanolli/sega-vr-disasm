; ============================================================================
; sh2_object_and_sprite_update_orch — SH2 Object and Sprite Update Orchestrator
; ROM Range: $00DCD0-$00DE98 (456 bytes)
; Per-frame SH2 communication orchestrator. Sends DMA transfer, runs
; object_update + sprite_update, then transfers 3D geometry and sprite
; data via sh2_send_cmd. Computes text overlay addresses from palette
; index with bit-shift multiplication. Renders text overlays via
; text_render. Sends final sh2_cmd_27 for tile updates. Handles
; exit via button detection with fade-out transition ($A8 sound).
;
; Uses: D0, D1, D2, D3, D4, A0, A1, A2
; Calls: $00B684 (object_update), $00B6DA (sprite_update),
;        $00E35A (sh2_send_cmd), $00E3B4 (sh2_cmd_27),
;        $00E466 (text_render), $00E52C (dma_transfer)
; Confidence: high
; ============================================================================

sh2_object_and_sprite_update_orch:
        CLR.W  D0                               ; $00DCD0
        jsr     MemoryInit(pc)          ; $4EBA $0858
        jsr     object_update(pc)       ; $4EBA $D9AC
        jsr     animated_seq_player+10(pc); $4EBA $D9FE
.wait_comm_ready:
        TST.B  COMM0_HI                        ; $00DCDE
        BNE.S  .wait_comm_ready                 ; $00DCE4
        MOVEA.L #$06037000,A0                   ; $00DCE6
        MOVEA.L #$24018010,A1                   ; $00DCEC
        MOVE.W  #$0120,D0                       ; $00DCF2
        MOVE.W  #$0030,D1                       ; $00DCF6
        DC.W    $6100,$065E         ; BSR.W  $00E35A; $00DCFA
        BTST    #7,(-600).W                     ; $00DCFE
        BNE.W  .send_sprite_data                ; $00DD04
        MOVEA.L #$0603A600,A0                   ; $00DD08
        MOVEQ   #$00,D3                         ; $00DD0E
        MOVE.W  #$0004,D4                       ; $00DD10
.overlay_loop:
        BTST    D3,(-4345).W                    ; $00DD14
        BEQ.S  .next_overlay                    ; $00DD18
        LEA     $0088DEB6,A1                    ; $00DD1A
        MOVE.W  D3,D0                           ; $00DD20
        ADD.W   D0,D0                           ; $00DD22
        ADD.W   D0,D0                           ; $00DD24
        MOVEA.L $00(A1,D0.W),A1                 ; $00DD26
        MOVE.W  #$0010,D0                       ; $00DD2A
        MOVE.W  #$0010,D1                       ; $00DD2E
        DC.W    $6100,$0626         ; BSR.W  $00E35A; $00DD32
.next_overlay:
        ADDQ.W  #1,D3                           ; $00DD36
        DBRA    D4,.overlay_loop                ; $00DD38
.send_sprite_data:
        MOVEA.L #$0603B600,A0                   ; $00DD3C
        MOVEA.L #$24014010,A1                   ; $00DD42
        MOVE.W  #$0120,D0                       ; $00DD48
        MOVE.W  #$0018,D1                       ; $00DD4C
        DC.W    $6100,$0608         ; BSR.W  $00E35A; $00DD50
        LEA     $24034850,A1                    ; $00DD54
        LEA     (-4344).W,A2                    ; $00DD5A
        ADDA.L  (-24536).W,A2                   ; $00DD5E
        MOVEQ   #$00,D0                         ; $00DD62
        MOVE.B  (-24551).W,D0                   ; $00DD64
        ADD.W   D0,D0                           ; $00DD68
        ADD.W   D0,D0                           ; $00DD6A
        ADD.W   D0,D0                           ; $00DD6C
        ADD.W   D0,D0                           ; $00DD6E
        MOVE.W  D0,D1                           ; $00DD70
        ADD.W   D0,D0                           ; $00DD72
        ADD.W   D0,D0                           ; $00DD74
        ADD.W   D1,D0                           ; $00DD76
        ADD.W   D0,D0                           ; $00DD78
        ADDA.L  D0,A2                           ; $00DD7A
        BTST    #7,(-600).W                     ; $00DD7C
        BEQ.W  .use_text_addr                   ; $00DD82
        LEA     $0088DECA,A2                    ; $00DD86
.use_text_addr:
        jsr     ByteProcessLoop(pc)     ; $4EBA $06D8
        LEA     $240348E8,A1                    ; $00DD90
        LEA     (-1464).W,A2                    ; $00DD96
        MOVEQ   #$00,D0                         ; $00DD9A
        MOVE.B  (-335).W,D0                     ; $00DD9C
        ADD.W   D0,D0                           ; $00DDA0
        ADD.W   D0,D0                           ; $00DDA2
        ADD.W   D0,D0                           ; $00DDA4
        MOVE.W  D0,D1                           ; $00DDA6
        ADD.W   D0,D0                           ; $00DDA8
        ADD.W   D1,D0                           ; $00DDAA
        ADD.W   D0,D0                           ; $00DDAC
        ADDA.L  D0,A2                           ; $00DDAE
        MOVEQ   #$00,D0                         ; $00DDB0
        MOVE.B  (-24551).W,D0                   ; $00DDB2
        ADD.W   D0,D0                           ; $00DDB6
        ADD.W   D0,D0                           ; $00DDB8
        ADD.W   D0,D0                           ; $00DDBA
        ADDQ.W  #4,D0                           ; $00DDBC
        ADDA.L  D0,A2                           ; $00DDBE
        BTST    #7,(-600).W                     ; $00DDC0
        BEQ.W  .use_text_addr_2                 ; $00DDC6
        LEA     $0088DECA,A2                    ; $00DDCA
.use_text_addr_2:
        jsr     ByteProcessLoop(pc)     ; $4EBA $0694
        MOVEQ   #$00,D0                         ; $00DDD4
        MOVE.B  (-24551).W,D0                   ; $00DDD6
        LEA     $0088DE98,A1                    ; $00DDDA
        ADD.W   D0,D0                           ; $00DDE0
        MOVE.W  D0,D1                           ; $00DDE2
        ADD.W   D0,D0                           ; $00DDE4
        ADD.W   D1,D0                           ; $00DDE6
        MOVEA.L $00(A1,D0.W),A0                 ; $00DDE8
        MOVE.W  $04(A1,D0.W),D0                 ; $00DDEC
        MOVE.W  #$0030,D1                       ; $00DDF0
        MOVE.W  #$0010,D2                       ; $00DDF4
.wait_comm_ready_2:
        TST.B  COMM0_HI                        ; $00DDF8
        BNE.S  .wait_comm_ready_2               ; $00DDFE
        bsr.w   sh2_cmd_27              ; $6100 $05B2
        MOVE.W  #$0018,$00FF0008                ; $00DE04
        CMPI.W  #$0001,(-24532).W               ; $00DE0C
        BEQ.W  .check_fade_done                 ; $00DE12
        CMPI.W  #$0002,(-24532).W               ; $00DE16
        BEQ.W  .check_fade_complete             ; $00DE1C
        MOVE.W  (-14228).W,D1                   ; $00DE20
        ANDI.B  #$E0,D1                         ; $00DE24
        BNE.S  .begin_fadeout                    ; $00DE28
        MOVE.W  (-14228).W,D1                   ; $00DE2A
        ANDI.B  #$10,D1                         ; $00DE2E
        BNE.S  .set_exit_flag                   ; $00DE32
        SUBQ.W  #8,(-14210).W                   ; $00DE34
        BRA.W  .finish                          ; $00DE38
.set_exit_flag:
        ST      (-24552).W                      ; $00DE3C
.begin_fadeout:
        MOVE.B  #$A8,(-14172).W                 ; $00DE40
        MOVE.B  #$01,(-14327).W                 ; $00DE46
        MOVE.B  #$01,(-14326).W                 ; $00DE4C
        BSET    #7,(-14322).W                   ; $00DE52
        MOVE.B  #$01,(-14334).W                 ; $00DE58
        MOVE.W  #$0002,(-24532).W               ; $00DE5E
        BRA.W  .dec_timer                       ; $00DE64
.check_fade_done:
        BTST    #6,(-14322).W                   ; $00DE68
        BNE.S  .dec_timer                       ; $00DE6E
        CLR.W  (-24532).W                       ; $00DE70
        BRA.W  .dec_timer                       ; $00DE74
.check_fade_complete:
        BTST    #7,(-14322).W                   ; $00DE78
        BNE.S  .dec_timer                       ; $00DE7E
        CLR.W  (-24532).W                       ; $00DE80
        ADDQ.W  #4,(-14210).W                   ; $00DE84
        BRA.W  .finish                          ; $00DE88
.dec_timer:
        SUBQ.W  #8,(-14210).W                   ; $00DE8C
.finish:
        MOVE.B  #$01,(-14303).W                 ; $00DE90
        RTS                                     ; $00DE96
