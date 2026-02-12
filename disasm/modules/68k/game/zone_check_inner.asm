; ============================================================================
; Zone Check Inner — Angle-Based Visibility
; ROM Range: $00AE06-$00AED6 (210 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Chained from proximity_distance_check via JMP when entities are close.
; Computes angle-based visibility zones for both entities using a 2KB
; lookup table, then sets direction bits in A0+$89 and A1+$89.
;
; Two symmetric passes:
;   Pass 1: Angle from A1→A0, check against bounding box at $C8E4-$C8EA,
;           set bits in A0+$89
;   Pass 2: Angle from A0→A1, check against bounding box at $C8EC-$C8F2,
;           set bits in A1+$89
;
; FIELDS ACCESSED
; ---------------
;   A0/A1+$30  Position X (word)
;   A0/A1+$34  Position Y (word)
;   A0+$3C, A1+$3C  Facing angle A (word)
;   A0+$40     Facing angle B (word)
;   A0+$89, A1+$89  Direction zone bits (byte, output)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC268  Angle lookup table base pointer (long)
;   $FFFFC8E4  Pass 1 X min bound (word)
;   $FFFFC8E6  Pass 1 Y max bound (word)
;   $FFFFC8E8  Pass 1 X max bound (word)
;   $FFFFC8EA  Pass 1 Y min bound (word)
;   $FFFFC8EC  Pass 2 X min bound (word)
;   $FFFFC8EE  Pass 2 X max bound (word)
;   $FFFFC8F0  Pass 2 Y min bound (word)
;   $FFFFC8F2  Pass 2 Y max bound (word)
;
; Entry: A0 = entity A, A1 = entity B
; Exit:  D0 = A0 zone bits; zone bits written to A0+$89 and A1+$89
; Uses:  D0-D7, A2
; ============================================================================

; Bit mask data table (referenced by LEA PC-relative from pass 2)
zone_check_data:
        dc.w    $0102,$0408             ; Bytes: $01,$02,$04,$08 (bit masks 0-3)

; --- Pass 1: Check A1→A0 angle, set A0 direction bits ---
zone_check_inner:
        move.w  $3C(a1),d0              ; $00AE0A: $3029 $003C — A1 facing angle
        sub.w   $40(a0),d0              ; $00AE0E: $9068 $0040 — subtract A0 angle B
        asr.w   #5,d0                   ; $00AE12: $EA40 — normalize to table index
        addi.w  #$0800,d0               ; $00AE14: $0640 $0800 — center offset
        andi.w  #$07FE,d0               ; $00AE18: $0240 $07FE — mask to valid even index
        move.w  $30(a0),d3              ; $00AE1C: $3628 $0030 — X position A0
        sub.w   $30(a1),d3              ; $00AE20: $9669 $0030 — X diff = A0.X - A1.X
        move.w  $34(a0),d4              ; $00AE24: $3828 $0034 — Y position A0
        sub.w   $34(a1),d4              ; $00AE28: $9869 $0034 — Y diff = A0.Y - A1.Y
        movea.l ($FFFFC268).w,a2        ; $00AE2C: $2478 $C268 — load angle table base
        lea     0(a2,d0.w),a2           ; $00AE30: $45F2 $0000 — index into table
        moveq   #3,d2                   ; $00AE34: $7603 — 4 iterations (zones 0-3)
.loop1:
        move.b  (a2),d6                 ; $00AE36: $1C12 — load X offset from table
        ext.w   d6                      ; $00AE38: $4886 — sign-extend to word
        add.w   d3,d6                   ; $00AE3A: $DC43 — add X position difference
        move.b  $01(a2),d7              ; $00AE3C: $1E2A $0001 — load Y offset from table
        ext.w   d7                      ; $00AE40: $4887 — sign-extend to word
        add.w   d4,d7                   ; $00AE42: $DE44 — add Y position difference
        cmp.w   ($FFFFC8E4).w,d6        ; $00AE44: $BC78 $C8E4 — X min bound check
        blt.s   .skip1                  ; $00AE48: $6D12 — below minimum: skip
        cmp.w   ($FFFFC8E8).w,d6        ; $00AE4A: $BC78 $C8E8 — X max bound check
        bgt.s   .skip1                  ; $00AE4E: $6E0C — above maximum: skip
        cmp.w   ($FFFFC8EA).w,d7        ; $00AE50: $BE78 $C8EA — Y min bound check
        blt.s   .skip1                  ; $00AE54: $6D06 — below minimum: skip
        cmp.w   ($FFFFC8E6).w,d7        ; $00AE56: $BE78 $C8E6 — Y max bound check
        bgt.s   .skip1                  ; $00AE5A: $6E00 — above maximum: skip
        ; All bounds satisfied — entity is in this zone
        moveq   #3,d0                   ; $00AE5C: $7003
        sub.w   d2,d0                   ; $00AE5E: $9042 — zone index = 3 - counter
        bset    d0,$89(a0)              ; $00AE60: $01E8 $0089 — set zone bit in A0
.skip1:
        lea     $0800(a2),a2            ; $00AE64: $45EA $0800 — advance to next 2KB segment
        dbf     d2,.loop1               ; $00AE68: $51CA $FFCC — loop 4 times

; --- Pass 2: Check A0→A1 angle, set A1 direction bits ---
        move.w  $3C(a0),d0              ; $00AE6C: $3028 $003C — A0 facing angle
        sub.w   $3C(a1),d0              ; $00AE70: $9069 $003C — subtract A1 facing angle
        asr.w   #5,d0                   ; $00AE74: $EA40 — normalize to table index
        addi.w  #$0800,d0               ; $00AE76: $0640 $0800 — center offset
        andi.w  #$07FE,d0               ; $00AE7A: $0240 $07FE — mask to valid even index
        move.w  $30(a1),d3              ; $00AE7E: $3629 $0030 — X position A1
        sub.w   $30(a0),d3              ; $00AE82: $9668 $0030 — X diff = A1.X - A0.X
        move.w  $34(a1),d4              ; $00AE86: $3829 $0034 — Y position A1
        sub.w   $34(a0),d4              ; $00AE8A: $9868 $0034 — Y diff = A1.Y - A0.Y
        movea.l ($FFFFC268).w,a2        ; $00AE8E: $2478 $C268 — reload angle table base
        lea     0(a2,d0.w),a2           ; $00AE92: $45F2 $0000 — index into table
        moveq   #3,d2                   ; $00AE96: $7603 — 4 iterations
.loop2:
        move.b  (a2),d6                 ; $00AE98: $1C12 — load X offset
        ext.w   d6                      ; $00AE9A: $4886 — sign-extend
        add.w   d3,d6                   ; $00AE9C: $DC43 — add X diff
        move.b  $01(a2),d7              ; $00AE9E: $1E2A $0001 — load Y offset
        ext.w   d7                      ; $00AEA2: $4887 — sign-extend
        add.w   d4,d7                   ; $00AEA4: $DE44 — add Y diff
        cmp.w   ($FFFFC8EC).w,d6        ; $00AEA6: $BC78 $C8EC — X min bound check
        blt.s   .skip2                  ; $00AEAA: $6D12 — below minimum
        cmp.w   ($FFFFC8EE).w,d6        ; $00AEAC: $BC78 $C8EE — X max bound check
        bgt.s   .skip2                  ; $00AEB0: $6E0C — above maximum
        cmp.w   ($FFFFC8F0).w,d7        ; $00AEB2: $BE78 $C8F0 — Y min bound check
        blt.s   .skip2                  ; $00AEB6: $6D06 — below minimum
        cmp.w   ($FFFFC8F2).w,d7        ; $00AEB8: $BE78 $C8F2 — Y max bound check
        bgt.s   .skip2                  ; $00AEBC: $6E00 — above maximum
        ; All bounds satisfied
        lea     zone_check_data(pc),a2  ; $00AEBE: $45FA $FF46 — load bit mask table
        moveq   #3,d0                   ; $00AEC2: $7003
        sub.w   d2,d0                   ; $00AEC4: $9042 — zone index
        bset    d0,$89(a1)              ; $00AEC6: $01E9 $0089 — set zone bit in A1
.skip2:
        lea     $0800(a2),a2            ; $00AECA: $45EA $0800 — advance table
        dbf     d2,.loop2               ; $00AECE: $51CA $FFC8 — loop 4 times
        ; Return result
        move.b  $89(a0),d0              ; $00AED2: $1028 $0089 — load A0 zone bits
        rts                             ; $00AED4: $4E75
