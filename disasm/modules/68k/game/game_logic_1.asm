; Generated assembly for $006200-$008200
; Branch targets: 312
; Labels: 245
; Format: DC.W with decoded mnemonics as comments

        org     $006200

        DC.W    $6702               ; $006200 BEQ.S  loc_006204
        DC.W    $7004               ; $006202 MOVEQ   #$04,D0
loc_006204:
        DC.W    $227B,$003A         ; $006204 MOVEA.L $3A(PC,D0.W),A1
        DC.W    $4E91               ; $006208 JSR     (A1)
        DC.W    $0C78,$0014,$C8AA   ; $00620A CMPI.W  #$0014,$C8AA.W
        DC.W    $662C               ; $006210 BNE.S  loc_00623E
        DC.W    $11FC,$0000,$C800   ; $006212 MOVE.B  #$0000,$C800.W
        DC.W    $31F8,$C092,$C07A   ; $006218 MOVE.W  $C092.W,$C07A.W
        DC.W    $31FC,$0004,$C8AC   ; $00621E MOVE.W  #$0004,$C8AC.W
        DC.W    $4A78,$C89C         ; $006224 TST.W  $C89C.W
        DC.W    $6706               ; $006228 BEQ.S  loc_006230
        DC.W    $31FC,$0020,$C8AC   ; $00622A MOVE.W  #$0020,$C8AC.W
loc_006230:
        DC.W    $0838,$0007,$C81C   ; $006230 BTST    #7,$C81C.W
        DC.W    $6706               ; $006236 BEQ.S  loc_00623E
        DC.W    $31FC,$0020,$C8AC   ; $006238 MOVE.W  #$0020,$C8AC.W
loc_00623E:
        DC.W    $4E75               ; $00623E RTS
        DC.W    $0088,$3C7E,$0088   ; $006240 ORI.L  #$3C7E0088,A0
        DC.W    $3D5A,$0088         ; $006246 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $00624A MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $00624E MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $006252 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$7000         ; $006256 MOVE.W  (A2)+,$7000(A6)
        DC.W    $3140,$0044         ; $00625A MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $00625E MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006262 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$0EE2         ; $006266 JSR     loc_00714A(PC)
        DC.W    $4EBA,$13E2         ; $00626A JSR     loc_00764E(PC)
        DC.W    $4EBA,$2458         ; $00626E JSR     $0086C8(PC)
        DC.W    $4EBA,$CEB2         ; $006272 JSR     $003126(PC)
        DC.W    $4EBA,$CEE8         ; $006276 JSR     $003160(PC)
        DC.W    $4EBA,$13A8         ; $00627A JSR     loc_007624(PC)
        DC.W    $4EBA,$10CE         ; $00627E JSR     loc_00734E(PC)
        DC.W    $11F8,$C304,$C30C   ; $006282 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EB9,$0088,$6C88   ; $006288 JSR     $00886C88
        DC.W    $4EFA,$E71A         ; $00628E JMP     $0049AA(PC)
        DC.W    $7000               ; $006292 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006294 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006298 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $00629C MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970; $0062A0 MOVE.L  #$00100010,$C970.W
        DC.W    $317C,$0002,$0092   ; $0062A8 MOVE.W  #$0002,$0092(A0)
        DC.W    $4EBA,$22EA         ; $0062AE JSR     $00859A(PC)
        DC.W    $4EBA,$409C         ; $0062B2 JSR     $00A350(PC)
        DC.W    $4EBA,$1EB8         ; $0062B6 JSR     loc_008170(PC)
        DC.W    $4EBA,$1E10         ; $0062BA JSR     loc_0080CC(PC)
        DC.W    $4EBA,$2288         ; $0062BE JSR     $008548(PC)
        DC.W    $4EBA,$3236         ; $0062C2 JSR     $0094FA(PC)
        DC.W    $4EBA,$304A         ; $0062C6 JSR     $009312(PC)
        DC.W    $4EBA,$3846         ; $0062CA JSR     $009B12(PC)
        DC.W    $4EBA,$2EB2         ; $0062CE JSR     $009182(PC)
        DC.W    $4EBA,$334A         ; $0062D2 JSR     $00961E(PC)
        DC.W    $4EBA,$33B0         ; $0062D6 JSR     $009688(PC)
        DC.W    $4EBA,$3526         ; $0062DA JSR     $009802(PC)
        DC.W    $4EBA,$1B9A         ; $0062DE JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0CB4         ; $0062E2 JSR     loc_006F98(PC)
        DC.W    $4EBA,$19F0         ; $0062E6 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$4148         ; $0062EA JSR     $00A434(PC)
        DC.W    $4EBA,$0DBA         ; $0062EE JSR     loc_0070AA(PC)
        DC.W    $4EBA,$1C10         ; $0062F2 JSR     loc_007F04(PC)
        DC.W    $4EBA,$1956         ; $0062F6 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0E4E         ; $0062FA JSR     loc_00714A(PC)
        DC.W    $4EBA,$134E         ; $0062FE JSR     loc_00764E(PC)
        DC.W    $4EBA,$1C4C         ; $006302 JSR     loc_007F50(PC)
        DC.W    $4EBA,$39C6         ; $006306 JSR     $009CCE(PC)
        DC.W    $4EBA,$3848         ; $00630A JSR     $009B54(PC)
        DC.W    $4EBA,$23B8         ; $00630E JSR     $0086C8(PC)
        DC.W    $4EBA,$49C0         ; $006312 JSR     $00ACD4(PC)
        DC.W    $4EBA,$E116         ; $006316 JSR     $00442E(PC)
        DC.W    $4EBA,$CE0A         ; $00631A JSR     $003126(PC)
        DC.W    $4EBA,$CE40         ; $00631E JSR     $003160(PC)
        DC.W    $4EBA,$1300         ; $006322 JSR     loc_007624(PC)
        DC.W    $4EBA,$1026         ; $006326 JSR     loc_00734E(PC)
        DC.W    $4EBA,$D3B2         ; $00632A JSR     $0036DE(PC)
        DC.W    $4EBA,$D486         ; $00632E JSR     $0037B6(PC)
        DC.W    $4EBA,$DC52         ; $006332 JSR     $003F86(PC)
        DC.W    $4EFA,$2D2C         ; $006336 JMP     $009064(PC)
        DC.W    $7000               ; $00633A MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $00633C MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006340 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006344 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1D82         ; $006348 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$21FA         ; $00634C JSR     $008548(PC)
        DC.W    $4EBA,$34B0         ; $006350 JSR     $009802(PC)
        DC.W    $4EBA,$1B24         ; $006354 JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0C3E         ; $006358 JSR     loc_006F98(PC)
        DC.W    $4EBA,$197A         ; $00635C JSR     loc_007CD8(PC)
        DC.W    $4EBA,$0D48         ; $006360 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$0DE4         ; $006364 JSR     loc_00714A(PC)
        DC.W    $4EBA,$12E4         ; $006368 JSR     loc_00764E(PC)
        DC.W    $4EBA,$1BE2         ; $00636C JSR     loc_007F50(PC)
        DC.W    $4EBA,$395C         ; $006370 JSR     $009CCE(PC)
        DC.W    $4EBA,$37DE         ; $006374 JSR     $009B54(PC)
        DC.W    $4EBA,$2400         ; $006378 JSR     $00877A(PC)
        DC.W    $4EBA,$2D26         ; $00637C JSR     $0090A4(PC)
        DC.W    $4EBA,$CDA4         ; $006380 JSR     $003126(PC)
        DC.W    $4EBA,$1278         ; $006384 JSR     loc_0075FE(PC)
        DC.W    $4EBA,$0E1C         ; $006388 JSR     loc_0071A6(PC)
        DC.W    $4EBA,$D350         ; $00638C JSR     $0036DE(PC)
        DC.W    $4EFA,$D424         ; $006390 JMP     $0037B6(PC)
        DC.W    $7000               ; $006394 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006396 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $00639A MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $00639E MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970; $0063A2 MOVE.L  #$00100010,$C970.W
        DC.W    $317C,$0002,$0092   ; $0063AA MOVE.W  #$0002,$0092(A0)
        DC.W    $08B8,$0004,$C30E   ; $0063B0 BCLR    #4,$C30E.W
        DC.W    $4EBA,$21E2         ; $0063B6 JSR     $00859A(PC)
        DC.W    $4EBA,$218C         ; $0063BA JSR     $008548(PC)
        DC.W    $4EBA,$2F52         ; $0063BE JSR     $009312(PC)
        DC.W    $4EBA,$374E         ; $0063C2 JSR     $009B12(PC)
        DC.W    $4EBA,$2DBA         ; $0063C6 JSR     $009182(PC)
        DC.W    $4EBA,$3252         ; $0063CA JSR     $00961E(PC)
        DC.W    $4EBA,$0BC8         ; $0063CE JSR     loc_006F98(PC)
        DC.W    $4EBA,$4060         ; $0063D2 JSR     $00A434(PC)
        DC.W    $4EBA,$0CD2         ; $0063D6 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$1872         ; $0063DA JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0D6A         ; $0063DE JSR     loc_00714A(PC)
        DC.W    $4EBA,$126A         ; $0063E2 JSR     loc_00764E(PC)
        DC.W    $4EBA,$38E6         ; $0063E6 JSR     $009CCE(PC)
        DC.W    $4EBA,$3768         ; $0063EA JSR     $009B54(PC)
        DC.W    $4EBA,$238A         ; $0063EE JSR     $00877A(PC)
        DC.W    $4EBA,$2CB0         ; $0063F2 JSR     $0090A4(PC)
        DC.W    $4EBA,$CD2E         ; $0063F6 JSR     $003126(PC)
        DC.W    $4EBA,$1202         ; $0063FA JSR     loc_0075FE(PC)
        DC.W    $4EBA,$0DA6         ; $0063FE JSR     loc_0071A6(PC)
        DC.W    $4EBA,$D2DA         ; $006402 JSR     $0036DE(PC)
        DC.W    $4EBA,$D3AE         ; $006406 JSR     $0037B6(PC)
        DC.W    $4EFA,$DB7A         ; $00640A JMP     $003F86(PC)
        DC.W    $49F8,$A000         ; $00640E LEA     $A000.W,A4
        DC.W    $41F8,$9000         ; $006412 LEA     $9000.W,A0
        DC.W    $11F8,$FEAF,$C30F   ; $006416 MOVE.B  $FEAF.W,$C30F.W
        DC.W    $4EBA,$07A0         ; $00641C JSR     loc_006BBE(PC)
        DC.W    $2168,$00B2,$0018   ; $006420 MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; $006426 MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; $00642A ANDI.B  #$0006,D1
        DC.W    $6706               ; $00642E BEQ.S  loc_006436
        DC.W    $2178,$C70C,$0018   ; $006430 MOVE.L  $C70C.W,$0018(A0)
loc_006436:
        DC.W    $3038,$C07A         ; $006436 MOVE.W  $C07A.W,D0
        DC.W    $43FA,$0160         ; $00643A LEA     $0160(PC),A1
        DC.W    $2271,$0000         ; $00643E MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; $006442 JSR     (A1)
        DC.W    $4EBA,$1ABE         ; $006444 JSR     loc_007F04(PC)
        DC.W    $4EBA,$1F72         ; $006448 JSR     $0083BC(PC)
        DC.W    $43F8,$9F00         ; $00644C LEA     $9F00.W,A1
        DC.W    $4EBA,$2220         ; $006450 JSR     $008672(PC)
        DC.W    $43F8,$819C         ; $006454 LEA     $819C.W,A1
        DC.W    $4EBA,$2C74         ; $006458 JSR     $0090CE(PC)
        DC.W    $45F8,$C000         ; $00645C LEA     $C000.W,A2
        DC.W    $43F8,$B400         ; $006460 LEA     $B400.W,A1
        DC.W    $7E1F               ; $006464 MOVEQ   #$1F,D7
loc_006466:
        DC.W    $4CDA,$087F         ; $006466 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+
        DC.W    $48E1,$FE10         ; $00646A MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $00646E DBRA    D7,loc_006466
        DC.W    $21F8,$C970,$C978   ; $006472 MOVE.L  $C970.W,$C978.W
        DC.W    $21F8,$C974,$C970   ; $006478 MOVE.L  $C974.W,$C970.W
        DC.W    $43F8,$B400         ; $00647E LEA     $B400.W,A1
        DC.W    $45F8,$C400         ; $006482 LEA     $C400.W,A2
        DC.W    $7E1F               ; $006486 MOVEQ   #$1F,D7
loc_006488:
        DC.W    $4CD9,$087F         ; $006488 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+
        DC.W    $48E2,$FE10         ; $00648C MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $006490 DBRA    D7,loc_006488
        DC.W    $4E75               ; $006494 RTS
        DC.W    $49F8,$A000         ; $006496 LEA     $A000.W,A4
        DC.W    $41F8,$9F00         ; $00649A LEA     $9F00.W,A0
        DC.W    $11F8,$FEB0,$C30F   ; $00649E MOVE.B  $FEB0.W,$C30F.W
        DC.W    $4EBA,$0718         ; $0064A4 JSR     loc_006BBE(PC)
        DC.W    $2168,$00B2,$0018   ; $0064A8 MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; $0064AE MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; $0064B2 ANDI.B  #$0006,D1
        DC.W    $6706               ; $0064B6 BEQ.S  loc_0064BE
        DC.W    $2178,$C70C,$0018   ; $0064B8 MOVE.L  $C70C.W,$0018(A0)
loc_0064BE:
        DC.W    $3038,$C07A         ; $0064BE MOVE.W  $C07A.W,D0
        DC.W    $43FA,$00D8         ; $0064C2 LEA     $00D8(PC),A1
        DC.W    $2271,$0000         ; $0064C6 MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; $0064CA JSR     (A1)
        DC.W    $4EBA,$398C         ; $0064CC JSR     $009E5A(PC)
        DC.W    $4EBA,$1A2A         ; $0064D0 JSR     loc_007EFC(PC)
        DC.W    $4EBA,$1F04         ; $0064D4 JSR     $0083DA(PC)
        DC.W    $4EBA,$2308         ; $0064D8 JSR     $0087E2(PC)
        DC.W    $41F8,$9F00         ; $0064DC LEA     $9F00.W,A0
        DC.W    $43F8,$9000         ; $0064E0 LEA     $9000.W,A1
        DC.W    $4EBA,$218C         ; $0064E4 JSR     $008672(PC)
        DC.W    $43F8,$831C         ; $0064E8 LEA     $831C.W,A1
        DC.W    $4EBA,$2BE0         ; $0064EC JSR     $0090CE(PC)
        DC.W    $41F8,$9000         ; $0064F0 LEA     $9000.W,A0
        DC.W    $4EBA,$3964         ; $0064F4 JSR     $009E5A(PC)
        DC.W    $4EBA,$4A1E         ; $0064F8 JSR     $00AF18(PC)
        DC.W    $41F8,$9F00         ; $0064FC LEA     $9F00.W,A0
        DC.W    $317C,$0000,$008A   ; $006500 MOVE.W  #$0000,$008A(A0)
        DC.W    $4EBA,$3CF4         ; $006506 JSR     $00A1FC(PC)
        DC.W    $4EBA,$10F2         ; $00650A JSR     loc_0075FE(PC)
        DC.W    $4EBA,$0D60         ; $00650E JSR     loc_007270(PC)
        DC.W    $4EBA,$C6F0         ; $006512 JSR     $002C04(PC)
        DC.W    $4EBA,$CE62         ; $006516 JSR     $00337A(PC)
        DC.W    $4EBA,$D60C         ; $00651A JSR     $003B28(PC)
        DC.W    $4EBA,$DA3A         ; $00651E JSR     $003F5A(PC)
        DC.W    $11F8,$C304,$C30C   ; $006522 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EBA,$06C0         ; $006528 JSR     loc_006BEA(PC)
        DC.W    $45F8,$C000         ; $00652C LEA     $C000.W,A2
        DC.W    $43F8,$B800         ; $006530 LEA     $B800.W,A1
        DC.W    $7E1F               ; $006534 MOVEQ   #$1F,D7
loc_006536:
        DC.W    $4CDA,$087F         ; $006536 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+
        DC.W    $48E1,$FE10         ; $00653A MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $00653E DBRA    D7,loc_006536
        DC.W    $21F8,$C978,$C970   ; $006542 MOVE.L  $C978.W,$C970.W
        DC.W    $43F8,$B000         ; $006548 LEA     $B000.W,A1
        DC.W    $45F8,$C400         ; $00654C LEA     $C400.W,A2
        DC.W    $7E1F               ; $006550 MOVEQ   #$1F,D7
loc_006552:
        DC.W    $4CD9,$087F         ; $006552 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+
        DC.W    $48E2,$FE10         ; $006556 MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $00655A DBRA    D7,loc_006552
        DC.W    $41F8,$9000         ; $00655E LEA     $9000.W,A0
        DC.W    $43F8,$9F00         ; $006562 LEA     $9F00.W,A1
        DC.W    $4EBA,$1EB0         ; $006566 JSR     $008418(PC)
        DC.W    $4EBA,$3954         ; $00656A JSR     $009EC0(PC)
        DC.W    $317C,$0000,$008A   ; $00656E MOVE.W  #$0000,$008A(A0)
        DC.W    $4EBA,$3C86         ; $006574 JSR     $00A1FC(PC)
        DC.W    $4EBA,$1084         ; $006578 JSR     loc_0075FE(PC)
        DC.W    $4EBA,$0CE2         ; $00657C JSR     loc_007260(PC)
        DC.W    $4EBA,$C62E         ; $006580 JSR     $002BB0(PC)
        DC.W    $4EBA,$CDF4         ; $006584 JSR     $00337A(PC)
        DC.W    $4EBA,$D22C         ; $006588 JSR     $0037B6(PC)
        DC.W    $4EBA,$D9A0         ; $00658C JSR     $003F2E(PC)
        DC.W    $11F8,$C304,$C30C   ; $006590 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EBA,$0652         ; $006596 JSR     loc_006BEA(PC)
        DC.W    $4E75               ; $00659A RTS
        DC.W    $0088,$65BC,$0088   ; $00659C ORI.L  #$65BC0088,A0
        DC.W    $6804               ; $0065A2 BVC.S  loc_0065A8
        DC.W    $0088,$662A,$0088   ; $0065A4 ORI.L  #$662A0088,A0
        DC.W    $66B4               ; $0065AA BNE.S  loc_006560
        DC.W    $0088,$671A,$0088   ; $0065AC ORI.L  #$671A0088,A0
        DC.W    $6718               ; $0065B2 BEQ.S  loc_0065CC
        DC.W    $0088,$677A,$0088   ; $0065B4 ORI.L  #$677A0088,A0
        DC.W    $6636               ; $0065BA BNE.S  loc_0065F2
        DC.W    $4EBA,$51B2         ; $0065BC JSR     $00B770(PC)
        DC.W    $7000               ; $0065C0 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $0065C2 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $0065C6 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $0065CA MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$2040         ; $0065CE JSR     $008610(PC)
        DC.W    $4EBA,$1FC6         ; $0065D2 JSR     $00859A(PC)
        DC.W    $4EBA,$3D78         ; $0065D6 JSR     $00A350(PC)
        DC.W    $4EBA,$1B94         ; $0065DA JSR     loc_008170(PC)
        DC.W    $4EBA,$1AEC         ; $0065DE JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1F64         ; $0065E2 JSR     $008548(PC)
        DC.W    $4EBA,$2F12         ; $0065E6 JSR     $0094FA(PC)
        DC.W    $4EBA,$2D26         ; $0065EA JSR     $009312(PC)
        DC.W    $4EBA,$3522         ; $0065EE JSR     $009B12(PC)
loc_0065F2:
        DC.W    $4EBA,$2B8E         ; $0065F2 JSR     $009182(PC)
        DC.W    $4EBA,$3026         ; $0065F6 JSR     $00961E(PC)
        DC.W    $4EBA,$308C         ; $0065FA JSR     $009688(PC)
        DC.W    $4EBA,$3202         ; $0065FE JSR     $009802(PC)
        DC.W    $4EBA,$1876         ; $006602 JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0990         ; $006606 JSR     loc_006F98(PC)
        DC.W    $4EBA,$16CC         ; $00660A JSR     loc_007CD8(PC)
        DC.W    $4EBA,$3E24         ; $00660E JSR     $00A434(PC)
        DC.W    $4EBA,$0A96         ; $006612 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$1636         ; $006616 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0B2E         ; $00661A JSR     loc_00714A(PC)
        DC.W    $4EBA,$102E         ; $00661E JSR     loc_00764E(PC)
        DC.W    $4EBA,$1A0E         ; $006622 JSR     loc_008032(PC)
        DC.W    $4EFA,$352C         ; $006626 JMP     $009B54(PC)
        DC.W    $317C,$0000,$0006   ; $00662A MOVE.W  #$0000,$0006(A0)
        DC.W    $317C,$0000,$0074   ; $006630 MOVE.W  #$0000,$0074(A0)
        DC.W    $4EBA,$5138         ; $006636 JSR     $00B770(PC)
        DC.W    $7000               ; $00663A MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $00663C MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006640 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006644 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$E3C2         ; $006648 JSR     $004A0C(PC)
        DC.W    $4EBA,$1F4C         ; $00664C JSR     $00859A(PC)
        DC.W    $4EBA,$3CFE         ; $006650 JSR     $00A350(PC)
        DC.W    $4EBA,$1B1A         ; $006654 JSR     loc_008170(PC)
        DC.W    $4EBA,$1A72         ; $006658 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1EEA         ; $00665C JSR     $008548(PC)
        DC.W    $4EBA,$2E98         ; $006660 JSR     $0094FA(PC)
        DC.W    $0C78,$0004,$C26C   ; $006664 CMPI.W  #$0004,$C26C.W
        DC.W    $6704               ; $00666A BEQ.S  loc_006670
        DC.W    $4EBA,$2CA4         ; $00666C JSR     $009312(PC)
loc_006670:
        DC.W    $4EBA,$34A0         ; $006670 JSR     $009B12(PC)
        DC.W    $4EBA,$2B0C         ; $006674 JSR     $009182(PC)
        DC.W    $4EBA,$3188         ; $006678 JSR     $009802(PC)
        DC.W    $4EBA,$0A06         ; $00667C JSR     loc_007084(PC)
        DC.W    $4EBA,$0A28         ; $006680 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$1190         ; $006684 JSR     loc_007816(PC)
        DC.W    $5378,$C02C         ; $006688 SUBQ.W  #1,$C02C.W
        DC.W    $6E12               ; $00668C BGT.S  loc_0066A0
        DC.W    $31FC,$0000,$C02C   ; $00668E MOVE.W  #$0000,$C02C.W
        DC.W    $317C,$0000,$0074   ; $006694 MOVE.W  #$0000,$0074(A0)
        DC.W    $31F8,$C08C,$C07A   ; $00669A MOVE.W  $C08C.W,$C07A.W
loc_0066A0:
        DC.W    $4EBA,$15AC         ; $0066A0 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0AA4         ; $0066A4 JSR     loc_00714A(PC)
        DC.W    $4EBA,$0FA4         ; $0066A8 JSR     loc_00764E(PC)
        DC.W    $4EBA,$1984         ; $0066AC JSR     loc_008032(PC)
        DC.W    $4EFA,$34A2         ; $0066B0 JMP     $009B54(PC)
        DC.W    $4EBA,$50BA         ; $0066B4 JSR     $00B770(PC)
        DC.W    $7000               ; $0066B8 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $0066BA MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $0066BE MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $0066C2 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1ED2         ; $0066C6 JSR     $00859A(PC)
        DC.W    $4EBA,$3C84         ; $0066CA JSR     $00A350(PC)
        DC.W    $4EBA,$1AA0         ; $0066CE JSR     loc_008170(PC)
        DC.W    $4EBA,$19F8         ; $0066D2 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1E70         ; $0066D6 JSR     $008548(PC)
        DC.W    $4EBA,$3126         ; $0066DA JSR     $009802(PC)
        DC.W    $4EBA,$179A         ; $0066DE JSR     loc_007E7A(PC)
        DC.W    $4EBA,$08B4         ; $0066E2 JSR     loc_006F98(PC)
        DC.W    $4EBA,$15F0         ; $0066E6 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$3D48         ; $0066EA JSR     $00A434(PC)
        DC.W    $4EBA,$09BA         ; $0066EE JSR     loc_0070AA(PC)
        DC.W    $4EBA,$155A         ; $0066F2 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0A52         ; $0066F6 JSR     loc_00714A(PC)
        DC.W    $4EBA,$0F52         ; $0066FA JSR     loc_00764E(PC)
        DC.W    $4EBA,$1932         ; $0066FE JSR     loc_008032(PC)
        DC.W    $4EBA,$2F1A         ; $006702 JSR     $00961E(PC)
        DC.W    $4EBA,$41F0         ; $006706 JSR     $00A8F8(PC)
        DC.W    $0838,$0004,$C30E   ; $00670A BTST    #4,$C30E.W
        DC.W    $6706               ; $006710 BEQ.S  loc_006718
        DC.W    $31F8,$C08C,$C07A   ; $006712 MOVE.W  $C08C.W,$C07A.W
