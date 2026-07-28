# Q-020 mode-1 DMAC0 transfer-end and re-arm repair

Date: 2026-07-28

Status: **static candidate evidence; not runtime acceptance**

## Defect

The first no-COMM1 candidate programmed CHCR0 as `$000044E5`, enabling IE/DEI,
then waited only for 32X DREQ length zero. It neither proved normal DMAC
completion nor acknowledged the sticky CHCR0.TE flag. A later DE write cannot
re-arm a channel while TE remains set.

## Primary-source rule

`docs/sh7604-hardware-manual.md` §9.2.4 states:

- IE=1 requests a DEI interrupt when TE is set;
- TCR reaching zero sets TE;
- TE must be read as 1 and then written as 0;
- TE=1 prevents DE from enabling another transfer.

Section 9.3.1 requires `DE=1, DME=1, TE=0, NMIF=0, AE=0` to start, and §9.3.8
identifies TCR=0/TE=1 as the normal per-channel transfer end.

## Repaired lifecycle

1. Program SAR0, DAR0, and TCR0.
2. Program CHCR0=`$000044E1`: destination increment, fixed source, word
   transfers, external request, IE=0, TE=0, DE=1.
3. Enable DMAOR.DME and read DMAOR back from the same address.
4. Clear and read back COMM0_LO to publish producer readiness; require
   COMM0_LO=0 and COMM0_HI=1.
5. After DREQ length zero, poll CHCR0 until TE=1.
6. That final poll is the documented read-as-1.
7. Write CHCR0=`$000044E0`, clearing TE and DE.
8. Read CHCR0 back and require low bits `IE:TE:DE=000`.
9. Only then write and read back COMM0 completion.

Leaving DE=0 prevents a later transaction from requesting a transfer against
stale SAR/DAR/TCR state. The next command re-arms only after rewriting all three
registers.

## Exact SH2 witnesses

The relevant assembled sequence is:

```text
02303A2E  D118  MOV.L @(CHCR0,PC),R1
02303A30  D018  MOV.L @($000044E1,PC),R0
02303A32  2102  MOV.L R0,@R1

02303A3E  8081  MOV.B R0,@(1,R8)
02303A40  8481  MOV.B @(1,R8),R0
02303A42  2008  TST R0,R0
02303A46  6080  MOV.B @R8,R0
02303A48  8801  CMP/EQ #1,R0

02303A4E  6011  MOV.W @DREQ_LEN,R0
02303A50  2008  TST R0,R0
02303A52  8BFC  BF $02303A4E

02303A54  D10E  MOV.L @(CHCR0,PC),R1
02303A56  6012  MOV.L @R1,R0
02303A58  C802  TST #2,R0
02303A5A  89FC  BT $02303A56
02303A5C  D00E  MOV.L @($000044E0,PC),R0
02303A5E  2102  MOV.L R0,@R1
02303A60  6012  MOV.L @R1,R0
02303A62  C807  TST #7,R0
02303A64  8B05  BF fail_stop

02303A68  8080  MOV.B R0,@(0,R8)
02303A6A  8480  MOV.B @(0,R8),R0
```

Literal witnesses:

```text
02303A90  FFFFFF8C  CHCR0
02303A94  000044E1  active, non-interrupt
02303A98  000044E0  idle, TE/DE cleared
```

Handler allocation: file `$303A10-$303AA7`

Literal pool: file `$303A78-$303AA7`

Handler binary SHA-256:
`d1fc1dcb28db09f049bed70e3669cdd2de9cba285b79c64a6ec0130db89e68ee`

## Static validation

The ROM verifier:

- rejects `$44E5`;
- requires `$44E1` active and `$44E0` idle literals;
- pins the TE poll/read-1/write-0/readback opcode sequence;
- models two consecutive arm -> TE -> acknowledge -> disabled-idle cycles;
- rejects an active value with IE set or an idle value with DE/TE/IE set;
- pins DMAC enable synchronization and COMM0_LO readiness/readback/HI guard;
- continues to pin all literal-pool users and zero COMM1/COMM2/COMM7 access.

Runtime/reset/MMIO eligibility remains blocked exactly as before. No runtime
acceptance or promotion claim is made.
