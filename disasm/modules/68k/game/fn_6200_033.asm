; ============================================================================
; Track Data Extract 033
; ROM Range: $0076A2-$007700 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Extracts signed byte pairs from 3D track data pages
;   Reads from 3 pages ($800 apart) into work buffer fields
;
; Entry: D0 = track segment index (pre-shifted)
; Uses: D0, D2, A1, A2
; RAM:
;   $C268: track_data_ptr
;   $C02E: track_work_buf
; Object fields (A2 → work buffer at $C02E):
;   +$00, +$04: page 0 signed byte pair
;   +$06, +$0A: page 1 signed byte pair
;   +$0C, +$10: page 2 signed byte pair
;   +$12, +$16: page 3 signed byte pair
; Confidence: high
; ============================================================================

fn_6200_033:
        movea.l ($FFFFC268).w,A1                ; $0076A2  A1 → track data base
        lea     ($FFFFC02E).w,A2                ; $0076A6  A2 → work buffer
        lsr.w   #6,D0                           ; $0076AA  D0 >>= 6 (segment stride)
        dc.w    $D040                           ; $0076AC  ADD.W D0,D0 — D0 *= 2
        lea     $00(A1,D0.W),A1                 ; $0076AE  A1 += offset
; --- page 0: read signed byte pair ---
        move.b  (A1)+,D2                        ; $0076B2  D2 = byte 0 (signed)
        ext.w   D2                              ; $0076B4  sign-extend
        move.w  D2,$0000(A2)                    ; $0076B6  buf+$00 = D2
        move.b  (A1),D2                         ; $0076BA  D2 = byte 1 (signed)
        ext.w   D2                              ; $0076BC  sign-extend
        move.w  D2,$0004(A2)                    ; $0076BE  buf+$04 = D2
; --- page 1: advance $7FF bytes ---
        lea     $07FF(A1),A1                    ; $0076C2  A1 += $7FF (next page)
        move.b  (A1)+,D2                        ; $0076C6
        ext.w   D2                              ; $0076C8
        move.w  D2,$0006(A2)                    ; $0076CA  buf+$06 = D2
        move.b  (A1),D2                         ; $0076CE
        ext.w   D2                              ; $0076D0
        move.w  D2,$000A(A2)                    ; $0076D2  buf+$0A = D2
; --- page 2: advance $7FF bytes ---
        lea     $07FF(A1),A1                    ; $0076D6  A1 += $7FF (next page)
        move.b  (A1)+,D2                        ; $0076DA
        ext.w   D2                              ; $0076DC
        move.w  D2,$000C(A2)                    ; $0076DE  buf+$0C = D2
        move.b  (A1),D2                         ; $0076E2
        ext.w   D2                              ; $0076E4
        move.w  D2,$0010(A2)                    ; $0076E6  buf+$10 = D2
; --- page 3: advance $7FF bytes ---
        lea     $07FF(A1),A1                    ; $0076EA  A1 += $7FF (next page)
        move.b  (A1)+,D2                        ; $0076EE
        ext.w   D2                              ; $0076F0
        move.w  D2,$0012(A2)                    ; $0076F2  buf+$12 = D2
        move.b  (A1),D2                         ; $0076F6
        ext.w   D2                              ; $0076F8
        move.w  D2,$0016(A2)                    ; $0076FA  buf+$16 = D2
        rts                                     ; $0076FE