loc_006718:
        DC.W    $4E75               ; $006718 RTS
        DC.W    $4EBA,$5054         ; $00671A JSR     $00B770(PC)
        DC.W    $11FC,$0001,$C800   ; $00671E MOVE.B  #$0001,$C800.W
        DC.W    $7000               ; $006724 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006726 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $00672A MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $00672E MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1998         ; $006732 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1E10         ; $006736 JSR     $008548(PC)
        DC.W    $4EBA,$30C6         ; $00673A JSR     $009802(PC)
        DC.W    $4EBA,$173A         ; $00673E JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0854         ; $006742 JSR     loc_006F98(PC)
        DC.W    $4EBA,$1590         ; $006746 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$095E         ; $00674A JSR     loc_0070AA(PC)
        DC.W    $4EBA,$09FA         ; $00674E JSR     loc_00714A(PC)
        DC.W    $4EBA,$0EFA         ; $006752 JSR     loc_00764E(PC)
        DC.W    $4EBA,$18DA         ; $006756 JSR     loc_008032(PC)
        DC.W    $4EBA,$33F8         ; $00675A JSR     $009B54(PC)
        DC.W    $0C78,$0014,$C8AA   ; $00675E CMPI.W  #$0014,$C8AA.W
        DC.W    $6612               ; $006764 BNE.S  loc_006778
        DC.W    $31F8,$C092,$C07A   ; $006766 MOVE.W  $C092.W,$C07A.W
        DC.W    $11FC,$0000,$C800   ; $00676C MOVE.B  #$0000,$C800.W
        DC.W    $31FC,$0030,$C8AC   ; $006772 MOVE.W  #$0030,$C8AC.W
loc_006778:
        DC.W    $4E75               ; $006778 RTS
        DC.W    $7000               ; $00677A MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $00677C MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006780 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006784 MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970; $006788 MOVE.L  #$00100010,$C970.W
        DC.W    $11FC,$0000,$C30F   ; $006790 MOVE.B  #$0000,$C30F.W
        DC.W    $4EBA,$4FD8         ; $006796 JSR     $00B770(PC)
        DC.W    $317C,$0002,$0092   ; $00679A MOVE.W  #$0002,$0092(A0)
        DC.W    $4EBA,$1DF8         ; $0067A0 JSR     $00859A(PC)
        DC.W    $4EBA,$3BAA         ; $0067A4 JSR     $00A350(PC)
        DC.W    $4EBA,$19C6         ; $0067A8 JSR     loc_008170(PC)
        DC.W    $4EBA,$191E         ; $0067AC JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1D96         ; $0067B0 JSR     $008548(PC)
        DC.W    $4EBA,$2D44         ; $0067B4 JSR     $0094FA(PC)
        DC.W    $4EBA,$2B58         ; $0067B8 JSR     $009312(PC)
        DC.W    $4EBA,$3354         ; $0067BC JSR     $009B12(PC)
        DC.W    $4EBA,$29C0         ; $0067C0 JSR     $009182(PC)
        DC.W    $4EBA,$2E58         ; $0067C4 JSR     $00961E(PC)
        DC.W    $4EBA,$2EBE         ; $0067C8 JSR     $009688(PC)
        DC.W    $4EBA,$3034         ; $0067CC JSR     $009802(PC)
        DC.W    $4EBA,$16A8         ; $0067D0 JSR     loc_007E7A(PC)
        DC.W    $4EBA,$07C2         ; $0067D4 JSR     loc_006F98(PC)
        DC.W    $4EBA,$14FE         ; $0067D8 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$3C56         ; $0067DC JSR     $00A434(PC)
        DC.W    $4EBA,$08C8         ; $0067E0 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$1468         ; $0067E4 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0960         ; $0067E8 JSR     loc_00714A(PC)
        DC.W    $4EBA,$0E60         ; $0067EC JSR     loc_00764E(PC)
        DC.W    $4EBA,$1840         ; $0067F0 JSR     loc_008032(PC)
        DC.W    $4EBA,$335E         ; $0067F4 JSR     $009B54(PC)
        DC.W    $4EBA,$DCEE         ; $0067F8 JSR     $0044E8(PC)
        DC.W    $4EBA,$C918         ; $0067FC JSR     $003116(PC)
        DC.W    $4EFA,$DD1A         ; $006800 JMP     $00451C(PC)
        DC.W    $4EBA,$4F6A         ; $006804 JSR     $00B770(PC)
        DC.W    $4EBA,$3B46         ; $006808 JSR     $00A350(PC)
        DC.W    $4EBA,$1962         ; $00680C JSR     loc_008170(PC)
        DC.W    $4EBA,$18BA         ; $006810 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1D32         ; $006814 JSR     $008548(PC)
        DC.W    $4EBA,$2E04         ; $006818 JSR     $00961E(PC)
        DC.W    $4EBA,$0FF8         ; $00681C JSR     loc_007816(PC)
        DC.W    $4EBA,$0E2C         ; $006820 JSR     loc_00764E(PC)
        DC.W    $4EBA,$0884         ; $006824 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$40B6         ; $006828 JSR     $00A8E0(PC)
        DC.W    $4EBA,$3326         ; $00682C JSR     $009B54(PC)
        DC.W    $4EBA,$2950         ; $006830 JSR     $009182(PC)
        DC.W    $4EBA,$2FCC         ; $006834 JSR     $009802(PC)
        DC.W    $4EBA,$0910         ; $006838 JSR     loc_00714A(PC)
        DC.W    $4EFA,$D486         ; $00683C JMP     $003CC4(PC)
        DC.W    $49F8,$A000         ; $006840 LEA     $A000.W,A4
        DC.W    $41F8,$9000         ; $006844 LEA     $9000.W,A0
        DC.W    $317C,$0002,$00AC   ; $006848 MOVE.W  #$0002,$00AC(A0)
        DC.W    $11F8,$FEAA,$C30F   ; $00684E MOVE.B  $FEAA.W,$C30F.W
        DC.W    $4EBA,$0368         ; $006854 JSR     loc_006BBE(PC)
        DC.W    $2168,$00B2,$0018   ; $006858 MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; $00685E MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; $006862 ANDI.B  #$0006,D1
        DC.W    $6706               ; $006866 BEQ.S  loc_00686E
        DC.W    $2178,$C70C,$0018   ; $006868 MOVE.L  $C70C.W,$0018(A0)
loc_00686E:
        DC.W    $3038,$C07A         ; $00686E MOVE.W  $C07A.W,D0
        DC.W    $227B,$0034         ; $006872 MOVEA.L $34(PC,D0.W),A1
        DC.W    $4E91               ; $006876 JSR     (A1)
        DC.W    $4EBA,$168A         ; $006878 JSR     loc_007F04(PC)
loc_00687C:
        DC.W    $4EBA,$27C2         ; $00687C JSR     $009040(PC)
        DC.W    $4EBA,$19DA         ; $006880 JSR     $00825C(PC)
        DC.W    $4EBA,$363A         ; $006884 JSR     $009EC0(PC)
loc_006888:
        DC.W    $4EBA,$0D74         ; $006888 JSR     loc_0075FE(PC)
        DC.W    $4EBA,$0918         ; $00688C JSR     loc_0071A6(PC)
        DC.W    $4EBA,$C0F2         ; $006890 JSR     $002984(PC)
        DC.W    $4EBA,$CC52         ; $006894 JSR     $0034E8(PC)
        DC.W    $4EBA,$CF1C         ; $006898 JSR     $0037B6(PC)
        DC.W    $4EBA,$D6E8         ; $00689C JSR     $003F86(PC)
        DC.W    $4EBA,$D422         ; $0068A0 JSR     $003CC4(PC)
        DC.W    $4EFA,$0344         ; $0068A4 JMP     loc_006BEA(PC)
        DC.W    $0088,$68C8,$0088   ; $0068A8 ORI.L  #$68C80088,A0
        DC.W    $6ACC               ; $0068AE BPL.S  loc_00687C
        DC.W    $0088,$693E,$0088   ; $0068B0 ORI.L  #$693E0088,A0
        DC.W    $69D0               ; $0068B6 BVS.S  loc_006888
        DC.W    $0088,$6A3A,$0088   ; $0068B8 ORI.L  #$6A3A0088,A0
        DC.W    $6A38               ; $0068BE BPL.S  loc_0068F8
        DC.W    $0088,$6B04,$0088   ; $0068C0 ORI.L  #$6B040088,A0
        DC.W    $694A               ; $0068C6 BVS.S  loc_006912
        DC.W    $4EBA,$4EA6         ; $0068C8 JSR     $00B770(PC)
        DC.W    $7000               ; $0068CC MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $0068CE MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $0068D2 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $0068D6 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1CE8         ; $0068DA JSR     $0085C4(PC)
        DC.W    $4EBA,$1CBA         ; $0068DE JSR     $00859A(PC)
        DC.W    $4EBA,$3A6C         ; $0068E2 JSR     $00A350(PC)
        DC.W    $4EBA,$1888         ; $0068E6 JSR     loc_008170(PC)
        DC.W    $4EBA,$17E0         ; $0068EA JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1C58         ; $0068EE JSR     $008548(PC)
        DC.W    $4EBA,$2C06         ; $0068F2 JSR     $0094FA(PC)
        DC.W    $4EBA,$2A1A         ; $0068F6 JSR     $009312(PC)
        DC.W    $4EBA,$3216         ; $0068FA JSR     $009B12(PC)
        DC.W    $4EBA,$2882         ; $0068FE JSR     $009182(PC)
        DC.W    $4EBA,$2D1A         ; $006902 JSR     $00961E(PC)
        DC.W    $4EBA,$2D80         ; $006906 JSR     $009688(PC)
        DC.W    $4EBA,$2EF6         ; $00690A JSR     $009802(PC)
        DC.W    $4EBA,$156A         ; $00690E JSR     loc_007E7A(PC)
loc_006912:
        DC.W    $4EBA,$0684         ; $006912 JSR     loc_006F98(PC)
        DC.W    $4EBA,$13C0         ; $006916 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$3B18         ; $00691A JSR     $00A434(PC)
        DC.W    $4EBA,$078A         ; $00691E JSR     loc_0070AA(PC)
        DC.W    $4EBA,$354A         ; $006922 JSR     $009E6E(PC)
        DC.W    $4EBA,$1326         ; $006926 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$081E         ; $00692A JSR     loc_00714A(PC)
        DC.W    $4EBA,$0D1E         ; $00692E JSR     loc_00764E(PC)
        DC.W    $4EBA,$161C         ; $006932 JSR     loc_007F50(PC)
        DC.W    $4EBA,$4306         ; $006936 JSR     $00AC3E(PC)
        DC.W    $4EFA,$3218         ; $00693A JMP     $009B54(PC)
        DC.W    $317C,$0000,$0006   ; $00693E MOVE.W  #$0000,$0006(A0)
        DC.W    $317C,$0000,$0074   ; $006944 MOVE.W  #$0000,$0074(A0)
        DC.W    $4EBA,$4E24         ; $00694A JSR     $00B770(PC)
        DC.W    $7000               ; $00694E MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006950 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006954 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006958 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$E0AE         ; $00695C JSR     $004A0C(PC)
        DC.W    $4EBA,$1C38         ; $006960 JSR     $00859A(PC)
        DC.W    $4EBA,$39EA         ; $006964 JSR     $00A350(PC)
        DC.W    $4EBA,$1806         ; $006968 JSR     loc_008170(PC)
        DC.W    $4EBA,$175E         ; $00696C JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1BD6         ; $006970 JSR     $008548(PC)
        DC.W    $4EBA,$2B84         ; $006974 JSR     $0094FA(PC)
        DC.W    $0C78,$0004,$C26C   ; $006978 CMPI.W  #$0004,$C26C.W
        DC.W    $6704               ; $00697E BEQ.S  loc_006984
        DC.W    $4EBA,$2990         ; $006980 JSR     $009312(PC)
loc_006984:
        DC.W    $4EBA,$318C         ; $006984 JSR     $009B12(PC)
        DC.W    $4EBA,$27F8         ; $006988 JSR     $009182(PC)
        DC.W    $4EBA,$2E74         ; $00698C JSR     $009802(PC)
        DC.W    $4EBA,$06F2         ; $006990 JSR     loc_007084(PC)
        DC.W    $4EBA,$0714         ; $006994 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$0E7C         ; $006998 JSR     loc_007816(PC)
        DC.W    $5378,$C02C         ; $00699C SUBQ.W  #1,$C02C.W
        DC.W    $6E12               ; $0069A0 BGT.S  loc_0069B4
        DC.W    $31FC,$0000,$C02C   ; $0069A2 MOVE.W  #$0000,$C02C.W
        DC.W    $317C,$0000,$0074   ; $0069A8 MOVE.W  #$0000,$0074(A0)
        DC.W    $31F8,$C08C,$C07A   ; $0069AE MOVE.W  $C08C.W,$C07A.W
loc_0069B4:
        DC.W    $4EBA,$34B8         ; $0069B4 JSR     $009E6E(PC)
        DC.W    $4EBA,$1294         ; $0069B8 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$078C         ; $0069BC JSR     loc_00714A(PC)
        DC.W    $4EBA,$0C8C         ; $0069C0 JSR     loc_00764E(PC)
        DC.W    $4EBA,$158A         ; $0069C4 JSR     loc_007F50(PC)
        DC.W    $4EBA,$4274         ; $0069C8 JSR     $00AC3E(PC)
        DC.W    $4EFA,$3186         ; $0069CC JMP     $009B54(PC)
        DC.W    $4EBA,$4D9E         ; $0069D0 JSR     $00B770(PC)
        DC.W    $7000               ; $0069D4 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $0069D6 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $0069DA MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $0069DE MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1BB6         ; $0069E2 JSR     $00859A(PC)
        DC.W    $4EBA,$3968         ; $0069E6 JSR     $00A350(PC)
        DC.W    $4EBA,$1784         ; $0069EA JSR     loc_008170(PC)
        DC.W    $4EBA,$16DC         ; $0069EE JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1B54         ; $0069F2 JSR     $008548(PC)
        DC.W    $4EBA,$2E0A         ; $0069F6 JSR     $009802(PC)
        DC.W    $4EBA,$147E         ; $0069FA JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0598         ; $0069FE JSR     loc_006F98(PC)
        DC.W    $4EBA,$12D4         ; $006A02 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$3A2C         ; $006A06 JSR     $00A434(PC)
        DC.W    $4EBA,$069E         ; $006A0A JSR     loc_0070AA(PC)
        DC.W    $4EBA,$345E         ; $006A0E JSR     $009E6E(PC)
        DC.W    $4EBA,$123A         ; $006A12 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$0732         ; $006A16 JSR     loc_00714A(PC)
        DC.W    $4EBA,$0C32         ; $006A1A JSR     loc_00764E(PC)
        DC.W    $4EBA,$1530         ; $006A1E JSR     loc_007F50(PC)
        DC.W    $4EBA,$2BFA         ; $006A22 JSR     $00961E(PC)
        DC.W    $4EBA,$3ED0         ; $006A26 JSR     $00A8F8(PC)
        DC.W    $0838,$0004,$C30E   ; $006A2A BTST    #4,$C30E.W
        DC.W    $6706               ; $006A30 BEQ.S  loc_006A38
        DC.W    $31F8,$C08C,$C07A   ; $006A32 MOVE.W  $C08C.W,$C07A.W
loc_006A38:
        DC.W    $4E75               ; $006A38 RTS
        DC.W    $4EBA,$4D34         ; $006A3A JSR     $00B770(PC)
        DC.W    $11FC,$0001,$C800   ; $006A3E MOVE.B  #$0001,$C800.W
        DC.W    $7000               ; $006A44 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006A46 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006A4A MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006A4E MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1678         ; $006A52 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1AF0         ; $006A56 JSR     $008548(PC)
        DC.W    $4EBA,$2DA6         ; $006A5A JSR     $009802(PC)
        DC.W    $4EBA,$141A         ; $006A5E JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0534         ; $006A62 JSR     loc_006F98(PC)
        DC.W    $4EBA,$1270         ; $006A66 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$063E         ; $006A6A JSR     loc_0070AA(PC)
        DC.W    $4EBA,$06DA         ; $006A6E JSR     loc_00714A(PC)
        DC.W    $4EBA,$0BDA         ; $006A72 JSR     loc_00764E(PC)
        DC.W    $4EBA,$14D8         ; $006A76 JSR     loc_007F50(PC)
        DC.W    $4EBA,$41C2         ; $006A7A JSR     $00AC3E(PC)
        DC.W    $4EBA,$30D4         ; $006A7E JSR     $009B54(PC)
        DC.W    $3038,$C8A0         ; $006A82 MOVE.W  $C8A0.W,D0
        DC.W    $227B,$002C         ; $006A86 MOVEA.L $2C(PC,D0.W),A1
        DC.W    $4E91               ; $006A8A JSR     (A1)
        DC.W    $0C78,$0014,$C8AA   ; $006A8C CMPI.W  #$0014,$C8AA.W
        DC.W    $661E               ; $006A92 BNE.S  loc_006AB2
        DC.W    $31F8,$C092,$C07A   ; $006A94 MOVE.W  $C092.W,$C07A.W
        DC.W    $11FC,$0000,$C800   ; $006A9A MOVE.B  #$0000,$C800.W
        DC.W    $31FC,$0004,$C8AC   ; $006AA0 MOVE.W  #$0004,$C8AC.W
        DC.W    $4A78,$C89C         ; $006AA6 TST.W  $C89C.W
        DC.W    $6706               ; $006AAA BEQ.S  loc_006AB2
        DC.W    $31FC,$0020,$C8AC   ; $006AAC MOVE.W  #$0020,$C8AC.W
loc_006AB2:
        DC.W    $4E75               ; $006AB2 RTS
        DC.W    $0088,$3C7E,$0088   ; $006AB4 ORI.L  #$3C7E0088,A0
        DC.W    $3D5A,$0088         ; $006ABA MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $006ABE MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $006AC2 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $006AC6 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$4EBA         ; $006ACA MOVE.W  (A2)+,$4EBA(A6)
        DC.W    $4CA2,$4EBA         ; $006ACE MOVEM.W D1/D4/D5/D6/A0/A2/A3/A4/A6,-(A2)
        DC.W    $387E               ; $006AD2 MOVEA.W <EA:3E>,A4
        DC.W    $4EBA,$169A         ; $006AD4 JSR     loc_008170(PC)
        DC.W    $4EBA,$15F2         ; $006AD8 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1A6A         ; $006ADC JSR     $008548(PC)
        DC.W    $4EBA,$2B3C         ; $006AE0 JSR     $00961E(PC)
        DC.W    $4EBA,$0D30         ; $006AE4 JSR     loc_007816(PC)
        DC.W    $4EBA,$0B64         ; $006AE8 JSR     loc_00764E(PC)
        DC.W    $4EBA,$05BC         ; $006AEC JSR     loc_0070AA(PC)
        DC.W    $4EBA,$3DEE         ; $006AF0 JSR     $00A8E0(PC)
        DC.W    $4EBA,$305E         ; $006AF4 JSR     $009B54(PC)
        DC.W    $4EBA,$2688         ; $006AF8 JSR     $009182(PC)
        DC.W    $4EBA,$2D04         ; $006AFC JSR     $009802(PC)
        DC.W    $4EFA,$0648         ; $006B00 JMP     loc_00714A(PC)
        DC.W    $7000               ; $006B04 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006B06 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006B0A MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006B0E MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970; $006B12 MOVE.L  #$00100010,$C970.W
        DC.W    $11FC,$0000,$C30F   ; $006B1A MOVE.B  #$0000,$C30F.W
        DC.W    $4EBA,$4C4E         ; $006B20 JSR     $00B770(PC)
        DC.W    $317C,$0002,$0092   ; $006B24 MOVE.W  #$0002,$0092(A0)
        DC.W    $4EBA,$1A6E         ; $006B2A JSR     $00859A(PC)
        DC.W    $4EBA,$3820         ; $006B2E JSR     $00A350(PC)
        DC.W    $4EBA,$163C         ; $006B32 JSR     loc_008170(PC)
        DC.W    $4EBA,$1594         ; $006B36 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$1A0C         ; $006B3A JSR     $008548(PC)
        DC.W    $4EBA,$29BA         ; $006B3E JSR     $0094FA(PC)
        DC.W    $4EBA,$27CE         ; $006B42 JSR     $009312(PC)
        DC.W    $4EBA,$2FCA         ; $006B46 JSR     $009B12(PC)
        DC.W    $4EBA,$2636         ; $006B4A JSR     $009182(PC)
        DC.W    $4EBA,$2ACE         ; $006B4E JSR     $00961E(PC)
        DC.W    $4EBA,$2B34         ; $006B52 JSR     $009688(PC)
        DC.W    $4EBA,$2CAA         ; $006B56 JSR     $009802(PC)
        DC.W    $4EBA,$131E         ; $006B5A JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0438         ; $006B5E JSR     loc_006F98(PC)
        DC.W    $4EBA,$1174         ; $006B62 JSR     loc_007CD8(PC)
        DC.W    $4EBA,$38CC         ; $006B66 JSR     $00A434(PC)
        DC.W    $4EBA,$053E         ; $006B6A JSR     loc_0070AA(PC)
        DC.W    $4EBA,$10DE         ; $006B6E JSR     loc_007C4E(PC)
        DC.W    $4EBA,$05D6         ; $006B72 JSR     loc_00714A(PC)
        DC.W    $4EBA,$0AD6         ; $006B76 JSR     loc_00764E(PC)
        DC.W    $4EBA,$13D4         ; $006B7A JSR     loc_007F50(PC)
        DC.W    $4EBA,$2FD4         ; $006B7E JSR     $009B54(PC)
        DC.W    $4EBA,$DBE6         ; $006B82 JSR     $00476A(PC)
        DC.W    $4EFA,$C58E         ; $006B86 JMP     $003116(PC)
loc_006B8A:
        DC.W    $3038,$C07A         ; $006B8A MOVE.W  $C07A.W,D0
        DC.W    $31FB,$0006,$C26C   ; $006B8E MOVE.W  $06(PC,D0.W),$C26C.W
        DC.W    $4E75               ; $006B94 RTS
        DC.W    $0001,$0001         ; $006B96 ORI.B  #$0001,D1
        DC.W    $0002,$0002         ; $006B9A ORI.B  #$0002,D2
        DC.W    $0004,$0004         ; $006B9E ORI.B  #$0004,D4
        DC.W    $0008,$0008         ; $006BA2 ORI.B  #$0008,A0
        DC.W    $0010,$0010         ; $006BA6 ORI.B  #$0010,(A0)
        DC.W    $0020,$0020         ; $006BAA ORI.B  #$0020,-(A0)
        DC.W    $0040,$0040         ; $006BAE ORI.W  #$0040,D0
        DC.W    $0080,$0080,$0100   ; $006BB2 ORI.L  #$00800100,D0
        DC.W    $0100               ; $006BB8 BTST    D0,D0
        DC.W    $0200,$0200         ; $006BBA ANDI.B  #$0200,D0
