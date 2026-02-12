; ============================================================================
; Set Camera Registers to Invalid ($FFFF)
; ROM Range: $009B54-$009B82 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Sets 3 camera registers to $FFFF unconditionally.
;   Then checks $FF6114 (SH2 status) and $C048 (camera_state):
;   if both non-zero, falls through to next function (skip remaining).
;   Otherwise sets 4 more camera registers to $FFFF, then returns.
;
; Uses: D0
; RAM:
;   $C00C: camera register A (word)
;   $C018: camera register B (word)
;   $C012: camera register C (word)
;   $C01E: camera register D (word, conditional)
;   $C024: camera register E (word, conditional)
;   $C00E: camera register F (word, conditional)
;   $C010: camera register G (word, conditional)
;   $C048: camera_state (word)
;   $FF6114: SH2 status (word)
; ============================================================================

fn_8200_041:
        moveq   #-$01,D0                        ; $009B54  D0 = $FFFFFFFF
        move.w  D0,($FFFFC00C).w                ; $009B56  camera A = $FFFF
        move.w  D0,($FFFFC018).w                ; $009B5A  camera B = $FFFF
        move.w  D0,($FFFFC012).w                ; $009B5E  camera C = $FFFF
        tst.w   $00FF6114                       ; $009B62  test SH2 status
        beq.s   .set_remaining                  ; $009B68  if zero → set all remaining
        tst.w   ($FFFFC048).w                   ; $009B6A  test camera_state
        dc.w    $6612                           ; $009B6E  bne.s past_module — fall through
.set_remaining:
        move.w  D0,($FFFFC01E).w                ; $009B70  camera D = $FFFF
        move.w  D0,($FFFFC024).w                ; $009B74  camera E = $FFFF
        move.w  D0,($FFFFC00E).w                ; $009B78  camera F = $FFFF
        move.w  D0,($FFFFC010).w                ; $009B7C  camera G = $FFFF
        rts                                     ; $009B80
