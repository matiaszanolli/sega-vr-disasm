; ============================================================================
; Scene Init Orchestrator
; ROM Range: $00C200-$00C30A (266 bytes)
; ============================================================================
; Category: object
; Purpose: Master scene initialization — calls 9 setup subroutines, configures
;   MARS VDP mode (240-line bitmap), sets SH2 interrupt control, initializes
;   frame buffer, loads road geometry from ROM table, waits for SH2 ready
;   signal via COMM1 bit 0, then sets up return address and clears stack.
;
; Entry: (none — standalone orchestrator)
; Uses: D0, A0, A5
; RAM:
;   $9000: object_base
;   $C802: scene_init_flag (byte, set to 1)
;   $C80A: frame_counter_mode (byte, set to $02)
;   $C80E: scene_config (byte, bit 6 set)
;   $C809: scene_state (byte, set to 1)
;   $C81C: adapter_bit0 (byte, bit 0 cleared)
;   $C874: vdp_state (word, read to A5)
;   $C875: vdp_config (byte, bit 6 set)
;   $C87E: game_state (word, cleared)
;   $C8A0: race_state (word)
;   $C8A4: sound_trigger (byte, set to $C5)
;   $C8A5: sound_param (byte)
;   $C8A8: scene_dispatch_param (word, set to $0102)
;   $C8C0: scene_addr_table (word, set to $C9A0)
;   $C8F4: scene_param_2 (word, cleared)
;   $C96C: road_geometry_ptr (longword)
;   $FEB7: system_ctrl (byte, bit 7 cleared)
;   $A000: frame_delay_counter (word)
; Calls:
;   $00A1FC: race_state_read
;   $00C974: track_segment_init
;   $00CF0C: scene_param_setup
;   $00CC06: object_array_init
;   $00CFAE: scene_display_init
;   $00C6DA: palette_scene_setup
;   $0058C8: sprite_input_check
;   $005908: sprite_update_check
;   $00593C: sprite_state_process
;   $0088204A, $008820C6: 32X init routines
;   $00882080: frame_sync
;   $00884998: vblank_wait
; MARS registers:
;   MARS_VDP_MODE+1: bitmap mode (clear bits 1:0, set bit 0 = 240-line)
;   MARS_SYS_INTCTL: set to $8083 (enable H/V/CMD interrupts)
;   COMM1_LO: SH2 ready handshake (bit 0)
; ROM tables:
;   $008BB1C4: road_geometry_table (longword ptrs, indexed by race_state)
; ============================================================================

fn_c200_001:
        lea     ($FFFF9000).w,A0                    ; $00C200  object_base
        dc.w    $4EBA,$DFF6         ; jsr     $00A1FC(pc)         ; $00C204  race_state_read
        dc.w    $4EBA,$076A         ; jsr     $00C974(pc)         ; $00C208  track_segment_init
        dc.w    $4EBA,$0CFE         ; jsr     $00CF0C(pc)         ; $00C20C  scene_param_setup
        dc.w    $4EBA,$09F4         ; jsr     $00CC06(pc)         ; $00C210  object_array_init
        dc.w    $4EBA,$0D98         ; jsr     $00CFAE(pc)         ; $00C214  scene_display_init
; --- clear scene state ---
        move.w  #$0000,($FFFFC87E).w                ; $00C218  game_state = 0
        move.w  #$0000,($FFFFC8F4).w                ; $00C21E  scene_param_2 = 0
        bclr    #7,($FFFFFEB7).w                    ; $00C224  system_ctrl: clear bit 7
        bclr    #0,($FFFFC81C).w                    ; $00C22A  adapter_bit0: clear
        move.w  #$C9A0,($FFFFC8C0).w                ; $00C230  scene_addr_table = $C9A0
        move.b  #$02,($FFFFC80A).w                  ; $00C236  frame_counter_mode = 2
; --- more init subroutines ---
        dc.w    $4EBA,$049C         ; jsr     $00C6DA(pc)         ; $00C23C  palette_scene_setup
        dc.w    $4EBA,$9686         ; jsr     $0058C8(pc)         ; $00C240  sprite_input_check
        dc.w    $4EBA,$96C2         ; jsr     $005908(pc)         ; $00C244  sprite_update_check
        dc.w    $4EBA,$96F2         ; jsr     $00593C(pc)         ; $00C248  sprite_state_process
; --- configure MARS VDP: 240-line bitmap mode ---
        andi.b  #$FC,MARS_VDP_MODE+1            ; $00C24C  clear mode bits 1:0
        ori.b   #$01,MARS_VDP_MODE+1            ; $00C254  set bit 0 (240-line)
        move.w  #$8083,MARS_SYS_INTCTL          ; $00C25C  enable H/V/CMD interrupts
; --- 32X init ---
        jsr     $0088204A                       ; $00C264
        jsr     $008820C6                       ; $00C26A
; --- setup VDP config ---
        bset    #6,($FFFFC875).w                    ; $00C270  vdp_config: set bit 6
        move.w  ($FFFFC874).w,(A5)                  ; $00C276  vdp_state → (A5)
        jsr     $00884998                       ; $00C27A  vblank_wait
; --- frame delay loop ($0080 = 128 frames) ---
        move.w  #$0080,($FFFFA000).w                ; $00C280  frame_delay_counter
        move.b  #$C5,($FFFFC8A4).w                  ; $00C286  sound_trigger = $C5
.frame_loop:
        jsr     $00882080                       ; $00C28C  frame_sync
        jsr     $00884998                       ; $00C292  vblank_wait
        subq.w  #1,($FFFFA000).w                    ; $00C298  decrement counter
        bne.s   .frame_loop                     ; $00C29C
; --- load road geometry from ROM table ---
        move.w  ($FFFFC8A0).w,D0                    ; $00C29E  race_state
        lea     $008BB1C4,A0                    ; $00C2A2  road_geometry_table
        move.l  $00(A0,D0.W),($FFFFC96C).w          ; $00C2A8  road_geometry_ptr
; --- scene state setup ---
        move.b  #$01,($FFFFC809).w                  ; $00C2AE  scene_state = 1
        bset    #6,($FFFFC80E).w                    ; $00C2B4  scene_config: set bit 6
        move.b  #$01,($FFFFC802).w                  ; $00C2BA  scene_init_flag = 1
; --- wait for SH2 ready (COMM1 bit 0) ---
.wait_sh2:
        btst    #0,COMM1_LO                     ; $00C2C0
        beq.s   .wait_sh2                       ; $00C2C8  loop until set
        bclr    #0,COMM1_LO                     ; $00C2CA  acknowledge
; --- final setup ---
        move.w  #$0102,($FFFFC8A8).w                ; $00C2D2  scene_dispatch_param
        move.b  #$9C,($FFFFC8A5).w                  ; $00C2D8  sound_param = $9C
        jsr     $00882080                       ; $00C2DE  frame_sync
        jsr     $00884998                       ; $00C2E4  vblank_wait
; --- set return address + clear stack ---
        move.l  #$0088C30A,$00FF0002            ; $00C2EA  return addr
        move.l  #$00000000,$00FF5FF8            ; $00C2F4  clear stack[0]
        move.l  #$00000000,$00FF5FFC            ; $00C2FE  clear stack[1]
        rts                                     ; $00C308
