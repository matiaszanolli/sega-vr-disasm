; ============================================================================
; I/O Port Config Backup + SH2 Scene Reset
; ROM Range: $013F80-$013FE0 (96 bytes)
; ============================================================================
; Conditionally copies 8-byte I/O port configuration blocks for each
; controller port whose status byte equals $06. Port 1 config ($FE82)
; is copied to $FE94; Port 2 config ($FE8A) is copied to $FE9C.
; Then waits for SH2 idle and sets scene handler $0089305E.
;
; Memory:
;   $FFFFFE92 = port 1 status (byte, compared to $06)
;   $FFFFFE93 = port 2 status (byte, compared to $06)
;   $FFFFFE82 = port 1 config source (8 bytes, read)
;   $FFFFFE8A = port 2 config source (8 bytes, read)
;   $FFFFFE94 = port 1 config backup (8 bytes, written)
;   $FFFFFE9C = port 2 config backup (8 bytes, written)
;   $FFFFC87E = main game state (word, cleared to 0)
;   $00FF0002 = SH2 scene handler pointer (long, set)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: port configs backed up, SH2 reset
; Uses: D0, A0, A1
; ============================================================================

i_o_port_config_backup_sh2_scene_reset:
.check_port1:
        cmpi.b  #$06,($FFFFFE92).w             ; $013F80: $0C38 $0006 $FE92 — port 1 status == 6?
        bne.w   .check_port2                    ; $013F86: $6600 $0014 — no → skip port 1 copy
        lea     ($FFFFFE82).w,a0               ; $013F8A: $41F8 $FE82 — port 1 config source
        lea     ($FFFFFE94).w,a1               ; $013F8E: $43F8 $FE94 — port 1 config dest
        move.w  #$0007,d0                       ; $013F92: $303C $0007 — 8 bytes
.copy_port1:
        move.b  (a0)+,(a1)+                     ; $013F96: $12D8 — copy byte
        dbra    d0,.copy_port1                  ; $013F98: $51C8 $FFFC
.check_port2:
        cmpi.b  #$06,($FFFFFE93).w             ; $013F9C: $0C38 $0006 $FE93 — port 2 status == 6?
        bne.w   .reset_sh2                      ; $013FA2: $6600 $0014 — no → skip port 2 copy
        lea     ($FFFFFE8A).w,a0               ; $013FA6: $41F8 $FE8A — port 2 config source
        lea     ($FFFFFE9C).w,a1               ; $013FAA: $43F8 $FE9C — port 2 config dest
        move.w  #$0007,d0                       ; $013FAE: $303C $0007 — 8 bytes
.copy_port2:
        move.b  (a0)+,(a1)+                     ; $013FB2: $12D8 — copy byte
        dbra    d0,.copy_port2                  ; $013FB4: $51C8 $FFFC
.reset_sh2:
        tst.b   COMM0_HI                        ; $013FB8: $4A38 $5120 — wait for SH2 idle
        bne.s   .check_port1                    ; $013FBE: $66C0 — busy → retry from top
        clr.b   COMM1_LO                        ; $013FC0: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w           ; $013FC6: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $013FCC: $33FC $0020 $00FF $0008 — display mode
        move.l  #$0089305E,$00FF0002            ; $013FD4: $23FC $0089 $305E $00FF $0002 — scene handler
        rts                                     ; $013FDE: $4E75
