; ============================================================================
; fn_8200_005 — Write Status Code to RAM
; ROM Range: $0082E0-$0082E8 (8 bytes)
; Stores D7 as the current status code at RAM $68F0. Used by the time
; display system to signal state changes (e.g., lap complete, countdown).
;
; Entry: D7 = status code value
; Uses: D7
; RAM: $68F0 (status_code)
; Confidence: high
; ============================================================================

fn_8200_005:
        MOVE.B  D7,$00FF68F0                    ; $0082E0
        RTS                                     ; $0082E6
