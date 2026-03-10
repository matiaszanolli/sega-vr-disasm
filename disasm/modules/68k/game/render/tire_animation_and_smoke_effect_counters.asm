; ============================================================================
; tire_animation_and_smoke_effect_counters — Tire Animation and Smoke Effect Counters
; ROM Range: $009B82-$009C9C (282 bytes)
; Updates tire/wheel animation and smoke effect counters. Reads entity
; speed +$04 and multiple effect timers (+$80, +$82, +$84, +$86, +$98,
; +$9A, +$E6, +$E8) to control animation frame rates. Speed-dependent
; frequency modulation for tire smoke. Jump table at end selects
; direction-dependent wheel animation data.
;
; Entry: A0 = entity pointer
; Uses: D0, D1, A0
; Object fields: +$04 speed, +$80-$86 tire timers, +$98-$9A smoke timers,
;   +$BE direction index, +$E6-$E8 wheel timers
; Confidence: high
; ============================================================================

tire_animation_and_smoke_effect_counters:
        MOVE.W  $0080(A0),D1                    ; $009B82
        CMPI.W  #$0007,D1                       ; $009B86
        BGT.S  .tire_timer_exceeded              ; $009B8A
        MOVE.W  $0082(A0),D1                    ; $009B8C
        CMPI.W  #$0007,D1                       ; $009B90
        BLE.S  .check_brake_timer               ; $009B94
.tire_timer_exceeded:
        MOVEQ   #$0F,D0                         ; $009B96
        SUB.W   D1,D0                           ; $009B98
        MOVE.W  D0,(-16372).W                   ; $009B9A
.check_brake_timer:
        MOVE.W  $0084(A0),D0                    ; $009B9E
        BEQ.S  .check_speed_for_smoke           ; $009BA2
        CMPI.W  #$000A,D0                       ; $009BA4
        BGT.S  .check_speed_for_smoke           ; $009BA8
        MOVEQ   #$0A,D1                         ; $009BAA
        SUB.W   D0,D1                           ; $009BAC
        MOVE.W  D1,(-16360).W                   ; $009BAE
.check_speed_for_smoke:
        CMPI.W  #$0014,$0004(A0)                ; $009BB2
        BLE.S  .speed_too_low_smoke             ; $009BB8
        MOVE.W  $0098(A0),D0                    ; $009BBA
        BEQ.S  .left_smoke_inactive             ; $009BBE
        ADDQ.W  #1,(-16354).W                   ; $009BC0
        ANDI.W  #$0003,(-16354).W               ; $009BC4
        CMPI.W  #$0078,$0004(A0)                ; $009BCA
        BGT.S  .check_right_smoke                ; $009BD0
        ADDQ.W  #4,(-16354).W                   ; $009BD2
        BRA.S  .check_right_smoke               ; $009BD6
.left_smoke_inactive:
        MOVE.W  #$FFFF,(-16354).W               ; $009BD8
.check_right_smoke:
        MOVE.W  $009A(A0),D1                    ; $009BDE
        BEQ.S  .right_smoke_inactive             ; $009BE2
        ADDQ.W  #1,(-16348).W                   ; $009BE4
        ANDI.W  #$0003,(-16348).W               ; $009BE8
        CMPI.W  #$0078,$0004(A0)                ; $009BEE
        BGT.S  .check_speed_for_wheels           ; $009BF4
        ADDQ.W  #4,(-16348).W                   ; $009BF6
        BRA.S  .check_speed_for_wheels           ; $009BFA
.speed_too_low_smoke:
        MOVE.W  #$FFFF,(-16354).W               ; $009BFC
.right_smoke_inactive:
        MOVE.W  #$FFFF,(-16348).W               ; $009C02
.check_speed_for_wheels:
        CMPI.W  #$0014,$0004(A0)                ; $009C08
        BLE.S  .speed_too_low_wheels             ; $009C0E
        MOVE.W  $00E6(A0),D0                    ; $009C10
        BEQ.S  .left_wheel_inactive             ; $009C14
        ADDQ.W  #1,(-16370).W                   ; $009C16
        ANDI.W  #$0003,(-16370).W               ; $009C1A
        CMPI.W  #$0078,$0004(A0)                ; $009C20
        BGT.S  .check_right_wheel                ; $009C26
        ADDQ.W  #4,(-16370).W                   ; $009C28
        BRA.S  .check_right_wheel               ; $009C2C
.left_wheel_inactive:
        MOVE.W  #$FFFF,(-16370).W               ; $009C2E
.check_right_wheel:
        MOVE.W  $00E8(A0),D1                    ; $009C34
        BEQ.S  .right_wheel_inactive             ; $009C38
        ADDQ.W  #1,(-16368).W                   ; $009C3A
        ANDI.W  #$0003,(-16368).W               ; $009C3E
        CMPI.W  #$0078,$0004(A0)                ; $009C44
        BGT.S  .direction_dispatch               ; $009C4A
        ADDQ.W  #4,(-16368).W                   ; $009C4C
        BRA.S  .direction_dispatch              ; $009C50
.speed_too_low_wheels:
        MOVE.W  #$FFFF,(-16370).W               ; $009C52
.right_wheel_inactive:
        MOVE.W  #$FFFF,(-16368).W               ; $009C58
.direction_dispatch:
        MOVE.W  $00BE(A0),D0                    ; $009C5E
        ADD.W   D0,D0                           ; $009C62
        JMP     $009C68(PC,D0.W)                ; $009C64
        BRA.S  .direction_forward                ; $009C68
        BRA.S  .direction_rear                  ; $009C6A
.direction_forward:
        CMPI.W  #$0007,$0086(A0)                ; $009C6C
        BLE.S  .done                            ; $009C72
        MOVEQ   #$0F,D1                         ; $009C74
        SUB.W  $0086(A0),D1                     ; $009C76
        ADD.W   D1,D1                           ; $009C7A
        MOVE.W  $009C9C(PC,D1.W),(-16366).W     ; $009C7C
        BRA.S  .done                             ; $009C82
.direction_rear:
        CMPI.W  #$0000,$0086(A0)                ; $009C84
        BLE.S  .done                            ; $009C8A
        MOVEQ   #$0F,D1                         ; $009C8C
        SUB.W  $0086(A0),D1                     ; $009C8E
        ADD.W   D1,D1                           ; $009C92
        MOVE.W  $009CAE(PC,D1.W),(-16366).W     ; $009C94
.done:
        RTS                                     ; $009C9A
