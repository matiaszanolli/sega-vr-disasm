; ============================================================================
; 32X Adapter Boot Entry ($0003C0-$000510)
;
; Contains the MARS adapter initialization sequence:
;   $0003C0-$0003CF: "MARS CHECK MODE " identification string
;   $0003D0-$0003EF: 32X boot parameters (stack pointers, SH2 entry points)
;   $0003F0-$0004D3: 68K-side adapter boot code (register setup, MARS handshake,
;                     VDP init, Z80 program load, jump to main)
;   $0004D4-$0004E7: VDP register initialization data table (20 bytes)
;   $0004E8-$000510: Z80 program data (41 bytes, loaded into Z80 RAM)
;
; WARNING: The MARS CHECK string at $0003C0 is verified by the 32X hardware
; during boot. Do not modify the first 16 bytes.
; ============================================================================

adapter_boot_entry:
        dc.w    $4D41        ; $0003C0 - 'MA' (MARS CHECK MODE string)
        dc.w    $5253        ; $0003C2 - 'RS'
        dc.w    $2043        ; $0003C4 - ' C'
        dc.w    $4845        ; $0003C6 - 'HE'
        dc.w    $434B        ; $0003C8 - 'CK'
        dc.w    $204D        ; $0003CA - ' M'
        dc.w    $4F44        ; $0003CC - 'OD'
        dc.w    $4520        ; $0003CE - 'E '
        dc.w    $0000        ; $0003D0
        dc.w    $0000        ; $0003D2
        dc.w    $0002        ; $0003D4
        dc.w    $0000        ; $0003D6
        dc.w    $0000        ; $0003D8
        dc.w    $0000        ; $0003DA
        dc.w    $0000        ; $0003DC
        dc.w    $C000        ; $0003DE
        dc.w    $0600        ; $0003E0
        dc.w    $0280        ; $0003E2
        dc.w    $0600        ; $0003E4  Slave PC high (SDRAM)
        dc.w    $0288        ; $0003E6  Slave PC low = 0x06000288 (original SDRAM code)
        dc.w    $0600        ; $0003E8
        dc.w    $0000        ; $0003EA
        dc.w    $0600        ; $0003EC
        dc.w    $0140        ; $0003EE
        dc.w    $287C        ; $0003F0
        dc.w    $FFFF        ; $0003F2
        dc.w    $FFC0        ; $0003F4
        dc.w    $23FC        ; $0003F6
        dc.w    $0000        ; $0003F8
        dc.w    $0000        ; $0003FA
        dc.w    $00A1        ; $0003FC
        dc.w    $5128        ; $0003FE
        dc.w    $46FC        ; $000400
        dc.w    $2700        ; $000402
        dc.w    $4BF9        ; $000404
        dc.w    $00A1        ; $000406
        dc.w    $0000        ; $000408
        dc.w    $7001        ; $00040A
        dc.w    $0CAD        ; $00040C
        dc.w    $4D41        ; $00040E
        dc.w    $5253        ; $000410
        dc.w    $30EC        ; $000412
        dc.w    $6600        ; $000414
        dc.w    $03E6        ; $000416
        dc.w    $082D        ; $000418
        dc.w    $0007        ; $00041A
        dc.w    $5101        ; $00041C
        dc.w    $67F8        ; $00041E
        dc.w    $4AAD        ; $000420
        dc.w    $0008        ; $000422
        dc.w    $6710        ; $000424
        dc.w    $4A6D        ; $000426
        dc.w    $000C        ; $000428
        dc.w    $670A        ; $00042A
        dc.w    $082D        ; $00042C
        dc.w    $0000        ; $00042E
        dc.w    $5101        ; $000430
        dc.w    $6600        ; $000432
        dc.w    $03B8        ; $000434
        dc.w    $102D        ; $000436
        dc.w    $0001        ; $000438
        dc.w    $0200        ; $00043A
        dc.w    $000F        ; $00043C
        dc.w    $6706        ; $00043E
        dc.w    $2B78        ; $000440
        dc.w    $055A        ; $000442
        dc.w    $4000        ; $000444
        dc.w    $7200        ; $000446
        dc.w    $2C41        ; $000448
        dc.w    $4E66        ; $00044A
        dc.w    $41F9        ; $00044C
        dc.w    $0000        ; $00044E
        dc.w    $04D4        ; $000450
        dc.w    $6100        ; $000452
        dc.w    $0152        ; $000454
        dc.w    $6100        ; $000456
        dc.w    $0176        ; $000458
        dc.w    $47F9        ; $00045A
        dc.w    $0000        ; $00045C
        dc.w    $04E8        ; $00045E
        dc.w    $43F9        ; $000460
        dc.w    $00A0        ; $000462
        dc.w    $0000        ; $000464
        dc.w    $45F9        ; $000466
        dc.w    $00C0        ; $000468
        dc.w    $0011        ; $00046A
        dc.w    $3E3C        ; $00046C
        dc.w    $0100        ; $00046E
        dc.w    $7000        ; $000470
        dc.w    $3B47        ; $000472
        dc.w    $1100        ; $000474
        dc.w    $3B47        ; $000476
        dc.w    $1200        ; $000478
        dc.w    $012D        ; $00047A
        dc.w    $1100        ; $00047C
        dc.w    $66FA        ; $00047E
        dc.w    $7425        ; $000480
        dc.w    $12DB        ; $000482
        dc.w    $51CA        ; $000484
        dc.w    $FFFC        ; $000486
        dc.w    $3B40        ; $000488
        dc.w    $1200        ; $00048A
        dc.w    $3B40        ; $00048C
        dc.w    $1100        ; $00048E
        dc.w    $3B47        ; $000490
        dc.w    $1200        ; $000492
        dc.w    $149B        ; $000494
        dc.w    $149B        ; $000496
        dc.w    $149B        ; $000498
        dc.w    $149B        ; $00049A
        dc.w    $41F9        ; $00049C
        dc.w    $0000        ; $00049E
        dc.w    $04C0        ; $0004A0
        dc.w    $43F9        ; $0004A2
        dc.w    $00FF        ; $0004A4
        dc.w    $0000        ; $0004A6
        dc.w    $22D8        ; $0004A8
        dc.w    $22D8        ; $0004AA
        dc.w    $22D8        ; $0004AC
        dc.w    $22D8        ; $0004AE
        dc.w    $22D8        ; $0004B0
        dc.w    $22D8        ; $0004B2
        dc.w    $22D8        ; $0004B4
        dc.w    $22D8        ; $0004B6
        dc.w    $41F9        ; $0004B8
        dc.w    $00FF        ; $0004BA
        dc.w    $0000        ; $0004BC
        dc.w    $4ED0        ; $0004BE
        dc.w    $1B7C        ; $0004C0
        dc.w    $0001        ; $0004C2
        dc.w    $5101        ; $0004C4
        dc.w    $41F9        ; $0004C6
        dc.w    $0000        ; $0004C8
        dc.w    $06BC        ; $0004CA
        dc.w    $D1FC        ; $0004CC
        dc.w    $0088        ; $0004CE
        dc.w    $0000        ; $0004D0
        dc.w    $4ED0        ; $0004D2
        dc.w    $0404        ; $0004D4
        dc.w    $303C        ; $0004D6
        dc.w    $076C        ; $0004D8
        dc.w    $0000        ; $0004DA
        dc.w    $0000        ; $0004DC
        dc.w    $FF00        ; $0004DE
        dc.w    $8137        ; $0004E0
        dc.w    $0002        ; $0004E2
        dc.w    $0100        ; $0004E4
        dc.w    $0000        ; $0004E6
        dc.w    $AF01        ; $0004E8
        dc.w    $D91F        ; $0004EA
        dc.w    $1127        ; $0004EC
        dc.w    $0021        ; $0004EE
        dc.w    $2600        ; $0004F0
        dc.w    $F977        ; $0004F2
        dc.w    $EDB0        ; $0004F4
        dc.w    $DDE1        ; $0004F6
        dc.w    $FDE1        ; $0004F8
        dc.w    $ED47        ; $0004FA
        dc.w    $ED4F        ; $0004FC
        dc.w    $D1E1        ; $0004FE
        dc.w    $F108        ; $000500
        dc.w    $D9C1        ; $000502
        dc.w    $D1E1        ; $000504
        dc.w    $F1F9        ; $000506
        dc.w    $F3ED        ; $000508
        dc.w    $5636        ; $00050A
        dc.w    $E9E9        ; $00050C
        dc.w    $9FBF        ; $00050E
        dc.w    $DFFF        ; $000510
