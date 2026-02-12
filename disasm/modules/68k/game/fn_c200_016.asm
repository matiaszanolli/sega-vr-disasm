; ============================================================================
; Scene Initialization (Variable Reset)
; ROM Range: $00CE76-$00CEC2 (76 bytes)
; ============================================================================
; Category: game
; Purpose: Initializes scene variables: clears display flags ($C81D/$C81F/$C820),
;   sets work buffer ($A9E0-$A9E9) to default values ($0000C4C4),
;   clears $C819 and $C8BE, copies $C81A to $C310.
;   Calls 3 SH2 initialization routines via absolute addresses.
;
; Uses: D1, A1
; RAM:
;   $A800: work buffer base (via LEA)
;   $A9E0: work param A (word, cleared)
;   $A9E2: work param B (long, set to $0000C4C4)
;   $A9E6: work param C (long, set to $0000C4C4)
;   $C819: scene flag (byte, cleared)
;   $C81A: scene source param (byte)
;   $C81D: display flag A (byte, cleared)
;   $C81F: display flag B (byte, cleared)
;   $C820: display flag C (byte, cleared)
;   $C8BE: scene counter (word, cleared)
;   $C310: scene target param (byte, copied from $C81A)
; Calls:
;   $00884842: SH2 init A
;   $00884846: SH2 init B
;   $00884856: SH2 init C
; ============================================================================

fn_c200_016:
        moveq   #$00,D1                         ; $00CE76  D1 = 0 (used for clearing)
        lea     ($FFFFA800).w,A1                 ; $00CE78  A1 → work buffer
        jsr     $00884842                        ; $00CE7C  SH2 init A
        jsr     $00884846                        ; $00CE82  SH2 init B
        jsr     $00884856                        ; $00CE88  SH2 init C
        move.b  D1,($FFFFC81D).w                 ; $00CE8E  clear display flag A
        move.b  D1,($FFFFC81F).w                 ; $00CE92  clear display flag B
        move.b  D1,($FFFFC820).w                 ; $00CE96  clear display flag C
        move.w  D1,($FFFFA9E0).w                 ; $00CE9A  clear work param A
        move.l  #$0000C4C4,($FFFFA9E2).w         ; $00CE9E  set work param B
        move.l  #$0000C4C4,($FFFFA9E6).w         ; $00CEA6  set work param C
        move.b  #$00,($FFFFC819).w               ; $00CEAE  clear scene flag
        move.w  #$0000,($FFFFC8BE).w             ; $00CEB4  clear scene counter
        move.b  ($FFFFC81A).w,($FFFFC310).w      ; $00CEBA  copy scene param
        rts                                      ; $00CEC0
