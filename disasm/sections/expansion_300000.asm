; ============================================================================
; Expansion ROM Section ($300000-$3FFFFF)
; 1MB of space available for custom code and data
; ============================================================================

        org     $300000

; ============================================================================
; 68K COMM Register Monitor
; Called from V-INT handler to test SH2 communication
;
; Purpose: Prove bidirectional COMM register communication
; - Read COMM2 (Slave's counter)
; - Echo to COMM4 (proves 68K can read Slave)
; - Set COMM6 = 1 (work signal for future Slave code)
;
; Size: 24 bytes
; Called from: V-INT handler at $0016A6
; ============================================================================

comm_monitor_vint:
        ; Save register we're using
        move.w  d0,-(sp)                ; Save D0

        ; Read COMM2 (Slave's work counter)
        move.w  $A15124,d0              ; D0 = COMM2

        ; Echo to COMM4 (proves 68K reading Slave)
        move.w  d0,$A15128              ; COMM4 = COMM2

        ; Signal work available (for future Slave code)
        move.w  #1,$A1512C              ; COMM6 = 1

        ; Restore register
        move.w  (sp)+,d0                ; Restore D0

        rts                             ; Return to V-INT handler

; ============================================================================
; Padding to fill section to 1MB
; ============================================================================

        dcb.b   $100000-(*-$300000),$FF ; Fill rest with 0xFF
