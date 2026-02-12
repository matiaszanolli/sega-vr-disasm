; ============================================================================
; Set State + Pre-Dispatch + Init SH2 Scene
; ROM Range: $004C8A-$004CB8 (46 bytes)
; ============================================================================
; Sets race/mode state ($C8A5) to $9A, calls pre_dispatch_common
; ($002080) and WaitForVBlank ($004998), then initializes SH2
; scene handler to $00885618 and clears two SH2 shared longs.
;
; Memory:
;   $FFFFC8A5 = race/mode state (byte, set to $9A)
;   $00FF0002 = SH2 scene handler pointer (long, set to $00885618)
;   $00FF5FF8 = SH2 shared data (long, cleared)
;   $00FF5FFC = SH2 shared data (long, cleared)
; Entry: none | Exit: SH2 scene initialized | Uses: none
; ============================================================================

fn_4200_010:
        move.b  #$9A,($FFFFC8A5).w              ; $004C8A: $11FC $009A $C8A5 — set race/mode state
        dc.w    $4EBA,$D3EE                     ; BSR.W $002080 ; $004C90: — call pre_dispatch_common
        dc.w    $4EBA,$FD02                     ; BSR.W $004998 ; $004C94: — call WaitForVBlank
        move.l  #$00885618,$00FF0002            ; $004C98: $23FC $0088 $5618 $00FF $0002 — SH2 handler
        move.l  #$00000000,$00FF5FF8            ; $004CA2: $23FC $0000 $0000 $00FF $5FF8 — clear shared 1
        move.l  #$00000000,$00FF5FFC            ; $004CAC: $23FC $0000 $0000 $00FF $5FFC — clear shared 2
        rts                                     ; $004CB6: $4E75

