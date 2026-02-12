; ============================================================================
; SFX Dispatch + Object Update + Animation Sequence
; ROM Range: $00B65A-$00B6D0 (118 bytes)
; ============================================================================
; Category: game
; Purpose: Three parts:
;   1) SFX dispatch ($B65A): sets $C802=1, calls dispatch_sfx ($B670)
;      3× with A2=$8480 work buffer. Each call: computes A1 from ROM
;      table $8BA000 + (D0 & $FF) × 32, tail-jumps to $00491A.
;   2) object_update ($B684): if $C80E bit 6 set, decrements rate
;      counter ($C80A). On tick: reads anim_idx ($C825), looks up byte
;      from 10-entry sequence table, writes to VDP $FF60D5. Advances
;      index; after 10 entries, clears bit 6 and resets index.
;   Data: 10-byte descending sequence ($FF..$F8,$F8,$80) at $B6D0.
;
; Uses: D0, D1, A1, A2
; RAM:
;   $C802: sfx_enable (byte)
;   $C809: anim_rate_init (byte)
;   $C80A: anim_rate_counter (byte)
;   $C80E: display_flags (byte, bit 6)
;   $C825: anim_idx (byte, 0-9)
;   $C96C: object_base_ptr (longword)
; ============================================================================

fn_a200_023:
; --- SFX dispatch: 3 calls ---
        move.b  #$01,($FFFFC802).w              ; $00B65A  sfx_enable = 1
        lea     ($FFFF8480).w,A2                ; $00B660  A2 → work buffer
        dc.w    $4EBA,$000A                     ; $00B664  jsr $00B670(pc) — dispatch_sfx [1]
        dc.w    $4EBA,$0006                     ; $00B668  jsr $00B670(pc) — dispatch_sfx [2]
        dc.w    $4EBA,$0002                     ; $00B66C  jsr $00B670(pc) — dispatch_sfx [3]
; --- dispatch_sfx subroutine ---
        lea     $008BA000,A1                    ; $00B670  A1 → SFX ROM table base
        moveq   #$00,D1                         ; $00B676  clear D1
        move.b  D0,D1                           ; $00B678  D1 = low byte of D0
        ror.l   #8,D0                           ; $00B67A  rotate next byte into position
        lsl.w   #5,D1                           ; $00B67C  D1 × 32 (table stride)
        adda.w  D1,A1                           ; $00B67E  A1 += offset
        dc.w    $4EFA,$9298                     ; $00B680  jmp $00491A(pc) — SFX handler
; --- object_update ---
object_update:
        btst    #6,($FFFFC80E).w                ; $00B684  animation active?
        beq.s   .done                           ; $00B68A  no → done
        subq.b  #1,($FFFFC80A).w                ; $00B68C  rate_counter--
        bne.s   .done                           ; $00B690  not zero → done
        move.b  ($FFFFC809).w,($FFFFC80A).w     ; $00B692  reload rate counter
        moveq   #$00,D0                         ; $00B698  clear D0
        move.b  ($FFFFC825).w,D0                ; $00B69A  D0 = anim_idx
        bne.s   .read_seq                       ; $00B69E  nonzero → read sequence
        movea.l ($FFFFC96C).w,A1                ; $00B6A0  A1 = object_base_ptr
        lea     ($FFFF8480).w,A2                ; $00B6A4  A2 → work buffer
        dc.w    $4EBA,$9240                     ; $00B6A8  jsr $0048EA(pc) — object setup
.read_seq:
        move.b  $00B6D0(PC,D0.W),D1             ; $00B6AC  D1 = sequence[idx]
        move.b  D1,$00FF60D5                    ; $00B6B0  write to VDP
        addq.b  #1,D0                           ; $00B6B6  idx++
        move.b  D0,($FFFFC825).w                ; $00B6B8  store anim_idx
        cmpi.b  #$0A,D0                         ; $00B6BC  idx == 10?
        bne.s   .done                           ; $00B6C0  no → done
        move.b  #$00,($FFFFC825).w              ; $00B6C2  reset anim_idx
        bclr    #6,($FFFFC80E).w                ; $00B6C8  clear animation flag
.done:
        rts                                     ; $00B6CE

