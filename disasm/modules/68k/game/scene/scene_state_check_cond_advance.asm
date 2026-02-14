; ============================================================================
; Scene State Check + Conditional Advance
; ROM Range: $004460-$004498 (56 bytes)
; ============================================================================
; Category: game
; Purpose: Checks scene_state counter:
;   - If == 1: calls init sub at $002066
;   - If == 60 ($3C): advances input_state, clears scene_state,
;     enables display flags $C809/$C80A/$C802, sets $C80E bit 7
;
; RAM:
;   $C8AA: scene_state counter (word)
;   $C07C: input_state (word, advanced by 4)
;   $C809: display enable A (byte, set to $01)
;   $C80A: display enable B (byte, set to $01)
;   $C80E: display control (byte, bit 7 set)
;   $C802: display enable C (byte, set to $01)
; Calls:
;   $002066: scene init sub (PC-relative)
; ============================================================================

scene_state_check_cond_advance:
        cmpi.w  #$0001,($FFFFC8AA).w            ; $004460  scene_state == 1?
        bne.s   .check_60                       ; $004466  no → check for 60
        jsr     sound_state_init_clear_comm_variables(pc); $4EBA $DBFC
.check_60:
        cmpi.w  #$003C,($FFFFC8AA).w            ; $00446C  scene_state == 60?
        bne.s   .done                           ; $004472  no → return
        addq.w  #4,($FFFFC07C).w                ; $004474  advance input_state
        move.w  #$0000,($FFFFC8AA).w            ; $004478  clear scene_state
        move.b  #$01,($FFFFC809).w              ; $00447E  enable display A
        move.b  #$01,($FFFFC80A).w              ; $004484  enable display B
        bset    #7,($FFFFC80E).w                ; $00448A  set display control bit 7
        move.b  #$01,($FFFFC802).w              ; $004490  enable display C
.done:
        rts                                     ; $004496
