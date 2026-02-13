; ============================================================================
; sh2_frame_sync_wrapper — SH2 Frame Sync Wrapper
; ROM Range: $00203A-$00204A (16 bytes)
; ============================================================================
; Saves all registers (D0-D7, A0-A6), calls the SH2 frame synchronization
; routine at $008B0004, then restores all registers and returns.
; Called by system_boot_init to sync 68K with SH2 processors.
;
; Uses: D0-D7, A0-A6 (saved/restored)
; Calls:
;   $008B0004: sh2_frame_sync
; ============================================================================

sh2_frame_sync_wrapper:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $00203A
        JSR     $008B0004                       ; $00203E
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $002044
        RTS                                     ; $002048