loc_006BBE:
        DC.W    $3038,$C07A         ; $006BBE MOVE.W  $C07A.W,D0
        DC.W    $31FB,$0006,$C26C   ; $006BC2 MOVE.W  $06(PC,D0.W),$C26C.W
        DC.W    $4E75               ; $006BC8 RTS
        DC.W    $0001,$0001         ; $006BCA ORI.B  #$0001,D1
        DC.W    $0002,$0002         ; $006BCE ORI.B  #$0002,D2
        DC.W    $0004,$0004         ; $006BD2 ORI.B  #$0004,D4
        DC.W    $0008,$0008         ; $006BD6 ORI.B  #$0008,A0
        DC.W    $0010,$0010         ; $006BDA ORI.B  #$0010,(A0)
        DC.W    $0020,$0020         ; $006BDE ORI.B  #$0020,-(A0)
        DC.W    $0040,$0040         ; $006BE2 ORI.W  #$0040,D0
        DC.W    $0080,$0080,$1038   ; $006BE6 ORI.L  #$00801038,D0
        DC.W    $C30E               ; $006BEC AND.B  D1,A6
        DC.W    $0200,$0021         ; $006BEE ANDI.B  #$0021,D0
        DC.W    $6712               ; $006BF2 BEQ.S  loc_006C06
        DC.W    $08B8,$0004,$C30E   ; $006BF4 BCLR    #4,$C30E.W
        DC.W    $0800,$0005         ; $006BFA BTST    #5,D0
        DC.W    $6706               ; $006BFE BEQ.S  loc_006C06
        DC.W    $31F8,$C098,$C07A   ; $006C00 MOVE.W  $C098.W,$C07A.W
loc_006C06:
        DC.W    $4E75               ; $006C06 RTS
        DC.W    $1038,$C30E         ; $006C08 MOVE.B  $C30E.W,D0
        DC.W    $0200,$0021         ; $006C0C ANDI.B  #$0021,D0
        DC.W    $6714               ; $006C10 BEQ.S  loc_006C26
        DC.W    $08B8,$0004,$C30E   ; $006C12 BCLR    #4,$C30E.W
        DC.W    $0800,$0005         ; $006C18 BTST    #5,D0
        DC.W    $6708               ; $006C1C BEQ.S  loc_006C26
        DC.W    $31F8,$C098,$C07A   ; $006C1E MOVE.W  $C098.W,$C07A.W
        DC.W    $4E75               ; $006C24 RTS
loc_006C26:
        DC.W    $3038,$C050         ; $006C26 MOVE.W  $C050.W,D0
        DC.W    $6A18               ; $006C2A BPL.S  loc_006C44
        DC.W    $08F8,$0000,$C30E   ; $006C2C BSET    #0,$C30E.W
        DC.W    $31F8,$C096,$C07A   ; $006C32 MOVE.W  $C096.W,$C07A.W
        DC.W    $31FC,$0014,$C07C   ; $006C38 MOVE.W  #$0014,$C07C.W
        DC.W    $31FC,$0000,$C050   ; $006C3E MOVE.W  #$0000,$C050.W
loc_006C44:
        DC.W    $4E75               ; $006C44 RTS
loc_006C46:
        DC.W    $2F0C               ; $006C46 MOVE.L  A4,-(A7)
        DC.W    $33FC,$0001,$00FF,$3000; $006C48 MOVE.W  #$0001,$00FF3000
        DC.W    $43F9,$0089,$B844   ; $006C50 LEA     $0089B844,A1
        DC.W    $45F9,$00FF,$304A   ; $006C56 LEA     $00FF304A,A2
        DC.W    $47F9,$00FF,$301A   ; $006C5C LEA     $00FF301A,A3
        DC.W    $49F9,$00FF,$3002   ; $006C62 LEA     $00FF3002,A4
        DC.W    $7A05               ; $006C68 MOVEQ   #$05,D5
loc_006C6A:
        DC.W    $7C01               ; $006C6A MOVEQ   #$01,D6
loc_006C6C:
        DC.W    $26CA               ; $006C6C MOVE.L  A2,(A3)+
        DC.W    $3E11               ; $006C6E MOVE.W  (A1),D7
        DC.W    $34D9               ; $006C70 MOVE.W  (A1)+,(A2)+
loc_006C72:
        DC.W    $4EBA,$DCAE         ; $006C72 JSR     $004922(PC)
        DC.W    $51CF,$FFFA         ; $006C76 DBRA    D7,loc_006C72
        DC.W    $51CE,$FFF0         ; $006C7A DBRA    D6,loc_006C6C
        DC.W    $28CA               ; $006C7E MOVE.L  A2,(A4)+
        DC.W    $51CD,$FFE8         ; $006C80 DBRA    D5,loc_006C6A
        DC.W    $285F               ; $006C84 MOVEA.L (A7)+,A4
        DC.W    $4E75               ; $006C86 RTS
        DC.W    $4A79,$00FF,$3000   ; $006C88 TST.W  $00FF3000
        DC.W    $6604               ; $006C8E BNE.S  loc_006C94
        DC.W    $4EBA,$FFB4         ; $006C90 JSR     loc_006C46(PC)
loc_006C94:
        DC.W    $1238,$C86E         ; $006C94 MOVE.B  $C86E.W,D1
        DC.W    $7030               ; $006C98 MOVEQ   #$30,D0
        DC.W    $0801,$0006         ; $006C9A BTST    #6,D1
        DC.W    $6602               ; $006C9E BNE.S  loc_006CA2
        DC.W    $7008               ; $006CA0 MOVEQ   #$08,D0
loc_006CA2:
        DC.W    $0801,$0002         ; $006CA2 BTST    #2,D1
        DC.W    $6600,$0090         ; $006CA6 BNE.W  loc_006D38
        DC.W    $0801,$0003         ; $006CAA BTST    #3,D1
        DC.W    $6600,$008E         ; $006CAE BNE.W  loc_006D3E
        DC.W    $0801,$0001         ; $006CB2 BTST    #1,D1
        DC.W    $6600,$008C         ; $006CB6 BNE.W  loc_006D44
        DC.W    $0801,$0000         ; $006CBA BTST    #0,D1
        DC.W    $6600,$008A         ; $006CBE BNE.W  loc_006D4A
        DC.W    $0801,$0004         ; $006CC2 BTST    #4,D1
        DC.W    $6600,$0088         ; $006CC6 BNE.W  loc_006D50
        DC.W    $0801,$0005         ; $006CCA BTST    #5,D1
        DC.W    $6600,$009E         ; $006CCE BNE.W  loc_006D6E
        DC.W    $0801,$0007         ; $006CD2 BTST    #7,D1
        DC.W    $6600,$00B4         ; $006CD6 BNE.W  loc_006D8C
        DC.W    $4E75               ; $006CDA RTS
        DC.W    $6122               ; $006CDC BSR.S  loc_006D00
        DC.W    $671E               ; $006CDE BEQ.S  loc_006CFE
        DC.W    $D151               ; $006CE0 ADD.W  D0,(A1)
        DC.W    $4E75               ; $006CE2 RTS
        DC.W    $611A               ; $006CE4 BSR.S  loc_006D00
        DC.W    $6716               ; $006CE6 BEQ.S  loc_006CFE
        DC.W    $9151               ; $006CE8 SUB.W  D0,(A1)
        DC.W    $4E75               ; $006CEA RTS
        DC.W    $6112               ; $006CEC BSR.S  loc_006D00
        DC.W    $670E               ; $006CEE BEQ.S  loc_006CFE
        DC.W    $D169,$0004         ; $006CF0 ADD.W  D0,$0004(A1)
        DC.W    $4E75               ; $006CF4 RTS
        DC.W    $6108               ; $006CF6 BSR.S  loc_006D00
        DC.W    $6704               ; $006CF8 BEQ.S  loc_006CFE
        DC.W    $9169,$0004         ; $006CFA SUB.W  D0,$0004(A1)
loc_006CFE:
        DC.W    $4E75               ; $006CFE RTS
loc_006D00:
        DC.W    $7E00               ; $006D00 MOVEQ   #$00,D7
        DC.W    $0838,$0002,$C313   ; $006D02 BTST    #2,$C313.W
        DC.W    $6702               ; $006D08 BEQ.S  loc_006D0C
        DC.W    $7E04               ; $006D0A MOVEQ   #$04,D7
loc_006D0C:
        DC.W    $DE78,$C8A0         ; $006D0C ADD.W  $C8A0.W,D7
        DC.W    $DE78,$C8A0         ; $006D10 ADD.W  $C8A0.W,D7
        DC.W    $45F9,$00FF,$301A   ; $006D14 LEA     $00FF301A,A2
        DC.W    $2272,$7000         ; $006D1A MOVEA.L $00(A2,D7.W),A1
        DC.W    $3238,$C0BA         ; $006D1E MOVE.W  $C0BA.W,D1
        DC.W    $3E19               ; $006D22 MOVE.W  (A1)+,D7
loc_006D24:
        DC.W    $B251               ; $006D24 CMP.W  (A1),D1
        DC.W    $670C               ; $006D26 BEQ.S  loc_006D34
        DC.W    $43E9,$0010         ; $006D28 LEA     $0010(A1),A1
        DC.W    $51CF,$FFF6         ; $006D2C DBRA    D7,loc_006D24
        DC.W    $7200               ; $006D30 MOVEQ   #$00,D1
        DC.W    $4E75               ; $006D32 RTS
loc_006D34:
        DC.W    $7201               ; $006D34 MOVEQ   #$01,D1
        DC.W    $4E75               ; $006D36 RTS
loc_006D38:
        DC.W    $9168,$0030         ; $006D38 SUB.W  D0,$0030(A0)
        DC.W    $4E75               ; $006D3C RTS
loc_006D3E:
        DC.W    $D168,$0030         ; $006D3E ADD.W  D0,$0030(A0)
        DC.W    $4E75               ; $006D42 RTS
loc_006D44:
        DC.W    $9168,$0034         ; $006D44 SUB.W  D0,$0034(A0)
        DC.W    $4E75               ; $006D48 RTS
loc_006D4A:
        DC.W    $D168,$0034         ; $006D4A ADD.W  D0,$0034(A0)
        DC.W    $4E75               ; $006D4E RTS
loc_006D50:
        DC.W    $5268,$001C         ; $006D50 ADDQ.W  #1,$001C(A0)
        DC.W    $3028,$001C         ; $006D54 MOVE.W  $001C(A0),D0
        DC.W    $2478,$C700         ; $006D58 MOVEA.L $C700.W,A2
        DC.W    $D040               ; $006D5C ADD.W  D0,D0
        DC.W    $D040               ; $006D5E ADD.W  D0,D0
        DC.W    $3172,$0000,$0030   ; $006D60 MOVE.W  $00(A2,D0.W),$0030(A0)
        DC.W    $3172,$0002,$0034   ; $006D66 MOVE.W  $02(A2,D0.W),$0034(A0)
        DC.W    $4E75               ; $006D6C RTS
loc_006D6E:
        DC.W    $5368,$001C         ; $006D6E SUBQ.W  #1,$001C(A0)
        DC.W    $3028,$001C         ; $006D72 MOVE.W  $001C(A0),D0
        DC.W    $2478,$C700         ; $006D76 MOVEA.L $C700.W,A2
        DC.W    $D040               ; $006D7A ADD.W  D0,D0
        DC.W    $D040               ; $006D7C ADD.W  D0,D0
        DC.W    $3172,$0000,$0030   ; $006D7E MOVE.W  $00(A2,D0.W),$0030(A0)
        DC.W    $3172,$0002,$0034   ; $006D84 MOVE.W  $02(A2,D0.W),$0034(A0)
        DC.W    $4E75               ; $006D8A RTS
loc_006D8C:
        DC.W    $48E7,$FFFE         ; $006D8C MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EB9,$0088,$6F98   ; $006D90 JSR     $00886F98
        DC.W    $4CDF,$7FFF         ; $006D96 MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+
        DC.W    $4E75               ; $006D9A RTS
        DC.W    $4EBA,$FDEC         ; $006D9C JSR     loc_006B8A(PC)
        DC.W    $49F8,$A000         ; $006DA0 LEA     $A000.W,A4
        DC.W    $13FC,$0000,$00FF,$5FFE; $006DA4 MOVE.B  #$0000,$00FF5FFE
        DC.W    $41F8,$9100         ; $006DAC LEA     $9100.W,A0
        DC.W    $4EBA,$EC3A         ; $006DB0 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC36         ; $006DB4 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC32         ; $006DB8 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC2E         ; $006DBC JSR     $0059EC(PC)
        DC.W    $4EBA,$EC2A         ; $006DC0 JSR     $0059EC(PC)
        DC.W    $4EFA,$EC26         ; $006DC4 JMP     $0059EC(PC)
        DC.W    $49F8,$A000         ; $006DC8 LEA     $A000.W,A4
        DC.W    $41F8,$9700         ; $006DCC LEA     $9700.W,A0
        DC.W    $4EBA,$EC1A         ; $006DD0 JSR     $0059EC(PC)
loc_006DD4:
        DC.W    $4EBA,$EC16         ; $006DD4 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC12         ; $006DD8 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC0E         ; $006DDC JSR     $0059EC(PC)
        DC.W    $4EBA,$EC0A         ; $006DE0 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC06         ; $006DE4 JSR     $0059EC(PC)
        DC.W    $4EBA,$EC02         ; $006DE8 JSR     $0059EC(PC)
        DC.W    $4EFA,$EBFE         ; $006DEC JMP     $0059EC(PC)
        DC.W    $49F8,$A000         ; $006DF0 LEA     $A000.W,A4
        DC.W    $41F8,$9F00         ; $006DF4 LEA     $9F00.W,A0
        DC.W    $4EBA,$EBF2         ; $006DF8 JSR     $0059EC(PC)
        DC.W    $41F8,$9000         ; $006DFC LEA     $9000.W,A0
        DC.W    $2168,$00B2,$0018   ; $006E00 MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; $006E06 MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; $006E0A ANDI.B  #$0006,D1
        DC.W    $6706               ; $006E0E BEQ.S  loc_006E16
        DC.W    $2178,$C70C,$0018   ; $006E10 MOVE.L  $C70C.W,$0018(A0)
loc_006E16:
        DC.W    $3038,$C07A         ; $006E16 MOVE.W  $C07A.W,D0
        DC.W    $227B,$0004         ; $006E1A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $006E1E JMP     (A1)
        DC.W    $0088,$6E48,$0088   ; $006E20 ORI.L  #$6E480088,A0
        DC.W    $5F9A               ; $006E26 SUBQ.L  #7,(A2)+
        DC.W    $0088,$6EBE,$0088   ; $006E28 ORI.L  #$6EBE0088,A0
        DC.W    $60D4               ; $006E2E BRA.S  loc_006E04
        DC.W    $0088,$617A,$0088   ; $006E30 ORI.L  #$617A0088,A0
        DC.W    $5DE0               ; $006E36 SLT     -(A0)
        DC.W    $0088,$6292,$0088   ; $006E38 ORI.L  #$62920088,A0
        DC.W    $6394               ; $006E3E BLS.S  loc_006DD4
        DC.W    $0088,$633A,$0088   ; $006E40 ORI.L  #$633A0088,A0
        DC.W    $6ECA               ; $006E46 BGT.S  loc_006E12
        DC.W    $7000               ; $006E48 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006E4A MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006E4E MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006E52 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$34F8         ; $006E56 JSR     $00A350(PC)
        DC.W    $4EBA,$1314         ; $006E5A JSR     loc_008170(PC)
        DC.W    $4EBA,$126C         ; $006E5E JSR     loc_0080CC(PC)
        DC.W    $4EBA,$16E4         ; $006E62 JSR     $008548(PC)
        DC.W    $4EBA,$2692         ; $006E66 JSR     $0094FA(PC)
        DC.W    $4EBA,$24A6         ; $006E6A JSR     $009312(PC)
        DC.W    $4EBA,$2CA2         ; $006E6E JSR     $009B12(PC)
        DC.W    $4EBA,$230E         ; $006E72 JSR     $009182(PC)
        DC.W    $4EBA,$27A6         ; $006E76 JSR     $00961E(PC)
        DC.W    $4EBA,$280C         ; $006E7A JSR     $009688(PC)
        DC.W    $4EBA,$2982         ; $006E7E JSR     $009802(PC)
        DC.W    $4EBA,$0FF6         ; $006E82 JSR     loc_007E7A(PC)
        DC.W    $4EBA,$0110         ; $006E86 JSR     loc_006F98(PC)
        DC.W    $4EBA,$0E4C         ; $006E8A JSR     loc_007CD8(PC)
        DC.W    $4EBA,$35A4         ; $006E8E JSR     $00A434(PC)
        DC.W    $4EBA,$0216         ; $006E92 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$106C         ; $006E96 JSR     loc_007F04(PC)
        DC.W    $4EBA,$2FD2         ; $006E9A JSR     $009E6E(PC)
        DC.W    $4EBA,$0DAE         ; $006E9E JSR     loc_007C4E(PC)
        DC.W    $4EBA,$02A6         ; $006EA2 JSR     loc_00714A(PC)
        DC.W    $4EBA,$07A6         ; $006EA6 JSR     loc_00764E(PC)
        DC.W    $4EBA,$10A4         ; $006EAA JSR     loc_007F50(PC)
        DC.W    $4EBA,$2E1E         ; $006EAE JSR     $009CCE(PC)
        DC.W    $4EBA,$2CA0         ; $006EB2 JSR     $009B54(PC)
        DC.W    $4EBA,$1810         ; $006EB6 JSR     $0086C8(PC)
        DC.W    $4EFA,$3E18         ; $006EBA JMP     $00ACD4(PC)
        DC.W    $317C,$0000,$0006   ; $006EBE MOVE.W  #$0000,$0006(A0)
        DC.W    $317C,$0000,$0074   ; $006EC4 MOVE.W  #$0000,$0074(A0)
        DC.W    $7000               ; $006ECA MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006ECC MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006ED0 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006ED4 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$DB14         ; $006ED8 JSR     $0049EE(PC)
        DC.W    $4EBA,$16BC         ; $006EDC JSR     $00859A(PC)
        DC.W    $4EBA,$346E         ; $006EE0 JSR     $00A350(PC)
        DC.W    $4EBA,$128A         ; $006EE4 JSR     loc_008170(PC)
        DC.W    $4EBA,$11E2         ; $006EE8 JSR     loc_0080CC(PC)
        DC.W    $4EBA,$165A         ; $006EEC JSR     $008548(PC)
        DC.W    $4EBA,$2608         ; $006EF0 JSR     $0094FA(PC)
        DC.W    $0C78,$0004,$C26C   ; $006EF4 CMPI.W  #$0004,$C26C.W
        DC.W    $6704               ; $006EFA BEQ.S  loc_006F00
        DC.W    $4EBA,$2414         ; $006EFC JSR     $009312(PC)
loc_006F00:
        DC.W    $4EBA,$2C10         ; $006F00 JSR     $009B12(PC)
        DC.W    $4EBA,$227C         ; $006F04 JSR     $009182(PC)
        DC.W    $4EBA,$28F8         ; $006F08 JSR     $009802(PC)
        DC.W    $4EBA,$0176         ; $006F0C JSR     loc_007084(PC)
        DC.W    $4EBA,$0198         ; $006F10 JSR     loc_0070AA(PC)
        DC.W    $4EBA,$0900         ; $006F14 JSR     loc_007816(PC)
        DC.W    $5378,$C02C         ; $006F18 SUBQ.W  #1,$C02C.W
        DC.W    $6E12               ; $006F1C BGT.S  loc_006F30
        DC.W    $31FC,$0000,$C02C   ; $006F1E MOVE.W  #$0000,$C02C.W
        DC.W    $317C,$0000,$0074   ; $006F24 MOVE.W  #$0000,$0074(A0)
        DC.W    $31F8,$C08C,$C07A   ; $006F2A MOVE.W  $C08C.W,$C07A.W
loc_006F30:
        DC.W    $4EBA,$0FD2         ; $006F30 JSR     loc_007F04(PC)
        DC.W    $4EBA,$2F38         ; $006F34 JSR     $009E6E(PC)
        DC.W    $4EBA,$0D14         ; $006F38 JSR     loc_007C4E(PC)
        DC.W    $4EBA,$020C         ; $006F3C JSR     loc_00714A(PC)
        DC.W    $4EBA,$070C         ; $006F40 JSR     loc_00764E(PC)
        DC.W    $4EBA,$100A         ; $006F44 JSR     loc_007F50(PC)
        DC.W    $4EBA,$2D84         ; $006F48 JSR     $009CCE(PC)
        DC.W    $4EBA,$3CF0         ; $006F4C JSR     $00AC3E(PC)
        DC.W    $4EBA,$2C02         ; $006F50 JSR     $009B54(PC)
        DC.W    $4EBA,$1772         ; $006F54 JSR     $0086C8(PC)
        DC.W    $4EFA,$3D7A         ; $006F58 JMP     $00ACD4(PC)
        DC.W    $2F0C               ; $006F5C MOVE.L  A4,-(A7)
        DC.W    $33FC,$0001,$00FF,$3000; $006F5E MOVE.W  #$0001,$00FF3000
        DC.W    $43F9,$0089,$C064   ; $006F66 LEA     $0089C064,A1
        DC.W    $45F9,$00FF,$3022   ; $006F6C LEA     $00FF3022,A2
        DC.W    $47F9,$00FF,$301A   ; $006F72 LEA     $00FF301A,A3
        DC.W    $49F9,$00FF,$3002   ; $006F78 LEA     $00FF3002,A4
        DC.W    $7C01               ; $006F7E MOVEQ   #$01,D6
loc_006F80:
        DC.W    $26CA               ; $006F80 MOVE.L  A2,(A3)+
        DC.W    $3E11               ; $006F82 MOVE.W  (A1),D7
        DC.W    $34D9               ; $006F84 MOVE.W  (A1)+,(A2)+
loc_006F86:
        DC.W    $4EBA,$D99A         ; $006F86 JSR     $004922(PC)
        DC.W    $51CF,$FFFA         ; $006F8A DBRA    D7,loc_006F86
        DC.W    $51CE,$FFF0         ; $006F8E DBRA    D6,loc_006F80
        DC.W    $28CA               ; $006F92 MOVE.L  A2,(A4)+
        DC.W    $285F               ; $006F94 MOVEA.L (A7)+,A4
        DC.W    $4E75               ; $006F96 RTS
loc_006F98:
        DC.W    $4A68,$0062         ; $006F98 TST.W  $0062(A0)
        DC.W    $6638               ; $006F9C BNE.S  loc_006FD6
        DC.W    $4A68,$0092         ; $006F9E TST.W  $0092(A0)
        DC.W    $6E2A               ; $006FA2 BGT.S  loc_006FCE
        DC.W    $3028,$003C         ; $006FA4 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $006FA8 ADD.W  $0096(A0),D0
        DC.W    $3140,$0040         ; $006FAC MOVE.W  D0,$0040(A0)
        DC.W    $4440               ; $006FB0 NEG.W  D0
        DC.W    $3428,$0006         ; $006FB2 MOVE.W  $0006(A0),D2
        DC.W    $3628,$0030         ; $006FB6 MOVE.W  $0030(A0),D3
        DC.W    $3828,$0034         ; $006FBA MOVE.W  $0034(A0),D4
        DC.W    $4EBA,$001E         ; $006FBE JSR     loc_006FDE(PC)
        DC.W    $3143,$0030         ; $006FC2 MOVE.W  D3,$0030(A0)
        DC.W    $3144,$0034         ; $006FC6 MOVE.W  D4,$0034(A0)
        DC.W    $4EFA,$0734         ; $006FCA JMP     loc_007700(PC)
loc_006FCE:
        DC.W    $4EBA,$002A         ; $006FCE JSR     loc_006FFA(PC)
        DC.W    $4EFA,$0842         ; $006FD2 JMP     loc_007816(PC)
loc_006FD6:
        DC.W    $4EBA,$0030         ; $006FD6 JSR     loc_007008(PC)
        DC.W    $4EFA,$083A         ; $006FDA JMP     loc_007816(PC)
