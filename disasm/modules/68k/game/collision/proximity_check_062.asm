; ============================================================================
; Proximity Check 062
; ROM Range: $003AB2-$003B28 (118 bytes)
; ============================================================================
; Category: game
; Purpose: Tests if object is within 3D bounding box of reference point
;   Checks X, Z, Y deltas against thresholds ($0C80 and $1400)
;   On match: copies reference data (position, params) to output buffer
;   Also updates rotation angle counter
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1, A2
; RAM:
;   $C8E2: rotation_angle
; Object fields (A0):
;   +$30: x_position
;   +$32: z_position
;   +$34: y_position
; Output buffer (A2 → $FF65B0):
;   +$00: match_flag (0=no, 1=yes)
;   +$02-$05: ref_position (longword)
;   +$06: ref_y
;   +$0A: rotation_angle
;   +$0C-$0E: ref_params
;   +$10-$13: ref_data (longword)
; Confidence: medium
; ============================================================================

proximity_check_062:
        lea     $00883A9C,A1                    ; $003AB2  A1 → reference data (ROM)
        lea     $00FF65B0,A2                    ; $003AB8  A2 → output buffer
        addi.w  #$003C,($FFFFC8E2).w            ; $003ABE  rotation_angle += 60
        move.w  #$0C80,D1                       ; $003AC4  D1 = X/Y threshold
        move.w  #$1400,D3                       ; $003AC8  D3 = Z threshold
        move.w  #$0000,$0000(A2)                ; $003ACC  match_flag = 0 (default)
; --- get rotation and object position ---
        move.w  ($FFFFC8E2).w,D0                ; $003AD2  D0 = rotation_angle
        andi.w  #$1FFF,D0                       ; $003AD6  mask to $1FFF range
        move.w  D0,$000A(A2)                    ; $003ADA  buf.rotation = D0
        move.w  $0030(A0),D2                    ; $003ADE  D2 = obj.x
        move.w  $0034(A0),D4                    ; $003AE2  D4 = obj.y
        move.w  $0032(A0),D5                    ; $003AE6  D5 = obj.z
; --- check X delta ---
        sub.w   (A1),D2                         ; $003AEA  D2 = obj.x - ref.x
        bpl.s   .check_x                       ; $003AEC  positive → ok
        neg.w   D2                              ; $003AEE  abs(delta_x)
.check_x:
        cmp.w   D1,D2                           ; $003AF0  |delta_x| > threshold?
        bgt.s   .done                           ; $003AF2  yes → no match
; --- check Z delta ---
        sub.w   $0002(A1),D5                    ; $003AF4  D5 = obj.z - ref.z
        bpl.s   .check_z                       ; $003AF8  positive → ok
        neg.w   D5                              ; $003AFA  abs(delta_z)
.check_z:
        cmp.w   D3,D5                           ; $003AFC  |delta_z| > threshold?
        bgt.s   .done                           ; $003AFE  yes → no match
; --- check Y delta ---
        sub.w   $0004(A1),D4                    ; $003B00  D4 = obj.y - ref.y
        bpl.s   .check_y                       ; $003B04  positive → ok
        neg.w   D4                              ; $003B06  abs(delta_y)
.check_y:
        cmp.w   D1,D4                           ; $003B08  |delta_y| > threshold?
        bgt.s   .done                           ; $003B0A  yes → no match
; --- match: copy reference data ---
        move.w  #$0001,$0000(A2)                ; $003B0C  match_flag = 1
        move.l  (A1)+,$0002(A2)                 ; $003B12  copy ref_position
        move.w  (A1)+,$0006(A2)                 ; $003B16  copy ref_y
        move.w  (A1)+,$000C(A2)                 ; $003B1A  copy ref_param_a
        move.w  (A1)+,$000E(A2)                 ; $003B1E  copy ref_param_b
        move.l  (A1)+,$0010(A2)                 ; $003B22  copy ref_data
.done:
        rts                                     ; $003B26
