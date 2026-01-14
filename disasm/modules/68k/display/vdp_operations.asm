; Generated assembly for $0027F8-$002878
; Branch targets: 5
; Labels: 5
; Format: DC.W with decoded mnemonics as comments

        org     $0027F8

        DC.W    $3E3C,$000F         ; $0027F8 MOVE.W  #$000F,D7
        DC.W    $303C,$0101         ; $0027FC MOVE.W  #$0101,D0
        DC.W    $343C,$0100         ; $002800 MOVE.W  #$0100,D2
        DC.W    $397C,$00FF,$0084   ; $002804 MOVE.W  #$00FF,$0084(A4)
loc_00280A:
        DC.W    $3481               ; $00280A MOVE.W  D1,(A2)
        DC.W    $3680               ; $00280C MOVE.W  D0,(A3)
loc_00280E:
        DC.W    $082C,$0001,$008B   ; $00280E BTST    #1,$008B(A4)
        DC.W    $66F8               ; $002814 BNE.S  loc_00280E
        DC.W    $D242               ; $002816 ADD.W  D2,D1
        DC.W    $51CF,$FFF0         ; $002818 DBRA    D7,loc_00280A
        DC.W    $4E75               ; $00281C RTS
        DC.W    $49F9,$00A1,$5100   ; $00281E LEA     $00A15100,A4
        DC.W    $45F9,$00A1,$5186   ; $002824 LEA     $00A15186,A2
        DC.W    $47F9,$00A1,$5188   ; $00282A LEA     $00A15188,A3
        DC.W    $323C,$1F00         ; $002830 MOVE.W  #$1F00,D1
        DC.W    $303C,$0101         ; $002834 MOVE.W  #$0101,D0
        DC.W    $397C,$00FF,$0084   ; $002838 MOVE.W  #$00FF,$0084(A4)
        DC.W    $3481               ; $00283E MOVE.W  D1,(A2)
        DC.W    $3680               ; $002840 MOVE.W  D0,(A3)
loc_002842:
        DC.W    $082C,$0001,$008B   ; $002842 BTST    #1,$008B(A4)
        DC.W    $66F8               ; $002848 BNE.S  loc_002842
        DC.W    $4E75               ; $00284A RTS
        DC.W    $47F9,$00A1,$5200   ; $00284C LEA     $00A15200,A3
        DC.W    $7E1F               ; $002852 MOVEQ   #$1F,D7
loc_002854:
        DC.W    $26DA               ; $002854 MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $002856 MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $002858 MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $00285A MOVE.L  (A2)+,(A3)+
        DC.W    $51CF,$FFF6         ; $00285C DBRA    D7,loc_002854
        DC.W    $4E75               ; $002860 RTS
        DC.W    $47F9,$00A1,$5240   ; $002862 LEA     $00A15240,A3
        DC.W    $7E07               ; $002868 MOVEQ   #$07,D7
loc_00286A:
        DC.W    $26DA               ; $00286A MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $00286C MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $00286E MOVE.L  (A2)+,(A3)+
        DC.W    $26DA               ; $002870 MOVE.L  (A2)+,(A3)+
        DC.W    $51CF,$FFF6         ; $002872 DBRA    D7,loc_00286A
        DC.W    $4E75               ; $002876 RTS
