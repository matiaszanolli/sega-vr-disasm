; ============================================================================
; Bank-Switched Call Infrastructure
; ============================================================================
;
; After the bank probe identifies the access path, this file provides
; the trampoline pattern for calling 68K code in expansion ROM.
;
; THREE POSSIBLE OUTCOMES FROM PROBE:
;
; 1. DIRECT ACCESS (winner = 'D')
;    No banking needed. Just JSR/JMP to $3xxxxx directly.
;    Trampoline is unnecessary — use normal JSR.
;
; 2. BANK REGISTER A (winner = 'A', register $A130F1)
;    Set bank 3 via byte write to $A130F1, call through $900000 window.
;
; 3. BANK REGISTER B (winner = 'B', register $A15104)
;    Set bank 3 via word write to $A15104, call through $900000 window.
;
; ============================================================================
; EXPANSION ROM LAYOUT FOR 68K CODE
; ============================================================================
;
; The expansion ROM is partitioned:
;   $300000-$300FFF  SH2 code (existing handlers, ~4KB reserved)
;   $301000-$3FFFFF  68K expansion area (~960KB free)
;
; For DIRECT access:
;   68K calls JSR $301000 (= file offset, = 68K runtime address)
;
; For BANKED access:
;   68K sets bank 3, calls JSR $901000 ($900000 + $1000 offset within bank)
;   Because: bank 3 maps ROM $300000-$3FFFFF → $900000-$9FFFFF
;   So ROM offset $301000 → banked address $901000
;
; ============================================================================
; TRAMPOLINE PATTERNS
; ============================================================================
;
; Pattern A: Direct access (simplest — no banking overhead)
; ---------------------------------------------------------
;
;   ; Replace original function body with direct call:
;   original_function:                      ; e.g., $00E3B4 (sh2_cmd_27)
;       jsr     $301000                     ; 6 bytes: call expansion version
;       rts                                 ; 2 bytes: return to caller
;       ; 8 bytes total — fits in any function slot
;
;
; Pattern B: Banked access via $A130F1 (byte register)
; ----------------------------------------------------
;
;   original_function:
;       move.b  #$03,$A130F1              ; 6 bytes: select bank 3
;       jsr     $901000                   ; 6 bytes: call through bank window
;       move.b  #$00,$A130F1              ; 6 bytes: restore bank 0
;       rts                               ; 2 bytes
;       ; 20 bytes total
;
;   NOTE: If V-INT accesses data through $900000 window, wrap with:
;       move    sr,-(sp)                  ; 2 bytes: save interrupt mask
;       ori     #$0700,sr                 ; 4 bytes: disable interrupts
;       ; ... bank switch + call ...
;       move    (sp)+,sr                  ; 2 bytes: restore interrupts
;       ; Adds 8 bytes → 28 bytes total
;
;
; Pattern C: Banked access via $A15104 (word register)
; ----------------------------------------------------
;
;   original_function:
;       move.w  #$0003,$A15104            ; 6 bytes: select bank 3
;       jsr     $901000                   ; 6 bytes: call through bank window
;       move.w  #$0000,$A15104            ; 6 bytes: restore bank 0
;       rts                               ; 2 bytes
;       ; 20 bytes total
;
;
; ============================================================================
; IMPLEMENTATION NOTES
; ============================================================================
;
; 1. The original function entrypoint is PRESERVED. All existing callers
;    (BSR, JSR, jump table entries) continue to work unchanged.
;
; 2. The trampoline replaces the function BODY, not the entry address.
;    Original: [function body, N bytes] [padding to next function]
;    New:      [trampoline, 8-28 bytes] [NOP padding to maintain size]
;
; 3. Bank 0 must always be restored after the call. The game's data access
;    (graphics, sound, etc.) may depend on the default bank setting.
;
; 4. First target: sh2_cmd_27 at $00E3B4 (82 bytes available).
;    The 82-byte slot easily fits any trampoline pattern.
;
; 5. Interrupt safety: The 68K code section ($000200-$031000) is entirely
;    in the fixed ROM window ($880000-$8FFFFF). V-INT handler code runs
;    from fixed addresses. HOWEVER, if V-INT reads DATA through the bank
;    window ($900000-$9FFFFF), interrupts must be masked during bank switch.
;    Investigation needed: does V-INT access $900000+?
;
; ============================================================================
