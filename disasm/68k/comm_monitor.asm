; ============================================================================
; 68K COMM Register Monitor
; Add to V-INT handler to test SH2 communication
;
; Location: Insert after frame counter increment ($0016A2)
; Size: 22 bytes (11 words)
;
; Purpose: Prove bidirectional COMM register communication
; - Read COMM2 (Slave's counter)
; - Echo to COMM4 (proves 68K can read Slave)
; - Set COMM6 = 1 (work signal for future Slave code)
; ============================================================================

; COMM register addresses (from 68K perspective)
COMM_BASE       equ     $A15120
COMM2_OFFSET    equ     4       ; COMM2 at $A15124
COMM4_OFFSET    equ     8       ; COMM4 at $A15128
COMM6_OFFSET    equ     12      ; COMM6 at $A1512C

comm_monitor:
        ; Save register we're using
        move.w  d0,-(sp)                ; Save D0

        ; Read COMM2 (Slave's work counter)
        move.w  COMM_BASE+COMM2_OFFSET,d0    ; D0 = COMM2

        ; Echo to COMM4 (proves 68K reading Slave)
        move.w  d0,COMM_BASE+COMM4_OFFSET    ; COMM4 = COMM2

        ; Signal work available (for future Slave code)
        move.w  #1,COMM_BASE+COMM6_OFFSET    ; COMM6 = 1

        ; Restore register
        move.w  (sp)+,d0                ; Restore D0