loc_006FDE:
        DC.W    $7C0C               ; $006FDE MOVEQ   #$0C,D6
        DC.W    $3A00               ; $006FE0 MOVE.W  D0,D5
        DC.W    $4EBA,$1F6E         ; $006FE2 JSR     $008F52(PC)
        DC.W    $C1C2               ; $006FE6 MULS    D2,D0
        DC.W    $ECA0               ; $006FE8 ASR.L  D6,D0
        DC.W    $D640               ; $006FEA ADD.W  D0,D3
        DC.W    $3005               ; $006FEC MOVE.W  D5,D0
        DC.W    $4EBA,$1F5E         ; $006FEE JSR     $008F4E(PC)
        DC.W    $C1C2               ; $006FF2 MULS    D2,D0
        DC.W    $ECA0               ; $006FF4 ASR.L  D6,D0
        DC.W    $D840               ; $006FF6 ADD.W  D0,D4
        DC.W    $4E75               ; $006FF8 RTS
loc_006FFA:
        DC.W    $5368,$0092         ; $006FFA SUBQ.W  #1,$0092(A0)
        DC.W    $4A68,$0006         ; $006FFE TST.W  $0006(A0)
        DC.W    $6600,$346C         ; $007002 BNE.W  $00A470
        DC.W    $4E75               ; $007006 RTS
loc_007008:
        DC.W    $7001               ; $007008 MOVEQ   #$01,D0
        DC.W    $4A68,$0072         ; $00700A TST.W  $0072(A0)
        DC.W    $6E06               ; $00700E BGT.S  loc_007016
        DC.W    $6B02               ; $007010 BMI.S  loc_007014
        DC.W    $7000               ; $007012 MOVEQ   #$00,D0
loc_007014:
        DC.W    $4440               ; $007014 NEG.W  D0
loc_007016:
        DC.W    $B068,$0068         ; $007016 CMP.W  $0068(A0),D0
        DC.W    $6618               ; $00701A BNE.S  loc_007034
        DC.W    $3028,$0066         ; $00701C MOVE.W  $0066(A0),D0
        DC.W    $3200               ; $007020 MOVE.W  D0,D1
        DC.W    $E640               ; $007022 ASR.W  #3,D0
        DC.W    $9168,$003C         ; $007024 SUB.W  D0,$003C(A0)
        DC.W    $3028,$003C         ; $007028 MOVE.W  $003C(A0),D0
        DC.W    $9041               ; $00702C SUB.W  D1,D0
        DC.W    $3140,$0040         ; $00702E MOVE.W  D0,$0040(A0)
        DC.W    $6026               ; $007032 BRA.S  loc_00705A
loc_007034:
        DC.W    $3028,$001E         ; $007034 MOVE.W  $001E(A0),D0
        DC.W    $3200               ; $007038 MOVE.W  D0,D1
        DC.W    $9268,$003C         ; $00703A SUB.W  $003C(A0),D1
        DC.W    $E241               ; $00703E ASR.W  #1,D1
        DC.W    $D368,$003C         ; $007040 ADD.W  D1,$003C(A0)
        DC.W    $3200               ; $007044 MOVE.W  D0,D1
        DC.W    $9268,$0040         ; $007046 SUB.W  $0040(A0),D1
        DC.W    $E241               ; $00704A ASR.W  #1,D1
        DC.W    $D368,$0040         ; $00704C ADD.W  D1,$0040(A0)
        DC.W    $9068,$0064         ; $007050 SUB.W  $0064(A0),D0
        DC.W    $E240               ; $007054 ASR.W  #1,D0
        DC.W    $D168,$0064         ; $007056 ADD.W  D0,$0064(A0)
loc_00705A:
        DC.W    $3028,$0064         ; $00705A MOVE.W  $0064(A0),D0
        DC.W    $4440               ; $00705E NEG.W  D0
        DC.W    $363C,$01AB         ; $007060 MOVE.W  #$01AB,D3
        DC.W    $7C0C               ; $007064 MOVEQ   #$0C,D6
        DC.W    $3400               ; $007066 MOVE.W  D0,D2
        DC.W    $4EBA,$1EE8         ; $007068 JSR     $008F52(PC)
        DC.W    $C1C3               ; $00706C MULS    D3,D0
        DC.W    $ECA0               ; $00706E ASR.L  D6,D0
        DC.W    $D168,$0030         ; $007070 ADD.W  D0,$0030(A0)
        DC.W    $3002               ; $007074 MOVE.W  D2,D0
        DC.W    $4EBA,$1ED6         ; $007076 JSR     $008F4E(PC)
        DC.W    $C1C3               ; $00707A MULS    D3,D0
        DC.W    $ECA0               ; $00707C ASR.L  D6,D0
        DC.W    $D168,$0034         ; $00707E ADD.W  D0,$0034(A0)
        DC.W    $4E75               ; $007082 RTS
loc_007084:
        DC.W    $3028,$0052         ; $007084 MOVE.W  $0052(A0),D0
        DC.W    $D168,$003C         ; $007088 ADD.W  D0,$003C(A0)
        DC.W    $3028,$003C         ; $00708C MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $007090 ADD.W  $0096(A0),D0
        DC.W    $3140,$0040         ; $007094 MOVE.W  D0,$0040(A0)
        DC.W    $3028,$004E         ; $007098 MOVE.W  $004E(A0),D0
        DC.W    $D168,$0030         ; $00709C ADD.W  D0,$0030(A0)
        DC.W    $3028,$0050         ; $0070A0 MOVE.W  $0050(A0),D0
        DC.W    $D168,$0034         ; $0070A4 ADD.W  D0,$0034(A0)
        DC.W    $4E75               ; $0070A8 RTS
loc_0070AA:
        DC.W    $43F9,$0093,$A02C   ; $0070AA LEA     $0093A02C,A1
        DC.W    $3028,$005C         ; $0070B0 MOVE.W  $005C(A0),D0
        DC.W    $9068,$005A         ; $0070B4 SUB.W  $005A(A0),D0
        DC.W    $D040               ; $0070B8 ADD.W  D0,D0
        DC.W    $6B0A               ; $0070BA BMI.S  loc_0070C6
        DC.W    $0240,$03FF         ; $0070BC ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $0070C0 MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $0070C4 BRA.S  loc_0070D2
loc_0070C6:
        DC.W    $4440               ; $0070C6 NEG.W  D0
        DC.W    $0240,$03FF         ; $0070C8 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $0070CC MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $0070D0 NEG.W  D0
loc_0070D2:
        DC.W    $3140,$003E         ; $0070D2 MOVE.W  D0,$003E(A0)
        DC.W    $43F9,$0093,$A42C   ; $0070D6 LEA     $0093A42C,A1
        DC.W    $3028,$005E         ; $0070DC MOVE.W  $005E(A0),D0
        DC.W    $9068,$005A         ; $0070E0 SUB.W  $005A(A0),D0
        DC.W    $D040               ; $0070E4 ADD.W  D0,D0
        DC.W    $6B0A               ; $0070E6 BMI.S  loc_0070F2
        DC.W    $0240,$03FF         ; $0070E8 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $0070EC MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $0070F0 BRA.S  loc_0070FE
loc_0070F2:
        DC.W    $4440               ; $0070F2 NEG.W  D0
        DC.W    $0240,$03FF         ; $0070F4 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $0070F8 MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $0070FC NEG.W  D0
loc_0070FE:
        DC.W    $3140,$003A         ; $0070FE MOVE.W  D0,$003A(A0)
        DC.W    $3028,$008E         ; $007102 MOVE.W  $008E(A0),D0
        DC.W    $4440               ; $007106 NEG.W  D0
        DC.W    $C1E8,$0004         ; $007108 MULS    $0004(A0),D0
        DC.W    $720F               ; $00710C MOVEQ   #$0F,D1
        DC.W    $E2A0               ; $00710E ASR.L  D1,D0
        DC.W    $D068,$00A2         ; $007110 ADD.W  $00A2(A0),D0
        DC.W    $3140,$004A         ; $007114 MOVE.W  D0,$004A(A0)
        DC.W    $3168,$009E,$0044   ; $007118 MOVE.W  $009E(A0),$0044(A0)
        DC.W    $3028,$00A0         ; $00711E MOVE.W  $00A0(A0),D0
        DC.W    $660A               ; $007122 BNE.S  loc_00712E
        DC.W    $3028,$0094         ; $007124 MOVE.W  $0094(A0),D0
        DC.W    $E740               ; $007128 ASL.W  #3,D0
        DC.W    $D068,$006E         ; $00712A ADD.W  $006E(A0),D0
loc_00712E:
        DC.W    $D068,$004C         ; $00712E ADD.W  $004C(A0),D0
        DC.W    $3140,$0046         ; $007132 MOVE.W  D0,$0046(A0)
        DC.W    $3028,$008E         ; $007136 MOVE.W  $008E(A0),D0
        DC.W    $E040               ; $00713A ASR.W  #8,D0
        DC.W    $4440               ; $00713C NEG.W  D0
        DC.W    $C1E8,$0004         ; $00713E MULS    $0004(A0),D0
        DC.W    $EA80               ; $007142 ASR.L  #5,D0
        DC.W    $3140,$004C         ; $007144 MOVE.W  D0,$004C(A0)
        DC.W    $4E75               ; $007148 RTS
loc_00714A:
        DC.W    $7000               ; $00714A MOVEQ   #$00,D0
        DC.W    $2268,$00CE         ; $00714C MOVEA.L $00CE(A0),A1
        DC.W    $1029,$001B         ; $007150 MOVE.B  $001B(A1),D0
        DC.W    $1140,$001D         ; $007154 MOVE.B  D0,$001D(A0)
        DC.W    $1168,$0025,$0027   ; $007158 MOVE.B  $0025(A0),$0027(A0)
        DC.W    $2478,$C704         ; $00715E MOVEA.L $C704.W,A2
        DC.W    $1232,$0000         ; $007162 MOVE.B  $00(A2,D0.W),D1
        DC.W    $1141,$0025         ; $007166 MOVE.B  D1,$0025(A0)
        DC.W    $2478,$C700         ; $00716A MOVEA.L $C700.W,A2
        DC.W    $D040               ; $00716E ADD.W  D0,D0
        DC.W    $D040               ; $007170 ADD.W  D0,D0
        DC.W    $3172,$0000,$0020   ; $007172 MOVE.W  $00(A2,D0.W),$0020(A0)
        DC.W    $3172,$0002,$0022   ; $007178 MOVE.W  $02(A2,D0.W),$0022(A0)
        DC.W    $3229,$001A         ; $00717E MOVE.W  $001A(A1),D1
        DC.W    $0241,$FF00         ; $007182 ANDI.W  #$FF00,D1
        DC.W    $3141,$001E         ; $007186 MOVE.W  D1,$001E(A0)
        DC.W    $1169,$0019,$00E5   ; $00718A MOVE.B  $0019(A1),$00E5(A0)
        DC.W    $117C,$0000,$00E4   ; $007190 MOVE.B  #$0000,$00E4(A0)
        DC.W    $0828,$0000,$00E5   ; $007196 BTST    #0,$00E5(A0)
        DC.W    $6706               ; $00719C BEQ.S  loc_0071A4
        DC.W    $117C,$0001,$00E4   ; $00719E MOVE.B  #$0001,$00E4(A0)
loc_0071A4:
        DC.W    $4E75               ; $0071A4 RTS
loc_0071A6:
        DC.W    $2F0C               ; $0071A6 MOVE.L  A4,-(A7)
        DC.W    $323C,$0400         ; $0071A8 MOVE.W  #$0400,D1
        DC.W    $3428,$0030         ; $0071AC MOVE.W  $0030(A0),D2
        DC.W    $E842               ; $0071B0 ASR.W  #4,D2
        DC.W    $D441               ; $0071B2 ADD.W  D1,D2
        DC.W    $EC42               ; $0071B4 ASR.W  #6,D2
        DC.W    $3628,$0034         ; $0071B6 MOVE.W  $0034(A0),D3
        DC.W    $E843               ; $0071BA ASR.W  #4,D3
        DC.W    $9243               ; $0071BC SUB.W  D3,D1
        DC.W    $0241,$FFC0         ; $0071BE ANDI.W  #$FFC0,D1
        DC.W    $E241               ; $0071C2 ASR.W  #1,D1
        DC.W    $D242               ; $0071C4 ADD.W  D2,D1
        DC.W    $D241               ; $0071C6 ADD.W  D1,D1
        DC.W    $D241               ; $0071C8 ADD.W  D1,D1
        DC.W    $3141,$00CA         ; $0071CA MOVE.W  D1,$00CA(A0)
        DC.W    $7000               ; $0071CE MOVEQ   #$00,D0
        DC.W    $3028,$00CC         ; $0071D0 MOVE.W  $00CC(A0),D0
        DC.W    $ED80               ; $0071D4 ASL.L  #6,D0
        DC.W    $4840               ; $0071D6 SWAP    D0
        DC.W    $0240,$003C         ; $0071D8 ANDI.W  #$003C,D0
        DC.W    $47F9,$0089,$A0D4   ; $0071DC LEA     $0089A0D4,A3
        DC.W    $3438,$C8A0         ; $0071E2 MOVE.W  $C8A0.W,D2
        DC.W    $0C42,$0004         ; $0071E6 CMPI.W  #$0004,D2
        DC.W    $6616               ; $0071EA BNE.S  loc_007202
        DC.W    $0C28,$0088,$001D   ; $0071EC CMPI.B  #$0088,$001D(A0)
        DC.W    $6D0E               ; $0071F2 BLT.S  loc_007202
        DC.W    $0C28,$0098,$001D   ; $0071F4 CMPI.B  #$0098,$001D(A0)
        DC.W    $6E06               ; $0071FA BGT.S  loc_007202
        DC.W    $47F9,$0089,$A434   ; $0071FC LEA     $0089A434,A3
loc_007202:
        DC.W    $2673,$0000         ; $007202 MOVEA.L $00(A3,D0.W),A3
        DC.W    $263C,$2207,$FFFE   ; $007206 MOVE.L  #$2207FFFE,D3
        DC.W    $43FA,$003A         ; $00720C LEA     $003A(PC),A1
        DC.W    $2271,$2000         ; $007210 MOVEA.L $00(A1,D2.W),A1
        DC.W    $45F9,$00FF,$6000   ; $007214 LEA     $00FF6000,A2
        DC.W    $7800               ; $00721A MOVEQ   #$00,D4
        DC.W    $2871,$1000         ; $00721C MOVEA.L $00(A1,D1.W),A4
        DC.W    $B9C3               ; $007220 CMPA.L  D3,A4
        DC.W    $6704               ; $007222 BEQ.S  loc_007228
        DC.W    $24CC               ; $007224 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $007226 ADDQ.W  #1,D4
loc_007228:
        DC.W    $3E1B               ; $007228 MOVE.W  (A3)+,D7
loc_00722A:
        DC.W    $3001               ; $00722A MOVE.W  D1,D0
        DC.W    $D05B               ; $00722C ADD.W  (A3)+,D0
        DC.W    $2871,$0000         ; $00722E MOVEA.L $00(A1,D0.W),A4
        DC.W    $B9C3               ; $007232 CMPA.L  D3,A4
        DC.W    $6704               ; $007234 BEQ.S  loc_00723A
        DC.W    $24CC               ; $007236 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $007238 ADDQ.W  #1,D4
loc_00723A:
        DC.W    $51CF,$FFEE         ; $00723A DBRA    D7,loc_00722A
        DC.W    $33C4,$00FF,$610E   ; $00723E MOVE.W  D4,$00FF610E
        DC.W    $285F               ; $007244 MOVEA.L (A7)+,A4
        DC.W    $4E75               ; $007246 RTS
        DC.W    $0095,$C000,$0095   ; $007248 ORI.L  #$C0000095,(A5)
        DC.W    $D000               ; $00724E ADD.B  D0,D0
        DC.W    $0095,$E000,$0095   ; $007250 ORI.L  #$E0000095,(A5)
        DC.W    $F000               ; $007256 MOVE.W  D0,D0
        DC.W    $0096,$1000,$0096   ; $007258 ORI.L  #$10000096,(A6)
        DC.W    $1000               ; $00725E MOVE.B  D0,D0
loc_007260:
        DC.W    $45F9,$00FF,$6000   ; $007260 LEA     $00FF6000,A2
        DC.W    $6118               ; $007266 BSR.S  loc_007280
        DC.W    $33C4,$00FF,$610E   ; $007268 MOVE.W  D4,$00FF610E
        DC.W    $4E75               ; $00726E RTS
loc_007270:
        DC.W    $45F9,$00FF,$6064   ; $007270 LEA     $00FF6064,A2
        DC.W    $6108               ; $007276 BSR.S  loc_007280
        DC.W    $33C4,$00FF,$633E   ; $007278 MOVE.W  D4,$00FF633E
        DC.W    $4E75               ; $00727E RTS
loc_007280:
        DC.W    $2F0C               ; $007280 MOVE.L  A4,-(A7)
        DC.W    $323C,$0400         ; $007282 MOVE.W  #$0400,D1
        DC.W    $3428,$0030         ; $007286 MOVE.W  $0030(A0),D2
        DC.W    $E842               ; $00728A ASR.W  #4,D2
        DC.W    $D441               ; $00728C ADD.W  D1,D2
        DC.W    $3602               ; $00728E MOVE.W  D2,D3
        DC.W    $7C00               ; $007290 MOVEQ   #$00,D6
        DC.W    $0243,$0020         ; $007292 ANDI.W  #$0020,D3
        DC.W    $6602               ; $007296 BNE.S  loc_00729A
        DC.W    $7C01               ; $007298 MOVEQ   #$01,D6
loc_00729A:
        DC.W    $EC42               ; $00729A ASR.W  #6,D2
        DC.W    $3628,$0034         ; $00729C MOVE.W  $0034(A0),D3
        DC.W    $E843               ; $0072A0 ASR.W  #4,D3
        DC.W    $9243               ; $0072A2 SUB.W  D3,D1
        DC.W    $3601               ; $0072A4 MOVE.W  D1,D3
        DC.W    $0243,$0020         ; $0072A6 ANDI.W  #$0020,D3
        DC.W    $6702               ; $0072AA BEQ.S  loc_0072AE
        DC.W    $5406               ; $0072AC ADDQ.B  #2,D6
loc_0072AE:
        DC.W    $0241,$FFC0         ; $0072AE ANDI.W  #$FFC0,D1
        DC.W    $E241               ; $0072B2 ASR.W  #1,D1
        DC.W    $D242               ; $0072B4 ADD.W  D2,D1
        DC.W    $D241               ; $0072B6 ADD.W  D1,D1
        DC.W    $D241               ; $0072B8 ADD.W  D1,D1
        DC.W    $3141,$00CA         ; $0072BA MOVE.W  D1,$00CA(A0)
        DC.W    $7000               ; $0072BE MOVEQ   #$00,D0
        DC.W    $3028,$00CC         ; $0072C0 MOVE.W  $00CC(A0),D0
        DC.W    $0640,$1000         ; $0072C4 ADDI.W  #$1000,D0
        DC.W    $EB80               ; $0072C8 ASL.L  #5,D0
        DC.W    $4840               ; $0072CA SWAP    D0
        DC.W    $0240,$001C         ; $0072CC ANDI.W  #$001C,D0
        DC.W    $47F9,$0089,$A932   ; $0072D0 LEA     $0089A932,A3
        DC.W    $2673,$0000         ; $0072D6 MOVEA.L $00(A3,D0.W),A3
        DC.W    $0800,$0002         ; $0072DA BTST    #2,D0
        DC.W    $661C               ; $0072DE BNE.S  loc_0072FC
        DC.W    $0200,$0008         ; $0072E0 ANDI.B  #$0008,D0
        DC.W    $660C               ; $0072E4 BNE.S  loc_0072F2
        DC.W    $0206,$0002         ; $0072E6 ANDI.B  #$0002,D6
        DC.W    $6728               ; $0072EA BEQ.S  loc_007314
        DC.W    $0641,$0080         ; $0072EC ADDI.W  #$0080,D1
        DC.W    $6022               ; $0072F0 BRA.S  loc_007314
loc_0072F2:
        DC.W    $0206,$0001         ; $0072F2 ANDI.B  #$0001,D6
        DC.W    $671C               ; $0072F6 BEQ.S  loc_007314
        DC.W    $5941               ; $0072F8 SUBQ.W  #4,D1
        DC.W    $6018               ; $0072FA BRA.S  loc_007314
loc_0072FC:
        DC.W    $0200,$0010         ; $0072FC ANDI.B  #$0010,D0
        DC.W    $670A               ; $007300 BEQ.S  loc_00730C
        DC.W    $0206,$0001         ; $007302 ANDI.B  #$0001,D6
        DC.W    $670C               ; $007306 BEQ.S  loc_007314
        DC.W    $5941               ; $007308 SUBQ.W  #4,D1
        DC.W    $6008               ; $00730A BRA.S  loc_007314
loc_00730C:
        DC.W    $0206,$0001         ; $00730C ANDI.B  #$0001,D6
        DC.W    $6602               ; $007310 BNE.S  loc_007314
        DC.W    $5841               ; $007312 ADDQ.W  #4,D1
loc_007314:
        DC.W    $263C,$2207,$FFFE   ; $007314 MOVE.L  #$2207FFFE,D3
        DC.W    $3038,$C8A0         ; $00731A MOVE.W  $C8A0.W,D0
        DC.W    $43FA,$FF28         ; $00731E LEA     -$00D8(PC),A1
        DC.W    $2271,$0000         ; $007322 MOVEA.L $00(A1,D0.W),A1
        DC.W    $7800               ; $007326 MOVEQ   #$00,D4
        DC.W    $2871,$1000         ; $007328 MOVEA.L $00(A1,D1.W),A4
        DC.W    $B9C3               ; $00732C CMPA.L  D3,A4
        DC.W    $6704               ; $00732E BEQ.S  loc_007334
        DC.W    $24CC               ; $007330 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $007332 ADDQ.W  #1,D4
loc_007334:
        DC.W    $7E0B               ; $007334 MOVEQ   #$0B,D7
loc_007336:
        DC.W    $3001               ; $007336 MOVE.W  D1,D0
        DC.W    $D05B               ; $007338 ADD.W  (A3)+,D0
        DC.W    $2871,$0000         ; $00733A MOVEA.L $00(A1,D0.W),A4
        DC.W    $B9C3               ; $00733E CMPA.L  D3,A4
        DC.W    $6704               ; $007340 BEQ.S  loc_007346
        DC.W    $24CC               ; $007342 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $007344 ADDQ.W  #1,D4
loc_007346:
        DC.W    $51CF,$FFEE         ; $007346 DBRA    D7,loc_007336
        DC.W    $285F               ; $00734A MOVEA.L (A7)+,A4
        DC.W    $4E75               ; $00734C RTS
loc_00734E:
        DC.W    $4A78,$C0BA         ; $00734E TST.W  $C0BA.W
        DC.W    $6700,$FE52         ; $007352 BEQ.W  loc_0071A6
        DC.W    $2F0C               ; $007356 MOVE.L  A4,-(A7)
        DC.W    $323C,$0400         ; $007358 MOVE.W  #$0400,D1
        DC.W    $3439,$00FF,$6102   ; $00735C MOVE.W  $00FF6102,D2
        DC.W    $E842               ; $007362 ASR.W  #4,D2
        DC.W    $D441               ; $007364 ADD.W  D1,D2
        DC.W    $EC42               ; $007366 ASR.W  #6,D2
        DC.W    $3639,$00FF,$6106   ; $007368 MOVE.W  $00FF6106,D3
        DC.W    $E843               ; $00736E ASR.W  #4,D3
        DC.W    $9243               ; $007370 SUB.W  D3,D1
        DC.W    $0241,$FFC0         ; $007372 ANDI.W  #$FFC0,D1
        DC.W    $E241               ; $007376 ASR.W  #1,D1
        DC.W    $D242               ; $007378 ADD.W  D2,D1
        DC.W    $D241               ; $00737A ADD.W  D1,D1
        DC.W    $D241               ; $00737C ADD.W  D1,D1
        DC.W    $7000               ; $00737E MOVEQ   #$00,D0
        DC.W    $3028,$00CC         ; $007380 MOVE.W  $00CC(A0),D0
        DC.W    $ED80               ; $007384 ASL.L  #6,D0
        DC.W    $4840               ; $007386 SWAP    D0
        DC.W    $0240,$003C         ; $007388 ANDI.W  #$003C,D0
        DC.W    $47F9,$0089,$A5D2   ; $00738C LEA     $0089A5D2,A3
        DC.W    $4A78,$C0BA         ; $007392 TST.W  $C0BA.W
        DC.W    $6606               ; $007396 BNE.S  loc_00739E
        DC.W    $47F9,$0089,$A0D4   ; $007398 LEA     $0089A0D4,A3
