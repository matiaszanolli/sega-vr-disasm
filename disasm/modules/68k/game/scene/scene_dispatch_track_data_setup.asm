; ============================================================================
; Scene Dispatch + Track Data Setup
; ROM Range: $00C8E6-$00C9AE (200 bytes)
; ============================================================================
; Category: game
; Purpose: Reads race_substate ($C8CC) to index a 6-word data table, storing
;   two config words to $FF6122/$FF6352. Then sets up 4 track data blocks
;   at $FF6114, $FF6218, $FF6344, $FF6448 by loading segment pointers from
;   ROM tables indexed by race_substate, copying header + 3 param groups
;   via a shared subroutine.
;
; Data table (6 words at function start, indexed as pairs by D0):
;   +0: $5400,$5500  +4: $5A00,$5B00  +8: $4A00,$4B00
;
; Uses: D0, A1, A2, A3, A4
; RAM:
;   $C8CC: race_substate (word, indexes data table)
;   $C710: track_segment_buffer (destination for first block)
;   $C734: track_transform_ptr (longword pointer)
;   $C754: track_offset_data (longword, copied to $FF6228/$FF6354)
; ROM tables:
;   $008957A0: track_segment_base_table
;   $008956C8: track_segment_alt_table
;   $008848FE: segment_copy_routine (JMP target)
; Calls:
;   $00C9AE: post_dispatch (called 3 times via BSR/BRA)
; ============================================================================

scene_dispatch_track_data_setup:
; --- data table (3 pairs of config words) ---
        dc.w    $5400                           ; $00C8E6  config pair 0, word A
        dc.w    $5500                           ; $00C8E8  config pair 0, word B
        dc.w    $5A00                           ; $00C8EA  config pair 1, word A
        dc.w    $5B00                           ; $00C8EC  config pair 1, word B
        dc.w    $4A00                           ; $00C8EE  config pair 2, word A
        dc.w    $4B00                           ; $00C8F0  config pair 2, word B
; --- read config from data table ---
        move.w  ($FFFFC8CC).w,D0                    ; $00C8F2  race_substate
        move.w  scene_dispatch_track_data_setup(PC,D0.W),$00FF6122  ; $00C8F6  config word A → $FF6122
        move.w  scene_dispatch_track_data_setup+2(PC,D0.W),$00FF6352 ; $00C8FE  config word B → $FF6352
; --- block 0: load track segment from race_substate ---
        lea     $008957A0,A1                    ; $00C906  track_segment_base_table
        bsr.s   .load_segment_alt               ; $00C90C
; --- block 1: $FF6114 ---
        lea     $00FF6114,A1                    ; $00C90E
        lea     $008957A0,A4                    ; $00C914
        bsr.s   .setup_block                    ; $00C91A
        dc.w    $4EBA,$0090         ; jsr     $00C9AE(pc)         ; $00C91C  post_dispatch
; --- block 2: $FF6218 ---
        lea     $00FF6218,A1                    ; $00C920
        lea     $008957A0,A4                    ; $00C926
        bsr.s   .setup_block                    ; $00C92C
        move.l  ($FFFFC754).w,$00FF6228             ; $00C92E  track_offset_data
; --- block 3: $FF6344 ---
        lea     $00FF6344,A1                    ; $00C936
        lea     $008957A0,A4                    ; $00C93C
        bsr.s   .setup_block                    ; $00C942
        dc.w    $6168               ; bsr.s   $00C9AE             ; $00C944  post_dispatch
        move.l  ($FFFFC754).w,$00FF6354             ; $00C946
; --- block 4: $FF6448 ---
        lea     $00FF6448,A1                    ; $00C94E
        lea     $008957A0,A4                    ; $00C954
        bra.s   .setup_block                    ; $00C95A
; --- load segment from alt table ---
.load_segment_alt_entry:
        lea     $008956C8,A1                    ; $00C95C  track_segment_alt_table
.load_segment_alt:
        move.w  ($FFFFC8CC).w,D0                    ; $00C962  race_substate
        movea.l $00(A1,D0.W),A1                 ; $00C966  segment data ptr
        lea     ($FFFFC710).w,A2                    ; $00C96A  track_segment_buffer
        jmp     $008848FE                       ; $00C96E  segment_copy_routine
; --- setup block (called from each block init) ---
        bsr.s   .load_segment_alt_entry         ; $00C974
        lea     $00FF6114,A1                    ; $00C976
        bsr.s   .load_transform                 ; $00C97C
        dc.w    $602E               ; bra.s   $00C9AE             ; $00C97E  post_dispatch
.load_transform:
        lea     $008956C8,A4                    ; $00C980  track_segment_alt_table
.setup_block:
        movea.l ($FFFFC734).w,A3                    ; $00C986  track_transform_ptr
        move.w  ($FFFFC8CC).w,D0                    ; $00C98A  race_substate
        movea.l $00(A4,D0.W),A4                 ; $00C98E  segment params ptr
        moveq   #$01,D0                         ; $00C992
        move.w  D0,(A1)                         ; $00C994  enable flag = 1
        lea     $0010(A1),A1                    ; $00C996  skip to data area
        move.l  (A4)+,(A1)+                     ; $00C99A  copy header longword
        bsr.s   .copy_param_group               ; $00C99C
        bsr.s   .copy_param_group               ; $00C99E
        nop                                     ; $00C9A0
; --- copy one param group (6 bytes from A3 + 4 bytes from A4) ---
.copy_param_group:
        move.w  D0,(A1)+                        ; $00C9A2  param index
        move.l  (A3)+,(A1)+                     ; $00C9A4  transform data (4 bytes)
        move.w  (A3)+,(A1)+                     ; $00C9A6  transform data (2 bytes)
        addq.l  #8,A1                           ; $00C9A8  skip padding
        move.l  (A4)+,(A1)+                     ; $00C9AA  segment data (4 bytes)
        rts                                     ; $00C9AC
