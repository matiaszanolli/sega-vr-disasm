; Q-026 validation-only lifecycle wrapper.
;
; Fixed placement: file $01C914 / 68K $0089C914.  It re-arms the shared
; lifecycle flag before tail-entering the untouched normal-1P loader.

q026_scene_entry_wrapper:
        nop
        clr.b   VR60_1P_FLAG
        jmp     $00884A3E