loc_00739E:
        DC.W    $2673,$0000         ; $00739E MOVEA.L $00(A3,D0.W),A3
        DC.W    $263C,$2207,$FFFE   ; $0073A2 MOVE.L  #$2207FFFE,D3
        DC.W    $3038,$C8A0         ; $0073A8 MOVE.W  $C8A0.W,D0
        DC.W    $43FA,$FE9A         ; $0073AC LEA     -$0166(PC),A1
        DC.W    $2271,$0000         ; $0073B0 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6000   ; $0073B4 LEA     $00FF6000,A2
        DC.W    $7800               ; $0073BA MOVEQ   #$00,D4
        DC.W    $2871,$1000         ; $0073BC MOVEA.L $00(A1,D1.W),A4
        DC.W    $B9C3               ; $0073C0 CMPA.L  D3,A4
        DC.W    $6704               ; $0073C2 BEQ.S  loc_0073C8
        DC.W    $24CC               ; $0073C4 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $0073C6 ADDQ.W  #1,D4
loc_0073C8:
        DC.W    $3E1B               ; $0073C8 MOVE.W  (A3)+,D7
loc_0073CA:
        DC.W    $3001               ; $0073CA MOVE.W  D1,D0
        DC.W    $D05B               ; $0073CC ADD.W  (A3)+,D0
        DC.W    $2871,$0000         ; $0073CE MOVEA.L $00(A1,D0.W),A4
        DC.W    $B9C3               ; $0073D2 CMPA.L  D3,A4
        DC.W    $6704               ; $0073D4 BEQ.S  loc_0073DA
        DC.W    $24CC               ; $0073D6 MOVE.L  A4,(A2)+
        DC.W    $5244               ; $0073D8 ADDQ.W  #1,D4
loc_0073DA:
        DC.W    $51CF,$FFEE         ; $0073DA DBRA    D7,loc_0073CA
        DC.W    $33C4,$00FF,$610E   ; $0073DE MOVE.W  D4,$00FF610E
        DC.W    $285F               ; $0073E4 MOVEA.L (A7)+,A4
        DC.W    $4E75               ; $0073E6 RTS
loc_0073E8:
        DC.W    $263C,$0000,$0400   ; $0073E8 MOVE.L  #$00000400,D3
        DC.W    $3801               ; $0073EE MOVE.W  D1,D4
        DC.W    $E844               ; $0073F0 ASR.W  #4,D4
        DC.W    $D843               ; $0073F2 ADD.W  D3,D4
        DC.W    $EA44               ; $0073F4 ASR.W  #5,D4
        DC.W    $3A02               ; $0073F6 MOVE.W  D2,D5
        DC.W    $E845               ; $0073F8 ASR.W  #4,D5
        DC.W    $D645               ; $0073FA ADD.W  D5,D3
        DC.W    $0243,$FFE0         ; $0073FC ANDI.W  #$FFE0,D3
        DC.W    $E343               ; $007400 ASL.W  #1,D3
        DC.W    $D644               ; $007402 ADD.W  D4,D3
        DC.W    $D643               ; $007404 ADD.W  D3,D3
        DC.W    $3038,$C8A0         ; $007406 MOVE.W  $C8A0.W,D0
        DC.W    $D040               ; $00740A ADD.W  D0,D0
        DC.W    $45FA,$001E         ; $00740C LEA     $001E(PC),A2
        DC.W    $4A28,$00E4         ; $007410 TST.B  $00E4(A0)
        DC.W    $6704               ; $007414 BEQ.S  loc_00741A
        DC.W    $45FA,$0044         ; $007416 LEA     $0044(PC),A2
loc_00741A:
        DC.W    $2272,$0000         ; $00741A MOVEA.L $00(A2,D0.W),A1
        DC.W    $3631,$3000         ; $00741E MOVE.W  $00(A1,D3.W),D3
        DC.W    $2272,$0004         ; $007422 MOVEA.L $04(A2,D0.W),A1
        DC.W    $D683               ; $007426 ADD.L  D3,D3
        DC.W    $D3C3               ; $007428 ADDA.L  D3,A1
        DC.W    $4E75               ; $00742A RTS
        DC.W    $0094,$C000,$0097   ; $00742C ORI.L  #$C0000097,(A4)
        DC.W    $0000,$0094         ; $007432 ORI.B  #$0094,D0
        DC.W    $E000               ; $007436 ASR.B  #8,D0
        DC.W    $0098,$8000,$0095   ; $007438 ORI.L  #$80000095,(A0)+
        DC.W    $0000,$009A         ; $00743E ORI.B  #$009A,D0
        DC.W    $0000,$0095         ; $007442 ORI.B  #$0095,D0
        DC.W    $4000               ; $007446 NEGX.B D0
        DC.W    $009B,$8000,$0095   ; $007448 ORI.L  #$80000095,(A3)+
        DC.W    $8000               ; $00744E OR.B   D0,D0
        DC.W    $009D,$0000,$0095   ; $007450 ORI.L  #$00000095,(A5)+
        DC.W    $2000               ; $007456 MOVE.L  D0,D0
        DC.W    $009D,$0000,$0000   ; $007458 ORI.L  #$00000000,(A5)+
        DC.W    $0000,$0000         ; $00745E ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $007462 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $007466 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00746A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00746E ORI.B  #$0000,D0
        DC.W    $0000,$0095         ; $007472 ORI.B  #$0095,D0
        DC.W    $6000,$009C         ; $007476 BRA.W  loc_007514
        DC.W    $4110               ; $00747A DC.W    $4110
        DC.W    $0000,$0000         ; $00747C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $007480 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $007484 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $007488 ORI.B  #$0000,D0
loc_00748C:
        DC.W    $0641,$4000         ; $00748C ADDI.W  #$4000,D1
        DC.W    $0241,$01FF         ; $007490 ANDI.W  #$01FF,D1
        DC.W    $E341               ; $007494 ASL.W  #1,D1
        DC.W    $48C1               ; $007496 EXT.L   D1
        DC.W    $0642,$4000         ; $007498 ADDI.W  #$4000,D2
        DC.W    $0242,$01FF         ; $00749C ANDI.W  #$01FF,D2
        DC.W    $E342               ; $0074A0 ASL.W  #1,D2
        DC.W    $48C2               ; $0074A2 EXT.L   D2
loc_0074A4:
        DC.W    $3E19               ; $0074A4 MOVE.W  (A1)+,D7
        DC.W    $6A04               ; $0074A6 BPL.S  loc_0074AC
        DC.W    $7000               ; $0074A8 MOVEQ   #$00,D0
        DC.W    $4E75               ; $0074AA RTS
loc_0074AC:
        DC.W    $2449               ; $0074AC MOVEA.L A1,A2
        DC.W    $7A09               ; $0074AE MOVEQ   #$09,D5
loc_0074B0:
        DC.W    $3619               ; $0074B0 MOVE.W  (A1)+,D3
        DC.W    $7C03               ; $0074B2 MOVEQ   #$03,D6
loc_0074B4:
        DC.W    $E343               ; $0074B4 ASL.W  #1,D3
        DC.W    $6532               ; $0074B6 BCS.S  loc_0074EA
        DC.W    $E343               ; $0074B8 ASL.W  #1,D3
        DC.W    $651E               ; $0074BA BCS.S  loc_0074DA
        DC.W    $3001               ; $0074BC MOVE.W  D1,D0
        DC.W    $C1D9               ; $0074BE MULS    (A1)+,D0
        DC.W    $3819               ; $0074C0 MOVE.W  (A1)+,D4
        DC.W    $48C4               ; $0074C2 EXT.L   D4
        DC.W    $EBA4               ; $0074C4 ASL.L  D5,D4
        DC.W    $D084               ; $0074C6 ADD.L  D4,D0
        DC.W    $EAA0               ; $0074C8 ASR.L  D5,D0
        DC.W    $B480               ; $0074CA CMP.L  D0,D2
        DC.W    $6D06               ; $0074CC BLT.S  loc_0074D4
        DC.W    $E343               ; $0074CE ASL.W  #1,D3
        DC.W    $6552               ; $0074D0 BCS.S  loc_007524
        DC.W    $6048               ; $0074D2 BRA.S  loc_00751C
loc_0074D4:
        DC.W    $E343               ; $0074D4 ASL.W  #1,D3
        DC.W    $644C               ; $0074D6 BCC.S  loc_007524
        DC.W    $6042               ; $0074D8 BRA.S  loc_00751C
loc_0074DA:
        DC.W    $B251               ; $0074DA CMP.W  (A1),D1
        DC.W    $6D06               ; $0074DC BLT.S  loc_0074E4
        DC.W    $E343               ; $0074DE ASL.W  #1,D3
        DC.W    $6442               ; $0074E0 BCC.S  loc_007524
        DC.W    $6036               ; $0074E2 BRA.S  loc_00751A
loc_0074E4:
        DC.W    $E343               ; $0074E4 ASL.W  #1,D3
        DC.W    $653C               ; $0074E6 BCS.S  loc_007524
        DC.W    $6030               ; $0074E8 BRA.S  loc_00751A
loc_0074EA:
        DC.W    $E343               ; $0074EA ASL.W  #1,D3
        DC.W    $651E               ; $0074EC BCS.S  loc_00750C
        DC.W    $3002               ; $0074EE MOVE.W  D2,D0
        DC.W    $C1D9               ; $0074F0 MULS    (A1)+,D0
        DC.W    $3819               ; $0074F2 MOVE.W  (A1)+,D4
        DC.W    $48C4               ; $0074F4 EXT.L   D4
        DC.W    $EBA4               ; $0074F6 ASL.L  D5,D4
        DC.W    $D084               ; $0074F8 ADD.L  D4,D0
        DC.W    $EAA0               ; $0074FA ASR.L  D5,D0
        DC.W    $B280               ; $0074FC CMP.L  D0,D1
        DC.W    $6D06               ; $0074FE BLT.S  loc_007506
        DC.W    $E343               ; $007500 ASL.W  #1,D3
        DC.W    $6420               ; $007502 BCC.S  loc_007524
        DC.W    $6016               ; $007504 BRA.S  loc_00751C
loc_007506:
        DC.W    $E343               ; $007506 ASL.W  #1,D3
        DC.W    $651A               ; $007508 BCS.S  loc_007524
        DC.W    $6010               ; $00750A BRA.S  loc_00751C
loc_00750C:
        DC.W    $B451               ; $00750C CMP.W  (A1),D2
        DC.W    $6D06               ; $00750E BLT.S  loc_007516
        DC.W    $E343               ; $007510 ASL.W  #1,D3
        DC.W    $6510               ; $007512 BCS.S  loc_007524
loc_007514:
        DC.W    $6004               ; $007514 BRA.S  loc_00751A
loc_007516:
        DC.W    $E343               ; $007516 ASL.W  #1,D3
        DC.W    $640A               ; $007518 BCC.S  loc_007524
loc_00751A:
        DC.W    $5889               ; $00751A ADDQ.L  #4,A1
loc_00751C:
        DC.W    $51CE,$FF96         ; $00751C DBRA    D6,loc_0074B4
        DC.W    $7001               ; $007520 MOVEQ   #$01,D0
        DC.W    $600E               ; $007522 BRA.S  loc_007532
loc_007524:
        DC.W    $D5FC,$0000,$001C   ; $007524 ADDA.L  #$0000001C,A2
        DC.W    $224A               ; $00752A MOVEA.L A2,A1
        DC.W    $51CF,$FF82         ; $00752C DBRA    D7,loc_0074B0
        DC.W    $7000               ; $007530 MOVEQ   #$00,D0
loc_007532:
        DC.W    $4E75               ; $007532 RTS
loc_007534:
        DC.W    $0641,$4000         ; $007534 ADDI.W  #$4000,D1
        DC.W    $0241,$01FF         ; $007538 ANDI.W  #$01FF,D1
        DC.W    $E341               ; $00753C ASL.W  #1,D1
        DC.W    $48C1               ; $00753E EXT.L   D1
        DC.W    $0642,$4000         ; $007540 ADDI.W  #$4000,D2
        DC.W    $0242,$01FF         ; $007544 ANDI.W  #$01FF,D2
        DC.W    $E342               ; $007548 ASL.W  #1,D2
        DC.W    $48C2               ; $00754A EXT.L   D2
        DC.W    $2449               ; $00754C MOVEA.L A1,A2
        DC.W    $7A09               ; $00754E MOVEQ   #$09,D5
        DC.W    $3619               ; $007550 MOVE.W  (A1)+,D3
        DC.W    $7C03               ; $007552 MOVEQ   #$03,D6
loc_007554:
        DC.W    $E343               ; $007554 ASL.W  #1,D3
        DC.W    $6532               ; $007556 BCS.S  loc_00758A
        DC.W    $E343               ; $007558 ASL.W  #1,D3
        DC.W    $651E               ; $00755A BCS.S  loc_00757A
        DC.W    $3001               ; $00755C MOVE.W  D1,D0
        DC.W    $C1D9               ; $00755E MULS    (A1)+,D0
        DC.W    $3819               ; $007560 MOVE.W  (A1)+,D4
        DC.W    $48C4               ; $007562 EXT.L   D4
        DC.W    $EBA4               ; $007564 ASL.L  D5,D4
        DC.W    $D084               ; $007566 ADD.L  D4,D0
        DC.W    $EAA0               ; $007568 ASR.L  D5,D0
        DC.W    $B480               ; $00756A CMP.L  D0,D2
        DC.W    $6D06               ; $00756C BLT.S  loc_007574
        DC.W    $E343               ; $00756E ASL.W  #1,D3
        DC.W    $6552               ; $007570 BCS.S  loc_0075C4
        DC.W    $6048               ; $007572 BRA.S  loc_0075BC
loc_007574:
        DC.W    $E343               ; $007574 ASL.W  #1,D3
        DC.W    $644C               ; $007576 BCC.S  loc_0075C4
        DC.W    $6042               ; $007578 BRA.S  loc_0075BC
loc_00757A:
        DC.W    $B251               ; $00757A CMP.W  (A1),D1
        DC.W    $6D06               ; $00757C BLT.S  loc_007584
        DC.W    $E343               ; $00757E ASL.W  #1,D3
        DC.W    $6442               ; $007580 BCC.S  loc_0075C4
        DC.W    $6036               ; $007582 BRA.S  loc_0075BA
loc_007584:
        DC.W    $E343               ; $007584 ASL.W  #1,D3
        DC.W    $653C               ; $007586 BCS.S  loc_0075C4
        DC.W    $6030               ; $007588 BRA.S  loc_0075BA
loc_00758A:
        DC.W    $E343               ; $00758A ASL.W  #1,D3
        DC.W    $651E               ; $00758C BCS.S  loc_0075AC
        DC.W    $3002               ; $00758E MOVE.W  D2,D0
        DC.W    $C1D9               ; $007590 MULS    (A1)+,D0
        DC.W    $3819               ; $007592 MOVE.W  (A1)+,D4
        DC.W    $48C4               ; $007594 EXT.L   D4
        DC.W    $EBA4               ; $007596 ASL.L  D5,D4
        DC.W    $D084               ; $007598 ADD.L  D4,D0
        DC.W    $EAA0               ; $00759A ASR.L  D5,D0
        DC.W    $B280               ; $00759C CMP.L  D0,D1
        DC.W    $6D06               ; $00759E BLT.S  loc_0075A6
        DC.W    $E343               ; $0075A0 ASL.W  #1,D3
        DC.W    $6420               ; $0075A2 BCC.S  loc_0075C4
        DC.W    $6016               ; $0075A4 BRA.S  loc_0075BC
loc_0075A6:
        DC.W    $E343               ; $0075A6 ASL.W  #1,D3
        DC.W    $651A               ; $0075A8 BCS.S  loc_0075C4
        DC.W    $6010               ; $0075AA BRA.S  loc_0075BC
loc_0075AC:
        DC.W    $B451               ; $0075AC CMP.W  (A1),D2
        DC.W    $6D06               ; $0075AE BLT.S  loc_0075B6
        DC.W    $E343               ; $0075B0 ASL.W  #1,D3
        DC.W    $6510               ; $0075B2 BCS.S  loc_0075C4
        DC.W    $6004               ; $0075B4 BRA.S  loc_0075BA
loc_0075B6:
        DC.W    $E343               ; $0075B6 ASL.W  #1,D3
        DC.W    $640A               ; $0075B8 BCC.S  loc_0075C4
loc_0075BA:
        DC.W    $5889               ; $0075BA ADDQ.L  #4,A1
loc_0075BC:
        DC.W    $51CE,$FF96         ; $0075BC DBRA    D6,loc_007554
        DC.W    $7001               ; $0075C0 MOVEQ   #$01,D0
        DC.W    $6002               ; $0075C2 BRA.S  loc_0075C6
loc_0075C4:
        DC.W    $7000               ; $0075C4 MOVEQ   #$00,D0
loc_0075C6:
        DC.W    $4E75               ; $0075C6 RTS
loc_0075C8:
        DC.W    $C3EA,$0012         ; $0075C8 MULS    $0012(A2),D1
        DC.W    $C5EA,$0014         ; $0075CC MULS    $0014(A2),D2
        DC.W    $D282               ; $0075D0 ADD.L  D2,D1
        DC.W    $342A,$0016         ; $0075D2 MOVE.W  $0016(A2),D2
        DC.W    $48C2               ; $0075D6 EXT.L   D2
        DC.W    $EB82               ; $0075D8 ASL.L  #5,D2
        DC.W    $D282               ; $0075DA ADD.L  D2,D1
        DC.W    $EC81               ; $0075DC ASR.L  #6,D1
        DC.W    $4E75               ; $0075DE RTS
loc_0075E0:
        DC.W    $4A2A,$0019         ; $0075E0 TST.B  $0019(A2)
        DC.W    $6AE2               ; $0075E4 BPL.S  loc_0075C8
        DC.W    $C3EA,$0012         ; $0075E6 MULS    $0012(A2),D1
        DC.W    $C5EA,$0014         ; $0075EA MULS    $0014(A2),D2
        DC.W    $D282               ; $0075EE ADD.L  D2,D1
        DC.W    $342A,$0016         ; $0075F0 MOVE.W  $0016(A2),D2
        DC.W    $48C2               ; $0075F4 EXT.L   D2
        DC.W    $EB82               ; $0075F6 ASL.L  #5,D2
        DC.W    $D282               ; $0075F8 ADD.L  D2,D1
        DC.W    $EA81               ; $0075FA ASR.L  #5,D1
        DC.W    $4E75               ; $0075FC RTS
loc_0075FE:
        DC.W    $4A78,$C04C         ; $0075FE TST.W  $C04C.W
        DC.W    $660E               ; $007602 BNE.S  loc_007612
        DC.W    $3028,$003C         ; $007604 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $007608 ADD.W  $0096(A0),D0
        DC.W    $3140,$00CC         ; $00760C MOVE.W  D0,$00CC(A0)
        DC.W    $4E75               ; $007610 RTS
loc_007612:
        DC.W    $3028,$003C         ; $007612 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $007616 ADD.W  $0096(A0),D0
        DC.W    $9068,$0046         ; $00761A SUB.W  $0046(A0),D0
        DC.W    $3140,$00CC         ; $00761E MOVE.W  D0,$00CC(A0)
        DC.W    $4E75               ; $007622 RTS
loc_007624:
        DC.W    $4A78,$C0BA         ; $007624 TST.W  $C0BA.W
        DC.W    $670C               ; $007628 BEQ.S  loc_007636
        DC.W    $3038,$C0C2         ; $00762A MOVE.W  $C0C2.W,D0
        DC.W    $4440               ; $00762E NEG.W  D0
        DC.W    $3140,$00CC         ; $007630 MOVE.W  D0,$00CC(A0)
        DC.W    $4E75               ; $007634 RTS
loc_007636:
        DC.W    $3038,$C0CA         ; $007636 MOVE.W  $C0CA.W,D0
        DC.W    $D078,$C0B0         ; $00763A ADD.W  $C0B0.W,D0
        DC.W    $E740               ; $00763E ASL.W  #3,D0
        DC.W    $D068,$003C         ; $007640 ADD.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $007644 ADD.W  $0096(A0),D0
        DC.W    $3140,$00CC         ; $007648 MOVE.W  D0,$00CC(A0)
        DC.W    $4E75               ; $00764C RTS
loc_00764E:
        DC.W    $3028,$001E         ; $00764E MOVE.W  $001E(A0),D0
        DC.W    $4EBA,$18FA         ; $007652 JSR     $008F4E(PC)
        DC.W    $3800               ; $007656 MOVE.W  D0,D4
        DC.W    $3428,$0020         ; $007658 MOVE.W  $0020(A0),D2
        DC.W    $9468,$0030         ; $00765C SUB.W  $0030(A0),D2
        DC.W    $C5C0               ; $007660 MULS    D0,D2
        DC.W    $3028,$001E         ; $007662 MOVE.W  $001E(A0),D0
        DC.W    $4EBA,$18EA         ; $007666 JSR     $008F52(PC)
        DC.W    $3A00               ; $00766A MOVE.W  D0,D5
        DC.W    $3628,$0022         ; $00766C MOVE.W  $0022(A0),D3
        DC.W    $9668,$0034         ; $007670 SUB.W  $0034(A0),D3
        DC.W    $C7C0               ; $007674 MULS    D0,D3
        DC.W    $D682               ; $007676 ADD.L  D2,D3
        DC.W    $E083               ; $007678 ASR.L  #8,D3
        DC.W    $4443               ; $00767A NEG.W  D3
        DC.W    $3143,$0072         ; $00767C MOVE.W  D3,$0072(A0)
        DC.W    $3005               ; $007680 MOVE.W  D5,D0
        DC.W    $3428,$0020         ; $007682 MOVE.W  $0020(A0),D2
        DC.W    $9468,$0030         ; $007686 SUB.W  $0030(A0),D2
        DC.W    $C5C0               ; $00768A MULS    D0,D2
        DC.W    $3004               ; $00768C MOVE.W  D4,D0
        DC.W    $3628,$0022         ; $00768E MOVE.W  $0022(A0),D3
        DC.W    $9668,$0034         ; $007692 SUB.W  $0034(A0),D3
        DC.W    $C7C0               ; $007696 MULS    D0,D3
        DC.W    $9483               ; $007698 SUB.L  D3,D2
        DC.W    $E082               ; $00769A ASR.L  #8,D2
        DC.W    $3142,$00E2         ; $00769C MOVE.W  D2,$00E2(A0)
        DC.W    $4E75               ; $0076A0 RTS
