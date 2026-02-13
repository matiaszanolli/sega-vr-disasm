; ============================================================================
; AI Flag Setup at Object Array
; ROM Range: $00B604-$00B632 (46 bytes)
; ============================================================================
; Category: game
; Purpose: Initializes AI control flags at $FF68D0+D0 offset.
;   Clears flag byte, then conditionally sets to $02 based on bit 4 of $C967.
;   Also sets $FF68B0 to $09 or $00 based on bit 5 of $C967.
;
; Entry: D0 = offset into $FF68D0 array
; Uses: D0, A1
; RAM:
;   $C967: AI configuration flags (byte)
;   $FF68B0: AI mode byte
;   $FF68D0: AI flag array base
; ============================================================================

ai_flag_setup_at_object_array:
        lea     $00FF68D0,A1                    ; $00B604  A1 = AI flag array base
        lea     $00(A1,D0.W),A1                 ; $00B60A  A1 = &array[D0]
        move.b  #$00,(A1)                       ; $00B60E  clear flag byte
        btst    #4,($FFFFC967).w                ; $00B612  test AI config bit 4
        bne.s   .set_flag                       ; $00B618  if set → write $02
        move.b  #$02,(A1)                       ; $00B61A  flag = $02 (bit 4 clear)
.set_flag:
        moveq   #$09,D0                         ; $00B61E  D0 = $09 (mode A)
        btst    #5,($FFFFC967).w                ; $00B620  test AI config bit 5
        bne.s   .store_mode                     ; $00B626  if set → keep $09
        moveq   #$00,D0                         ; $00B628  D0 = $00 (mode B)
.store_mode:
        move.b  D0,$00FF68B0                    ; $00B62A  store AI mode
        rts                                     ; $00B630
