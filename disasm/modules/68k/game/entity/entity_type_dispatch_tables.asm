; ============================================================================
; entity_type_dispatch_tables — AI Position Tables + Entity Type Dispatcher
; ROM Range: $00A868-$00A8F6 (142 bytes)
; ============================================================================
; Combined data tables and dispatcher for AI entity type routing.
;
; Data section ($A868-$A8DF):
;   - Signed coordinate pair table (48 words): pre-computed position offsets
;     for AI entity positioning, referenced by ai_entity_main_update_orch
;     via LEA $00A868(PC),A1
;   - Group size table (6 words): 256,128,128,128,128,128
;   - Handler pointer table (3 longwords): addresses into
;     ai_entity_main_update_orch ($A972, $AB88, $ABCE)
;
; Code section ($A8E0-$A8F6):
;   Two-level jump table dispatch: reads entity type from $AE(A0),
;   indexes into RAM table at ($C05C).W for secondary index,
;   then reads longword handler address from ROM pointer table.
;
; Called from: entity_render_pipeline*.asm via JSR $00A8E0(PC)
; Entry: A0 = entity pointer
; Uses: D0, A1
; ============================================================================

entity_type_dispatch_tables:
; --- signed coordinate pair table (48 words) ---
        dc.w    $F190        ; $00A868
        dc.w    $F1F0        ; $00A86A
        dc.w    $F128        ; $00A86C
        dc.w    $F060        ; $00A86E
        dc.w    $F128        ; $00A870
        dc.w    $EED0        ; $00A872
        dc.w    $F128        ; $00A874
        dc.w    $ED40        ; $00A876
        dc.w    $F128        ; $00A878
        dc.w    $F380        ; $00A87A
        dc.w    $F128        ; $00A87C
        dc.w    $F060        ; $00A87E
        dc.w    $F128        ; $00A880
        dc.w    $ED40        ; $00A882
        dc.w    $F128        ; $00A884
        dc.w    $EA20        ; $00A886
        dc.w    $EA70        ; $00A888
        dc.w    $FB50        ; $00A88A
        dc.w    $EA70        ; $00A88C
        dc.w    $FA88        ; $00A88E
        dc.w    $EA70        ; $00A890
        dc.w    $F9C0        ; $00A892
        dc.w    $EA70        ; $00A894
        dc.w    $F8F8        ; $00A896
        dc.w    $E900        ; $00A898
        dc.w    $0800        ; $00A89A
        dc.w    $F128        ; $00A89C
        dc.w    $F060        ; $00A89E
        dc.w    $F128        ; $00A8A0
        dc.w    $ED40        ; $00A8A2
        dc.w    $F128        ; $00A8A4
        dc.w    $EA20        ; $00A8A6
        dc.w    $F128        ; $00A8A8
        dc.w    $F380        ; $00A8AA
        dc.w    $F128        ; $00A8AC
        dc.w    $F060        ; $00A8AE
        dc.w    $F128        ; $00A8B0
        dc.w    $ED40        ; $00A8B2
        dc.w    $F128        ; $00A8B4
        dc.w    $EA20        ; $00A8B6
        dc.w    $F128        ; $00A8B8
        dc.w    $F380        ; $00A8BA
        dc.w    $F128        ; $00A8BC
        dc.w    $F060        ; $00A8BE
        dc.w    $F128        ; $00A8C0
        dc.w    $ED40        ; $00A8C2
        dc.w    $F128        ; $00A8C4
        dc.w    $EA20        ; $00A8C6
; --- group size table (6 words) ---
        dc.w    $0100        ; $00A8C8  256
        dc.w    $0080        ; $00A8CA  128
        dc.w    $0080        ; $00A8CC  128
        dc.w    $0080        ; $00A8CE  128
        dc.w    $0080        ; $00A8D0  128
        dc.w    $0080        ; $00A8D2  128
; --- handler pointer table (3 longwords) ---
        dc.w    $0088        ; $00A8D4  → $0088A972
        dc.w    $A972        ; $00A8D6
        dc.w    $0088        ; $00A8D8  → $0088AB88
        dc.w    $AB88        ; $00A8DA
        dc.w    $0088        ; $00A8DC  → $0088ABCE
        dc.w    $ABCE        ; $00A8DE
; --- entity type dispatcher (code) ---
entity_type_dispatch:
        dc.w    $3028        ; $00A8E0  MOVE.W $00AE(A0),D0
        dc.w    $00AE        ; $00A8E2
        dc.w    $D040        ; $00A8E4  ADD.W D0,D0
        dc.w    $43F8        ; $00A8E6  LEA ($C05C).W,A1
        dc.w    $C05C        ; $00A8E8
        dc.w    $3031        ; $00A8EA  MOVE.W (A1,D0.W),D0
        dc.w    $0000        ; $00A8EC
        dc.w    $D040        ; $00A8EE  ADD.W D0,D0
        dc.w    $D040        ; $00A8F0  ADD.W D0,D0
        dc.w    $227B        ; $00A8F2  MOVEA.L (-36,PC,D0.W),A1
        dc.w    $00DC        ; $00A8F4
        dc.w    $4ED1        ; $00A8F6  JMP (A1)