loc_0076A2:
        DC.W    $2278,$C268         ; $0076A2 MOVEA.L $C268.W,A1
        DC.W    $45F8,$C02E         ; $0076A6 LEA     $C02E.W,A2
        DC.W    $EC48               ; $0076AA LSR.W  #6,D0
        DC.W    $D040               ; $0076AC ADD.W  D0,D0
        DC.W    $43F1,$0000         ; $0076AE LEA     $00(A1,D0.W),A1
        DC.W    $1419               ; $0076B2 MOVE.B  (A1)+,D2
        DC.W    $4882               ; $0076B4 EXT.W   D2
        DC.W    $3542,$0000         ; $0076B6 MOVE.W  D2,$0000(A2)
        DC.W    $1411               ; $0076BA MOVE.B  (A1),D2
        DC.W    $4882               ; $0076BC EXT.W   D2
        DC.W    $3542,$0004         ; $0076BE MOVE.W  D2,$0004(A2)
        DC.W    $43E9,$07FF         ; $0076C2 LEA     $07FF(A1),A1
        DC.W    $1419               ; $0076C6 MOVE.B  (A1)+,D2
        DC.W    $4882               ; $0076C8 EXT.W   D2
        DC.W    $3542,$0006         ; $0076CA MOVE.W  D2,$0006(A2)
        DC.W    $1411               ; $0076CE MOVE.B  (A1),D2
        DC.W    $4882               ; $0076D0 EXT.W   D2
        DC.W    $3542,$000A         ; $0076D2 MOVE.W  D2,$000A(A2)
        DC.W    $43E9,$07FF         ; $0076D6 LEA     $07FF(A1),A1
        DC.W    $1419               ; $0076DA MOVE.B  (A1)+,D2
        DC.W    $4882               ; $0076DC EXT.W   D2
        DC.W    $3542,$000C         ; $0076DE MOVE.W  D2,$000C(A2)
        DC.W    $1411               ; $0076E2 MOVE.B  (A1),D2
        DC.W    $4882               ; $0076E4 EXT.W   D2
        DC.W    $3542,$0010         ; $0076E6 MOVE.W  D2,$0010(A2)
        DC.W    $43E9,$07FF         ; $0076EA LEA     $07FF(A1),A1
        DC.W    $1419               ; $0076EE MOVE.B  (A1)+,D2
        DC.W    $4882               ; $0076F0 EXT.W   D2
        DC.W    $3542,$0012         ; $0076F2 MOVE.W  D2,$0012(A2)
        DC.W    $1411               ; $0076F6 MOVE.B  (A1),D2
        DC.W    $4882               ; $0076F8 EXT.W   D2
        DC.W    $3542,$0016         ; $0076FA MOVE.W  D2,$0016(A2)
        DC.W    $4E75               ; $0076FE RTS
loc_007700:
        DC.W    $4EBA,$019A         ; $007700 JSR     loc_00789C(PC)
        DC.W    $0C68,$0000,$0062   ; $007704 CMPI.W  #$0000,$0062(A0)
        DC.W    $6E00,$00EE         ; $00770A BGT.W  loc_0077FA
        DC.W    $0828,$0000,$0055   ; $00770E BTST    #0,$0055(A0)
        DC.W    $6700,$00E4         ; $007714 BEQ.W  loc_0077FA
        DC.W    $3628,$0040         ; $007718 MOVE.W  $0040(A0),D3
        DC.W    $9668,$0042         ; $00771C SUB.W  $0042(A0),D3
        DC.W    $E443               ; $007720 ASR.W  #2,D3
        DC.W    $3828,$0046         ; $007722 MOVE.W  $0046(A0),D4
        DC.W    $9868,$0048         ; $007726 SUB.W  $0048(A0),D4
        DC.W    $E444               ; $00772A ASR.W  #2,D4
        DC.W    $3A28,$0030         ; $00772C MOVE.W  $0030(A0),D5
        DC.W    $9A68,$0036         ; $007730 SUB.W  $0036(A0),D5
        DC.W    $E445               ; $007734 ASR.W  #2,D5
        DC.W    $3C28,$0034         ; $007736 MOVE.W  $0034(A0),D6
        DC.W    $9C68,$0038         ; $00773A SUB.W  $0038(A0),D6
        DC.W    $E446               ; $00773E ASR.W  #2,D6
        DC.W    $3168,$0036,$0030   ; $007740 MOVE.W  $0036(A0),$0030(A0)
        DC.W    $3168,$0038,$0034   ; $007746 MOVE.W  $0038(A0),$0034(A0)
        DC.W    $3168,$0042,$0040   ; $00774C MOVE.W  $0042(A0),$0040(A0)
        DC.W    $3168,$0048,$0046   ; $007752 MOVE.W  $0048(A0),$0046(A0)
        DC.W    $D768,$0040         ; $007758 ADD.W  D3,$0040(A0)
        DC.W    $D968,$0046         ; $00775C ADD.W  D4,$0046(A0)
        DC.W    $DB68,$0030         ; $007760 ADD.W  D5,$0030(A0)
        DC.W    $DD68,$0034         ; $007764 ADD.W  D6,$0034(A0)
        DC.W    $48E7,$FF00         ; $007768 MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EBA,$012E         ; $00776C JSR     loc_00789C(PC)
        DC.W    $4CDF,$00FF         ; $007770 MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+
        DC.W    $0828,$0000,$0055   ; $007774 BTST    #0,$0055(A0)
        DC.W    $6600,$006E         ; $00777A BNE.W  loc_0077EA
        DC.W    $D768,$0040         ; $00777E ADD.W  D3,$0040(A0)
        DC.W    $D968,$0046         ; $007782 ADD.W  D4,$0046(A0)
        DC.W    $DB68,$0030         ; $007786 ADD.W  D5,$0030(A0)
        DC.W    $DD68,$0034         ; $00778A ADD.W  D6,$0034(A0)
        DC.W    $48E7,$FF00         ; $00778E MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EBA,$0108         ; $007792 JSR     loc_00789C(PC)
        DC.W    $4CDF,$00FF         ; $007796 MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+
        DC.W    $0828,$0000,$0055   ; $00779A BTST    #0,$0055(A0)
        DC.W    $6648               ; $0077A0 BNE.S  loc_0077EA
        DC.W    $D768,$0040         ; $0077A2 ADD.W  D3,$0040(A0)
        DC.W    $D968,$0046         ; $0077A6 ADD.W  D4,$0046(A0)
        DC.W    $DB68,$0030         ; $0077AA ADD.W  D5,$0030(A0)
        DC.W    $DD68,$0034         ; $0077AE ADD.W  D6,$0034(A0)
        DC.W    $48E7,$FF00         ; $0077B2 MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EBA,$00E4         ; $0077B6 JSR     loc_00789C(PC)
        DC.W    $4CDF,$00FF         ; $0077BA MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+
        DC.W    $0828,$0000,$0055   ; $0077BE BTST    #0,$0055(A0)
        DC.W    $6624               ; $0077C4 BNE.S  loc_0077EA
        DC.W    $D768,$0040         ; $0077C6 ADD.W  D3,$0040(A0)
        DC.W    $D968,$0046         ; $0077CA ADD.W  D4,$0046(A0)
        DC.W    $DB68,$0030         ; $0077CE ADD.W  D5,$0030(A0)
        DC.W    $DD68,$0034         ; $0077D2 ADD.W  D6,$0034(A0)
        DC.W    $48E7,$FF00         ; $0077D6 MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EBA,$00C0         ; $0077DA JSR     loc_00789C(PC)
        DC.W    $4CDF,$00FF         ; $0077DE MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+
        DC.W    $0828,$0000,$0055   ; $0077E2 BTST    #0,$0055(A0)
        DC.W    $6710               ; $0077E8 BEQ.S  loc_0077FA
loc_0077EA:
        DC.W    $9768,$0040         ; $0077EA SUB.W  D3,$0040(A0)
        DC.W    $9968,$0046         ; $0077EE SUB.W  D4,$0046(A0)
        DC.W    $9B68,$0030         ; $0077F2 SUB.W  D5,$0030(A0)
        DC.W    $9D68,$0034         ; $0077F6 SUB.W  D6,$0034(A0)
loc_0077FA:
        DC.W    $3168,$0040,$0042   ; $0077FA MOVE.W  $0040(A0),$0042(A0)
        DC.W    $3168,$0046,$0048   ; $007800 MOVE.W  $0046(A0),$0048(A0)
        DC.W    $3168,$0030,$0036   ; $007806 MOVE.W  $0030(A0),$0036(A0)
        DC.W    $3168,$0034,$0038   ; $00780C MOVE.W  $0034(A0),$0038(A0)
        DC.W    $6000,$0006         ; $007812 BRA.W  loc_00781A
loc_007816:
        DC.W    $4EBA,$0084         ; $007816 JSR     loc_00789C(PC)
loc_00781A:
        DC.W    $2468,$00D2         ; $00781A MOVEA.L $00D2(A0),A2
        DC.W    $3238,$C0D4         ; $00781E MOVE.W  $C0D4.W,D1
        DC.W    $3438,$C0D6         ; $007822 MOVE.W  $C0D6.W,D2
        DC.W    $4EBA,$FDB8         ; $007826 JSR     loc_0075E0(PC)
        DC.W    $6F0E               ; $00782A BLE.S  loc_00783A
        DC.W    $3428,$005A         ; $00782C MOVE.W  $005A(A0),D2
        DC.W    $48C2               ; $007830 EXT.L   D2
        DC.W    $D282               ; $007832 ADD.L  D2,D1
        DC.W    $E281               ; $007834 ASR.L  #1,D1
        DC.W    $3141,$005A         ; $007836 MOVE.W  D1,$005A(A0)
loc_00783A:
        DC.W    $2468,$00D6         ; $00783A MOVEA.L $00D6(A0),A2
        DC.W    $3238,$C0D8         ; $00783E MOVE.W  $C0D8.W,D1
        DC.W    $3438,$C0DA         ; $007842 MOVE.W  $C0DA.W,D2
        DC.W    $4EBA,$FD98         ; $007846 JSR     loc_0075E0(PC)
        DC.W    $6F0E               ; $00784A BLE.S  loc_00785A
        DC.W    $3428,$005C         ; $00784C MOVE.W  $005C(A0),D2
        DC.W    $48C2               ; $007850 EXT.L   D2
        DC.W    $D282               ; $007852 ADD.L  D2,D1
        DC.W    $E281               ; $007854 ASR.L  #1,D1
        DC.W    $3141,$005C         ; $007856 MOVE.W  D1,$005C(A0)
loc_00785A:
        DC.W    $2468,$00DA         ; $00785A MOVEA.L $00DA(A0),A2
        DC.W    $3238,$C0DC         ; $00785E MOVE.W  $C0DC.W,D1
        DC.W    $3438,$C0DE         ; $007862 MOVE.W  $C0DE.W,D2
        DC.W    $4EBA,$FD78         ; $007866 JSR     loc_0075E0(PC)
        DC.W    $6F0E               ; $00786A BLE.S  loc_00787A
        DC.W    $3428,$005E         ; $00786C MOVE.W  $005E(A0),D2
        DC.W    $48C2               ; $007870 EXT.L   D2
        DC.W    $D282               ; $007872 ADD.L  D2,D1
        DC.W    $E281               ; $007874 ASR.L  #1,D1
        DC.W    $3141,$005E         ; $007876 MOVE.W  D1,$005E(A0)
loc_00787A:
        DC.W    $2468,$00CE         ; $00787A MOVEA.L $00CE(A0),A2
        DC.W    $3238,$C0D0         ; $00787E MOVE.W  $C0D0.W,D1
        DC.W    $3438,$C0D2         ; $007882 MOVE.W  $C0D2.W,D2
        DC.W    $4EBA,$FD58         ; $007886 JSR     loc_0075E0(PC)
        DC.W    $6F0E               ; $00788A BLE.S  loc_00789A
        DC.W    $3428,$0032         ; $00788C MOVE.W  $0032(A0),D2
        DC.W    $48C2               ; $007890 EXT.L   D2
        DC.W    $D282               ; $007892 ADD.L  D2,D1
        DC.W    $E281               ; $007894 ASR.L  #1,D1
        DC.W    $3141,$0032         ; $007896 MOVE.W  D1,$0032(A0)
loc_00789A:
        DC.W    $4E75               ; $00789A RTS
loc_00789C:
        DC.W    $11FC,$0000,$C31A   ; $00789C MOVE.B  #$0000,$C31A.W
        DC.W    $3028,$0040         ; $0078A2 MOVE.W  $0040(A0),D0
        DC.W    $D068,$0046         ; $0078A6 ADD.W  $0046(A0),D0
        DC.W    $4EBA,$FDF6         ; $0078AA JSR     loc_0076A2(PC)
        DC.W    $3228,$0030         ; $0078AE MOVE.W  $0030(A0),D1
        DC.W    $3428,$0034         ; $0078B2 MOVE.W  $0034(A0),D2
        DC.W    $4EBA,$FB30         ; $0078B6 JSR     loc_0073E8(PC)
        DC.W    $2889               ; $0078BA MOVE.L  A1,(A4)
        DC.W    $4EBA,$FBCE         ; $0078BC JSR     loc_00748C(PC)
        DC.W    $6610               ; $0078C0 BNE.S  loc_0078D2
        DC.W    $28BC,$0000,$0000   ; $0078C2 MOVE.L  #$00000000,(A4)
        DC.W    $297C,$0000,$0000,$0004; $0078C8 MOVE.L  #$00000000,$0004(A4)
        DC.W    $6018               ; $0078D0 BRA.S  loc_0078EA
loc_0078D2:
        DC.W    $294A,$0004         ; $0078D2 MOVE.L  A2,$0004(A4)
        DC.W    $214A,$00CE         ; $0078D6 MOVE.L  A2,$00CE(A0)
        DC.W    $102A,$0018         ; $0078DA MOVE.B  $0018(A2),D0
        DC.W    $11C0,$C319         ; $0078DE MOVE.B  D0,$C319.W
        DC.W    $31C1,$C0D0         ; $0078E2 MOVE.W  D1,$C0D0.W
        DC.W    $31C2,$C0D2         ; $0078E6 MOVE.W  D2,$C0D2.W
loc_0078EA:
        DC.W    $3228,$0030         ; $0078EA MOVE.W  $0030(A0),D1
        DC.W    $D278,$C02E         ; $0078EE ADD.W  $C02E.W,D1
        DC.W    $3428,$0034         ; $0078F2 MOVE.W  $0034(A0),D2
        DC.W    $D478,$C032         ; $0078F6 ADD.W  $C032.W,D2
        DC.W    $117C,$0001,$0056   ; $0078FA MOVE.B  #$0001,$0056(A0)
        DC.W    $4EBA,$FAE6         ; $007900 JSR     loc_0073E8(PC)
        DC.W    $2014               ; $007904 MOVE.L  (A4),D0
        DC.W    $6718               ; $007906 BEQ.S  loc_007920
        DC.W    $B3C0               ; $007908 CMPA.L  D0,A1
        DC.W    $6614               ; $00790A BNE.S  loc_007920
        DC.W    $2649               ; $00790C MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $00790E MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$FC20         ; $007912 JSR     loc_007534(PC)
        DC.W    $660E               ; $007916 BNE.S  loc_007926
        DC.W    $224B               ; $007918 MOVEA.L A3,A1
        DC.W    $4EBA,$FB88         ; $00791A JSR     loc_0074A4(PC)
        DC.W    $6004               ; $00791E BRA.S  loc_007924
loc_007920:
        DC.W    $4EBA,$FB6A         ; $007920 JSR     loc_00748C(PC)
loc_007924:
        DC.W    $6714               ; $007924 BEQ.S  loc_00793A
loc_007926:
        DC.W    $214A,$00D2         ; $007926 MOVE.L  A2,$00D2(A0)
        DC.W    $31C1,$C0D4         ; $00792A MOVE.W  D1,$C0D4.W
        DC.W    $31C2,$C0D6         ; $00792E MOVE.W  D2,$C0D6.W
        DC.W    $4EBA,$010C         ; $007932 JSR     loc_007A40(PC)
        DC.W    $1140,$0056         ; $007936 MOVE.B  D0,$0056(A0)
loc_00793A:
        DC.W    $3228,$0030         ; $00793A MOVE.W  $0030(A0),D1
        DC.W    $D278,$C034         ; $00793E ADD.W  $C034.W,D1
        DC.W    $3428,$0034         ; $007942 MOVE.W  $0034(A0),D2
        DC.W    $D478,$C038         ; $007946 ADD.W  $C038.W,D2
        DC.W    $117C,$0001,$0057   ; $00794A MOVE.B  #$0001,$0057(A0)
        DC.W    $4EBA,$FA96         ; $007950 JSR     loc_0073E8(PC)
        DC.W    $2014               ; $007954 MOVE.L  (A4),D0
        DC.W    $6718               ; $007956 BEQ.S  loc_007970
        DC.W    $B3C0               ; $007958 CMPA.L  D0,A1
        DC.W    $6614               ; $00795A BNE.S  loc_007970
        DC.W    $2649               ; $00795C MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $00795E MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$FBD0         ; $007962 JSR     loc_007534(PC)
        DC.W    $660E               ; $007966 BNE.S  loc_007976
        DC.W    $224B               ; $007968 MOVEA.L A3,A1
        DC.W    $4EBA,$FB38         ; $00796A JSR     loc_0074A4(PC)
        DC.W    $6004               ; $00796E BRA.S  loc_007974
loc_007970:
        DC.W    $4EBA,$FB1A         ; $007970 JSR     loc_00748C(PC)
loc_007974:
        DC.W    $6714               ; $007974 BEQ.S  loc_00798A
loc_007976:
        DC.W    $214A,$00D6         ; $007976 MOVE.L  A2,$00D6(A0)
        DC.W    $31C1,$C0D8         ; $00797A MOVE.W  D1,$C0D8.W
        DC.W    $31C2,$C0DA         ; $00797E MOVE.W  D2,$C0DA.W
        DC.W    $4EBA,$00BC         ; $007982 JSR     loc_007A40(PC)
        DC.W    $1140,$0057         ; $007986 MOVE.B  D0,$0057(A0)
loc_00798A:
        DC.W    $3228,$0030         ; $00798A MOVE.W  $0030(A0),D1
        DC.W    $D278,$C03A         ; $00798E ADD.W  $C03A.W,D1
        DC.W    $3428,$0034         ; $007992 MOVE.W  $0034(A0),D2
        DC.W    $D478,$C03E         ; $007996 ADD.W  $C03E.W,D2
        DC.W    $117C,$0001,$0058   ; $00799A MOVE.B  #$0001,$0058(A0)
        DC.W    $4EBA,$FA46         ; $0079A0 JSR     loc_0073E8(PC)
        DC.W    $2014               ; $0079A4 MOVE.L  (A4),D0
        DC.W    $6718               ; $0079A6 BEQ.S  loc_0079C0
        DC.W    $B3C0               ; $0079A8 CMPA.L  D0,A1
        DC.W    $6614               ; $0079AA BNE.S  loc_0079C0
        DC.W    $2649               ; $0079AC MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $0079AE MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$FB80         ; $0079B2 JSR     loc_007534(PC)
        DC.W    $660E               ; $0079B6 BNE.S  loc_0079C6
        DC.W    $224B               ; $0079B8 MOVEA.L A3,A1
        DC.W    $4EBA,$FAE8         ; $0079BA JSR     loc_0074A4(PC)
        DC.W    $6004               ; $0079BE BRA.S  loc_0079C4
loc_0079C0:
        DC.W    $4EBA,$FACA         ; $0079C0 JSR     loc_00748C(PC)
loc_0079C4:
        DC.W    $6714               ; $0079C4 BEQ.S  loc_0079DA
loc_0079C6:
        DC.W    $214A,$00DA         ; $0079C6 MOVE.L  A2,$00DA(A0)
        DC.W    $31C1,$C0DC         ; $0079CA MOVE.W  D1,$C0DC.W
        DC.W    $31C2,$C0DE         ; $0079CE MOVE.W  D2,$C0DE.W
        DC.W    $4EBA,$006C         ; $0079D2 JSR     loc_007A40(PC)
        DC.W    $1140,$0058         ; $0079D6 MOVE.B  D0,$0058(A0)
loc_0079DA:
        DC.W    $3228,$0030         ; $0079DA MOVE.W  $0030(A0),D1
        DC.W    $D278,$C040         ; $0079DE ADD.W  $C040.W,D1
        DC.W    $3428,$0034         ; $0079E2 MOVE.W  $0034(A0),D2
        DC.W    $D478,$C044         ; $0079E6 ADD.W  $C044.W,D2
        DC.W    $117C,$0001,$0059   ; $0079EA MOVE.B  #$0001,$0059(A0)
        DC.W    $4EBA,$F9F6         ; $0079F0 JSR     loc_0073E8(PC)
        DC.W    $2014               ; $0079F4 MOVE.L  (A4),D0
        DC.W    $6718               ; $0079F6 BEQ.S  loc_007A10
        DC.W    $B3C0               ; $0079F8 CMPA.L  D0,A1
        DC.W    $6614               ; $0079FA BNE.S  loc_007A10
        DC.W    $2649               ; $0079FC MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $0079FE MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$FB30         ; $007A02 JSR     loc_007534(PC)
        DC.W    $660E               ; $007A06 BNE.S  loc_007A16
        DC.W    $224B               ; $007A08 MOVEA.L A3,A1
        DC.W    $4EBA,$FA98         ; $007A0A JSR     loc_0074A4(PC)
        DC.W    $6004               ; $007A0E BRA.S  loc_007A14
loc_007A10:
        DC.W    $4EBA,$FA7A         ; $007A10 JSR     loc_00748C(PC)
loc_007A14:
        DC.W    $6714               ; $007A14 BEQ.S  loc_007A2A
loc_007A16:
        DC.W    $214A,$00DE         ; $007A16 MOVE.L  A2,$00DE(A0)
        DC.W    $31C1,$C0E0         ; $007A1A MOVE.W  D1,$C0E0.W
        DC.W    $31C2,$C0E2         ; $007A1E MOVE.W  D2,$C0E2.W
        DC.W    $4EBA,$001C         ; $007A22 JSR     loc_007A40(PC)
        DC.W    $1140,$0059         ; $007A26 MOVE.B  D0,$0059(A0)
loc_007A2A:
        DC.W    $1028,$0056         ; $007A2A MOVE.B  $0056(A0),D0
        DC.W    $8028,$0057         ; $007A2E OR.B   $0057(A0),D0
        DC.W    $8028,$0058         ; $007A32 OR.B   $0058(A0),D0
        DC.W    $8028,$0059         ; $007A36 OR.B   $0059(A0),D0
        DC.W    $1140,$0055         ; $007A3A MOVE.B  D0,$0055(A0)
        DC.W    $4E75               ; $007A3E RTS
loc_007A40:
        DC.W    $102A,$0018         ; $007A40 MOVE.B  $0018(A2),D0
        DC.W    $0240,$000F         ; $007A44 ANDI.W  #$000F,D0
        DC.W    $D040               ; $007A48 ADD.W  D0,D0
        DC.W    $D040               ; $007A4A ADD.W  D0,D0
        DC.W    $227B,$0004         ; $007A4C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $007A50 JMP     (A1)
        DC.W    $0088,$7A8A,$0088   ; $007A52 ORI.L  #$7A8A0088,A0
        DC.W    $7A8E               ; $007A58 MOVEQ   #-$72,D5
        DC.W    $0088,$7A92,$0088   ; $007A5A ORI.L  #$7A920088,A0
        DC.W    $7A9A               ; $007A60 MOVEQ   #-$66,D5
        DC.W    $0088,$7AAA,$0088   ; $007A62 ORI.L  #$7AAA0088,A0
        DC.W    $7AB2               ; $007A68 MOVEQ   #-$4E,D5
        DC.W    $0088,$7AB2,$0088   ; $007A6A ORI.L  #$7AB20088,A0
        DC.W    $7AB2               ; $007A70 MOVEQ   #-$4E,D5
        DC.W    $0088,$7AA2,$0088   ; $007A72 ORI.L  #$7AA20088,A0
        DC.W    $7AB2               ; $007A78 MOVEQ   #-$4E,D5
        DC.W    $0088,$7AB2,$0088   ; $007A7A ORI.L  #$7AB20088,A0
        DC.W    $7AB2               ; $007A80 MOVEQ   #-$4E,D5
        DC.W    $0088,$7AB2,$0088   ; $007A82 ORI.L  #$7AB20088,A0
        DC.W    $7AAE               ; $007A88 MOVEQ   #-$52,D5
        DC.W    $7001               ; $007A8A MOVEQ   #$01,D0
        DC.W    $4E75               ; $007A8C RTS
        DC.W    $7002               ; $007A8E MOVEQ   #$02,D0
        DC.W    $4E75               ; $007A90 RTS
        DC.W    $5238,$C31A         ; $007A92 ADDQ.B  #1,$C31A.W
        DC.W    $7004               ; $007A96 MOVEQ   #$04,D0
        DC.W    $4E75               ; $007A98 RTS
        DC.W    $5238,$C31A         ; $007A9A ADDQ.B  #1,$C31A.W
        DC.W    $7008               ; $007A9E MOVEQ   #$08,D0
        DC.W    $4E75               ; $007AA0 RTS
        DC.W    $5238,$C31A         ; $007AA2 ADDQ.B  #1,$C31A.W
        DC.W    $7010               ; $007AA6 MOVEQ   #$10,D0
        DC.W    $4E75               ; $007AA8 RTS
        DC.W    $7002               ; $007AAA MOVEQ   #$02,D0
        DC.W    $4E75               ; $007AAC RTS
        DC.W    $7002               ; $007AAE MOVEQ   #$02,D0
        DC.W    $4E75               ; $007AB0 RTS
        DC.W    $80FC,$0000         ; $007AB2 DIVU    #$0000,D0
        DC.W    $0828,$0007,$00C0   ; $007AB6 BTST    #7,$00C0(A0)
        DC.W    $6618               ; $007ABC BNE.S  loc_007AD6
        DC.W    $4EBA,$00EC         ; $007ABE JSR     loc_007BAC(PC)
        DC.W    $3228,$0032         ; $007AC2 MOVE.W  $0032(A0),D1
        DC.W    $3141,$00C6         ; $007AC6 MOVE.W  D1,$00C6(A0)
        DC.W    $3141,$00C8         ; $007ACA MOVE.W  D1,$00C8(A0)
        DC.W    $5239,$00FF,$5FFE   ; $007ACE ADDQ.B  #1,$00FF5FFE
        DC.W    $4E75               ; $007AD4 RTS
