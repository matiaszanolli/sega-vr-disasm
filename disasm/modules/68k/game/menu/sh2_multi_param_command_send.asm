; ============================================================================
; sh2_multi_param_command_send — SH2 Multi-Parameter Command Send
; ROM Range: $012FE4-$013054 (112 bytes)
; ============================================================================
; Sends command $21 to SH2 with 4 parameters via COMM register handshake:
;   1. Wait COMM0_HI clear, send A1 via COMM4, cmd $21 via COMM0
;   2. Wait COMM6 clear, send D0/D1 via COMM4/COMM5
;   3. Wait COMM6 clear, send D2 via COMM4
;   4. Wait COMM6 clear, send A0 via COMM4
; Each parameter is acknowledged by SH2 clearing COMM6.
;
; Entry: A0 = param 4, A1 = param 1, D0 = param 2 hi, D1 = param 2 lo,
;        D2 = param 3
; Uses: D0, D1, D2, A0, A1
; ============================================================================

sh2_multi_param_command_send:
.loc_0000:
        TST.B  COMM0_HI                        ; $012FE4
        BNE.S  .loc_0000                        ; $012FEA
        MOVE.L  A1,COMM4                    ; $012FEC
        MOVE.W  #$0101,COMM6                ; $012FF2
        MOVE.B  #$21,COMM0_LO                  ; $012FFA
        MOVE.B  #$01,COMM0_HI                  ; $013002
.loc_0026:
        TST.B  COMM6                        ; $01300A
        BNE.S  .loc_0026                        ; $013010
        MOVE.W  D0,COMM4                    ; $013012
        MOVE.W  D1,COMM5                    ; $013018
        MOVE.W  #$0101,COMM6                ; $01301E
        TST.B  COMM6                        ; $013026
        BNE.S  .loc_0026                        ; $01302C
        MOVE.W  D2,COMM4                    ; $01302E
        MOVE.W  #$0101,COMM6                ; $013034
.loc_0058:
        TST.B  COMM6                        ; $01303C
        BNE.S  .loc_0058                        ; $013042
        MOVE.L  A0,COMM4                    ; $013044
        MOVE.W  #$0101,COMM6                ; $01304A
        RTS                                     ; $013052