loc_007AD6:
        DC.W    $3028,$0040         ; $007AD6 MOVE.W  $0040(A0),D0
        DC.W    $D068,$0046         ; $007ADA ADD.W  $0046(A0),D0
        DC.W    $47F9,$0093,$661E   ; $007ADE LEA     $0093661E,A3
        DC.W    $EC48               ; $007AE4 LSR.W  #6,D0
        DC.W    $D040               ; $007AE6 ADD.W  D0,D0
        DC.W    $47F3,$0000         ; $007AE8 LEA     $00(A3,D0.W),A3
        DC.W    $121B               ; $007AEC MOVE.B  (A3)+,D1
        DC.W    $4881               ; $007AEE EXT.W   D1
        DC.W    $1413               ; $007AF0 MOVE.B  (A3),D2
        DC.W    $4882               ; $007AF2 EXT.W   D2
        DC.W    $D268,$0030         ; $007AF4 ADD.W  $0030(A0),D1
        DC.W    $D468,$0034         ; $007AF8 ADD.W  $0034(A0),D2
        DC.W    $4EBA,$F8EA         ; $007AFC JSR     loc_0073E8(PC)
        DC.W    $2889               ; $007B00 MOVE.L  A1,(A4)
        DC.W    $4EBA,$F988         ; $007B02 JSR     loc_00748C(PC)
        DC.W    $6610               ; $007B06 BNE.S  loc_007B18
        DC.W    $28BC,$0000,$0000   ; $007B08 MOVE.L  #$00000000,(A4)
        DC.W    $297C,$0000,$0000,$0004; $007B0E MOVE.L  #$00000000,$0004(A4)
        DC.W    $6018               ; $007B16 BRA.S  loc_007B30
loc_007B18:
        DC.W    $294A,$0004         ; $007B18 MOVE.L  A2,$0004(A4)
        DC.W    $4EBA,$FAAA         ; $007B1C JSR     loc_0075C8(PC)
        DC.W    $6F0E               ; $007B20 BLE.S  loc_007B30
        DC.W    $3428,$00C6         ; $007B22 MOVE.W  $00C6(A0),D2
        DC.W    $48C2               ; $007B26 EXT.L   D2
        DC.W    $D282               ; $007B28 ADD.L  D2,D1
        DC.W    $E281               ; $007B2A ASR.L  #1,D1
        DC.W    $3141,$00C6         ; $007B2C MOVE.W  D1,$00C6(A0)
loc_007B30:
        DC.W    $47EB,$07FF         ; $007B30 LEA     $07FF(A3),A3
        DC.W    $121B               ; $007B34 MOVE.B  (A3)+,D1
        DC.W    $4881               ; $007B36 EXT.W   D1
        DC.W    $1413               ; $007B38 MOVE.B  (A3),D2
        DC.W    $4882               ; $007B3A EXT.W   D2
        DC.W    $D268,$0030         ; $007B3C ADD.W  $0030(A0),D1
        DC.W    $D468,$0034         ; $007B40 ADD.W  $0034(A0),D2
        DC.W    $4EBA,$F8A2         ; $007B44 JSR     loc_0073E8(PC)
        DC.W    $2014               ; $007B48 MOVE.L  (A4),D0
        DC.W    $6718               ; $007B4A BEQ.S  loc_007B64
        DC.W    $B3C0               ; $007B4C CMPA.L  D0,A1
        DC.W    $6614               ; $007B4E BNE.S  loc_007B64
        DC.W    $2649               ; $007B50 MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $007B52 MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$F9DC         ; $007B56 JSR     loc_007534(PC)
        DC.W    $660C               ; $007B5A BNE.S  loc_007B68
        DC.W    $224B               ; $007B5C MOVEA.L A3,A1
        DC.W    $4EBA,$F944         ; $007B5E JSR     loc_0074A4(PC)
        DC.W    $6004               ; $007B62 BRA.S  loc_007B68
loc_007B64:
        DC.W    $4EBA,$F926         ; $007B64 JSR     loc_00748C(PC)
loc_007B68:
        DC.W    $4EBA,$FA5E         ; $007B68 JSR     loc_0075C8(PC)
        DC.W    $6F0E               ; $007B6C BLE.S  loc_007B7C
        DC.W    $3428,$00C8         ; $007B6E MOVE.W  $00C8(A0),D2
        DC.W    $48C2               ; $007B72 EXT.L   D2
        DC.W    $D282               ; $007B74 ADD.L  D2,D1
        DC.W    $E281               ; $007B76 ASR.L  #1,D1
        DC.W    $3141,$00C8         ; $007B78 MOVE.W  D1,$00C8(A0)
loc_007B7C:
        DC.W    $3228,$0030         ; $007B7C MOVE.W  $0030(A0),D1
        DC.W    $3428,$0034         ; $007B80 MOVE.W  $0034(A0),D2
        DC.W    $117C,$0001,$0055   ; $007B84 MOVE.B  #$0001,$0055(A0)
        DC.W    $4EBA,$F85C         ; $007B8A JSR     loc_0073E8(PC)
        DC.W    $2014               ; $007B8E MOVE.L  (A4),D0
        DC.W    $672C               ; $007B90 BEQ.S  loc_007BBE
        DC.W    $B3C0               ; $007B92 CMPA.L  D0,A1
        DC.W    $6628               ; $007B94 BNE.S  loc_007BBE
        DC.W    $2649               ; $007B96 MOVEA.L A1,A3
        DC.W    $226C,$0004         ; $007B98 MOVEA.L $0004(A4),A1
        DC.W    $4EBA,$F996         ; $007B9C JSR     loc_007534(PC)
        DC.W    $6622               ; $007BA0 BNE.S  loc_007BC4
        DC.W    $224B               ; $007BA2 MOVEA.L A3,A1
        DC.W    $4EBA,$F8FE         ; $007BA4 JSR     loc_0074A4(PC)
        DC.W    $661A               ; $007BA8 BNE.S  loc_007BC4
        DC.W    $4E75               ; $007BAA RTS
loc_007BAC:
        DC.W    $3228,$0030         ; $007BAC MOVE.W  $0030(A0),D1
        DC.W    $3428,$0034         ; $007BB0 MOVE.W  $0034(A0),D2
        DC.W    $117C,$0001,$0055   ; $007BB4 MOVE.B  #$0001,$0055(A0)
        DC.W    $4EBA,$F82C         ; $007BBA JSR     loc_0073E8(PC)
loc_007BBE:
        DC.W    $4EBA,$F8CC         ; $007BBE JSR     loc_00748C(PC)
        DC.W    $671E               ; $007BC2 BEQ.S  loc_007BE2
loc_007BC4:
        DC.W    $214A,$00CE         ; $007BC4 MOVE.L  A2,$00CE(A0)
        DC.W    $611A               ; $007BC8 BSR.S  loc_007BE4
        DC.W    $1140,$0055         ; $007BCA MOVE.B  D0,$0055(A0)
        DC.W    $4EBA,$F9F8         ; $007BCE JSR     loc_0075C8(PC)
        DC.W    $6F0E               ; $007BD2 BLE.S  loc_007BE2
        DC.W    $3428,$0032         ; $007BD4 MOVE.W  $0032(A0),D2
        DC.W    $48C2               ; $007BD8 EXT.L   D2
        DC.W    $D282               ; $007BDA ADD.L  D2,D1
        DC.W    $E281               ; $007BDC ASR.L  #1,D1
        DC.W    $3141,$0032         ; $007BDE MOVE.W  D1,$0032(A0)
loc_007BE2:
        DC.W    $4E75               ; $007BE2 RTS
loc_007BE4:
        DC.W    $102A,$0018         ; $007BE4 MOVE.B  $0018(A2),D0
        DC.W    $0240,$000F         ; $007BE8 ANDI.W  #$000F,D0
        DC.W    $D040               ; $007BEC ADD.W  D0,D0
        DC.W    $D040               ; $007BEE ADD.W  D0,D0
        DC.W    $227B,$0004         ; $007BF0 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $007BF4 JMP     (A1)
        DC.W    $0088,$7C2E,$0088   ; $007BF6 ORI.L  #$7C2E0088,A0
        DC.W    $7C32               ; $007BFC MOVEQ   #$32,D6
        DC.W    $0088,$7C36,$0088   ; $007BFE ORI.L  #$7C360088,A0
        DC.W    $7C3A               ; $007C04 MOVEQ   #$3A,D6
        DC.W    $0088,$7C42,$0088   ; $007C06 ORI.L  #$7C420088,A0
        DC.W    $7C46               ; $007C0C MOVEQ   #$46,D6
        DC.W    $0088,$7C46,$0088   ; $007C0E ORI.L  #$7C460088,A0
        DC.W    $7C46               ; $007C14 MOVEQ   #$46,D6
        DC.W    $0088,$7C3E,$0088   ; $007C16 ORI.L  #$7C3E0088,A0
        DC.W    $7C46               ; $007C1C MOVEQ   #$46,D6
        DC.W    $0088,$7C46,$0088   ; $007C1E ORI.L  #$7C460088,A0
        DC.W    $7C46               ; $007C24 MOVEQ   #$46,D6
        DC.W    $0088,$7C46,$0088   ; $007C26 ORI.L  #$7C460088,A0
        DC.W    $7C42               ; $007C2C MOVEQ   #$42,D6
        DC.W    $7001               ; $007C2E MOVEQ   #$01,D0
        DC.W    $4E75               ; $007C30 RTS
        DC.W    $7002               ; $007C32 MOVEQ   #$02,D0
        DC.W    $4E75               ; $007C34 RTS
        DC.W    $7004               ; $007C36 MOVEQ   #$04,D0
        DC.W    $4E75               ; $007C38 RTS
        DC.W    $7008               ; $007C3A MOVEQ   #$08,D0
        DC.W    $4E75               ; $007C3C RTS
        DC.W    $7010               ; $007C3E MOVEQ   #$10,D0
        DC.W    $4E75               ; $007C40 RTS
        DC.W    $7002               ; $007C42 MOVEQ   #$02,D0
        DC.W    $4E75               ; $007C44 RTS
        DC.W    $7002               ; $007C46 MOVEQ   #$02,D0
        DC.W    $4E75               ; $007C48 RTS
        DC.W    $80FC,$0000         ; $007C4A DIVU    #$0000,D0
loc_007C4E:
        DC.W    $4A68,$0004         ; $007C4E TST.W  $0004(A0)
        DC.W    $6602               ; $007C52 BNE.S  loc_007C56
        DC.W    $4E75               ; $007C54 RTS
loc_007C56:
        DC.W    $4A68,$0098         ; $007C56 TST.W  $0098(A0)
        DC.W    $661A               ; $007C5A BNE.S  loc_007C76
        DC.W    $0828,$0003,$0058   ; $007C5C BTST    #3,$0058(A0)
        DC.W    $6712               ; $007C62 BEQ.S  loc_007C76
        DC.W    $317C,$000F,$0098   ; $007C64 MOVE.W  #$000F,$0098(A0)
        DC.W    $4A38,$C8A4         ; $007C6A TST.B  $C8A4.W
        DC.W    $6606               ; $007C6E BNE.S  loc_007C76
        DC.W    $11FC,$00D2,$C8A4   ; $007C70 MOVE.B  #$00D2,$C8A4.W
loc_007C76:
        DC.W    $4A68,$009A         ; $007C76 TST.W  $009A(A0)
        DC.W    $661A               ; $007C7A BNE.S  loc_007C96
        DC.W    $0828,$0003,$0059   ; $007C7C BTST    #3,$0059(A0)
        DC.W    $6712               ; $007C82 BEQ.S  loc_007C96
        DC.W    $317C,$000F,$009A   ; $007C84 MOVE.W  #$000F,$009A(A0)
        DC.W    $4A38,$C8A4         ; $007C8A TST.B  $C8A4.W
        DC.W    $6606               ; $007C8E BNE.S  loc_007C96
        DC.W    $11FC,$00D2,$C8A4   ; $007C90 MOVE.B  #$00D2,$C8A4.W
loc_007C96:
        DC.W    $4A68,$00E6         ; $007C96 TST.W  $00E6(A0)
        DC.W    $661A               ; $007C9A BNE.S  loc_007CB6
        DC.W    $0828,$0004,$0058   ; $007C9C BTST    #4,$0058(A0)
        DC.W    $6712               ; $007CA2 BEQ.S  loc_007CB6
        DC.W    $317C,$000F,$00E6   ; $007CA4 MOVE.W  #$000F,$00E6(A0)
        DC.W    $4A38,$C8A4         ; $007CAA TST.B  $C8A4.W
        DC.W    $6606               ; $007CAE BNE.S  loc_007CB6
        DC.W    $11FC,$00D2,$C8A4   ; $007CB0 MOVE.B  #$00D2,$C8A4.W
loc_007CB6:
        DC.W    $4A68,$00E8         ; $007CB6 TST.W  $00E8(A0)
        DC.W    $661A               ; $007CBA BNE.S  loc_007CD6
        DC.W    $0828,$0004,$0059   ; $007CBC BTST    #4,$0059(A0)
        DC.W    $6712               ; $007CC2 BEQ.S  loc_007CD6
        DC.W    $317C,$000F,$00E8   ; $007CC4 MOVE.W  #$000F,$00E8(A0)
        DC.W    $4A38,$C8A4         ; $007CCA TST.B  $C8A4.W
        DC.W    $6606               ; $007CCE BNE.S  loc_007CD6
        DC.W    $11FC,$00D2,$C8A4   ; $007CD0 MOVE.B  #$00D2,$C8A4.W
loc_007CD6:
        DC.W    $4E75               ; $007CD6 RTS
loc_007CD8:
        DC.W    $1028,$0057         ; $007CD8 MOVE.B  $0057(A0),D0
        DC.W    $C028,$0056         ; $007CDC AND.B  $0056(A0),D0
        DC.W    $C028,$0059         ; $007CE0 AND.B  $0059(A0),D0
        DC.W    $C028,$0058         ; $007CE4 AND.B  $0058(A0),D0
        DC.W    $0800,$0001         ; $007CE8 BTST    #1,D0
        DC.W    $6702               ; $007CEC BEQ.S  loc_007CF0
        DC.W    $4E75               ; $007CEE RTS
loc_007CF0:
        DC.W    $0200,$000C         ; $007CF0 ANDI.B  #$000C,D0
        DC.W    $673A               ; $007CF4 BEQ.S  loc_007D30
        DC.W    $0C68,$0064,$0004   ; $007CF6 CMPI.W  #$0064,$0004(A0)
        DC.W    $6F32               ; $007CFC BLE.S  loc_007D30
        DC.W    $4A68,$006A         ; $007CFE TST.W  $006A(A0)
        DC.W    $662C               ; $007D02 BNE.S  loc_007D30
        DC.W    $4A68,$008C         ; $007D04 TST.W  $008C(A0)
        DC.W    $6626               ; $007D08 BNE.S  loc_007D30
        DC.W    $3038,$C8D2         ; $007D0A MOVE.W  $C8D2.W,D0
        DC.W    $B068,$0094         ; $007D0E CMP.W  $0094(A0),D0
        DC.W    $6E08               ; $007D12 BGT.S  loc_007D1C
        DC.W    $0068,$1000,$0002   ; $007D14 ORI.W  #$1000,$0002(A0)
        DC.W    $600E               ; $007D1A BRA.S  loc_007D2A
loc_007D1C:
        DC.W    $4440               ; $007D1C NEG.W  D0
        DC.W    $B068,$0094         ; $007D1E CMP.W  $0094(A0),D0
        DC.W    $6D0C               ; $007D22 BLT.S  loc_007D30
        DC.W    $0068,$2000,$0002   ; $007D24 ORI.W  #$2000,$0002(A0)
loc_007D2A:
        DC.W    $11FC,$00B2,$C8A4   ; $007D2A MOVE.B  #$00B2,$C8A4.W
loc_007D30:
        DC.W    $4A68,$0062         ; $007D30 TST.W  $0062(A0)
        DC.W    $6716               ; $007D34 BEQ.S  loc_007D4C
        DC.W    $1228,$0057         ; $007D36 MOVE.B  $0057(A0),D1
        DC.W    $C228,$0056         ; $007D3A AND.B  $0056(A0),D1
        DC.W    $0201,$0001         ; $007D3E ANDI.B  #$0001,D1
        DC.W    $6710               ; $007D42 BEQ.S  loc_007D54
        DC.W    $3028,$001C         ; $007D44 MOVE.W  $001C(A0),D0
        DC.W    $4EFA,$015A         ; $007D48 JMP     loc_007EA4(PC)
loc_007D4C:
        DC.W    $0828,$0000,$0055   ; $007D4C BTST    #0,$0055(A0)
        DC.W    $6602               ; $007D52 BNE.S  loc_007D56
loc_007D54:
        DC.W    $4E75               ; $007D54 RTS
loc_007D56:
        DC.W    $11FC,$00B5,$C8A4   ; $007D56 MOVE.B  #$00B5,$C8A4.W
        DC.W    $3028,$0040         ; $007D5C MOVE.W  $0040(A0),D0
        DC.W    $9068,$001E         ; $007D60 SUB.W  $001E(A0),D0
        DC.W    $6A02               ; $007D64 BPL.S  loc_007D68
        DC.W    $4440               ; $007D66 NEG.W  D0
loc_007D68:
        DC.W    $0C68,$0118,$0004   ; $007D68 CMPI.W  #$0118,$0004(A0)
        DC.W    $6F00,$009C         ; $007D6E BLE.W  loc_007E0C
        DC.W    $0C40,$0800         ; $007D72 CMPI.W  #$0800,D0
        DC.W    $6F00,$0094         ; $007D76 BLE.W  loc_007E0C
        DC.W    $4A68,$008C         ; $007D7A TST.W  $008C(A0)
        DC.W    $6702               ; $007D7E BEQ.S  loc_007D82
        DC.W    $4E75               ; $007D80 RTS
loc_007D82:
        DC.W    $0C78,$0001,$C89C   ; $007D82 CMPI.W  #$0001,$C89C.W
        DC.W    $660A               ; $007D88 BNE.S  loc_007D94
        DC.W    $0828,$0002,$00E5   ; $007D8A BTST    #2,$00E5(A0)
        DC.W    $6600,$009E         ; $007D90 BNE.W  loc_007E30
loc_007D94:
        DC.W    $4A78,$C04C         ; $007D94 TST.W  $C04C.W
        DC.W    $670C               ; $007D98 BEQ.S  loc_007DA6
        DC.W    $31FC,$0001,$C004   ; $007D9A MOVE.W  #$0001,$C004.W
        DC.W    $31FC,$0001,$C048   ; $007DA0 MOVE.W  #$0001,$C048.W
loc_007DA6:
        DC.W    $3028,$0024         ; $007DA6 MOVE.W  $0024(A0),D0
        DC.W    $5440               ; $007DAA ADDQ.W  #2,D0
        DC.W    $4A38,$C312         ; $007DAC TST.B  $C312.W
        DC.W    $6702               ; $007DB0 BEQ.S  loc_007DB4
        DC.W    $5940               ; $007DB2 SUBQ.W  #4,D0
loc_007DB4:
        DC.W    $43FA,$00BE         ; $007DB4 LEA     $00BE(PC),A1
        DC.W    $3C38,$C89C         ; $007DB8 MOVE.W  $C89C.W,D6
        DC.W    $1C31,$6000         ; $007DBC MOVE.B  $00(A1,D6.W),D6
        DC.W    $ED68               ; $007DC0 LSL.W  D6,D0
        DC.W    $1228,$00E5         ; $007DC2 MOVE.B  $00E5(A0),D1
        DC.W    $0201,$0006         ; $007DC6 ANDI.B  #$0006,D1
        DC.W    $6702               ; $007DCA BEQ.S  loc_007DCE
        DC.W    $5240               ; $007DCC ADDQ.W  #1,D0
loc_007DCE:
        DC.W    $2278,$C708         ; $007DCE MOVEA.L $C708.W,A1
        DC.W    $1031,$0000         ; $007DD2 MOVE.B  $00(A1,D0.W),D0
        DC.W    $0240,$00FF         ; $007DD6 ANDI.W  #$00FF,D0
        DC.W    $7228               ; $007DDA MOVEQ   #$28,D1
        DC.W    $3141,$008C         ; $007DDC MOVE.W  D1,$008C(A0)
        DC.W    $3141,$0014         ; $007DE0 MOVE.W  D1,$0014(A0)
        DC.W    $31F8,$C09A,$C07A   ; $007DE4 MOVE.W  $C09A.W,$C07A.W
        DC.W    $4EBA,$00CC         ; $007DEA JSR     loc_007EB8(PC)
        DC.W    $4A38,$C826         ; $007DEE TST.B  $C826.W
        DC.W    $6710               ; $007DF2 BEQ.S  loc_007E04
        DC.W    $0C68,$000F,$008A   ; $007DF4 CMPI.W  #$000F,$008A(A0)
        DC.W    $6C08               ; $007DFA BGE.S  loc_007E04
        DC.W    $5268,$008A         ; $007DFC ADDQ.W  #1,$008A(A0)
        DC.W    $4EBA,$23FA         ; $007E00 JSR     $00A1FC(PC)
loc_007E04:
        DC.W    $11FC,$00B0,$C8A4   ; $007E04 MOVE.B  #$00B0,$C8A4.W
        DC.W    $4E75               ; $007E0A RTS
loc_007E0C:
        DC.W    $0C78,$0001,$C89C   ; $007E0C CMPI.W  #$0001,$C89C.W
        DC.W    $6608               ; $007E12 BNE.S  loc_007E1C
        DC.W    $0C28,$00B1,$001D   ; $007E14 CMPI.B  #$00B1,$001D(A0)
        DC.W    $6714               ; $007E1A BEQ.S  loc_007E30
loc_007E1C:
        DC.W    $1228,$0057         ; $007E1C MOVE.B  $0057(A0),D1
        DC.W    $C228,$0056         ; $007E20 AND.B  $0056(A0),D1
        DC.W    $0201,$0001         ; $007E24 ANDI.B  #$0001,D1
        DC.W    $6606               ; $007E28 BNE.S  loc_007E30
        DC.W    $0C40,$3000         ; $007E2A CMPI.W  #$3000,D0
        DC.W    $6F08               ; $007E2E BLE.S  loc_007E38
loc_007E30:
        DC.W    $3028,$001C         ; $007E30 MOVE.W  $001C(A0),D0
        DC.W    $4EFA,$006E         ; $007E34 JMP     loc_007EA4(PC)
loc_007E38:
        DC.W    $4A68,$0092         ; $007E38 TST.W  $0092(A0)
        DC.W    $6E34               ; $007E3C BGT.S  loc_007E72
        DC.W    $0640,$1000         ; $007E3E ADDI.W  #$1000,D0
        DC.W    $E340               ; $007E42 ASL.W  #1,D0
        DC.W    $317C,$FFFF,$0068   ; $007E44 MOVE.W  #$FFFF,$0068(A0)
        DC.W    $4A68,$0072         ; $007E4A TST.W  $0072(A0)
        DC.W    $6F08               ; $007E4E BLE.S  loc_007E58
        DC.W    $317C,$0001,$0068   ; $007E50 MOVE.W  #$0001,$0068(A0)
        DC.W    $4440               ; $007E56 NEG.W  D0
loc_007E58:
        DC.W    $3140,$0066         ; $007E58 MOVE.W  D0,$0066(A0)
        DC.W    $9068,$0040         ; $007E5C SUB.W  $0040(A0),D0
        DC.W    $4440               ; $007E60 NEG.W  D0
        DC.W    $3140,$0064         ; $007E62 MOVE.W  D0,$0064(A0)
        DC.W    $317C,$0004,$0062   ; $007E66 MOVE.W  #$0004,$0062(A0)
        DC.W    $317C,$0004,$0014   ; $007E6C MOVE.W  #$0004,$0014(A0)
loc_007E72:
        DC.W    $4E75               ; $007E72 RTS
        DC.W    $0101               ; $007E74 BTST    D0,D1
        DC.W    $0101               ; $007E76 BTST    D0,D1
        DC.W    $0101               ; $007E78 BTST    D0,D1
loc_007E7A:
        DC.W    $0828,$0001,$0055   ; $007E7A BTST    #1,$0055(A0)
        DC.W    $661C               ; $007E80 BNE.S  loc_007E9E
        DC.W    $5278,$C02A         ; $007E82 ADDQ.W  #1,$C02A.W
        DC.W    $0C78,$0050,$C02A   ; $007E86 CMPI.W  #$0050,$C02A.W
        DC.W    $6F14               ; $007E8C BLE.S  loc_007EA2
        DC.W    $4278,$C02A         ; $007E8E CLR.W  $C02A.W
        DC.W    $4268,$0006         ; $007E92 CLR.W  $0006(A0)
        DC.W    $3028,$001C         ; $007E96 MOVE.W  $001C(A0),D0
        DC.W    $4EFA,$0008         ; $007E9A JMP     loc_007EA4(PC)
loc_007E9E:
        DC.W    $4278,$C02A         ; $007E9E CLR.W  $C02A.W
loc_007EA2:
        DC.W    $4E75               ; $007EA2 RTS
loc_007EA4:
        DC.W    $7214               ; $007EA4 MOVEQ   #$14,D1
        DC.W    $3838,$C07A         ; $007EA6 MOVE.W  $C07A.W,D4
        DC.W    $B878,$C098         ; $007EAA CMP.W  $C098.W,D4
        DC.W    $6602               ; $007EAE BNE.S  loc_007EB2
        DC.W    $4E75               ; $007EB0 RTS
loc_007EB2:
        DC.W    $31F8,$C090,$C07A   ; $007EB2 MOVE.W  $C090.W,$C07A.W
loc_007EB8:
        DC.W    $31C1,$C02C         ; $007EB8 MOVE.W  D1,$C02C.W
        DC.W    $D040               ; $007EBC ADD.W  D0,D0
        DC.W    $3400               ; $007EBE MOVE.W  D0,D2
        DC.W    $D442               ; $007EC0 ADD.W  D2,D2
        DC.W    $2278,$C700         ; $007EC2 MOVEA.L $C700.W,A1
        DC.W    $3631,$2000         ; $007EC6 MOVE.W  $00(A1,D2.W),D3
        DC.W    $9668,$0030         ; $007ECA SUB.W  $0030(A0),D3
        DC.W    $48C3               ; $007ECE EXT.L   D3
        DC.W    $87C1               ; $007ED0 DIVS    D1,D3
        DC.W    $5243               ; $007ED2 ADDQ.W  #1,D3
        DC.W    $3143,$004E         ; $007ED4 MOVE.W  D3,$004E(A0)
        DC.W    $3631,$2002         ; $007ED8 MOVE.W  $02(A1,D2.W),D3
        DC.W    $9668,$0034         ; $007EDC SUB.W  $0034(A0),D3
        DC.W    $48C3               ; $007EE0 EXT.L   D3
        DC.W    $87C1               ; $007EE2 DIVS    D1,D3
        DC.W    $5243               ; $007EE4 ADDQ.W  #1,D3
        DC.W    $3143,$0050         ; $007EE6 MOVE.W  D3,$0050(A0)
        DC.W    $3028,$001E         ; $007EEA MOVE.W  $001E(A0),D0
        DC.W    $9068,$003C         ; $007EEE SUB.W  $003C(A0),D0
        DC.W    $48C0               ; $007EF2 EXT.L   D0
        DC.W    $81C1               ; $007EF4 DIVS    D1,D0
        DC.W    $3140,$0052         ; $007EF6 MOVE.W  D0,$0052(A0)
        DC.W    $4E75               ; $007EFA RTS
loc_007EFC:
        DC.W    $45F9,$00FF,$6940   ; $007EFC LEA     $00FF6940,A2
        DC.W    $6006               ; $007F02 BRA.S  loc_007F0A
loc_007F04:
        DC.W    $45F9,$00FF,$6930   ; $007F04 LEA     $00FF6930,A2
loc_007F0A:
        DC.W    $3028,$003C         ; $007F0A MOVE.W  $003C(A0),D0
        DC.W    $9068,$001E         ; $007F0E SUB.W  $001E(A0),D0
        DC.W    $48C0               ; $007F12 EXT.L   D0
        DC.W    $6A06               ; $007F14 BPL.S  loc_007F1C
        DC.W    $0680,$0001,$0000   ; $007F16 ADDI.L  #$00010000,D0
loc_007F1C:
        DC.W    $0C80,$0000,$4000   ; $007F1C CMPI.L  #$00004000,D0
        DC.W    $6F1E               ; $007F22 BLE.S  loc_007F42
        DC.W    $0C80,$0000,$C000   ; $007F24 CMPI.L  #$0000C000,D0
        DC.W    $6C16               ; $007F2A BGE.S  loc_007F42
        DC.W    $11FC,$0001,$C312   ; $007F2C MOVE.B  #$0001,$C312.W
        DC.W    $4212               ; $007F32 CLR.B  (A2)
        DC.W    $0838,$0002,$C8AB   ; $007F34 BTST    #2,$C8AB.W
        DC.W    $6712               ; $007F3A BEQ.S  loc_007F4E
        DC.W    $14BC,$0001         ; $007F3C MOVE.B  #$0001,(A2)
        DC.W    $600C               ; $007F40 BRA.S  loc_007F4E
loc_007F42:
        DC.W    $4A38,$C312         ; $007F42 TST.B  $C312.W
        DC.W    $6706               ; $007F46 BEQ.S  loc_007F4E
        DC.W    $4212               ; $007F48 CLR.B  (A2)
        DC.W    $4238,$C312         ; $007F4A CLR.B  $C312.W
loc_007F4E:
        DC.W    $4E75               ; $007F4E RTS
loc_007F50:
        DC.W    $3028,$0024         ; $007F50 MOVE.W  $0024(A0),D0
        DC.W    $9068,$0026         ; $007F54 SUB.W  $0026(A0),D0
        DC.W    $0C40,$0064         ; $007F58 CMPI.W  #$0064,D0
        DC.W    $6F06               ; $007F5C BLE.S  loc_007F64
        DC.W    $5368,$002E         ; $007F5E SUBQ.W  #1,$002E(A0)
        DC.W    $4E75               ; $007F62 RTS
loc_007F64:
        DC.W    $0C40,$FF9C         ; $007F64 CMPI.W  #$FF9C,D0
        DC.W    $6C00,$009A         ; $007F68 BGE.W  loc_008004
        DC.W    $5268,$002E         ; $007F6C ADDQ.W  #1,$002E(A0)
        DC.W    $317C,$0497,$0008   ; $007F70 MOVE.W  #$0497,$0008(A0)
        DC.W    $3228,$002C         ; $007F76 MOVE.W  $002C(A0),D1
        DC.W    $5241               ; $007F7A ADDQ.W  #1,D1
        DC.W    $B268,$002E         ; $007F7C CMP.W  $002E(A0),D1
        DC.W    $6656               ; $007F80 BNE.S  loc_007FD8
        DC.W    $11FC,$0004,$C305   ; $007F82 MOVE.B  #$0004,$C305.W
        DC.W    $5268,$002C         ; $007F88 ADDQ.W  #1,$002C(A0)
        DC.W    $4268,$0028         ; $007F8C CLR.W  $0028(A0)
        DC.W    $4A68,$00AC         ; $007F90 TST.W  $00AC(A0)
        DC.W    $6F08               ; $007F94 BLE.S  loc_007F9E
        DC.W    $0C68,$0003,$001C   ; $007F96 CMPI.W  #$0003,$001C(A0)
        DC.W    $6E10               ; $007F9C BGT.S  loc_007FAE
loc_007F9E:
        DC.W    $0068,$4000,$0002   ; $007F9E ORI.W  #$4000,$0002(A0)
        DC.W    $31FC,$0050,$C04E   ; $007FA4 MOVE.W  #$0050,$C04E.W
        DC.W    $4278,$C8AA         ; $007FAA CLR.W  $C8AA.W
loc_007FAE:
        DC.W    $1038,$C310         ; $007FAE MOVE.B  $C310.W,D0
        DC.W    $5300               ; $007FB2 SUBQ.B  #1,D0
        DC.W    $B028,$002D         ; $007FB4 CMP.B  $002D(A0),D0
        DC.W    $6C34               ; $007FB8 BGE.S  loc_007FEE
        DC.W    $08F8,$0005,$C30E   ; $007FBA BSET    #5,$C30E.W
        DC.W    $0838,$0005,$C80E   ; $007FC0 BTST    #5,$C80E.W
        DC.W    $6712               ; $007FC6 BEQ.S  loc_007FDA
        DC.W    $0068,$4000,$0002   ; $007FC8 ORI.W  #$4000,$0002(A0)
        DC.W    $31FC,$0050,$C04E   ; $007FCE MOVE.W  #$0050,$C04E.W
        DC.W    $4278,$C8AA         ; $007FD4 CLR.W  $C8AA.W
loc_007FD8:
        DC.W    $4E75               ; $007FD8 RTS
loc_007FDA:
        DC.W    $0268,$BFFF,$0002   ; $007FDA ANDI.W  #$BFFF,$0002(A0)
        DC.W    $31FC,$0000,$C04E   ; $007FE0 MOVE.W  #$0000,$C04E.W
        DC.W    $11FC,$0000,$C305   ; $007FE6 MOVE.B  #$0000,$C305.W
        DC.W    $4E75               ; $007FEC RTS
loc_007FEE:
        DC.W    $B028,$002D         ; $007FEE CMP.B  $002D(A0),D0
        DC.W    $660E               ; $007FF2 BNE.S  loc_008002
        DC.W    $0C68,$0064,$001C   ; $007FF4 CMPI.W  #$0064,$001C(A0)
        DC.W    $6406               ; $007FFA BCC.S  loc_008002
        DC.W    $11FC,$00BE,$C8A4   ; $007FFC MOVE.B  #$00BE,$C8A4.W
loc_008002:
        DC.W    $4E75               ; $008002 RTS
loc_008004:
        DC.W    $3028,$002C         ; $008004 MOVE.W  $002C(A0),D0
        DC.W    $B068,$002E         ; $008008 CMP.W  $002E(A0),D0
        DC.W    $6622               ; $00800C BNE.S  loc_008030
        DC.W    $3028,$0024         ; $00800E MOVE.W  $0024(A0),D0
        DC.W    $B068,$0028         ; $008012 CMP.W  $0028(A0),D0
        DC.W    $6F18               ; $008016 BLE.S  loc_008030
        DC.W    $3168,$0024,$0028   ; $008018 MOVE.W  $0024(A0),$0028(A0)
        DC.W    $4A38,$C319         ; $00801E TST.B  $C319.W
        DC.W    $6A0C               ; $008022 BPL.S  loc_008030
        DC.W    $0068,$4000,$0002   ; $008024 ORI.W  #$4000,$0002(A0)
        DC.W    $31FC,$0050,$C04E   ; $00802A MOVE.W  #$0050,$C04E.W
loc_008030:
        DC.W    $4E75               ; $008030 RTS
loc_008032:
        DC.W    $4A78,$C07C         ; $008032 TST.W  $C07C.W
        DC.W    $661A               ; $008036 BNE.S  loc_008052
        DC.W    $0C68,$0014,$002C   ; $008038 CMPI.W  #$0014,$002C(A0)
        DC.W    $6C12               ; $00803E BGE.S  loc_008052
        DC.W    $3028,$0024         ; $008040 MOVE.W  $0024(A0),D0
        DC.W    $9068,$0026         ; $008044 SUB.W  $0026(A0),D0
        DC.W    $0C40,$0064         ; $008048 CMPI.W  #$0064,D0
        DC.W    $6F06               ; $00804C BLE.S  loc_008054
        DC.W    $5368,$002E         ; $00804E SUBQ.W  #1,$002E(A0)
loc_008052:
        DC.W    $4E75               ; $008052 RTS
loc_008054:
        DC.W    $0C40,$FF9C         ; $008054 CMPI.W  #$FF9C,D0
        DC.W    $6CAA               ; $008058 BGE.S  loc_008004
        DC.W    $5268,$002E         ; $00805A ADDQ.W  #1,$002E(A0)
        DC.W    $317C,$0497,$0008   ; $00805E MOVE.W  #$0497,$0008(A0)
        DC.W    $3228,$002C         ; $008064 MOVE.W  $002C(A0),D1
        DC.W    $5241               ; $008068 ADDQ.W  #1,D1
        DC.W    $B268,$002E         ; $00806A CMP.W  $002E(A0),D1
        DC.W    $663C               ; $00806E BNE.S  loc_0080AC
        DC.W    $11FC,$0004,$C305   ; $008070 MOVE.B  #$0004,$C305.W
        DC.W    $5268,$002C         ; $008076 ADDQ.W  #1,$002C(A0)
        DC.W    $4268,$0028         ; $00807A CLR.W  $0028(A0)
        DC.W    $0068,$4000,$0002   ; $00807E ORI.W  #$4000,$0002(A0)
        DC.W    $31FC,$0050,$C04E   ; $008084 MOVE.W  #$0050,$C04E.W
        DC.W    $4278,$C8AA         ; $00808A CLR.W  $C8AA.W
        DC.W    $1038,$C310         ; $00808E MOVE.B  $C310.W,D0
        DC.W    $5300               ; $008092 SUBQ.B  #1,D0
        DC.W    $B028,$002D         ; $008094 CMP.B  $002D(A0),D0
        DC.W    $6C14               ; $008098 BGE.S  loc_0080AE
        DC.W    $0268,$BFFF,$0002   ; $00809A ANDI.W  #$BFFF,$0002(A0)
        DC.W    $31FC,$0000,$C04E   ; $0080A0 MOVE.W  #$0000,$C04E.W
        DC.W    $08F8,$0005,$C30E   ; $0080A6 BSET    #5,$C30E.W
loc_0080AC:
        DC.W    $4E75               ; $0080AC RTS
loc_0080AE:
        DC.W    $B028,$002D         ; $0080AE CMP.B  $002D(A0),D0
        DC.W    $6616               ; $0080B2 BNE.S  loc_0080CA
        DC.W    $3038,$C08E         ; $0080B4 MOVE.W  $C08E.W,D0
        DC.W    $B078,$C07A         ; $0080B8 CMP.W  $C07A.W,D0
        DC.W    $670C               ; $0080BC BEQ.S  loc_0080CA
        DC.W    $4A38,$C819         ; $0080BE TST.B  $C819.W
        DC.W    $6606               ; $0080C2 BNE.S  loc_0080CA
        DC.W    $11FC,$00BE,$C8A4   ; $0080C4 MOVE.B  #$00BE,$C8A4.W
loc_0080CA:
        DC.W    $4E75               ; $0080CA RTS
loc_0080CC:
        DC.W    $7400               ; $0080CC MOVEQ   #$00,D2
        DC.W    $3428,$008C         ; $0080CE MOVE.W  $008C(A0),D2
        DC.W    $6602               ; $0080D2 BNE.S  loc_0080D6
        DC.W    $4E75               ; $0080D4 RTS
loc_0080D6:
        DC.W    $4A78,$C04C         ; $0080D6 TST.W  $C04C.W
        DC.W    $670C               ; $0080DA BEQ.S  loc_0080E8
        DC.W    $31FC,$0001,$C004   ; $0080DC MOVE.W  #$0001,$C004.W
        DC.W    $31FC,$0001,$C048   ; $0080E2 MOVE.W  #$0001,$C048.W
loc_0080E8:
        DC.W    $43F9,$0093,$9EEC   ; $0080E8 LEA     $00939EEC,A1
        DC.W    $E74A               ; $0080EE LSL.W  #3,D2
        DC.W    $D3C2               ; $0080F0 ADDA.L  D2,A1
        DC.W    $3159,$009C         ; $0080F2 MOVE.W  (A1)+,$009C(A0)
        DC.W    $3159,$009E         ; $0080F6 MOVE.W  (A1)+,$009E(A0)
        DC.W    $3159,$00A0         ; $0080FA MOVE.W  (A1)+,$00A0(A0)
        DC.W    $3151,$00A2         ; $0080FE MOVE.W  (A1),$00A2(A0)
        DC.W    $5368,$008C         ; $008102 SUBQ.W  #1,$008C(A0)
        DC.W    $6E66               ; $008106 BGT.S  loc_00816E
        DC.W    $4A78,$C004         ; $008108 TST.W  $C004.W
        DC.W    $6708               ; $00810C BEQ.S  loc_008116
        DC.W    $4278,$C048         ; $00810E CLR.W  $C048.W
        DC.W    $4278,$C004         ; $008112 CLR.W  $C004.W
loc_008116:
        DC.W    $7000               ; $008116 MOVEQ   #$00,D0
        DC.W    $3140,$008C         ; $008118 MOVE.W  D0,$008C(A0)
        DC.W    $3140,$009E         ; $00811C MOVE.W  D0,$009E(A0)
        DC.W    $3140,$00A0         ; $008120 MOVE.W  D0,$00A0(A0)
        DC.W    $3140,$00A2         ; $008124 MOVE.W  D0,$00A2(A0)
        DC.W    $3140,$009C         ; $008128 MOVE.W  D0,$009C(A0)
        DC.W    $0C68,$011C,$0006   ; $00812C CMPI.W  #$011C,$0006(A0)
        DC.W    $6C06               ; $008132 BGE.S  loc_00813A
        DC.W    $317C,$011C,$0006   ; $008134 MOVE.W  #$011C,$0006(A0)
loc_00813A:
        DC.W    $0C78,$0001,$C89C   ; $00813A CMPI.W  #$0001,$C89C.W
        DC.W    $661A               ; $008140 BNE.S  loc_00815C
        DC.W    $1028,$00E5         ; $008142 MOVE.B  $00E5(A0),D0
        DC.W    $0200,$0006         ; $008146 ANDI.B  #$0006,D0
        DC.W    $6710               ; $00814A BEQ.S  loc_00815C
        DC.W    $3028,$0024         ; $00814C MOVE.W  $0024(A0),D0
        DC.W    $0C40,$0069         ; $008150 CMPI.W  #$0069,D0
        DC.W    $6D06               ; $008154 BLT.S  loc_00815C
        DC.W    $0C40,$0071         ; $008156 CMPI.W  #$0071,D0
        DC.W    $6F12               ; $00815A BLE.S  loc_00816E
loc_00815C:
        DC.W    $31FC,$0027,$C0AC   ; $00815C MOVE.W  #$0027,$C0AC.W
        DC.W    $317C,$0028,$0092   ; $008162 MOVE.W  #$0028,$0092(A0)
        DC.W    $3168,$003C,$0040   ; $008168 MOVE.W  $003C(A0),$0040(A0)
loc_00816E:
        DC.W    $4E75               ; $00816E RTS
loc_008170:
        DC.W    $4A68,$0062         ; $008170 TST.W  $0062(A0)
        DC.W    $6F48               ; $008174 BLE.S  loc_0081BE
        DC.W    $5368,$0062         ; $008176 SUBQ.W  #1,$0062(A0)
        DC.W    $6642               ; $00817A BNE.S  loc_0081BE
        DC.W    $0C78,$0001,$C89C   ; $00817C CMPI.W  #$0001,$C89C.W
        DC.W    $661A               ; $008182 BNE.S  loc_00819E
        DC.W    $1028,$00E5         ; $008184 MOVE.B  $00E5(A0),D0
        DC.W    $0200,$0006         ; $008188 ANDI.B  #$0006,D0
        DC.W    $6710               ; $00818C BEQ.S  loc_00819E
        DC.W    $3028,$0024         ; $00818E MOVE.W  $0024(A0),D0
        DC.W    $0C40,$0069         ; $008192 CMPI.W  #$0069,D0
        DC.W    $6D06               ; $008196 BLT.S  loc_00819E
        DC.W    $0C40,$006F         ; $008198 CMPI.W  #$006F,D0
        DC.W    $6F20               ; $00819C BLE.S  loc_0081BE
loc_00819E:
        DC.W    $31FC,$000F,$C0AC   ; $00819E MOVE.W  #$000F,$C0AC.W
        DC.W    $0C78,$0002,$C8C8   ; $0081A4 CMPI.W  #$0002,$C8C8.W
        DC.W    $6606               ; $0081AA BNE.S  loc_0081B2
        DC.W    $31FC,$0004,$C0AC   ; $0081AC MOVE.W  #$0004,$C0AC.W
loc_0081B2:
        DC.W    $317C,$0028,$0092   ; $0081B2 MOVE.W  #$0028,$0092(A0)
        DC.W    $3168,$003C,$0040   ; $0081B8 MOVE.W  $003C(A0),$0040(A0)
loc_0081BE:
        DC.W    $4E75               ; $0081BE RTS
        DC.W    $0A0A,$0E0A         ; $0081C0 EORI.B  #$0E0A,A2
        DC.W    $120A               ; $0081C4 MOVE.B  A2,D1
        DC.W    $0000,$0B0B         ; $0081C6 ORI.B  #$0B0B,D0
        DC.W    $100B               ; $0081CA MOVE.B  A3,D0
        DC.W    $140B               ; $0081CC MOVE.B  A3,D2
        DC.W    $0000,$0A0A         ; $0081CE ORI.B  #$0A0A,D0
        DC.W    $0E0A               ; $0081D2 DC.W    $0E0A
        DC.W    $120A               ; $0081D4 MOVE.B  A2,D1
        DC.W    $0000,$0828         ; $0081D6 ORI.B  #$0828,D0
        DC.W    $0006,$0002         ; $0081DA ORI.B  #$0002,D6
        DC.W    $672A               ; $0081DE BEQ.S  $00820A
        DC.W    $0268,$BFFF,$0002   ; $0081E0 ANDI.W  #$BFFF,$0002(A0)
        DC.W    $3038,$C8CC         ; $0081E6 MOVE.W  $C8CC.W,D0
        DC.W    $D040               ; $0081EA ADD.W  D0,D0
        DC.W    $D078,$C89C         ; $0081EC ADD.W  $C89C.W,D0
        DC.W    $103B,$00CE         ; $0081F0 MOVE.B  -$32(PC,D0.W),D0
        DC.W    $D178,$C050         ; $0081F4 ADD.W  D0,$C050.W
        DC.W    $4278,$C8AA         ; $0081F8 CLR.W  $C8AA.W
        DC.W    $0C38,$00BE,$C8A4   ; $0081FC CMPI.B  #$00BE,$C8A4.W
