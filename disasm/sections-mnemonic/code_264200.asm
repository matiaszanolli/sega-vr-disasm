; Generated assembly for $264200-$266200
; Branch targets: 0
; Labels: 0
; Format: DC.W with decoded mnemonics as comments

        org     $264200

        OR.L   D7,D0                            ; $264200
        OR.L   A2,D0                            ; $264202
        OR.L   A4,D0                            ; $264204
        OR.L   A6,D0                            ; $264206
        OR.L   A6,D0                            ; $264208
        OR.L   A6,D0                            ; $26420A
        MOVE.W  A5,-$75(A7,D7.L)                ; $26420C
        MOVEQ   #-$77,D7                        ; $264210
        MOVEQ   #-$79,D7                        ; $264212
        MOVEQ   #-$7B,D7                        ; $264214
        MOVE.W  D2,-$80(A6,D7.L)                ; $264216
        DC.W    $7D7E,$7D7D         ; $26421A MOVE.W  <EA:3E>,$7D7D(A6)
        MOVE.W  #$7D7C,$7E7C(A6)                ; $26421E
        MOVEQ   #$7C,D7                         ; $264224
        MOVEQ   #$7D,D7                         ; $264226
        DC.W    $7F7E,$7F7F         ; $264228 MOVE.W  <EA:3E>,$7F7F(A7)
        MOVE.W  D1,-$7E(A7,D7.L)                ; $26422C
        OR.L   D4,D0                            ; $264230
        OR.L   D5,D0                            ; $264232
        OR.L   D5,D0                            ; $264234
        OR.L   D5,D0                            ; $264236
        OR.L   D0,D5                            ; $264238
        OR.L   D0,D5                            ; $26423A
        OR.L   D4,D1                            ; $26423C
        OR.L   D2,D1                            ; $26423E
        OR.L   D1,D1                            ; $264240
        DC.W    $817F               ; $264242 OR.W   D0,<EA:3F>
        DC.W    $817D               ; $264244 OR.W   D0,<EA:3D>
        OR.W   $7A(PC,A0.W),D0                  ; $264246
        OR.W   D0,$81778076                     ; $26424A
        OR.W   $73(A4,D7.L),D0                  ; $264250
        MOVE.W  $72(A2,D7.L),$7E72(A7)          ; $264254
        MOVEQ   #$73,D7                         ; $26425A
        MOVE.W  $78(A5,D7.L),$7F7B(A7)          ; $26425C
        DC.W    $7F7D,$7F7F         ; $264262 MOVE.W  <EA:3D>,$7F7F(A7)
        MOVE.W  D0,-$80(A7,D7.L)                ; $264266
        MOVE.W  D0,$7F(A7,D7.L)                 ; $26426A
        MOVEQ   #$7D,D7                         ; $26426E
        MOVEQ   #$7A,D7                         ; $264270
        MOVEQ   #$77,D7                         ; $264272
        MOVEQ   #$74,D7                         ; $264274
        MOVE.W  $6E(A1,D7.L),$7D6D(A6)          ; $264276
        MOVE.W  $7D6D(A4),$7D6E(A6)             ; $26427C
        MOVEQ   #$6E,D7                         ; $264282
        MOVEQ   #$6F,D7                         ; $264284
        MOVE.W  $72(A1,D7.L),$7F74(A7)          ; $264286
        OR.W   $79(A7,A0.W),D0                  ; $26428C
        OR.W   #$807F,D0                        ; $264290
        OR.L   D1,D0                            ; $264294
        OR.L   D2,D0                            ; $264296
        OR.L   D0,D4                            ; $264298
        OR.L   D0,D4                            ; $26429A
        OR.L   D5,D1                            ; $26429C
        OR.L   D5,D1                            ; $26429E
        OR.L   D5,D1                            ; $2642A0
        OR.L   D4,D1                            ; $2642A2
        OR.L   D4,D1                            ; $2642A4
        OR.L   D4,D1                            ; $2642A6
        OR.L   D0,D4                            ; $2642A8
        OR.L   D0,D5                            ; $2642AA
        OR.L   D0,D6                            ; $2642AC
        OR.L   D0,D6                            ; $2642AE
        OR.L   D6,D0                            ; $2642B0
        OR.L   D7,D0                            ; $2642B2
        OR.L   A0,D0                            ; $2642B4
        OR.L   A0,D0                            ; $2642B6
        MOVE.W  A1,-$76(A7,D7.L)                ; $2642B8
        MOVE.W  A2,-$77(A7,D7.L)                ; $2642BC
        MOVE.W  A0,-$7A(A7,D7.L)                ; $2642C0
        MOVEQ   #-$7C,D7                        ; $2642C4
        MOVEQ   #-$7F,D7                        ; $2642C6
        MOVEQ   #$7F,D7                         ; $2642C8
        MOVEQ   #$7E,D7                         ; $2642CA
        MOVEQ   #$7C,D7                         ; $2642CC
        MOVEQ   #$7B,D7                         ; $2642CE
        MOVEQ   #$7A,D7                         ; $2642D0
        MOVEQ   #$79,D7                         ; $2642D2
        MOVEQ   #$78,D7                         ; $2642D4
        MOVEQ   #$77,D7                         ; $2642D6
        MOVEQ   #$77,D7                         ; $2642D8
        MOVEQ   #$78,D7                         ; $2642DA
        MOVEQ   #$79,D7                         ; $2642DC
        MOVE.W  $7D(PC,D7.L),$7F7F(A7)          ; $2642DE
        DC.W    $7F7F,$7F7F         ; $2642E4 MOVE.W  <EA:3F>,$7F7F(A7)
        DC.W    $7F7E,$7F7D         ; $2642E8 MOVE.W  <EA:3E>,$7F7D(A7)
        MOVE.W  $7B(PC,A0.W),-$7F85(A7)         ; $2642EC
        MOVE.W  $7C(PC,A0.W),-$7F84(A7)         ; $2642F2
        DC.W    $807D               ; $2642F8 OR.W   <EA:3D>,D0
        DC.W    $807E               ; $2642FA OR.W   <EA:3E>,D0
        DC.W    $807F               ; $2642FC OR.W   <EA:3F>,D0
        DC.W    $807F               ; $2642FE OR.W   <EA:3F>,D0
        DC.W    $807F               ; $264300 OR.W   <EA:3F>,D0
        DC.W    $807E               ; $264302 OR.W   <EA:3E>,D0
        DC.W    $807F               ; $264304 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $264306 OR.W   <EA:3F>,D0
        OR.L   D0,D0                            ; $264308
        OR.L   D0,D0                            ; $26430A
        OR.L   D0,D0                            ; $26430C
        OR.L   D0,D0                            ; $26430E
        OR.L   D1,D0                            ; $264310
        OR.L   D1,D0                            ; $264312
        OR.L   D2,D0                            ; $264314
        OR.L   D3,D0                            ; $264316
        OR.L   D4,D0                            ; $264318
        OR.L   D5,D0                            ; $26431A
        OR.L   D7,D0                            ; $26431C
        OR.L   D7,D0                            ; $26431E
        MOVE.W  D7,-$79(A7,D7.L)                ; $264320
        MOVEQ   #-$7B,D7                        ; $264324
        MOVEQ   #-$7E,D7                        ; $264326
        MOVEQ   #-$80,D7                        ; $264328
        MOVEQ   #$7D,D7                         ; $26432A
        MOVEQ   #$7B,D7                         ; $26432C
        MOVE.W  $7D77.W,$7D76(A6)               ; $26432E
        MOVE.W  $76(A6,D7.L),$7E77(A6)          ; $264334
        MOVEQ   #$78,D7                         ; $26433A
        MOVEQ   #$79,D7                         ; $26433C
        MOVEQ   #$79,D7                         ; $26433E
        MOVEQ   #$79,D7                         ; $264340
        MOVEQ   #$79,D7                         ; $264342
        MOVEQ   #$78,D7                         ; $264344
        MOVEQ   #$76,D7                         ; $264346
        MOVEQ   #$75,D7                         ; $264348
        MOVE.W  $72(A3,D7.L),$7F71(A7)          ; $26434A
        MOVE.W  $71(A0,D7.L),-$7F8E(A7)         ; $264350
        OR.W   $76(A4,A0.W),D0                  ; $264356
        OR.W   $807A807B,D0                     ; $26435A
        OR.W   D0,#$817D                        ; $264360
        DC.W    $817D               ; $264364 OR.W   D0,<EA:3D>
        DC.W    $817E               ; $264366 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $264368 OR.W   D0,<EA:3E>
        DC.W    $817D               ; $26436A OR.W   D0,<EA:3D>
        DC.W    $807D               ; $26436C OR.W   <EA:3D>,D0
        DC.W    $807D               ; $26436E OR.W   <EA:3D>,D0
        DC.W    $807D               ; $264370 OR.W   <EA:3D>,D0
        DC.W    $807E               ; $264372 OR.W   <EA:3E>,D0
        OR.L   D0,D0                            ; $264374
        OR.L   D2,D0                            ; $264376
        OR.L   D3,D0                            ; $264378
        OR.L   D5,D0                            ; $26437A
        OR.L   D6,D0                            ; $26437C
        OR.L   D6,D0                            ; $26437E
        OR.L   D5,D0                            ; $264380
        MOVE.W  D3,-$7F(A7,D7.L)                ; $264382
        MOVEQ   #$7F,D7                         ; $264386
        MOVEQ   #$7C,D7                         ; $264388
        DC.W    $7D79,$7D76,$7D75,$7D73; $26438A MOVE.W  $7D767D75,$7D73(A6)
        MOVE.W  $73(A3,D7.L),$7E73(A6)          ; $264392
        MOVEQ   #$75,D7                         ; $264398
        MOVEQ   #$76,D7                         ; $26439A
        MOVEQ   #$78,D7                         ; $26439C
        MOVEQ   #$7A,D7                         ; $26439E
        MOVEQ   #$7C,D7                         ; $2643A0
        DC.W    $7F7D,$7F7F         ; $2643A2 MOVE.W  <EA:3D>,$7F7F(A7)
        MOVE.W  D0,-$7F(A7,D7.L)                ; $2643A6
        MOVE.W  D3,-$7C(A7,D7.L)                ; $2643AA
        MOVE.W  D5,-$79(A7,A0.W)                ; $2643AE
        OR.L   A0,D0                            ; $2643B2
        OR.L   A2,D0                            ; $2643B4
        OR.L   D0,A3                            ; $2643B6
        OR.L   D0,A3                            ; $2643B8
        OR.L   D0,A3                            ; $2643BA
        OR.L   D0,A3                            ; $2643BC
        OR.L   D0,A2                            ; $2643BE
        OR.L   D0,A0                            ; $2643C0
        OR.L   D0,D6                            ; $2643C2
        OR.L   D0,D4                            ; $2643C4
        OR.L   D0,D2                            ; $2643C6
        OR.L   D0,D1                            ; $2643C8
        OR.L   D0,D0                            ; $2643CA
        OR.L   D0,D0                            ; $2643CC
        OR.L   D0,D1                            ; $2643CE
        OR.L   D0,D3                            ; $2643D0
        OR.L   D0,D5                            ; $2643D2
        OR.L   D6,D0                            ; $2643D4
        OR.L   D7,D0                            ; $2643D6
        MOVE.W  A0,-$78(A7,D7.L)                ; $2643D8
        MOVEQ   #-$78,D7                        ; $2643DC
        MOVEQ   #-$79,D7                        ; $2643DE
        MOVEQ   #-$7A,D7                        ; $2643E0
        MOVEQ   #-$7C,D7                        ; $2643E2
        MOVEQ   #-$7E,D7                        ; $2643E4
        DC.W    $7D7F,$7D7C         ; $2643E6 MOVE.W  <EA:3F>,$7D7C(A6)
        MOVEQ   #$79,D6                         ; $2643EA
        MOVEQ   #$76,D6                         ; $2643EC
        MOVE.W  $72(A4,D7.L),$7D71(A6)          ; $2643EE
        MOVEQ   #$71,D7                         ; $2643F4
        MOVEQ   #$71,D7                         ; $2643F6
        MOVEQ   #$71,D7                         ; $2643F8
        MOVEQ   #$72,D7                         ; $2643FA
        MOVEQ   #$73,D7                         ; $2643FC
        MOVE.W  $75(A4,D7.L),$7F77(A7)          ; $2643FE
        DC.W    $7F79,$7F7B,$7F7D,$7F7E; $264404 MOVE.W  $7F7B7F7D,$7F7E(A7)
        DC.W    $7F7E,$7E7E         ; $26440C MOVE.W  <EA:3E>,$7E7E(A7)
        DC.W    $7F7E,$7F7E         ; $264410 MOVE.W  <EA:3E>,$7F7E(A7)
        DC.W    $7F7F,$807F         ; $264414 MOVE.W  <EA:3F>,-$7F81(A7)
        DC.W    $807F               ; $264418 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26441A OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26441C OR.W   <EA:3F>,D0
        DC.W    $807E               ; $26441E OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264420 OR.W   <EA:3E>,D0
        DC.W    $817D               ; $264422 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264424 OR.W   D0,<EA:3D>
        DC.W    $817E               ; $264426 OR.W   D0,<EA:3E>
        DC.W    $827F               ; $264428 OR.W   <EA:3F>,D1
        OR.L   D0,D1                            ; $26442A
        OR.L   D1,D1                            ; $26442C
        OR.L   D2,D1                            ; $26442E
        OR.L   D3,D1                            ; $264430
        OR.L   D4,D1                            ; $264432
        OR.L   D4,D1                            ; $264434
        OR.L   D0,D4                            ; $264436
        OR.L   D3,D0                            ; $264438
        OR.L   D1,D0                            ; $26443A
        MOVE.W  D0,$7E(A7,D7.L)                 ; $26443C
        MOVEQ   #$7C,D7                         ; $264440
        MOVEQ   #$7A,D7                         ; $264442
        MOVEQ   #$78,D7                         ; $264444
        MOVE.W  $74(A6,D7.L),$7D73(A6)          ; $264446
        MOVE.W  $71(A1,D7.L),$7E71(A6)          ; $26444C
        MOVEQ   #$72,D7                         ; $264452
        MOVEQ   #$74,D7                         ; $264454
        MOVEQ   #$76,D7                         ; $264456
        MOVEQ   #$77,D7                         ; $264458
        MOVEQ   #$79,D7                         ; $26445A
        MOVEQ   #$7A,D7                         ; $26445C
        MOVE.W  $7F7A(PC),$7F7A(A7)             ; $26445E
        DC.W    $7F79,$7F79,$7F78,$7F78; $264464 MOVE.W  $7F797F78,$7F78(A7)
        MOVE.W  $77(A7,D7.L),$7F78(A7)          ; $26446C
        DC.W    $7F79,$7F7A,$7F7C,$807D; $264472 MOVE.W  $7F7A7F7C,-$7F83(A7)
        DC.W    $807E               ; $26447A OR.W   <EA:3E>,D0
        OR.L   D0,D0                            ; $26447C
        OR.L   D1,D0                            ; $26447E
        OR.L   D0,D3                            ; $264480
        OR.L   D0,D4                            ; $264482
        OR.L   D0,D5                            ; $264484
        OR.L   D0,D6                            ; $264486
        OR.L   D0,D7                            ; $264488
        OR.L   D0,A1                            ; $26448A
        OR.L   D0,A2                            ; $26448C
        OR.L   D0,A2                            ; $26448E
        OR.L   D0,A2                            ; $264490
        OR.L   D0,A2                            ; $264492
        OR.L   D0,A1                            ; $264494
        OR.L   A0,D0                            ; $264496
        OR.L   D6,D0                            ; $264498
        OR.L   D4,D0                            ; $26449A
        MOVE.W  D2,-$80(A7,D7.L)                ; $26449C
        MOVEQ   #$7D,D7                         ; $2644A0
        MOVEQ   #$7B,D7                         ; $2644A2
        MOVEQ   #$7A,D7                         ; $2644A4
        MOVEQ   #$7A,D7                         ; $2644A6
        MOVEQ   #$7A,D7                         ; $2644A8
        MOVEQ   #$7B,D7                         ; $2644AA
        MOVEQ   #$7C,D7                         ; $2644AC
        MOVEQ   #$7D,D7                         ; $2644AE
        MOVEQ   #$7E,D7                         ; $2644B0
        MOVEQ   #-$80,D7                        ; $2644B2
        MOVEQ   #-$7F,D7                        ; $2644B4
        MOVEQ   #-$7E,D7                        ; $2644B6
        MOVEQ   #-$7E,D7                        ; $2644B8
        MOVEQ   #-$7E,D7                        ; $2644BA
        MOVE.W  D1,$7F(A7,D7.L)                 ; $2644BC
        DC.W    $7F7E,$7F7D         ; $2644C0 MOVE.W  <EA:3E>,$7F7D(A7)
        MOVEQ   #$7B,D7                         ; $2644C4
        MOVEQ   #$7A,D7                         ; $2644C6
        MOVEQ   #$79,D7                         ; $2644C8
        DC.W    $7D79,$7D79,$7E7A,$7E7B; $2644CA MOVE.W  $7D797E7A,$7E7B(A6)
        DC.W    $7F7D,$7F7E         ; $2644D2 MOVE.W  <EA:3D>,$7F7E(A7)
        DC.W    $7F7E,$807E         ; $2644D6 MOVE.W  <EA:3E>,-$7F82(A7)
        DC.W    $807E               ; $2644DA OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2644DC OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2644DE OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2644E0 OR.W   <EA:3E>,D0
        DC.W    $817F               ; $2644E2 OR.W   D0,<EA:3F>
        OR.L   D0,D0                            ; $2644E4
        OR.L   D1,D1                            ; $2644E6
        OR.L   D2,D1                            ; $2644E8
        OR.L   D3,D1                            ; $2644EA
        OR.L   D3,D1                            ; $2644EC
        OR.L   D0,D3                            ; $2644EE
        OR.L   D0,D3                            ; $2644F0
        OR.L   D0,D3                            ; $2644F2
        OR.L   D0,D2                            ; $2644F4
        OR.L   D0,D1                            ; $2644F6
        OR.L   D0,D0                            ; $2644F8
        DC.W    $807E               ; $2644FA OR.W   <EA:3E>,D0
        MOVE.W  $79(PC,D7.L),$7E76(A7)          ; $2644FC
        MOVE.W  $71(A3,D7.L),$7D6F(A6)          ; $264502
        MOVE.W  $7D6C(A5),$7D6B(A6)             ; $264508
        MOVE.W  $7E6B(A3),$7E6C(A6)             ; $26450E
        MOVEQ   #$6E,D7                         ; $264514
        MOVEQ   #$70,D7                         ; $264516
        MOVEQ   #$71,D7                         ; $264518
        MOVEQ   #$73,D7                         ; $26451A
        MOVE.W  $75(A4,D7.L),$7F76(A7)          ; $26451C
        MOVE.W  $79(A7,D7.L),$7F7B(A7)          ; $264522
        DC.W    $7F7D,$7F80         ; $264528 MOVE.W  <EA:3D>,$7F80(A7)
        OR.L   D2,D0                            ; $26452C
        OR.L   D5,D0                            ; $26452E
        OR.L   D7,D0                            ; $264530
        MOVE.W  A2,-$74(A7,D7.L)                ; $264532
        MOVE.W  A5,-$73(A7,A0.W)                ; $264536
        MOVE.W  A4,-$75(A7,D7.L)                ; $26453A
        OR.L   A2,D0                            ; $26453E
        OR.L   A2,D0                            ; $264540
        OR.L   D0,A2                            ; $264542
        OR.L   D0,A2                            ; $264544
        OR.L   D0,A3                            ; $264546
        OR.L   A4,D1                            ; $264548
        OR.L   A5,D1                            ; $26454A
        OR.L   A6,D1                            ; $26454C
        OR.L   A6,D1                            ; $26454E
        OR.L   A5,D1                            ; $264550
        OR.L   A3,D1                            ; $264552
        OR.L   D0,A0                            ; $264554
        OR.L   D0,D6                            ; $264556
        OR.L   D3,D0                            ; $264558
        OR.L   D1,D0                            ; $26455A
        DC.W    $7F7E,$7F7C         ; $26455C MOVE.W  <EA:3E>,$7F7C(A7)
        MOVEQ   #$7A,D7                         ; $264560
        MOVEQ   #$78,D7                         ; $264562
        MOVEQ   #$77,D7                         ; $264564
        MOVEQ   #$75,D7                         ; $264566
        MOVEQ   #$75,D7                         ; $264568
        MOVEQ   #$75,D7                         ; $26456A
        MOVEQ   #$76,D7                         ; $26456C
        MOVEQ   #$77,D7                         ; $26456E
        MOVEQ   #$79,D7                         ; $264570
        MOVE.W  $7C(PC,D7.L),$7F7C(A7)          ; $264572
        MOVE.W  $7A(PC,D7.L),$7F79(A7)          ; $264578
        DC.W    $7F79,$7F79,$7F79,$7E7A; $26457E MOVE.W  $7F797F79,$7E7A(A7)
        MOVEQ   #$7B,D7                         ; $264586
        MOVEQ   #$7B,D7                         ; $264588
        MOVEQ   #$7C,D7                         ; $26458A
        MOVEQ   #$7C,D7                         ; $26458C
        MOVEQ   #$7C,D7                         ; $26458E
        MOVEQ   #$7C,D7                         ; $264590
        MOVEQ   #$7B,D7                         ; $264592
        MOVEQ   #$7A,D7                         ; $264594
        DC.W    $7F79,$7F79,$7F79,$7F79; $264596 MOVE.W  $7F797F79,$7F79(A7)
        OR.W   $7D(PC,A0.W),D0                  ; $26459E
        DC.W    $817F               ; $2645A2 OR.W   D0,<EA:3F>
        OR.L   D0,D2                            ; $2645A4
        OR.L   D5,D1                            ; $2645A6
        OR.L   D7,D1                            ; $2645A8
        OR.L   A1,D1                            ; $2645AA
        OR.L   A1,D1                            ; $2645AC
        OR.L   A0,D1                            ; $2645AE
        OR.L   D0,D6                            ; $2645B0
        OR.L   D0,D4                            ; $2645B2
        OR.L   D1,D0                            ; $2645B4
        DC.W    $807F               ; $2645B6 OR.W   <EA:3F>,D0
        MOVE.W  #$7F7B,$7F79(A7)                ; $2645B8
        MOVE.W  $7F77.W,$7E76(A7)               ; $2645BE
        MOVEQ   #$75,D7                         ; $2645C4
        MOVEQ   #$75,D7                         ; $2645C6
        MOVEQ   #$75,D7                         ; $2645C8
        MOVEQ   #$75,D7                         ; $2645CA
        MOVEQ   #$76,D7                         ; $2645CC
        MOVE.W  $78(A7,D7.L),$7F78(A7)          ; $2645CE
        DC.W    $7F79,$7F79,$7F79,$7F78; $2645D4 MOVE.W  $7F797F79,$7F78(A7)
        MOVE.W  $7F78.W,$7F77(A7)               ; $2645DC
        MOVE.W  $76(A7,D7.L),$7E76(A7)          ; $2645E2
        MOVEQ   #$76,D7                         ; $2645E8
        MOVEQ   #$76,D7                         ; $2645EA
        MOVE.W  $77(A6,D7.L),$7E78(A6)          ; $2645EC
        MOVEQ   #$79,D7                         ; $2645F2
        MOVEQ   #$7A,D7                         ; $2645F4
        MOVEQ   #$7B,D7                         ; $2645F6
        DC.W    $7F7D,$7F7F         ; $2645F8 MOVE.W  <EA:3D>,$7F7F(A7)
        OR.L   D2,D0                            ; $2645FC
        OR.L   D5,D0                            ; $2645FE
        OR.L   D0,A0                            ; $264600
        OR.L   D0,A2                            ; $264602
        OR.L   A4,D1                            ; $264604
        OR.L   A5,D1                            ; $264606
        OR.L   A5,D1                            ; $264608
        OR.L   A3,D1                            ; $26460A
        OR.L   A1,D1                            ; $26460C
        OR.L   D7,D1                            ; $26460E
        OR.L   D0,D4                            ; $264610
        OR.L   D0,D2                            ; $264612
        OR.L   D0,D0                            ; $264614
        DC.W    $807E               ; $264616 OR.W   <EA:3E>,D0
        DC.W    $807D               ; $264618 OR.W   <EA:3D>,D0
        MOVE.W  $7A(PC,D7.L),$7E7A(A7)          ; $26461A
        MOVEQ   #$7B,D7                         ; $264620
        MOVEQ   #$7C,D7                         ; $264622
        MOVEQ   #$7D,D7                         ; $264624
        MOVEQ   #$7E,D7                         ; $264626
        MOVEQ   #-$80,D7                        ; $264628
        MOVEQ   #-$7F,D7                        ; $26462A
        MOVEQ   #-$7E,D7                        ; $26462C
        MOVE.W  D4,-$7C(A7,D7.L)                ; $26462E
        MOVE.W  D5,-$7B(A7,A0.W)                ; $264632
        OR.L   D5,D0                            ; $264636
        OR.L   D4,D0                            ; $264638
        MOVE.W  D2,-$7E(A7,D7.L)                ; $26463A
        MOVEQ   #-$7F,D7                        ; $26463E
        MOVEQ   #-$7E,D7                        ; $264640
        MOVEQ   #-$7E,D7                        ; $264642
        MOVEQ   #-$7D,D7                        ; $264644
        MOVE.W  D4,-$7C(A7,D7.L)                ; $264646
        MOVE.W  D4,-$7D(A7,D7.L)                ; $26464A
        MOVEQ   #-$7E,D7                        ; $26464E
        MOVEQ   #-$80,D7                        ; $264650
        MOVEQ   #$7F,D7                         ; $264652
        MOVEQ   #$7F,D7                         ; $264654
        DC.W    $7F7E,$7F7F         ; $264656 MOVE.W  <EA:3E>,$7F7F(A7)
        MOVE.W  D0,-$7E(A7,D7.L)                ; $26465A
        OR.L   D3,D0                            ; $26465E
        OR.L   D5,D0                            ; $264660
        OR.L   D0,D6                            ; $264662
        OR.L   D0,D6                            ; $264664
        OR.L   D0,D5                            ; $264666
        OR.L   D4,D1                            ; $264668
        OR.L   D2,D1                            ; $26466A
        OR.L   D0,D1                            ; $26466C
        DC.W    $827E               ; $26466E OR.W   <EA:3E>,D1
        OR.W   D0,#$817A                        ; $264670
        OR.W   D0,$8077.W                       ; $264674
        OR.W   $76(A6,A0.W),D0                  ; $264678
        MOVE.W  $76(A6,D7.L),$7F77(A7)          ; $26467C
        MOVEQ   #$77,D7                         ; $264682
        MOVEQ   #$77,D7                         ; $264684
        MOVEQ   #$76,D7                         ; $264686
        MOVE.W  $74(A5,D7.L),$7D74(A6)          ; $264688
        MOVE.W  $74(A3,D7.L),$7E74(A6)          ; $26468E
        MOVEQ   #$74,D7                         ; $264694
        MOVEQ   #$74,D7                         ; $264696
        MOVEQ   #$75,D7                         ; $264698
        MOVE.W  $79(A7,D7.L),$7F7B(A7)          ; $26469A
        MOVE.W  #$7F7D,$7F7C(A7)                ; $2646A0
        MOVE.W  $78(PC,D7.L),$7E76(A7)          ; $2646A6
        MOVEQ   #$73,D7                         ; $2646AC
        MOVE.W  $70(A2,D7.L),$7D70(A6)          ; $2646AE
        MOVE.W  $73(A1,D7.L),$7E75(A6)          ; $2646B4
        MOVEQ   #$77,D7                         ; $2646BA
        MOVE.W  $7F7E(PC),$7F81(A7)             ; $2646BC
        OR.L   D3,D0                            ; $2646C2
        OR.L   D4,D0                            ; $2646C4
        OR.L   D0,D5                            ; $2646C6
        OR.L   D0,D5                            ; $2646C8
        OR.L   D5,D1                            ; $2646CA
        OR.L   D5,D1                            ; $2646CC
        OR.L   D4,D1                            ; $2646CE
        OR.L   D3,D1                            ; $2646D0
        OR.L   D2,D1                            ; $2646D2
        OR.L   D0,D2                            ; $2646D4
        OR.L   D0,D1                            ; $2646D6
        OR.L   D0,D0                            ; $2646D8
        DC.W    $817F               ; $2646DA OR.W   D0,<EA:3F>
        DC.W    $807E               ; $2646DC OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2646DE OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2646E0 OR.W   <EA:3E>,D0
        DC.W    $807E               ; $2646E2 OR.W   <EA:3E>,D0
        DC.W    $7F7F,$7F80         ; $2646E4 MOVE.W  <EA:3F>,$7F80(A7)
        MOVE.W  D1,-$7D(A7,D7.L)                ; $2646E8
        MOVEQ   #-$7C,D7                        ; $2646EC
        MOVE.W  D5,-$7B(A7,D7.L)                ; $2646EE
        MOVE.W  D5,-$7C(A7,D7.L)                ; $2646F2
        MOVE.W  D2,-$80(A7,D7.L)                ; $2646F6
        DC.W    $7F7D,$7F7B         ; $2646FA MOVE.W  <EA:3D>,$7F7B(A7)
        MOVE.W  $7F79(PC),$7E77(A7)             ; $2646FE
        MOVEQ   #$76,D7                         ; $264704
        MOVEQ   #$75,D7                         ; $264706
        MOVEQ   #$74,D7                         ; $264708
        MOVE.W  $76(A5,D7.L),$7D77(A6)          ; $26470A
        MOVEQ   #$7A,D7                         ; $264710
        MOVEQ   #$7D,D7                         ; $264712
        MOVEQ   #-$80,D7                        ; $264714
        MOVE.W  D3,-$7A(A7,D7.L)                ; $264716
        MOVE.W  A1,-$75(A7,A0.W)                ; $26471A
        OR.L   A4,D0                            ; $26471E
        OR.L   A4,D0                            ; $264720
        OR.L   A3,D0                            ; $264722
        OR.L   D0,A1                            ; $264724
        OR.L   D0,D7                            ; $264726
        OR.L   D0,D5                            ; $264728
        OR.L   D0,D3                            ; $26472A
        OR.L   D1,D0                            ; $26472C
        OR.L   D0,D0                            ; $26472E
        DC.W    $807F               ; $264730 OR.W   <EA:3F>,D0
        DC.W    $807E               ; $264732 OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264734 OR.W   <EA:3E>,D0
        DC.W    $807F               ; $264736 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $264738 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26473A OR.W   <EA:3F>,D0
        DC.W    $807E               ; $26473C OR.W   <EA:3E>,D0
        DC.W    $807D               ; $26473E OR.W   <EA:3D>,D0
        OR.W   #$807B,D0                        ; $264740
        OR.W   $7F7A(PC),D0                     ; $264744
        MOVE.W  $7F7A(PC),$7F79(A7)             ; $264748
        DC.W    $7F79,$7F78,$7F78,$7E78; $26474E MOVE.W  $7F787F78,$7E78(A7)
        MOVE.W  $7F78.W,$7F78(A7)               ; $264756
        MOVE.W  $7F78.W,$7F79(A7)               ; $26475C
        MOVE.W  $7F78.W,$7F78(A7)               ; $264762
        MOVE.W  $77(A7,D7.L),$7E78(A7)          ; $264768
        MOVEQ   #$78,D7                         ; $26476E
        MOVEQ   #$7A,D7                         ; $264770
        MOVEQ   #$7B,D7                         ; $264772
        MOVEQ   #$7D,D7                         ; $264774
        DC.W    $7F7F,$7F81         ; $264776 MOVE.W  <EA:3F>,$7F81(A7)
        MOVE.W  D3,-$7B(A7,D7.L)                ; $26477A
        OR.L   D5,D0                            ; $26477E
        OR.L   D4,D0                            ; $264780
        OR.L   D3,D0                            ; $264782
        OR.L   D1,D0                            ; $264784
        DC.W    $807E               ; $264786 OR.W   <EA:3E>,D0
        MOVE.W  $79(PC,D7.L),$7F78(A7)          ; $264788
        MOVE.W  $7F78.W,$7F79(A7)               ; $26478E
        OR.W   $7C(PC,A0.W),D0                  ; $264794
        DC.W    $807D               ; $264798 OR.W   <EA:3D>,D0
        DC.W    $807E               ; $26479A OR.W   <EA:3E>,D0
        DC.W    $807F               ; $26479C OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26479E OR.W   <EA:3F>,D0
        DC.W    $7F7F,$7F7F         ; $2647A0 MOVE.W  <EA:3F>,$7F7F(A7)
        DC.W    $7F7F,$807F         ; $2647A4 MOVE.W  <EA:3F>,-$7F81(A7)
        OR.L   D0,D0                            ; $2647A8
        MOVE.W  D1,-$7F(A7,D7.L)                ; $2647AA
        MOVE.W  D0,$7F(A7,D7.L)                 ; $2647AE
        DC.W    $7F7E,$7E7C         ; $2647B2 MOVE.W  <EA:3E>,$7E7C(A7)
        MOVEQ   #$7B,D7                         ; $2647B6
        MOVEQ   #$7A,D7                         ; $2647B8
        MOVEQ   #$79,D7                         ; $2647BA
        MOVEQ   #$79,D7                         ; $2647BC
        DC.W    $7F79,$7F7A,$807C,$807E; $2647BE MOVE.W  $7F7A807C,-$7F82(A7)
        OR.L   D0,D0                            ; $2647C6
        OR.L   D1,D0                            ; $2647C8
        MOVE.W  D3,-$7B(A7,A0.W)                ; $2647CA
        OR.L   D7,D0                            ; $2647CE
        MOVE.W  A1,-$76(A7,D7.L)                ; $2647D0
        MOVE.W  A3,-$74(A7,D7.L)                ; $2647D4
        MOVE.W  A5,-$73(A7,D7.L)                ; $2647D8
        MOVE.W  A5,-$74(A7,A0.W)                ; $2647DC
        OR.L   A2,D0                            ; $2647E0
        OR.L   A0,D0                            ; $2647E2
        OR.L   D7,D0                            ; $2647E4
        OR.L   D5,D0                            ; $2647E6
        OR.L   D3,D0                            ; $2647E8
        OR.L   D2,D0                            ; $2647EA
        OR.L   D0,D0                            ; $2647EC
        DC.W    $807F               ; $2647EE OR.W   <EA:3F>,D0
        DC.W    $807D               ; $2647F0 OR.W   <EA:3D>,D0
        OR.W   D0,#$817B                        ; $2647F2
        OR.W   D0,-$7F87(PC)                    ; $2647F6
        OR.W   $8077.W,D0                       ; $2647FA
        OR.W   $76(A7,D7.L),D0                  ; $2647FE
        MOVE.W  $76(A6,D7.L),$7F76(A7)          ; $264802
        MOVE.W  $74(A5,D7.L),$7F74(A7)          ; $264808
        MOVE.W  $73(A3,D7.L),$7E72(A7)          ; $26480E
        MOVE.W  $70(A1,D7.L),$7D6E(A6)          ; $264814
        MOVE.W  $7C6C(A5),$7D6C(A6)             ; $26481A
        MOVE.W  $7E70(A5),$7F73(A6)             ; $264820
        OR.W   $7B(A7,A0.W),D0                  ; $264826
        OR.L   D0,D0                            ; $26482A
        OR.L   D4,D0                            ; $26482C
        OR.L   A0,D0                            ; $26482E
        OR.L   A3,D0                            ; $264830
        OR.L   A5,D0                            ; $264832
        OR.L   A5,D0                            ; $264834
        OR.L   A4,D0                            ; $264836
        OR.L   A3,D0                            ; $264838
        MOVE.W  A2,-$77(A7,D7.L)                ; $26483A
        MOVE.W  D7,-$7B(A7,D7.L)                ; $26483E
        MOVE.W  D4,-$7D(A7,D7.L)                ; $264842
        MOVE.W  D2,-$7E(A7,D7.L)                ; $264846
        MOVE.W  D1,$7F(A7,D7.L)                 ; $26484A
        DC.W    $7F7D,$807C         ; $26484E MOVE.W  <EA:3D>,-$7F84(A7)
        OR.W   -$7F87(PC),D0                    ; $264852
        OR.W   $8077.W,D0                       ; $264856
        OR.W   $8078.W,D0                       ; $26485A
        OR.W   D0,$8179.W                       ; $26485E
        OR.W   D0,-$7E86(PC)                    ; $264862
        OR.W   D0,-$7E87(PC)                    ; $264866
        OR.W   D0,$80788077                     ; $26486A
        OR.W   $74(A5,D7.L),D0                  ; $264870
        MOVE.W  $70(A2,D7.L),$7E6F(A7)          ; $264874
        MOVE.W  $7D6D(A5),$7D6D(A6)             ; $26487A
        MOVE.W  $7D6F(A6),$7E70(A6)             ; $264880
        MOVEQ   #$73,D7                         ; $264886
        MOVE.W  $7A(A6,D7.L),$7F7E(A7)          ; $264888
        OR.L   D2,D0                            ; $26488E
        MOVE.W  D5,-$78(A7,D7.L)                ; $264890
        MOVE.W  A3,-$74(A7,D7.L)                ; $264894
        MOVE.W  A4,-$75(A7,D7.L)                ; $264898
        MOVE.W  A2,-$78(A7,D7.L)                ; $26489C
        MOVE.W  D7,-$7B(A7,D7.L)                ; $2648A0
        MOVE.W  D5,-$7C(A7,D7.L)                ; $2648A4
        MOVE.W  D5,-$7A(A7,D7.L)                ; $2648A8
        MOVE.W  D7,-$78(A7,D7.L)                ; $2648AC
        OR.L   A0,D0                            ; $2648B0
        OR.L   A0,D0                            ; $2648B2
        OR.L   A1,D0                            ; $2648B4
        OR.L   A2,D0                            ; $2648B6
        OR.L   A4,D0                            ; $2648B8
        OR.L   A5,D0                            ; $2648BA
        OR.L   A5,D0                            ; $2648BC
        OR.L   D0,A6                            ; $2648BE
        OR.L   D0,A6                            ; $2648C0
        OR.L   D0,A6                            ; $2648C2
        OR.L   A5,D1                            ; $2648C4
        OR.L   A3,D1                            ; $2648C6
        OR.L   D0,A0                            ; $2648C8
        OR.L   D0,D5                            ; $2648CA
        OR.L   D0,D2                            ; $2648CC
        DC.W    $817F               ; $2648CE OR.W   D0,<EA:3F>
        DC.W    $807E               ; $2648D0 OR.W   <EA:3E>,D0
        OR.W   #$807A,D0                        ; $2648D2
        MOVE.W  $7F77.W,$7E76(A7)               ; $2648D6
        MOVEQ   #$76,D7                         ; $2648DC
        MOVEQ   #$76,D7                         ; $2648DE
        MOVEQ   #$76,D7                         ; $2648E0
        MOVEQ   #$77,D7                         ; $2648E2
        MOVEQ   #$79,D7                         ; $2648E4
        MOVEQ   #$7C,D7                         ; $2648E6
        DC.W    $7F7E,$8081         ; $2648E8 MOVE.W  <EA:3E>,-$7F7F(A7)
        OR.L   D3,D0                            ; $2648EC
        OR.L   D4,D0                            ; $2648EE
        OR.L   D5,D0                            ; $2648F0
        OR.L   D4,D0                            ; $2648F2
        OR.L   D3,D0                            ; $2648F4
        OR.L   D2,D0                            ; $2648F6
        MOVE.W  D1,-$7F(A7,D7.L)                ; $2648F8
        MOVE.W  D0,-$80(A7,D7.L)                ; $2648FC
        DC.W    $7F7F,$7F7E         ; $264900 MOVE.W  <EA:3F>,$7F7E(A7)
        DC.W    $7F7D,$7E7B         ; $264904 MOVE.W  <EA:3D>,$7E7B(A7)
        MOVEQ   #$79,D7                         ; $264908
        MOVEQ   #$77,D7                         ; $26490A
        MOVEQ   #$76,D7                         ; $26490C
        MOVEQ   #$74,D7                         ; $26490E
        MOVEQ   #$73,D7                         ; $264910
        MOVEQ   #$72,D7                         ; $264912
        MOVE.W  $70(A1,D7.L),$7F6F(A7)          ; $264914
        MOVE.W  $7F6F(A7),$7F6F(A7)             ; $26491A
        OR.W   -$7F92(A7),D0                    ; $264920
        OR.W   D0,-$7E93(A6)                    ; $264924
        OR.W   D0,-$7E94(A5)                    ; $264928
        OR.W   D0,-$7F93(A5)                    ; $26492C
        OR.W   -$7F92(A5),D0                    ; $264930
        OR.W   -$7F90(A7),D0                    ; $264934
        OR.W   $74(A2,A0.W),D0                  ; $264938
        OR.W   $78(A6,D7.L),D0                  ; $26493C
        MOVE.W  $7F7D(PC),$7F80(A7)             ; $264940
        MOVE.W  D3,-$7B(A7,A0.W)                ; $264946
        OR.L   D6,D0                            ; $26494A
        OR.L   D6,D0                            ; $26494C
        OR.L   D6,D0                            ; $26494E
        OR.L   D6,D0                            ; $264950
        OR.L   D6,D0                            ; $264952
        MOVE.W  D6,-$79(A7,D7.L)                ; $264954
        MOVE.W  D7,-$79(A7,D7.L)                ; $264958
        MOVE.W  A0,-$78(A7,D7.L)                ; $26495C
        MOVE.W  D7,-$79(A7,D7.L)                ; $264960
        MOVEQ   #-$79,D7                        ; $264964
        MOVEQ   #-$79,D7                        ; $264966
        MOVEQ   #-$78,D7                        ; $264968
        MOVEQ   #-$77,D7                        ; $26496A
        MOVE.W  A3,-$74(A7,D7.L)                ; $26496C
        MOVE.W  A4,-$74(A7,D7.L)                ; $264970
        MOVE.W  A3,-$77(A7,D7.L)                ; $264974
        MOVE.W  D6,-$7D(A7,D7.L)                ; $264978
        OR.L   D1,D0                            ; $26497C
        DC.W    $807E               ; $26497E OR.W   <EA:3E>,D0
        OR.W   $79(PC,A0.W),D0                  ; $264980
        OR.W   $74(A6,A0.W),D0                  ; $264984
        OR.W   D0,$70(A2,A0.W)                  ; $264988
        OR.W   $72(A0,A0.W),D0                  ; $26498C
        OR.W   $78(A4,A0.W),D0                  ; $264990
        OR.W   $7E(PC,A0.W),D0                  ; $264994
        OR.L   D0,D0                            ; $264998
        OR.L   D0,D1                            ; $26499A
        OR.L   D1,D0                            ; $26499C
        OR.L   D1,D0                            ; $26499E
        MOVE.W  D0,$7E(A7,D7.L)                 ; $2649A0
        MOVEQ   #$7C,D7                         ; $2649A4
        MOVEQ   #$7B,D7                         ; $2649A6
        MOVEQ   #$7B,D7                         ; $2649A8
        MOVEQ   #$7A,D7                         ; $2649AA
        MOVEQ   #$7B,D7                         ; $2649AC
        MOVEQ   #$7C,D7                         ; $2649AE
        DC.W    $7F7E,$7F80         ; $2649B0 MOVE.W  <EA:3E>,$7F80(A7)
        MOVE.W  D3,-$7B(A7,D7.L)                ; $2649B4
        MOVEQ   #-$79,D7                        ; $2649B8
        MOVEQ   #-$77,D7                        ; $2649BA
        MOVEQ   #-$77,D7                        ; $2649BC
        MOVEQ   #-$77,D7                        ; $2649BE
        MOVE.W  A1,-$77(A7,D7.L)                ; $2649C0
        MOVEQ   #-$78,D7                        ; $2649C4
        MOVEQ   #-$79,D7                        ; $2649C6
        MOVEQ   #-$7A,D7                        ; $2649C8
        MOVEQ   #-$7B,D7                        ; $2649CA
        MOVEQ   #-$7C,D7                        ; $2649CC
        MOVEQ   #-$7C,D7                        ; $2649CE
        MOVEQ   #-$7D,D7                        ; $2649D0
        MOVE.W  D4,-$7C(A7,D7.L)                ; $2649D2
        MOVE.W  D4,-$7D(A7,D7.L)                ; $2649D6
        MOVE.W  D2,-$80(A7,D7.L)                ; $2649DA
        DC.W    $7F7D,$7F7A         ; $2649DE MOVE.W  <EA:3D>,$7F7A(A7)
        MOVE.W  $73(A6,D7.L),$7F70(A7)          ; $2649E2
        OR.W   -$7F93(A6),D0                    ; $2649E8
        OR.W   -$7E91(A6),D0                    ; $2649EC
        OR.W   D0,$73(A1,A0.W)                  ; $2649F0
        OR.W   $76(A5,A0.W),D0                  ; $2649F4
        OR.W   $76(A7,A0.W),D0                  ; $2649F8
        OR.W   $74(A6,A0.W),D0                  ; $2649FC
        OR.W   $72(A3,D7.L),D0                  ; $264A00
        MOVE.W  $6F(A0,D7.L),$7E6E(A7)          ; $264A04
        MOVEQ   #$6E,D7                         ; $264A0A
        MOVE.W  $7F72(A7),-$7F8A(A7)            ; $264A0C
        OR.W   -$80(PC,A0.W),D0                 ; $264A12
        OR.L   D3,D0                            ; $264A16
        OR.L   D5,D0                            ; $264A18
        MOVE.W  D5,-$7C(A7,D7.L)                ; $264A1A
        MOVEQ   #-$7D,D7                        ; $264A1E
        MOVE.W  D1,$7F(A6,D7.L)                 ; $264A20
        DC.W    $7D7E,$7E7E         ; $264A24 MOVE.W  <EA:3E>,$7E7E(A6)
        MOVEQ   #$7E,D7                         ; $264A28
        DC.W    $7F7F,$7F81         ; $264A2A MOVE.W  <EA:3F>,$7F81(A7)
        MOVE.W  D3,-$7B(A7,D7.L)                ; $264A2E
        MOVE.W  D6,-$78(A7,D7.L)                ; $264A32
        MOVE.W  A0,-$78(A7,D7.L)                ; $264A36
        MOVE.W  D7,-$7B(A7,D7.L)                ; $264A3A
        MOVEQ   #-$7D,D7                        ; $264A3E
        MOVEQ   #-$7F,D7                        ; $264A40
        MOVE.W  D0,$7E(A7,D7.L)                 ; $264A42
        DC.W    $7F7D,$7F7C         ; $264A46 MOVE.W  <EA:3D>,$7F7C(A7)
        DC.W    $807D               ; $264A4A OR.W   <EA:3D>,D0
        DC.W    $807D               ; $264A4C OR.W   <EA:3D>,D0
        DC.W    $807E               ; $264A4E OR.W   <EA:3E>,D0
        DC.W    $807F               ; $264A50 OR.W   <EA:3F>,D0
        OR.L   D0,D0                            ; $264A52
        OR.L   D1,D0                            ; $264A54
        MOVE.W  D1,-$7F(A7,A0.W)                ; $264A56
        OR.L   D1,D0                            ; $264A5A
        OR.L   D1,D0                            ; $264A5C
        OR.L   D0,D0                            ; $264A5E
        OR.L   D1,D0                            ; $264A60
        OR.L   D1,D0                            ; $264A62
        OR.L   D3,D0                            ; $264A64
        OR.L   D4,D0                            ; $264A66
        OR.L   D6,D0                            ; $264A68
        OR.L   D7,D0                            ; $264A6A
        OR.L   A1,D0                            ; $264A6C
        OR.L   A2,D0                            ; $264A6E
        OR.L   D0,A2                            ; $264A70
        OR.L   D0,A1                            ; $264A72
        OR.L   D7,D0                            ; $264A74
        OR.L   D4,D0                            ; $264A76
        MOVE.W  D1,$7E(A7,D7.L)                 ; $264A78
        MOVEQ   #$7C,D7                         ; $264A7C
        MOVE.W  $7D79(PC),$7D78(A6)             ; $264A7E
        MOVE.W  $7D78.W,$7D79(A6)               ; $264A84
        DC.W    $7D79,$7E7A,$7E7C,$7F7E; $264A8A MOVE.W  $7E7A7E7C,$7F7E(A6)
        DC.W    $7F7E,$7F7E         ; $264A92 MOVE.W  <EA:3E>,$7F7E(A7)
        DC.W    $807E               ; $264A96 OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264A98 OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264A9A OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264A9C OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264A9E OR.W   <EA:3E>,D0
        DC.W    $817D               ; $264AA0 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264AA2 OR.W   D0,<EA:3D>
        DC.W    $817E               ; $264AA4 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $264AA6 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $264AA8 OR.W   D0,<EA:3E>
        DC.W    $807E               ; $264AAA OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264AAC OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264AAE OR.W   <EA:3E>,D0
        DC.W    $807E               ; $264AB0 OR.W   <EA:3E>,D0
        DC.W    $807D               ; $264AB2 OR.W   <EA:3D>,D0
        OR.W   #$807C,D0                        ; $264AB4
        OR.W   $7B(PC,A0.W),D0                  ; $264AB8
        OR.W   $7A(PC,A0.W),D0                  ; $264ABC
        OR.W   -$7F85(PC),D0                    ; $264AC0
        MOVE.W  #$7F7E,$7F7F(A7)                ; $264AC4
        DC.W    $7F7F,$7F80         ; $264ACA MOVE.W  <EA:3F>,$7F80(A7)
        DC.W    $7F7F,$7F7D         ; $264ACE MOVE.W  <EA:3F>,$7F7D(A7)
        MOVEQ   #$7B,D7                         ; $264AD2
        MOVEQ   #$79,D7                         ; $264AD4
        MOVEQ   #$77,D7                         ; $264AD6
        MOVEQ   #$75,D7                         ; $264AD8
        MOVEQ   #$73,D7                         ; $264ADA
        MOVEQ   #$71,D7                         ; $264ADC
        MOVE.W  $71(A0,D7.L),$7D71(A6)          ; $264ADE
        MOVE.W  $74(A3,D7.L),$7D76(A6)          ; $264AE4
        MOVE.W  $77(A7,D7.L),$7E76(A6)          ; $264AEA
        MOVEQ   #$75,D7                         ; $264AF0
        MOVE.W  $73(A4,D7.L),$7F72(A7)          ; $264AF2
        MOVE.W  $74(A3,A0.W),-$7F8A(A7)         ; $264AF8
        OR.W   D0,$817B827D                     ; $264AFE
        DC.W    $827E               ; $264B04 OR.W   <EA:3E>,D1
        DC.W    $817E               ; $264B06 OR.W   D0,<EA:3E>
        DC.W    $817D               ; $264B08 OR.W   D0,<EA:3D>
        OR.W   D0,#$817A                        ; $264B0A
        OR.W   D0,$75(A7,A0.W)                  ; $264B0E
        OR.W   $71(A2,A0.W),D0                  ; $264B12
        OR.W   $72(A1,A0.W),D0                  ; $264B16
        MOVE.W  $78(A4,D7.L),$7F7C(A7)          ; $264B1A
        DC.W    $7F7F,$8082         ; $264B20 MOVE.W  <EA:3F>,-$7F7E(A7)
        OR.L   D4,D0                            ; $264B24
        OR.L   D5,D0                            ; $264B26
        OR.L   D6,D0                            ; $264B28
        OR.L   D6,D0                            ; $264B2A
        OR.L   D6,D0                            ; $264B2C
        OR.L   D6,D0                            ; $264B2E
        MOVE.W  D7,-$79(A7,D7.L)                ; $264B30
        MOVEQ   #-$78,D7                        ; $264B34
        MOVEQ   #-$77,D7                        ; $264B36
        MOVEQ   #-$76,D7                        ; $264B38
        MOVEQ   #-$75,D7                        ; $264B3A
        MOVEQ   #-$74,D7                        ; $264B3C
        MOVEQ   #-$74,D7                        ; $264B3E
        MOVE.W  A4,-$74(A6,D7.L)                ; $264B40
        MOVE.W  A4,-$75(A6,D7.L)                ; $264B44
        MOVE.W  A3,-$76(A6,D7.L)                ; $264B48
        MOVE.W  A1,-$78(A6,D7.L)                ; $264B4C
        MOVE.W  D7,-$79(A6,D7.L)                ; $264B50
        MOVE.W  D7,-$78(A6,D7.L)                ; $264B54
        MOVEQ   #-$78,D7                        ; $264B58
        MOVE.W  A1,-$77(A7,D7.L)                ; $264B5A
        OR.L   A1,D0                            ; $264B5E
        OR.L   A0,D0                            ; $264B60
        OR.L   D0,D7                            ; $264B62
        OR.L   D0,D5                            ; $264B64
        OR.L   D0,D3                            ; $264B66
        OR.L   D0,D0                            ; $264B68
        DC.W    $817D               ; $264B6A OR.W   D0,<EA:3D>
        OR.W   D0,$79(PC,A0.W)                  ; $264B6C
        OR.W   D0,$81798179                     ; $264B70
        OR.W   D0,$7D(PC,A0.W)                  ; $264B76
        DC.W    $817F               ; $264B7A OR.W   D0,<EA:3F>
        OR.L   D0,D1                            ; $264B7C
        OR.L   D0,D4                            ; $264B7E
        OR.L   D0,D6                            ; $264B80
        OR.L   D0,A0                            ; $264B82
        OR.L   A0,D0                            ; $264B84
        OR.L   A0,D0                            ; $264B86
        OR.L   D6,D0                            ; $264B88
        MOVE.W  D5,-$7C(A7,D7.L)                ; $264B8A
        MOVE.W  D2,-$7F(A7,D7.L)                ; $264B8E
        DC.W    $7F7F,$7E7D         ; $264B92 MOVE.W  <EA:3F>,$7E7D(A7)
        MOVEQ   #$7A,D7                         ; $264B96
        MOVEQ   #$77,D7                         ; $264B98
        MOVE.W  $72(A4,D7.L),$7C6F(A6)          ; $264B9A
        MOVE.W  $7D6B(A5),$7D6A(A6)             ; $264BA0
        MOVE.W  $7D6A(A1),$7D6B(A6)             ; $264BA6
        MOVE.W  $7D6D(A4),$7D6F(A6)             ; $264BAC
        MOVEQ   #$72,D7                         ; $264BB2
        MOVEQ   #$75,D7                         ; $264BB4
        MOVE.W  $7F7B.W,-$7F84(A7)              ; $264BB6
        DC.W    $817D               ; $264BBC OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264BBE OR.W   D0,<EA:3D>
        OR.W   D0,#$817B                        ; $264BC0
        OR.W   D0,$81778175                     ; $264BC4
        OR.W   $72(A3,A0.W),D0                  ; $264BCA
        OR.W   D0,$71(A2,A0.W)                  ; $264BCE
        OR.W   D0,$73(A2,A0.W)                  ; $264BD2
        OR.W   D0,$78(A5,A0.W)                  ; $264BD6
        OR.W   D0,$7D(PC,A0.W)                  ; $264BDA
        DC.W    $817F               ; $264BDE OR.W   D0,<EA:3F>
        OR.L   D0,D1                            ; $264BE0
        OR.L   D2,D0                            ; $264BE2
        OR.L   D3,D0                            ; $264BE4
        OR.L   D3,D0                            ; $264BE6
        OR.L   D3,D0                            ; $264BE8
        OR.L   D2,D0                            ; $264BEA
        OR.L   D0,D0                            ; $264BEC
        DC.W    $7F7E,$7F7D         ; $264BEE MOVE.W  <EA:3E>,$7F7D(A7)
        MOVE.W  #$7F7B,$7E7B(A7)                ; $264BF2
        MOVEQ   #$7B,D7                         ; $264BF8
        MOVEQ   #$7A,D7                         ; $264BFA
        MOVEQ   #$7A,D7                         ; $264BFC
        MOVEQ   #$79,D7                         ; $264BFE
        MOVE.W  $7D77.W,$7D77(A6)               ; $264C00
        MOVEQ   #$77,D6                         ; $264C06
        MOVEQ   #$78,D6                         ; $264C08
        DC.W    $7D79,$7D7B,$7D7E,$7D81; $264C0A MOVE.W  $7D7B7D7E,$7D81(A6)
        MOVEQ   #-$7B,D7                        ; $264C12
        MOVEQ   #-$78,D7                        ; $264C14
        MOVEQ   #-$74,D7                        ; $264C16
        MOVE.W  A6,-$71(A7,D7.L)                ; $264C18
        MOVE.W  A7,-$71(A7,D7.L)                ; $264C1C
        MOVE.W  A6,-$73(A7,A0.W)                ; $264C20
        OR.L   A3,D0                            ; $264C24
        OR.L   A1,D0                            ; $264C26
        OR.L   D6,D0                            ; $264C28
        OR.L   D4,D0                            ; $264C2A
        OR.L   D1,D0                            ; $264C2C
        DC.W    $817F               ; $264C2E OR.W   D0,<EA:3F>
        DC.W    $817E               ; $264C30 OR.W   D0,<EA:3E>
        DC.W    $817D               ; $264C32 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264C34 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264C36 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264C38 OR.W   D0,<EA:3D>
        DC.W    $817E               ; $264C3A OR.W   D0,<EA:3E>
        OR.L   D0,D0                            ; $264C3C
        OR.L   D0,D1                            ; $264C3E
        OR.L   D0,D2                            ; $264C40
        OR.L   D0,D3                            ; $264C42
        OR.L   D0,D4                            ; $264C44
        OR.L   D0,D4                            ; $264C46
        OR.L   D0,D3                            ; $264C48
        OR.L   D0,D2                            ; $264C4A
        OR.L   D0,D2                            ; $264C4C
        OR.L   D1,D0                            ; $264C4E
        OR.L   D1,D0                            ; $264C50
        OR.L   D1,D0                            ; $264C52
        MOVE.W  D1,-$7F(A7,D7.L)                ; $264C54
        MOVEQ   #-$7F,D7                        ; $264C58
        MOVE.W  D0,$7F(A6,D7.L)                 ; $264C5A
        MOVEQ   #$7D,D6                         ; $264C5E
        MOVE.W  $7A(PC,D7.L),$7E79(A6)          ; $264C60
        MOVEQ   #$79,D7                         ; $264C66
        MOVEQ   #$79,D7                         ; $264C68
        MOVEQ   #$7A,D7                         ; $264C6A
        MOVEQ   #$7B,D7                         ; $264C6C
        MOVEQ   #$7C,D7                         ; $264C6E
        MOVEQ   #$7C,D7                         ; $264C70
        MOVEQ   #$7D,D7                         ; $264C72
        MOVEQ   #$7D,D7                         ; $264C74
        MOVEQ   #$7C,D7                         ; $264C76
        MOVEQ   #$7B,D7                         ; $264C78
        MOVE.W  $7F78(PC),$7F78(A7)             ; $264C7A
        MOVE.W  $7F79.W,-$7F86(A7)              ; $264C80
        OR.W   #$807D,D0                        ; $264C86
        DC.W    $807D               ; $264C8A OR.W   <EA:3D>,D0
        DC.W    $807D               ; $264C8C OR.W   <EA:3D>,D0
        OR.W   #$807B,D0                        ; $264C8E
        OR.W   -$7F87(PC),D0                    ; $264C92
        OR.W   $80788079,D0                     ; $264C96
        OR.W   $80798078,D0                     ; $264C9C
        OR.W   $76(A7,A0.W),D0                  ; $264CA2
        OR.W   $75(A5,A0.W),D0                  ; $264CA6
        OR.W   $76(A5,A0.W),D0                  ; $264CAA
        MOVE.W  $77(A6,D7.L),$7E76(A7)          ; $264CAE
        MOVEQ   #$75,D7                         ; $264CB4
        MOVEQ   #$74,D7                         ; $264CB6
        MOVEQ   #$73,D7                         ; $264CB8
        MOVEQ   #$72,D7                         ; $264CBA
        MOVEQ   #$72,D7                         ; $264CBC
        MOVEQ   #$72,D7                         ; $264CBE
        MOVEQ   #$74,D7                         ; $264CC0
        MOVEQ   #$76,D7                         ; $264CC2
        MOVE.W  $7F7B.W,$7F7E(A7)               ; $264CC4
        MOVE.W  D0,-$7F(A7,A0.W)                ; $264CCA
        OR.L   D2,D0                            ; $264CCE
        OR.L   D3,D0                            ; $264CD0
        MOVE.W  D3,-$7F(A7,D7.L)                ; $264CD2
        MOVE.W  D0,$7F(A7,D7.L)                 ; $264CD6
        DC.W    $7F7F,$7F80         ; $264CDA MOVE.W  <EA:3F>,$7F80(A7)
        OR.L   D2,D0                            ; $264CDE
        OR.L   D0,D5                            ; $264CE0
        OR.L   D0,D7                            ; $264CE2
        OR.L   D0,A1                            ; $264CE4
        OR.L   D0,A2                            ; $264CE6
        OR.L   D0,A4                            ; $264CE8
        OR.L   D0,A6                            ; $264CEA
        OR.L   D0,A7                            ; $264CEC
        OR.L   (A0),D0                          ; $264CEE
        OR.L   (A1),D0                          ; $264CF0
        MOVE.W  (A1),-$70(A7,D7.L)              ; $264CF2
        MOVE.W  A7,-$73(A7,D7.L)                ; $264CF6
        MOVE.W  A3,-$77(A7,D7.L)                ; $264CFA
        MOVE.W  A0,-$7A(A7,D7.L)                ; $264CFE
        MOVE.W  D6,-$7B(A7,D7.L)                ; $264D02
        MOVE.W  D4,-$7C(A7,A0.W)                ; $264D06
        MOVE.W  D2,-$80(A7,D7.L)                ; $264D0A
        DC.W    $7F7F,$7F7D         ; $264D0E MOVE.W  <EA:3F>,$7F7D(A7)
        MOVE.W  #$7F7B,$7F7B(A7)                ; $264D12
        MOVE.W  $7B(PC,D7.L),$7F7C(A7)          ; $264D18
        DC.W    $7F7D,$7F7E         ; $264D1E MOVE.W  <EA:3D>,$7F7E(A7)
        MOVE.W  D0,-$7E(A7,D7.L)                ; $264D22
        MOVE.W  D4,-$7B(A7,D7.L)                ; $264D26
        MOVE.W  D5,-$7C(A7,D7.L)                ; $264D2A
        MOVE.W  D2,$7E(A7,D7.L)                 ; $264D2E
        MOVEQ   #$7B,D7                         ; $264D32
        MOVE.W  $75(A7,D7.L),$7F74(A7)          ; $264D34
        MOVE.W  $75(A4,D7.L),-$7F89(A7)         ; $264D3A
        OR.W   $817A.W,D0                       ; $264D40
        OR.W   D0,-$7E86(PC)                    ; $264D44
        OR.W   D0,-$7E87(PC)                    ; $264D48
        OR.W   $76(A7,A0.W),D0                  ; $264D4C
        OR.W   $74(A5,A0.W),D0                  ; $264D50
        MOVE.W  $72(A3,D7.L),$7E71(A7)          ; $264D54
        MOVEQ   #$70,D7                         ; $264D5A
        MOVEQ   #$70,D7                         ; $264D5C
        MOVE.W  $70(A0,D7.L),$7F70(A7)          ; $264D5E
        MOVE.W  $70(A0,D7.L),$7F71(A7)          ; $264D64
        MOVE.W  $72(A2,D7.L),$7F72(A7)          ; $264D6A
        MOVE.W  $72(A1,D7.L),$7E73(A7)          ; $264D70
        MOVEQ   #$75,D7                         ; $264D76
        MOVE.W  $7F7C.W,$7F7F(A7)               ; $264D78
        MOVE.W  D1,-$7D(A7,D7.L)                ; $264D7E
        MOVE.W  D4,-$7C(A7,D7.L)                ; $264D82
        MOVE.W  D3,-$7D(A7,D7.L)                ; $264D86
        MOVE.W  D2,-$7F(A7,D7.L)                ; $264D8A
        MOVE.W  D0,$7E(A7,D7.L)                 ; $264D8E
        DC.W    $7F7D,$7F7C         ; $264D92 MOVE.W  <EA:3D>,$7F7C(A7)
        OR.W   #$807D,D0                        ; $264D96
        DC.W    $807F               ; $264D9A OR.W   <EA:3F>,D0
        OR.L   D0,D1                            ; $264D9C
        OR.L   D0,D3                            ; $264D9E
        OR.L   D0,D4                            ; $264DA0
        OR.L   D0,D5                            ; $264DA2
        OR.L   D0,D4                            ; $264DA4
        OR.L   D3,D0                            ; $264DA6
        OR.L   D3,D0                            ; $264DA8
        OR.L   D2,D0                            ; $264DAA
        OR.L   D1,D0                            ; $264DAC
        MOVE.W  D0,$7F(A7,D7.L)                 ; $264DAE
        MOVEQ   #$7F,D7                         ; $264DB2
        MOVEQ   #-$80,D7                        ; $264DB4
        MOVEQ   #-$80,D7                        ; $264DB6
        MOVEQ   #-$80,D7                        ; $264DB8
        MOVEQ   #-$80,D7                        ; $264DBA
        MOVEQ   #-$7F,D7                        ; $264DBC
        MOVEQ   #-$7E,D7                        ; $264DBE
        MOVEQ   #-$7D,D7                        ; $264DC0
        MOVEQ   #-$7D,D7                        ; $264DC2
        MOVEQ   #-$7E,D7                        ; $264DC4
        MOVEQ   #$7F,D7                         ; $264DC6
        MOVEQ   #$7C,D7                         ; $264DC8
        MOVEQ   #$79,D7                         ; $264DCA
        MOVEQ   #$77,D7                         ; $264DCC
        MOVEQ   #$77,D7                         ; $264DCE
        MOVE.W  $7F7C.W,-$7F80(A7)              ; $264DD0
        OR.L   D5,D0                            ; $264DD6
        OR.L   A1,D0                            ; $264DD8
        OR.L   D0,A5                            ; $264DDA
        OR.L   D0,A7                            ; $264DDC
        OR.L   D0,(A1)                          ; $264DDE
        OR.L   D0,(A1)                          ; $264DE0
        OR.L   (A0),D0                          ; $264DE2
        OR.L   A6,D0                            ; $264DE4
        OR.L   A3,D0                            ; $264DE6
        MOVE.W  A0,-$7A(A7,D7.L)                ; $264DE8
        MOVE.W  D3,-$7F(A7,D7.L)                ; $264DEC
        MOVE.W  D0,$7F(A7,A0.W)                 ; $264DF0
        DC.W    $817E               ; $264DF4 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $264DF6 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $264DF8 OR.W   D0,<EA:3E>
        DC.W    $817F               ; $264DFA OR.W   D0,<EA:3F>
        DC.W    $807F               ; $264DFC OR.W   <EA:3F>,D0
        OR.L   D0,D0                            ; $264DFE
        OR.L   D1,D0                            ; $264E00
        OR.L   D2,D0                            ; $264E02
        OR.L   D3,D0                            ; $264E04
        OR.L   D4,D0                            ; $264E06
        OR.L   D5,D0                            ; $264E08
        OR.L   D6,D0                            ; $264E0A
        OR.L   D7,D0                            ; $264E0C
        OR.L   D7,D0                            ; $264E0E
        MOVE.W  D6,-$7B(A7,D7.L)                ; $264E10
        MOVE.W  D2,-$80(A6,D7.L)                ; $264E14
        DC.W    $7D7D,$7D7B         ; $264E18 MOVE.W  <EA:3D>,$7D7B(A6)
        DC.W    $7D79,$7D77,$7E75,$7E73; $264E1C MOVE.W  $7D777E75,$7E73(A6)
        MOVEQ   #$71,D7                         ; $264E24
        MOVEQ   #$6E,D7                         ; $264E26
        MOVEQ   #$6B,D7                         ; $264E28
        MOVE.W  $7E67(A1),$7E67(A6)             ; $264E2A
        MOVEQ   #$69,D7                         ; $264E30
        MOVE.W  $7F6E(A3),-$7F8E(A7)            ; $264E32
        OR.W   D0,$78(A5,A0.W)                  ; $264E38
        OR.W   -$7F84(PC),D0                    ; $264E3C
        DC.W    $7F7D,$7F7D         ; $264E40 MOVE.W  <EA:3D>,$7F7D(A7)
        MOVE.W  #$7E7A,$7E78(A7)                ; $264E44
        MOVE.W  $76(A7,D7.L),$7F75(A7)          ; $264E4A
        OR.W   $75(A4,A0.W),D0                  ; $264E50
        OR.W   $77(A5,A0.W),D0                  ; $264E54
        OR.W   $827A.W,D1                       ; $264E58
        OR.W   $7C(PC,A0.W),D1                  ; $264E5C
        DC.W    $837D               ; $264E60 OR.W   D1,<EA:3D>
        DC.W    $837E               ; $264E62 OR.W   D1,<EA:3E>
        DC.W    $837F               ; $264E64 OR.W   D1,<EA:3F>
        DC.W    $827F               ; $264E66 OR.W   <EA:3F>,D1
        DC.W    $827F               ; $264E68 OR.W   <EA:3F>,D1
        DC.W    $817F               ; $264E6A OR.W   D0,<EA:3F>
        DC.W    $817F               ; $264E6C OR.W   D0,<EA:3F>
        DC.W    $807F               ; $264E6E OR.W   <EA:3F>,D0
        DC.W    $807F               ; $264E70 OR.W   <EA:3F>,D0
        DC.W    $7F7E,$7F7D         ; $264E72 MOVE.W  <EA:3E>,$7F7D(A7)
        MOVEQ   #$7C,D7                         ; $264E76
        MOVE.W  $7D79(PC),$7C78(A6)             ; $264E78
        MOVEQ   #$77,D6                         ; $264E7E
        MOVEQ   #$76,D6                         ; $264E80
        MOVEQ   #$76,D6                         ; $264E82
        MOVEQ   #$75,D6                         ; $264E84
        MOVE.W  $75(A5,D7.L),$7D77(A6)          ; $264E86
        MOVEQ   #$79,D7                         ; $264E8C
        MOVEQ   #$7C,D7                         ; $264E8E
        MOVEQ   #$7F,D7                         ; $264E90
        MOVE.W  D2,-$7A(A7,D7.L)                ; $264E92
        MOVE.W  A1,-$74(A7,D7.L)                ; $264E96
        OR.L   A5,D0                            ; $264E9A
        OR.L   A6,D0                            ; $264E9C
        OR.L   A5,D0                            ; $264E9E
        OR.L   A4,D0                            ; $264EA0
        OR.L   A2,D0                            ; $264EA2
        OR.L   A0,D0                            ; $264EA4
        OR.L   D7,D0                            ; $264EA6
        OR.L   D7,D0                            ; $264EA8
        OR.L   D7,D0                            ; $264EAA
        OR.L   D0,A1                            ; $264EAC
        OR.L   D0,A3                            ; $264EAE
        OR.L   D0,A4                            ; $264EB0
        OR.L   D0,A6                            ; $264EB2
        OR.L   A7,D1                            ; $264EB4
        OR.L   A7,D1                            ; $264EB6
        OR.L   A6,D1                            ; $264EB8
        OR.L   D0,A4                            ; $264EBA
        OR.L   D0,A2                            ; $264EBC
        OR.L   D0,A1                            ; $264EBE
        OR.L   D0,D7                            ; $264EC0
        OR.L   D0,D7                            ; $264EC2
        OR.L   D6,D1                            ; $264EC4
        OR.L   D0,D5                            ; $264EC6
        OR.L   D0,D4                            ; $264EC8
        OR.L   D0,D4                            ; $264ECA
        OR.L   D4,D0                            ; $264ECC
        OR.L   D4,D0                            ; $264ECE
        OR.L   D4,D0                            ; $264ED0
        MOVE.W  D3,-$7E(A7,D7.L)                ; $264ED2
        MOVEQ   #-$7E,D7                        ; $264ED6
        MOVEQ   #-$7F,D7                        ; $264ED8
        MOVE.W  D0,$7F(A6,D7.L)                 ; $264EDA
        MOVEQ   #$7C,D6                         ; $264EDE
        MOVEQ   #$78,D6                         ; $264EE0
        MOVEQ   #$74,D6                         ; $264EE2
        MOVEQ   #$71,D6                         ; $264EE4
        MOVEQ   #$6F,D6                         ; $264EE6
        MOVE.W  $7E6E(A6),$7F6F(A6)             ; $264EE8
        MOVE.W  $71(A0,D7.L),$7F72(A7)          ; $264EEE
        MOVEQ   #$73,D7                         ; $264EF4
        MOVEQ   #$74,D7                         ; $264EF6
        MOVEQ   #$74,D7                         ; $264EF8
        MOVE.W  $72(A3,D7.L),$7F71(A7)          ; $264EFA
        MOVE.W  $6F(A0,D7.L),$7F6F(A7)          ; $264F00
        MOVEQ   #$70,D7                         ; $264F06
        MOVEQ   #$71,D7                         ; $264F08
        MOVE.W  $75(A3,D7.L),-$7F88(A7)         ; $264F0A
        OR.W   $7D(PC,A0.W),D0                  ; $264F10
        DC.W    $817F               ; $264F14 OR.W   D0,<EA:3F>
        OR.L   D0,D1                            ; $264F16
        OR.L   D0,D1                            ; $264F18
        DC.W    $827F               ; $264F1A OR.W   <EA:3F>,D1
        DC.W    $827F               ; $264F1C OR.W   <EA:3F>,D1
        DC.W    $817F               ; $264F1E OR.W   D0,<EA:3F>
        DC.W    $817F               ; $264F20 OR.W   D0,<EA:3F>
        OR.L   D0,D0                            ; $264F22
        OR.L   D0,D0                            ; $264F24
        OR.L   D0,D0                            ; $264F26
        DC.W    $817F               ; $264F28 OR.W   D0,<EA:3F>
        DC.W    $817E               ; $264F2A OR.W   D0,<EA:3E>
        DC.W    $817D               ; $264F2C OR.W   D0,<EA:3D>
        OR.W   $7A(PC,D7.L),D0                  ; $264F2E
        DC.W    $7F79,$7F78,$7E77,$7E75; $264F32 MOVE.W  $7F787E77,$7E75(A7)
        MOVE.W  $70(A3,D7.L),$7C6E(A6)          ; $264F3A
        MOVEQ   #$6D,D6                         ; $264F40
        MOVEQ   #$6E,D6                         ; $264F42
        MOVE.W  $75(A1,D7.L),$7D79(A6)          ; $264F44
        MOVEQ   #$7D,D7                         ; $264F4A
        MOVE.W  D1,-$7B(A7,D7.L)                ; $264F4C
        OR.L   A1,D0                            ; $264F50
        OR.L   A3,D0                            ; $264F52
        OR.L   A3,D0                            ; $264F54
        OR.L   A2,D0                            ; $264F56
        OR.L   D7,D0                            ; $264F58
        OR.L   D5,D0                            ; $264F5A
        OR.L   D2,D0                            ; $264F5C
        DC.W    $807F               ; $264F5E OR.W   <EA:3F>,D0
        DC.W    $807D               ; $264F60 OR.W   <EA:3D>,D0
        OR.W   #$807B,D0                        ; $264F62
        MOVE.W  $7C(PC,D7.L),$7F7D(A7)          ; $264F66
        DC.W    $7F7E,$7E80         ; $264F6C MOVE.W  <EA:3E>,$7E80(A7)
        MOVEQ   #-$7F,D7                        ; $264F70
        MOVE.W  D3,-$7B(A7,D7.L)                ; $264F72
        OR.L   D6,D0                            ; $264F76
        OR.L   A0,D0                            ; $264F78
        OR.L   D0,A1                            ; $264F7A
        OR.L   A2,D1                            ; $264F7C
        OR.L   A4,D1                            ; $264F7E
        OR.L   A5,D1                            ; $264F80
        OR.L   D0,A6                            ; $264F82
        OR.L   D0,A7                            ; $264F84
        OR.L   (A0),D1                          ; $264F86
        OR.L   (A1),D1                          ; $264F88
        OR.L   D0,(A0)                          ; $264F8A
        OR.L   D0,A7                            ; $264F8C
        OR.L   A5,D0                            ; $264F8E
        OR.L   A3,D0                            ; $264F90
        OR.L   A0,D0                            ; $264F92
        MOVE.W  D4,-$80(A7,D7.L)                ; $264F94
        MOVE.W  $77(PC,D7.L),$7E73(A7)          ; $264F98
        MOVE.W  $71(A1,D7.L),$7D73(A6)          ; $264F9E
        MOVE.W  $7A(A6,D7.L),$7D7E(A6)          ; $264FA4
        MOVEQ   #-$7E,D7                        ; $264FAA
        MOVEQ   #-$7A,D7                        ; $264FAC
        MOVEQ   #-$78,D7                        ; $264FAE
        MOVE.W  A2,-$76(A7,D7.L)                ; $264FB0
        MOVE.W  A1,-$7A(A7,D7.L)                ; $264FB4
        MOVE.W  D3,$7F(A7,D7.L)                 ; $264FB8
        MOVE.W  #$7F7A,$7F79(A7)                ; $264FBC
        MOVE.W  $7F78.W,$7F78(A7)               ; $264FC2
        OR.W   $8078.W,D0                       ; $264FC8
        OR.W   $80798179,D0                     ; $264FCC
        OR.W   D0,-$7E86(PC)                    ; $264FD2
        OR.W   $7B(PC,A0.W),D0                  ; $264FD6
        OR.W   #$807C,D0                        ; $264FDA
        DC.W    $817D               ; $264FDE OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264FE0 OR.W   D0,<EA:3D>
        DC.W    $817D               ; $264FE2 OR.W   D0,<EA:3D>
        DC.W    $807D               ; $264FE4 OR.W   <EA:3D>,D0
        DC.W    $807D               ; $264FE6 OR.W   <EA:3D>,D0
        DC.W    $7F7D,$7F7C         ; $264FE8 MOVE.W  <EA:3D>,$7F7C(A7)
        MOVEQ   #$79,D7                         ; $264FEC
        MOVEQ   #$77,D7                         ; $264FEE
        MOVEQ   #$74,D7                         ; $264FF0
        MOVEQ   #$72,D7                         ; $264FF2
        MOVEQ   #$6F,D7                         ; $264FF4
        MOVEQ   #$6C,D7                         ; $264FF6
        MOVEQ   #$69,D7                         ; $264FF8
        MOVEQ   #$66,D7                         ; $264FFA
        MOVE.W  -(A5),$7E66(A6)                 ; $264FFC
        MOVEQ   #$69,D7                         ; $265000
        MOVE.W  $7F71(A5),$7F76(A7)             ; $265002
        DC.W    $7F79,$7F7C,$7F7F,$7F80; $265008 MOVE.W  $7F7C7F7F,$7F80(A7)
        MOVE.W  D0,$7F(A7,D7.L)                 ; $265010
        DC.W    $7F7D,$7F7B         ; $265014 MOVE.W  <EA:3D>,$7F7B(A7)
        MOVE.W  -$7F87(PC),-$7F88(A7)           ; $265018
        OR.W   $8079.W,D0                       ; $26501E
        OR.W   -$7F85(PC),D0                    ; $265022
        DC.W    $817D               ; $265026 OR.W   D0,<EA:3D>
        DC.W    $817F               ; $265028 OR.W   D0,<EA:3F>
        OR.L   D0,D0                            ; $26502A
        OR.L   D0,D1                            ; $26502C
        OR.L   D0,D2                            ; $26502E
        OR.L   D0,D2                            ; $265030
        OR.L   D0,D3                            ; $265032
        OR.L   D0,D4                            ; $265034
        OR.L   D0,D4                            ; $265036
        OR.L   D0,D4                            ; $265038
        OR.L   D0,D4                            ; $26503A
        OR.L   D0,D4                            ; $26503C
        OR.L   D0,D4                            ; $26503E
        OR.L   D5,D0                            ; $265040
        OR.L   D6,D0                            ; $265042
        MOVE.W  D6,-$79(A7,D7.L)                ; $265044
        MOVEQ   #-$79,D7                        ; $265048
        MOVEQ   #-$78,D7                        ; $26504A
        MOVEQ   #-$78,D7                        ; $26504C
        MOVEQ   #-$78,D7                        ; $26504E
        MOVEQ   #-$78,D7                        ; $265050
        MOVEQ   #-$7A,D7                        ; $265052
        MOVEQ   #-$7C,D7                        ; $265054
        MOVE.W  D2,-$7F(A6,D7.L)                ; $265056
        MOVE.W  D2,-$7D(A6,D7.L)                ; $26505A
        MOVEQ   #-$7C,D7                        ; $26505E
        MOVE.W  D6,-$78(A7,D7.L)                ; $265060
        MOVE.W  A2,-$75(A7,A0.W)                ; $265064
        OR.L   A3,D0                            ; $265068
        OR.L   A2,D0                            ; $26506A
        MOVE.W  A0,-$7B(A7,D7.L)                ; $26506C
        MOVE.W  D1,$7E(A7,D7.L)                 ; $265070
        MOVE.W  $7F78(PC),$7F77(A7)             ; $265074
        MOVE.W  $77(A6,A0.W),-$7F88(A7)         ; $26507A
        OR.W   D0,$817A817C                     ; $265080
        DC.W    $817D               ; $265086 OR.W   D0,<EA:3D>
        DC.W    $817E               ; $265088 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $26508A OR.W   D0,<EA:3E>
        DC.W    $817E               ; $26508C OR.W   D0,<EA:3E>
        DC.W    $817E               ; $26508E OR.W   D0,<EA:3E>
        DC.W    $817E               ; $265090 OR.W   D0,<EA:3E>
        DC.W    $817E               ; $265092 OR.W   D0,<EA:3E>
        DC.W    $807E               ; $265094 OR.W   <EA:3E>,D0
        DC.W    $807F               ; $265096 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $265098 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26509A OR.W   <EA:3F>,D0
        DC.W    $807F               ; $26509C OR.W   <EA:3F>,D0
        DC.W    $817F               ; $26509E OR.W   D0,<EA:3F>
        DC.W    $817F               ; $2650A0 OR.W   D0,<EA:3F>
        DC.W    $817F               ; $2650A2 OR.W   D0,<EA:3F>
        DC.W    $807F               ; $2650A4 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $2650A6 OR.W   <EA:3F>,D0
        DC.W    $807F               ; $2650A8 OR.W   <EA:3F>,D0
        DC.W    $7F7E,$7E7E         ; $2650AA MOVE.W  <EA:3E>,$7E7E(A7)
        MOVEQ   #$7C,D7                         ; $2650AE
        MOVE.W  $7D74.W,$7C71(A6)               ; $2650B0
        MOVEQ   #$6F,D6                         ; $2650B6
        MOVEQ   #$6E,D6                         ; $2650B8
        MOVEQ   #$6E,D6                         ; $2650BA
        MOVEQ   #$70,D6                         ; $2650BC
        MOVE.W  $76(A3,D7.L),$7D79(A6)          ; $2650BE
        MOVEQ   #$7D,D7                         ; $2650C4
        MOVEQ   #-$80,D7                        ; $2650C6
        MOVEQ   #-$7E,D7                        ; $2650C8
        MOVEQ   #-$7D,D7                        ; $2650CA
        MOVEQ   #-$7D,D7                        ; $2650CC
        MOVEQ   #-$7F,D7                        ; $2650CE
        MOVEQ   #$7F,D7                         ; $2650D0
        MOVEQ   #$7D,D7                         ; $2650D2
        MOVE.W  $79(PC,D7.L),$7F77(A7)          ; $2650D4
        MOVE.W  $74(A5,A0.W),-$7F8D(A7)         ; $2650DA
        OR.W   $70(A1,A0.W),D0                  ; $2650E0
        OR.W   D0,$70(A0,A0.W)                  ; $2650E4
        OR.W   D0,$71(A0,A0.W)                  ; $2650E8
        OR.W   D0,$74(A2,A0.W)                  ; $2650EC
        OR.W   $79(A6,A0.W),D1                  ; $2650F0
        OR.W   $7E(PC,A0.W),D1                  ; $2650F4
        OR.L   D2,D1                            ; $2650F8
        OR.L   D5,D1                            ; $2650FA
        OR.L   D7,D1                            ; $2650FC
        OR.L   D0,A0                            ; $2650FE
        OR.L   D0,A1                            ; $265100
        OR.L   A2,D0                            ; $265102
        OR.L   A1,D0                            ; $265104
        MOVE.W  A0,-$78(A7,D7.L)                ; $265106
        MOVE.W  D7,-$7B(A7,D7.L)                ; $26510A
        MOVEQ   #-$7E,D7                        ; $26510E
        DC.W    $7D7E,$7D7B         ; $265110 MOVE.W  <EA:3E>,$7D7B(A6)
        MOVE.W  $7D77.W,$7D77(A6)               ; $265114
        MOVEQ   #$78,D7                         ; $26511A
        MOVEQ   #$7A,D7                         ; $26511C
        DC.W    $7D7D,$7D7F         ; $26511E MOVE.W  <EA:3D>,$7D7F(A6)
        MOVEQ   #-$7E,D7                        ; $265122
        MOVEQ   #-$7C,D7                        ; $265124
        MOVEQ   #-$7B,D7                        ; $265126
        MOVEQ   #-$79,D7                        ; $265128
        MOVEQ   #-$78,D7                        ; $26512A
        MOVE.W  A0,-$79(A7,D7.L)                ; $26512C
        MOVEQ   #-$7B,D7                        ; $265130
        MOVEQ   #-$7D,D7                        ; $265132
        MOVEQ   #-$7F,D7                        ; $265134
        MOVEQ   #-$80,D7                        ; $265136
        MOVEQ   #$7F,D7                         ; $265138
        MOVEQ   #$7E,D7                         ; $26513A
        MOVEQ   #$7E,D7                         ; $26513C
        DC.W    $7F7E,$7F7D         ; $26513E MOVE.W  <EA:3E>,$7F7D(A7)
        DC.W    $807D               ; $265142 OR.W   <EA:3D>,D0
        OR.W   #$807B,D0                        ; $265144
        OR.W   $7B(PC,A0.W),D0                  ; $265148
        DC.W    $807D               ; $26514C OR.W   <EA:3D>,D0
        DC.W    $807E               ; $26514E OR.W   <EA:3E>,D0
        OR.L   D0,D0                            ; $265150
        OR.L   D0,D1                            ; $265152
        OR.L   D0,D3                            ; $265154
        OR.L   D0,D5                            ; $265156
        OR.L   D0,D7                            ; $265158
        OR.L   D0,A0                            ; $26515A
        OR.L   D0,A0                            ; $26515C
        OR.L   A0,D0                            ; $26515E
        OR.L   A0,D0                            ; $265160
        OR.L   D7,D0                            ; $265162
        OR.L   D7,D0                            ; $265164
        OR.L   D6,D0                            ; $265166
        OR.L   D6,D0                            ; $265168
        OR.L   D6,D0                            ; $26516A
        OR.L   D4,D0                            ; $26516C
        MOVE.W  D2,$7E(A7,D7.L)                 ; $26516E
        MOVEQ   #$7B,D7                         ; $265172
        MOVEQ   #$7A,D7                         ; $265174
        MOVEQ   #$7A,D7                         ; $265176
        MOVE.W  $7D(PC,D7.L),-$7F81(A7)         ; $265178
        MOVE.W  D0,$7F(A7,D7.L)                 ; $26517E
        MOVEQ   #$7F,D7                         ; $265182
        MOVEQ   #$7D,D7                         ; $265184
        MOVEQ   #$7C,D7                         ; $265186
        MOVEQ   #$7A,D7                         ; $265188
        MOVEQ   #$79,D7                         ; $26518A
        MOVEQ   #$77,D7                         ; $26518C
        MOVEQ   #$76,D7                         ; $26518E
        MOVEQ   #$75,D7                         ; $265190
        MOVEQ   #$74,D7                         ; $265192
        MOVEQ   #$75,D7                         ; $265194
        MOVEQ   #$75,D7                         ; $265196
        MOVEQ   #$76,D7                         ; $265198
        MOVEQ   #$78,D7                         ; $26519A
        DC.W    $7F79,$7F7A,$7F7B,$7F7B; $26519C MOVE.W  $7F7A7F7B,$7F7B(A7)
        MOVE.W  $7B(PC,D7.L),$7F7B(A7)          ; $2651A4
        MOVE.W  -$7F87(PC),-$7F88(A7)           ; $2651AA
        OR.W   D0,$76(A7,A0.W)                  ; $2651B0
        OR.W   D0,$75(A5,A0.W)                  ; $2651B4
        OR.W   $75(A5,A0.W),D0                  ; $2651B8
        OR.W   $77(A6,A0.W),D0                  ; $2651BC
        OR.W   $78(A7,A0.W),D0                  ; $2651C0
        OR.W   $8078.W,D0                       ; $2651C4
        OR.W   $75(A7,A0.W),D0                  ; $2651C8
        MOVE.W  $71(A3,D7.L),$7E70(A7)          ; $2651CC
        MOVEQ   #$71,D7                         ; $2651D2
        MOVEQ   #$73,D7                         ; $2651D4
        MOVEQ   #$76,D7                         ; $2651D6
        DC.W    $7F79,$7F7D,$7F81,$7F84; $2651D8 MOVE.W  $7F7D7F81,$7F84(A7)
        MOVE.W  D7,-$77(A7,D7.L)                ; $2651E0
        MOVE.W  A2,-$76(A7,D7.L)                ; $2651E4
        MOVE.W  A1,-$7A(A7,D7.L)                ; $2651E8
        MOVEQ   #-$7C,D7                        ; $2651EC
        MOVEQ   #-$7E,D7                        ; $2651EE
        MOVEQ   #-$7F,D7                        ; $2651F0
        DC.W    $7F7F,$7F7E         ; $2651F2 MOVE.W  <EA:3F>,$7F7E(A7)
        MOVE.W  #$7F7C,$7F7C(A7)                ; $2651F6
        DC.W    $7F7D,$7F7E         ; $2651FC MOVE.W  <EA:3D>,$7F7E(A7)
        MOVE.W  D0,-$7F(A7,D7.L)                ; $265200
        MOVE.W  D3,-$7A(A7,A0.W)                ; $265204
        OR.L   A0,D0                            ; $265208
        OR.L   A2,D0                            ; $26520A
        OR.L   A4,D0                            ; $26520C
        OR.L   A6,D0                            ; $26520E
        OR.L   A6,D0                            ; $265210
        OR.L   A6,D0                            ; $265212
        OR.L   A5,D0                            ; $265214
        OR.L   A4,D0                            ; $265216
        OR.L   A1,D0                            ; $265218
        OR.L   D6,D0                            ; $26521A
        OR.L   D3,D0                            ; $26521C
        OR.L   D0,D0                            ; $26521E
        DC.W    $807E               ; $265220 OR.W   <EA:3E>,D0
        DC.W    $807D               ; $265222 OR.W   <EA:3D>,D0
        OR.W   #$7F7C,D0                        ; $265224
        MOVE.W  $79(PC,D7.L),$7E78(A7)          ; $265228
        MOVEQ   #$78,D7                         ; $26522E
        MOVEQ   #$79,D7                         ; $265230
        MOVEQ   #$7B,D7                         ; $265232
        DC.W    $7F7E,$7F80         ; $265234 MOVE.W  <EA:3E>,$7F80(A7)
        OR.L   D3,D0                            ; $265238
        OR.L   D4,D0                            ; $26523A
        OR.L   D5,D0                            ; $26523C
        OR.L   D0,D6                            ; $26523E
        OR.L   D0,D6                            ; $265240
        OR.L   D0,D6                            ; $265242
        OR.L   D0,D5                            ; $265244
        OR.L   D0,D4                            ; $265246
        OR.L   D0,D2                            ; $265248
        OR.L   D0,D1                            ; $26524A
        OR.L   D0,D0                            ; $26524C
        DC.W    $807F               ; $26524E OR.W   <EA:3F>,D0
        DC.W    $807E               ; $265250 OR.W   <EA:3E>,D0
        DC.W    $7F7D,$7F7C         ; $265252 MOVE.W  <EA:3D>,$7F7C(A7)
        MOVE.W  #$7F7B,$7E7A(A7)                ; $265256
        MOVEQ   #$79,D7                         ; $26525C
        MOVEQ   #$78,D7                         ; $26525E
        MOVEQ   #$77,D7                         ; $265260
        MOVEQ   #$75,D7                         ; $265262
        MOVEQ   #$74,D7                         ; $265264
        MOVEQ   #$73,D7                         ; $265266
        MOVE.W  $73(A3,D7.L),$7F73(A7)          ; $265268
        MOVE.W  $74(A3,D7.L),$7E74(A7)          ; $26526E
        MOVE.W  $77(A6,D7.L),$7F77(A7)          ; $265274
        MOVE.W  $7F78.W,$7F79(A7)               ; $26527A
        MOVE.W  -$7F86(PC),-$7F86(A7)           ; $265280
        MOVE.W  $74(A7,D7.L),$7F72(A7)          ; $265286
        MOVEQ   #$70,D7                         ; $26528C
        MOVEQ   #$70,D7                         ; $26528E
        MOVEQ   #$71,D7                         ; $265290
        MOVEQ   #$73,D7                         ; $265292
        MOVE.W  $75(A4,D7.L),$7E74(A7)          ; $265294
        MOVEQ   #$74,D7                         ; $26529A
        MOVEQ   #$73,D7                         ; $26529C
        MOVEQ   #$72,D7                         ; $26529E
        MOVE.W  $72(A2,D7.L),-$7F8E(A7)         ; $2652A0
        OR.W   $73(A2,A0.W),D0                  ; $2652A6
        MOVE.W  $76(A4,D7.L),$7F79(A7)          ; $2652AA
        DC.W    $7F7D,$8081         ; $2652B0 MOVE.W  <EA:3D>,-$7F7F(A7)
        OR.L   D5,D0                            ; $2652B4
        OR.L   A0,D0                            ; $2652B6
        OR.L   A2,D0                            ; $2652B8
        OR.L   A3,D0                            ; $2652BA
        OR.L   A2,D0                            ; $2652BC
        OR.L   A0,D0                            ; $2652BE
        MOVE.W  D6,-$7C(A7,D7.L)                ; $2652C0
        MOVE.W  D3,-$7E(A7,A0.W)                ; $2652C4
        OR.L   D3,D0                            ; $2652C8
        OR.L   D4,D0                            ; $2652CA
        OR.L   D5,D0                            ; $2652CC
        OR.L   D5,D0                            ; $2652CE
        OR.L   D6,D0                            ; $2652D0
        MOVE.W  D6,-$7B(A7,D7.L)                ; $2652D2
        MOVE.W  D5,-$7B(A7,D7.L)                ; $2652D6
        MOVE.W  D6,-$79(A7,D7.L)                ; $2652DA
        MOVE.W  A0,-$77(A7,D7.L)                ; $2652DE
        MOVE.W  A2,-$76(A7,D7.L)                ; $2652E2
        MOVE.W  A1,-$78(A7,D7.L)                ; $2652E6
        MOVE.W  D6,-$7C(A7,D7.L)                ; $2652EA
        MOVEQ   #-$7D,D7                        ; $2652EE
        MOVEQ   #-$7F,D7                        ; $2652F0
        MOVEQ   #$7F,D7                         ; $2652F2
        DC.W    $7F7E,$7F7D         ; $2652F4 MOVE.W  <EA:3E>,$7F7D(A7)
        MOVE.W  #$7F7D,-$7F81(A7)               ; $2652F8
        OR.L   D0,D0                            ; $2652FE
        OR.L   D1,D0                            ; $265300
        OR.L   D1,D0                            ; $265302
        OR.L   D1,D0                            ; $265304
        OR.L   D0,D0                            ; $265306
        OR.L   D0,D0                            ; $265308
        OR.L   D1,D0                            ; $26530A
        OR.L   D2,D0                            ; $26530C
        OR.L   D4,D0                            ; $26530E
        OR.L   D7,D0                            ; $265310
        OR.L   A1,D0                            ; $265312
        OR.L   A2,D0                            ; $265314
        OR.L   A3,D0                            ; $265316
        OR.L   D0,A2                            ; $265318
        OR.L   D0,A1                            ; $26531A
        OR.L   D0,A0                            ; $26531C
        OR.L   D0,D6                            ; $26531E
        OR.L   D4,D0                            ; $265320
        OR.L   D2,D0                            ; $265322
        MOVE.W  D0,$7E(A7,D7.L)                 ; $265324
        MOVEQ   #$7B,D7                         ; $265328
        MOVEQ   #$79,D7                         ; $26532A
        MOVEQ   #$77,D7                         ; $26532C
        MOVEQ   #$77,D7                         ; $26532E
        MOVEQ   #$78,D7                         ; $265330
        MOVEQ   #$78,D7                         ; $265332
        MOVEQ   #$77,D7                         ; $265334
        MOVEQ   #$76,D7                         ; $265336
        MOVEQ   #$75,D7                         ; $265338
        MOVEQ   #$74,D7                         ; $26533A
        MOVE.W  $70(A2,D7.L),$7F6F(A7)          ; $26533C
        MOVE.W  $7F6D(A6),$7F6E(A7)             ; $265342
        MOVE.W  $7F71(A7),$7F73(A7)             ; $265348
        MOVE.W  $77(A5,D7.L),$7F79(A7)          ; $26534E
        MOVE.W  $7D(PC,D7.L),$7F80(A7)          ; $265354
        MOVE.W  D1,-$7E(A7,D7.L)                ; $26535A
        MOVE.W  D1,-$80(A7,D7.L)                ; $26535E
        DC.W    $7F7D,$7F7B         ; $265362 MOVE.W  <EA:3D>,$7F7B(A7)
        DC.W    $7F79,$7F77,$7F75,$8074; $265366 MOVE.W  $7F777F75,-$7F8C(A7)
        OR.W   $72(A3,A0.W),D0                  ; $26536E
        MOVE.W  $72(A2,D7.L),-$7F8D(A7)         ; $265372
        OR.W   $74(A3,A0.W),D0                  ; $265378
        OR.W   $77(A5,A0.W),D0                  ; $26537C
        OR.W   D0,$807A.W                       ; $265380
        OR.W   #$807E,D0                        ; $265384
        MOVE.W  D1,-$7C(A7,D7.L)                ; $265388
        MOVE.W  D7,-$77(A7,D7.L)                ; $26538C
        MOVEQ   #-$76,D7                        ; $265390
        MOVEQ   #-$76,D7                        ; $265392
        MOVE.W  A2,-$77(A6,D7.L)                ; $265394
        MOVEQ   #-$78,D7                        ; $265398
        MOVEQ   #-$7B,D7                        ; $26539A
        DC.W    $7D7F,$7D7A         ; $26539C MOVE.W  <EA:3F>,$7D7A(A6)
        MOVE.W  $70(A4,D7.L),$7E6E(A6)          ; $2653A0
        MOVEQ   #$6E,D7                         ; $2653A6
        MOVE.W  $72(A0,D7.L),$7F75(A7)          ; $2653A8
        MOVE.W  $7F7B.W,$7F7E(A7)               ; $2653AE
        MOVE.W  D1,-$7C(A7,A0.W)                ; $2653B4
        OR.L   A0,D0                            ; $2653B8
        OR.L   D0,A3                            ; $2653BA
        OR.L   D0,A5                            ; $2653BC
        OR.L   D0,A6                            ; $2653BE
        OR.L   D0,A6                            ; $2653C0
        OR.L   D0,A6                            ; $2653C2
        OR.L   A5,D0                            ; $2653C4
        OR.L   A4,D0                            ; $2653C6
        OR.L   D0,A1                            ; $2653C8
        OR.L   D6,D0                            ; $2653CA
        OR.L   D3,D0                            ; $2653CC
        OR.L   D0,D0                            ; $2653CE
        DC.W    $807E               ; $2653D0 OR.W   <EA:3E>,D0
        OR.W   #$807C,D0                        ; $2653D2
        DC.W    $807E               ; $2653D6 OR.W   <EA:3E>,D0
        OR.L   D1,D0                            ; $2653D8
        OR.L   D5,D0                            ; $2653DA
        OR.L   A2,D0                            ; $2653DC
        OR.L   D0,A6                            ; $2653DE
        OR.L   D0,(A2)                          ; $2653E0
        OR.L   D0,(A4)                          ; $2653E2
        OR.L   D0,(A5)                          ; $2653E4
        OR.L   (A5),D0                          ; $2653E6
        MOVE.W  (A3),-$6E(A7,D7.L)              ; $2653E8
        MOVE.W  A7,-$75(A7,D7.L)                ; $2653EC
        MOVEQ   #-$78,D7                        ; $2653F0
        MOVEQ   #-$7B,D7                        ; $2653F2
        MOVEQ   #-$7E,D7                        ; $2653F4
        MOVEQ   #-$80,D7                        ; $2653F6
        DC.W    $7D7D,$7D79         ; $2653F8 MOVE.W  <EA:3D>,$7D79(A6)
        MOVEQ   #$74,D6                         ; $2653FC
        MOVEQ   #$70,D6                         ; $2653FE
        MOVEQ   #$6D,D6                         ; $265400
        MOVEQ   #$6B,D6                         ; $265402
        MOVE.W  $7E6B(A3),$7F6D(A6)             ; $265404
        MOVE.W  $7F70(A7),-$7F8F(A7)            ; $26540A
        MOVE.W  $73(A2,D7.L),$7F73(A7)          ; $265410
        OR.W   $74(A4,A0.W),D0                  ; $265416
        OR.W   $74(A4,A0.W),D0                  ; $26541A
        OR.W   $73(A4,D7.L),D0                  ; $26541E
        MOVE.W  $74(A3,D7.L),$7F75(A7)          ; $265422
        MOVE.W  $78(A6,A0.W),-$7F87(A7)         ; $265428
        OR.W   D0,$81798179                     ; $26542E
        OR.W   D0,-$7F85(PC)                    ; $265434
        DC.W    $807D               ; $265438 OR.W   <EA:3D>,D0
        DC.W    $807F               ; $26543A OR.W   <EA:3F>,D0
        OR.L   D1,D0                            ; $26543C
        OR.L   D2,D0                            ; $26543E
        OR.L   D0,D3                            ; $265440
        OR.L   D3,D0                            ; $265442
        OR.L   D3,D0                            ; $265444
        MOVE.W  D2,-$7F(A7,D7.L)                ; $265446
        MOVE.W  D0,$7E(A7,D7.L)                 ; $26544A
        MOVE.W  #$7F7A,$7F79(A7)                ; $26544E
        MOVEQ   #$78,D7                         ; $265454
        MOVEQ   #$76,D7                         ; $265456
        MOVE.W  $74(A5,D7.L),$7C73(A6)          ; $265458
        MOVEQ   #$72,D6                         ; $26545E
        MOVE.W  $76(A3,D7.L),$7C79(A5)          ; $265460
        MOVE.W  #$7E7F,$7E80(A6)                ; $265466
        MOVE.W  D1,-$7F(A7,A0.W)                ; $26546C
        OR.L   D0,D0                            ; $265470
        DC.W    $807F               ; $265472 OR.W   <EA:3F>,D0
        DC.W    $817D               ; $265474 OR.W   D0,<EA:3D>
        OR.W   D0,-$7E89(PC)                    ; $265476
        OR.W   $73(A5,A0.W),D1                  ; $26547A
        OR.W   D0,$73(A3,A0.W)                  ; $26547E
        OR.W   $75(A3,A0.W),D0                  ; $265482
        OR.W   $7B(A7,A0.W),D0                  ; $265486
        DC.W    $817F               ; $26548A OR.W   D0,<EA:3F>
        OR.L   D0,D4                            ; $26548C
        OR.L   D0,A1                            ; $26548E
        OR.L   D0,A5                            ; $265490
        OR.L   D0,(A1)                          ; $265492
        OR.L   D0,(A3)                          ; $265494
        OR.L   D0,(A5)                          ; $265496
        OR.L   D0,(A7)                          ; $265498
        OR.L   (A1)+,D1                         ; $26549A
        OR.L   D0,(A2)+                         ; $26549C
        OR.L   D0,(A2)+                         ; $26549E
        OR.L   (A1)+,D0                         ; $2654A0
        OR.L   (A6),D0                          ; $2654A2
        MOVE.W  (A3),-$70(A7,D7.L)              ; $2654A4
        MOVEQ   #-$74,D7                        ; $2654A8
        MOVEQ   #-$77,D7                        ; $2654AA
        MOVE.W  D6,-$7C(A6,D7.L)                ; $2654AC
        MOVE.W  D3,-$7E(A6,D7.L)                ; $2654B0
        MOVE.W  D1,-$80(A6,D7.L)                ; $2654B4
        MOVEQ   #$7F,D6                         ; $2654B8
        MOVEQ   #$7E,D6                         ; $2654BA
        MOVEQ   #$7F,D6                         ; $2654BC
        MOVE.W  D0,-$7E(A6,D7.L)                ; $2654BE
        MOVEQ   #-$7D,D7                        ; $2654C2
        MOVEQ   #-$7D,D7                        ; $2654C4
        MOVEQ   #-$7D,D7                        ; $2654C6
        MOVEQ   #-$7E,D7                        ; $2654C8
        MOVEQ   #-$80,D7                        ; $2654CA
        DC.W    $7F7E,$7F7D         ; $2654CC MOVE.W  <EA:3E>,$7F7D(A7)
        OR.W   #$807B,D0                        ; $2654D0
        OR.W   -$7F87(PC),D0                    ; $2654D4
        OR.W   $8079817A,D0                     ; $2654D8
        OR.W   D0,-$7E85(PC)                    ; $2654DE
        OR.W   D0,$7A(PC,A0.W)                  ; $2654E2
        OR.W   $80778074,D0                     ; $2654E6
        OR.W   $6E(A1,A0.W),D0                  ; $2654EC
        OR.W   -$7E94(A4),D0                    ; $2654F0
        OR.W   -$7D92(A4),D1                    ; $2654F4
        OR.W   $72(A0,A0.W),D1                  ; $2654F8
        OR.W   D0,$77(A4,A0.W)                  ; $2654FC
        OR.W   D0,$817B807D                     ; $265500
        DC.W    $807E               ; $265506 OR.W   <EA:3E>,D0
        DC.W    $807E               ; $265508 OR.W   <EA:3E>,D0
        DC.W    $7F7D,$7E7B         ; $26550A MOVE.W  <EA:3D>,$7E7B(A7)
        MOVE.W  $7C75.W,$7B71(A6)               ; $26550E
        MOVE.W  $7B6B(A6),$7C6A(A5)             ; $265514
        MOVEQ   #$6B,D6                         ; $26551A
        MOVE.W  $7D6E(A4),$7D70(A6)             ; $26551C
        MOVE.W  $73(A2,D7.L),$7E74(A6)          ; $265522
        MOVEQ   #$75,D7                         ; $265528
        MOVE.W  $78(A6,D7.L),$7F79(A7)          ; $26552A
        OR.W   -$7F86(PC),D0                    ; $265530
        OR.W   -$7F86(PC),D0                    ; $265534
        MOVE.W  $7F7B(PC),$7F7C(A7)             ; $265538
        DC.W    $7F7E,$7F80         ; $26553E MOVE.W  <EA:3E>,$7F80(A7)
        MOVE.W  D2,-$7D(A7,A0.W)                ; $265542
        OR.L   D3,D0                            ; $265546
        OR.L   D3,D0                            ; $265548
        OR.L   D3,D0                            ; $26554A
        OR.L   D0,D3                            ; $26554C
        OR.L   D4,D1                            ; $26554E
        OR.L   D5,D1                            ; $265550
        OR.L   D1,D6                            ; $265552
        OR.L   A0,D1                            ; $265554
        OR.L   A2,D1                            ; $265556
        OR.L   A3,D1                            ; $265558
        OR.L   A3,D1                            ; $26555A
        OR.L   A2,D1                            ; $26555C
        OR.L   D0,A1                            ; $26555E
        OR.L   D0,A0                            ; $265560
        OR.L   D0,A0                            ; $265562
        OR.L   D0,A0                            ; $265564
        OR.L   D0,A2                            ; $265566
        OR.L   A3,D0                            ; $265568
        MOVE.W  A5,-$73(A7,D7.L)                ; $26556A
        MOVE.W  A4,-$75(A6,D7.L)                ; $26556E
        MOVE.W  A0,-$7A(A5,D7.L)                ; $265572
        MOVE.W  D3,-$80(A5,D7.L)                ; $265576
        MOVEQ   #$7E,D6                         ; $26557A
        MOVEQ   #$7C,D6                         ; $26557C
        MOVE.W  $7D7A(PC),$7E7A(A6)             ; $26557E
        MOVEQ   #$7B,D7                         ; $265584
        MOVE.W  #$7F7E,-$7F80(A7)               ; $265586
        OR.L   D2,D0                            ; $26558C
        OR.L   D3,D0                            ; $26558E
        OR.L   D3,D0                            ; $265590
        OR.L   D2,D0                            ; $265592
        OR.L   D2,D0                            ; $265594
        OR.L   D2,D0                            ; $265596
        OR.L   D3,D0                            ; $265598
        OR.L   D4,D0                            ; $26559A
        MOVE.W  D5,-$7B(A7,D7.L)                ; $26559C
        MOVE.W  D5,-$7C(A7,D7.L)                ; $2655A0
        MOVEQ   #-$7D,D7                        ; $2655A4
        MOVEQ   #-$7E,D7                        ; $2655A6
        MOVE.W  D2,-$7E(A7,A0.W)                ; $2655A8
        OR.L   D0,D3                            ; $2655AC
        OR.L   D0,D4                            ; $2655AE
        OR.L   D5,D1                            ; $2655B0
        OR.L   D6,D1                            ; $2655B2
        OR.L   D7,D1                            ; $2655B4
        OR.L   D7,D1                            ; $2655B6
        OR.L   D7,D1                            ; $2655B8
        OR.L   D7,D1                            ; $2655BA
        OR.L   D6,D1                            ; $2655BC
        OR.L   D5,D1                            ; $2655BE
        OR.L   D0,D3                            ; $2655C0
        DC.W    $807F               ; $2655C2 OR.W   <EA:3F>,D0
        MOVE.W  #$7F78,$7F75(A7)                ; $2655C4
        MOVE.W  $6F(A2,D7.L),$7E6D(A7)          ; $2655CA
        MOVE.W  $7C6A(A3),$7B6A(A6)             ; $2655D0
        MOVEQ   #$6B,D5                         ; $2655D6
        MOVEQ   #$6C,D5                         ; $2655D8
        MOVE.W  $7B6F(A5),$7D71(A5)             ; $2655DA
        MOVEQ   #$74,D7                         ; $2655E0
        MOVE.W  $78(A6,D7.L),-$7F87(A7)         ; $2655E2
        OR.W   $81788176,D0                     ; $2655E8
        OR.W   D0,$71(A3,A0.W)                  ; $2655EE
        OR.W   D0,$6F(A0,A0.W)                  ; $2655F2
        OR.W   D0,$72(A0,A0.W)                  ; $2655F6
        OR.W   D0,$76(A4,A0.W)                  ; $2655FA
        OR.W   $78(A7,D7.L),D0                  ; $2655FE
        MOVE.W  $7F78.W,$7F77(A7)               ; $265602
        MOVE.W  $78(A7,A0.W),-$7F87(A7)         ; $265608
        OR.W   D0,#$817E                        ; $26560E
        OR.L   D0,D1                            ; $265612
        OR.L   D3,D1                            ; $265614
        OR.L   D5,D1                            ; $265616
        OR.L   D7,D1                            ; $265618
        OR.L   A1,D1                            ; $26561A
        OR.L   A3,D1                            ; $26561C
        OR.L   A5,D1                            ; $26561E
        OR.L   D0,A5                            ; $265620
        OR.L   D0,A4                            ; $265622
        OR.L   A1,D0                            ; $265624
        MOVE.W  D5,-$80(A7,D7.L)                ; $265626
        MOVEQ   #$7D,D7                         ; $26562A
        MOVEQ   #$7A,D7                         ; $26562C
        MOVE.W  $7D77.W,$7C76(A6)               ; $26562E
        MOVE.W  $73(A5,D7.L),$7B73(A5)          ; $265634
        MOVE.W  $74(A3,D7.L),$7B75(A5)          ; $26563A
        MOVEQ   #$78,D6                         ; $265640
        MOVEQ   #$7B,D6                         ; $265642
        DC.W    $7D7F,$7E84         ; $265644 MOVE.W  <EA:3F>,$7E84(A6)
        MOVE.W  A0,-$74(A7,A0.W)                ; $265648
        OR.L   A7,D0                            ; $26564C
        OR.L   D0,(A0)                          ; $26564E
        OR.L   D0,(A1)                          ; $265650
        OR.L   D0,A7                            ; $265652
        OR.L   D0,A5                            ; $265654
        OR.L   D0,A2                            ; $265656
        OR.L   D0,D7                            ; $265658
        OR.L   D0,D3                            ; $26565A
        OR.L   D0,D0                            ; $26565C
        DC.W    $807D               ; $26565E OR.W   <EA:3D>,D0
        OR.W   #$807D,D0                        ; $265660
        DC.W    $807E               ; $265664 OR.W   <EA:3E>,D0
        OR.L   D0,D0                            ; $265666
        OR.L   D0,D2                            ; $265668
        OR.L   D0,D4                            ; $26566A
        OR.L   D0,D7                            ; $26566C
        OR.L   D0,A1                            ; $26566E
        OR.L   D0,A4                            ; $265670
        OR.L   D0,A6                            ; $265672
        OR.L   D0,A7                            ; $265674
        OR.L   A7,D1                            ; $265676
        OR.L   A7,D1                            ; $265678
        OR.L   A6,D1                            ; $26567A
        OR.L   D1,A5                            ; $26567C
        OR.L   D1,A3                            ; $26567E
        OR.L   A0,D1                            ; $265680
        OR.L   D4,D1                            ; $265682
        OR.L   D0,D0                            ; $265684
        DC.W    $807D               ; $265686 OR.W   <EA:3D>,D0
        MOVE.W  $7E79(PC),$7E78(A7)             ; $265688
        MOVE.W  $7D79.W,$7D79(A6)               ; $26568E
        MOVEQ   #$79,D6                         ; $265694
        MOVEQ   #$78,D6                         ; $265696
        MOVE.W  $73(A6,D7.L),$7A70(A5)          ; $265698
        MOVEQ   #$6E,D5                         ; $26569E
        MOVEQ   #$6C,D5                         ; $2656A0
        MOVE.W  $7C69(A2),$7C68(A5)             ; $2656A2
        MOVE.W  $7D69(A0),$7E6B(A6)             ; $2656A8
        MOVEQ   #$6D,D7                         ; $2656AE
        MOVE.W  $73(A0,A0.W),-$7F89(A7)         ; $2656B0
        OR.W   $8179.W,D0                       ; $2656B6
        OR.W   D0,$817A817B                     ; $2656BA
        OR.W   D0,#$817E                        ; $2656C0
        OR.L   D0,D0                            ; $2656C4
        OR.L   D0,D2                            ; $2656C6
        OR.L   D0,D5                            ; $2656C8
        OR.L   D0,D6                            ; $2656CA
        OR.L   D0,D6                            ; $2656CC
        OR.L   D0,D7                            ; $2656CE
        OR.L   D7,D1                            ; $2656D0
        OR.L   D1,A0                            ; $2656D2
        OR.L   D1,A1                            ; $2656D4
        OR.L   D1,A1                            ; $2656D6
        OR.L   D1,A1                            ; $2656D8
        OR.L   D1,A1                            ; $2656DA
        OR.L   D1,A0                            ; $2656DC
        OR.L   D7,D1                            ; $2656DE
        OR.L   D0,D4                            ; $2656E0
        OR.L   D0,D1                            ; $2656E2
        DC.W    $807E               ; $2656E4 OR.W   <EA:3E>,D0
        OR.W   $7F77(PC),D0                     ; $2656E6
        MOVEQ   #$74,D7                         ; $2656EA
        MOVEQ   #$72,D7                         ; $2656EC
        MOVE.W  $7C6E(A7),$7C6C(A6)             ; $2656EE
        MOVE.W  $7B6B(A3),$7B6D(A5)             ; $2656F4
        MOVE.W  $7B71(A7),$7B73(A5)             ; $2656FA
        MOVEQ   #$74,D6                         ; $265700
        MOVEQ   #$74,D6                         ; $265702
        MOVEQ   #$75,D6                         ; $265704
        MOVE.W  $75(A4,D7.L),$7D75(A6)          ; $265706
        MOVE.W  $76(A6,D7.L),$7E78(A6)          ; $26570C
        MOVE.W  -$7F84(PC),-$7F82(A7)           ; $265712
        OR.L   D0,D0                            ; $265718
        OR.L   D3,D0                            ; $26571A
        OR.L   D0,D5                            ; $26571C
        OR.L   D0,A0                            ; $26571E
        OR.L   A3,D1                            ; $265720
        OR.L   A6,D1                            ; $265722
        OR.L   D1,(A1)                          ; $265724
        OR.L   D1,(A3)                          ; $265726
        OR.L   (A5),D2                          ; $265728
        OR.L   (A6),D2                          ; $26572A
        OR.L   D1,(A7)                          ; $26572C
        OR.L   D1,(A6)                          ; $26572E
        OR.L   D1,(A5)                          ; $265730
        OR.L   (A3),D1                          ; $265732
        OR.L   (A0),D1                          ; $265734
        OR.L   D0,A5                            ; $265736
        OR.L   A2,D0                            ; $265738
        OR.L   D7,D0                            ; $26573A
        OR.L   D5,D0                            ; $26573C
        OR.L   D4,D0                            ; $26573E
        OR.L   D4,D0                            ; $265740
        MOVE.W  D4,-$7A(A7,D7.L)                ; $265742
        MOVE.W  D7,-$78(A7,D7.L)                ; $265746
        MOVEQ   #-$78,D7                        ; $26574A
        MOVEQ   #-$79,D7                        ; $26574C
        MOVE.W  D5,-$7C(A6,D7.L)                ; $26574E
        MOVE.W  D3,-$7F(A6,D7.L)                ; $265752
        DC.W    $7D7F,$7D7D         ; $265756 MOVE.W  <EA:3F>,$7D7D(A6)
        MOVE.W  $7D78(PC),$7D77(A6)             ; $26575A
        MOVE.W  $77(A7,D7.L),$7D77(A6)          ; $265760
        MOVE.W  $7D79.W,$7D7A(A6)               ; $265766
        MOVE.W  $7C(PC,D7.L),$7D7D(A6)          ; $26576C
        MOVEQ   #$7E,D7                         ; $265772
        DC.W    $7F7F,$8080         ; $265774 MOVE.W  <EA:3F>,-$7F80(A7)
        OR.L   D0,D1                            ; $265778
        OR.L   D0,D1                            ; $26577A
        OR.L   D0,D1                            ; $26577C
        DC.W    $827F               ; $26577E OR.W   <EA:3F>,D1
        DC.W    $827D               ; $265780 OR.W   <EA:3D>,D1
        OR.W   D1,-$7C89(PC)                    ; $265782
        OR.W   D1,$74(A5,A0.W)                  ; $265786
        OR.W   D1,$74(A3,A0.W)                  ; $26578A
        OR.W   D1,$77(A5,A0.W)                  ; $26578E
        OR.W   $817A817A,D1                     ; $265792
        OR.W   D0,-$7E86(PC)                    ; $265798
        OR.W   -$7F85(PC),D0                    ; $26579C
        OR.W   $7B(PC,A0.W),D0                  ; $2657A0
        OR.W   $7A(PC,D7.L),D0                  ; $2657A4
        MOVEQ   #$79,D7                         ; $2657A8
        MOVEQ   #$78,D7                         ; $2657AA
        MOVEQ   #$76,D7                         ; $2657AC
        MOVE.W  $72(A4,D7.L),$7D70(A6)          ; $2657AE
        MOVE.W  $7D6B(A6),$7C69(A6)             ; $2657B4
        MOVEQ   #$68,D6                         ; $2657BA
        MOVEQ   #$66,D6                         ; $2657BC
        MOVEQ   #$66,D6                         ; $2657BE
        MOVEQ   #$67,D6                         ; $2657C0
        MOVEQ   #$68,D6                         ; $2657C2
        MOVEQ   #$6A,D6                         ; $2657C4
        MOVEQ   #$6C,D6                         ; $2657C6
        MOVEQ   #$6F,D6                         ; $2657C8
        MOVEQ   #$70,D6                         ; $2657CA
        MOVE.W  $72(A1,D7.L),$7C73(A5)          ; $2657CC
        MOVEQ   #$75,D6                         ; $2657D2
        MOVE.W  $7A(A7,D7.L),$7F7E(A6)          ; $2657D4
        OR.L   D2,D0                            ; $2657DA
        OR.L   D0,D6                            ; $2657DC
        OR.L   A1,D1                            ; $2657DE
        OR.L   A2,D1                            ; $2657E0
        OR.L   A1,D1                            ; $2657E2
        OR.L   A1,D1                            ; $2657E4
        OR.L   A1,D1                            ; $2657E6
        OR.L   A1,D1                            ; $2657E8
        OR.L   D1,A1                            ; $2657EA
        OR.L   A2,D2                            ; $2657EC
        OR.L   A3,D2                            ; $2657EE
        OR.L   A3,D2                            ; $2657F0
        OR.L   A3,D2                            ; $2657F2
        OR.L   D1,A3                            ; $2657F4
        OR.L   A2,D1                            ; $2657F6
        OR.L   A2,D1                            ; $2657F8
        OR.L   A3,D1                            ; $2657FA
        OR.L   D0,A5                            ; $2657FC
        OR.L   D0,A7                            ; $2657FE
        OR.L   D0,(A2)                          ; $265800
        OR.L   D0,(A4)                          ; $265802
        OR.L   D0,(A5)                          ; $265804
        OR.L   (A4),D0                          ; $265806
        MOVE.W  (A0),-$74(A7,D7.L)              ; $265808
        MOVEQ   #-$79,D6                        ; $26580C
        MOVEQ   #-$7E,D6                        ; $26580E
        DC.W    $7B7E,$7B7A         ; $265810 MOVE.W  <EA:3E>,$7B7A(A5)
        MOVE.W  $74(A6,D7.L),$7B72(A5)          ; $265814
        MOVE.W  $70(A1,D7.L),$7C72(A5)          ; $26581A
        MOVEQ   #$75,D6                         ; $265820
        DC.W    $7D79,$7D7C,$7D7F,$7D81; $265822 MOVE.W  $7D7C7D7F,$7D81(A6)
        MOVE.W  D1,-$7E(A6,D7.L)                ; $26582A
        MOVE.W  D1,-$7F(A6,D7.L)                ; $26582E
        MOVEQ   #-$7F,D7                        ; $265832
        MOVEQ   #-$7E,D7                        ; $265834
        MOVE.W  D3,-$7C(A7,D7.L)                ; $265836
        OR.L   D6,D0                            ; $26583A
        OR.L   D7,D0                            ; $26583C
        OR.L   D0,A1                            ; $26583E
        OR.L   A2,D1                            ; $265840
        OR.L   A4,D1                            ; $265842
        OR.L   D1,A5                            ; $265844
        OR.L   D1,A7                            ; $265846
        OR.L   (A1),D2                          ; $265848
        OR.L   (A2),D2                          ; $26584A
        OR.L   (A3),D2                          ; $26584C
        OR.L   (A2),D2                          ; $26584E
        OR.L   D1,A7                            ; $265850
        OR.L   A4,D1                            ; $265852
        OR.L   A1,D1                            ; $265854
        OR.L   D0,D6                            ; $265856
        OR.L   D0,D4                            ; $265858
        OR.L   D0,D2                            ; $26585A
        DC.W    $807F               ; $26585C OR.W   <EA:3F>,D0
        OR.W   #$7F78,D0                        ; $26585E
        MOVE.W  $6F(A3,D7.L),$7F6B(A7)          ; $265862
        MOVE.W  $7E68(A1),$7E68(A7)             ; $265868
        MOVE.W  $7D6A(A1),$7D6C(A6)             ; $26586E
        MOVE.W  $7D70(A6),$7D70(A6)             ; $265874
        MOVE.W  $7C6E(A7),$7C6C(A6)             ; $26587A
        MOVEQ   #$6B,D6                         ; $265880
        MOVEQ   #$6A,D6                         ; $265882
        MOVEQ   #$68,D6                         ; $265884
        MOVEQ   #$67,D6                         ; $265886
        MOVEQ   #$66,D6                         ; $265888
        MOVEQ   #$66,D6                         ; $26588A
        MOVEQ   #$67,D6                         ; $26588C
        MOVE.W  $7D6C(A1),$7E70(A6)             ; $26588E
        MOVEQ   #$73,D7                         ; $265894
        MOVEQ   #$76,D7                         ; $265896
        MOVEQ   #$7A,D7                         ; $265898
        DC.W    $7F7D,$8080         ; $26589A MOVE.W  <EA:3D>,-$7F80(A7)
        OR.L   D2,D0                            ; $26589E
        OR.L   D0,D4                            ; $2658A0
        OR.L   D5,D1                            ; $2658A2
        OR.L   D1,D7                            ; $2658A4
        OR.L   A1,D2                            ; $2658A6
        OR.L   A3,D2                            ; $2658A8
        OR.L   A3,D2                            ; $2658AA
        OR.L   A3,D2                            ; $2658AC
        OR.L   D1,A1                            ; $2658AE
        OR.L   D1,A0                            ; $2658B0
        OR.L   D7,D1                            ; $2658B2
        OR.L   A0,D1                            ; $2658B4
        OR.L   D0,A0                            ; $2658B6
        OR.L   D0,A0                            ; $2658B8
        OR.L   D0,A1                            ; $2658BA
        OR.L   D0,A1                            ; $2658BC
        OR.L   D0,A0                            ; $2658BE
        OR.L   D6,D0                            ; $2658C0
        MOVE.W  D3,-$80(A7,D7.L)                ; $2658C2
        DC.W    $7D7D,$7D7A         ; $2658C6 MOVE.W  <EA:3D>,$7D7A(A6)
        MOVE.W  $75(A7,D7.L),$7E74(A6)          ; $2658CA
        MOVEQ   #$73,D7                         ; $2658D0
        MOVEQ   #$73,D7                         ; $2658D2
        MOVEQ   #$72,D7                         ; $2658D4
        MOVE.W  $74(A3,D7.L),$7C77(A6)          ; $2658D6
        MOVEQ   #$7A,D6                         ; $2658DC
        MOVEQ   #$7D,D6                         ; $2658DE
        MOVEQ   #$7F,D6                         ; $2658E0
        MOVE.W  D1,-$7F(A5,D7.L)                ; $2658E2
        DC.W    $7B7F,$7B7E         ; $2658E6 MOVE.W  <EA:3F>,$7B7E(A5)
        MOVE.W  #$7C7C,$7D7C(A5)                ; $2658EA
        MOVE.W  #$7E7C,$7F7D(A6)                ; $2658F0
        DC.W    $807F               ; $2658F6 OR.W   <EA:3F>,D0
        OR.L   D1,D0                            ; $2658F8
        OR.L   D0,D4                            ; $2658FA
        OR.L   A1,D1                            ; $2658FC
        OR.L   A6,D1                            ; $2658FE
        OR.L   (A2),D1                          ; $265900
        OR.L   D1,(A6)                          ; $265902
        OR.L   (A1)+,D2                         ; $265904
        OR.L   D2,(A2)+                         ; $265906
        OR.L   D2,(A2)+                         ; $265908
        OR.L   D2,(A1)+                         ; $26590A
        OR.L   D2,(A6)                          ; $26590C
        OR.L   D2,(A4)                          ; $26590E
        OR.L   (A2),D2                          ; $265910
        OR.L   (A0),D2                          ; $265912
        OR.L   D1,A6                            ; $265914
        OR.L   A4,D1                            ; $265916
        OR.L   D0,A0                            ; $265918
        OR.L   D0,D5                            ; $26591A
        OR.L   D1,D0                            ; $26591C
        DC.W    $807E               ; $26591E OR.W   <EA:3E>,D0
        DC.W    $807D               ; $265920 OR.W   <EA:3D>,D0
        DC.W    $807D               ; $265922 OR.W   <EA:3D>,D0
        DC.W    $7F7D,$7E7D         ; $265924 MOVE.W  <EA:3D>,$7E7D(A7)
        MOVEQ   #$7D,D7                         ; $265928
        MOVE.W  #$7D7A,$7D78(A6)                ; $26592A
        MOVE.W  $72(A5,D7.L),$7E6F(A6)          ; $265930
        MOVEQ   #$6D,D7                         ; $265936
        MOVEQ   #$6C,D7                         ; $265938
        MOVEQ   #$6A,D7                         ; $26593A
        MOVE.W  $7C67(A1),$7C66(A6)             ; $26593C
        MOVE.W  -(A5),$7B65(A5)                 ; $265942
        MOVE.W  -(A7),$7B69(A5)                 ; $265946
        MOVE.W  $7C6F(A4),$7C71(A5)             ; $26594A
        MOVE.W  $77(A4,D7.L),$7F79(A6)          ; $265950
        OR.W   #$817E,D0                        ; $265956
        OR.L   D0,D0                            ; $26595A
        OR.L   D0,D1                            ; $26595C
        OR.L   D3,D1                            ; $26595E
        OR.L   D4,D1                            ; $265960
        OR.L   D4,D1                            ; $265962
        OR.L   D1,D4                            ; $265964
        OR.L   D1,D3                            ; $265966
        OR.L   D1,D3                            ; $265968
        OR.L   D3,D2                            ; $26596A
        OR.L   D4,D2                            ; $26596C
        OR.L   D1,D5                            ; $26596E
        OR.L   D6,D1                            ; $265970
        OR.L   D7,D1                            ; $265972
        OR.L   D1,A0                            ; $265974
        OR.L   D7,D1                            ; $265976
        OR.L   D0,D5                            ; $265978
        OR.L   D0,D2                            ; $26597A
        OR.L   D0,D0                            ; $26597C
        DC.W    $807D               ; $26597E OR.W   <EA:3D>,D0
        MOVE.W  $78(PC,D7.L),$7E75(A7)          ; $265980
        MOVEQ   #$73,D7                         ; $265986
        MOVE.W  $71(A2,D7.L),$7C71(A6)          ; $265988
        MOVEQ   #$72,D6                         ; $26598E
        MOVEQ   #$73,D6                         ; $265990
        MOVE.W  $76(A5,D7.L),$7D76(A6)          ; $265992
        MOVE.W  $75(A6,D7.L),$7D74(A6)          ; $265998
        MOVE.W  $71(A3,D7.L),$7D70(A6)          ; $26599E
        MOVE.W  $70(A0,D7.L),$7C71(A6)          ; $2659A4
        MOVEQ   #$72,D6                         ; $2659AA
        MOVEQ   #$75,D6                         ; $2659AC
        MOVEQ   #$78,D6                         ; $2659AE
        MOVE.W  #$7D80,$7E84(A6)                ; $2659B0
        MOVE.W  D7,-$77(A7,A0.W)                ; $2659B6
        OR.L   D0,A3                            ; $2659BA
        OR.L   A6,D1                            ; $2659BC
        OR.L   D1,(A1)                          ; $2659BE
        OR.L   (A3),D2                          ; $2659C0
        OR.L   (A5),D2                          ; $2659C2
        OR.L   (A5),D2                          ; $2659C4
        OR.L   (A5),D2                          ; $2659C6
        OR.L   (A5),D2                          ; $2659C8
        OR.L   (A4),D2                          ; $2659CA
        OR.L   (A2),D2                          ; $2659CC
        OR.L   (A0),D2                          ; $2659CE
        OR.L   A6,D2                            ; $2659D0
        OR.L   A3,D2                            ; $2659D2
        OR.L   A1,D2                            ; $2659D4
        OR.L   D1,D6                            ; $2659D6
        OR.L   D2,D1                            ; $2659D8
        OR.L   D0,D0                            ; $2659DA
        DC.W    $7F7F,$7F7F         ; $2659DC MOVE.W  <EA:3F>,$7F7F(A7)
        MOVEQ   #-$80,D7                        ; $2659E0
        MOVEQ   #-$7F,D7                        ; $2659E2
        MOVEQ   #-$7E,D7                        ; $2659E4
        MOVEQ   #-$7F,D7                        ; $2659E6
        MOVE.W  D0,$7E(A6,D7.L)                 ; $2659E8
        DC.W    $7D7D,$7E7C         ; $2659EC MOVE.W  <EA:3D>,$7E7C(A6)
        MOVE.W  $7A(PC,D7.L),$7E79(A6)          ; $2659F0
        MOVEQ   #$78,D7                         ; $2659F6
        MOVE.W  $77(A7,D7.L),$7C77(A6)          ; $2659F8
        MOVEQ   #$78,D6                         ; $2659FE
        MOVEQ   #$79,D6                         ; $265A00
        MOVEQ   #$7A,D6                         ; $265A02
        MOVEQ   #$7C,D6                         ; $265A04
        MOVEQ   #$7E,D6                         ; $265A06
        MOVEQ   #$7F,D6                         ; $265A08
        MOVE.W  D0,-$7F(A6,D7.L)                ; $265A0A
        MOVE.W  D1,-$80(A6,D7.L)                ; $265A0E
        DC.W    $7D7E,$7D7B         ; $265A12 MOVE.W  <EA:3E>,$7D7B(A6)
        DC.W    $7D79,$7D77,$7E76,$7F76; $265A16 MOVE.W  $7D777E76,$7F76(A6)
        OR.W   $77(A6,A0.W),D0                  ; $265A1E
        OR.W   D1,$847B847E                     ; $265A22
        OR.L   D2,D1                            ; $265A28
        OR.L   D2,D4                            ; $265A2A
        OR.L   D5,D2                            ; $265A2C
        OR.L   D6,D2                            ; $265A2E
        OR.L   D1,D7                            ; $265A30
        OR.L   D7,D2                            ; $265A32
        OR.L   D7,D2                            ; $265A34
        OR.L   D6,D2                            ; $265A36
        OR.L   D1,D4                            ; $265A38
        OR.L   D0,D0                            ; $265A3A
        OR.W   #$7F78,D0                        ; $265A3C
        MOVEQ   #$74,D7                         ; $265A40
        MOVEQ   #$71,D7                         ; $265A42
        MOVEQ   #$6E,D7                         ; $265A44
        MOVEQ   #$6E,D7                         ; $265A46
        MOVEQ   #$6E,D7                         ; $265A48
        MOVEQ   #$6F,D7                         ; $265A4A
        MOVE.W  $71(A0,D7.L),$7E72(A6)          ; $265A4C
        MOVEQ   #$72,D7                         ; $265A52
        MOVEQ   #$72,D7                         ; $265A54
        MOVEQ   #$72,D7                         ; $265A56
        MOVEQ   #$73,D7                         ; $265A58
        MOVEQ   #$74,D7                         ; $265A5A
        MOVEQ   #$75,D7                         ; $265A5C
        MOVE.W  $76(A6,D7.L),$7C76(A6)          ; $265A5E
        MOVE.W  $76(A6,D7.L),$7B76(A5)          ; $265A64
        MOVE.W  $76(A6,D7.L),$7C78(A5)          ; $265A6A
        MOVE.W  $7D7D(PC),$7E80(A6)             ; $265A70
        MOVEQ   #-$7F,D7                        ; $265A76
        MOVEQ   #-$7E,D7                        ; $265A78
        MOVE.W  D2,-$7F(A7,A0.W)                ; $265A7A
        DC.W    $817F               ; $265A7E OR.W   D0,<EA:3F>
        DC.W    $827E               ; $265A80 OR.W   <EA:3E>,D1
        DC.W    $837D               ; $265A82 OR.W   D1,<EA:3D>
        DC.W    $847E               ; $265A84 OR.W   <EA:3E>,D2
        DC.W    $857F               ; $265A86 OR.W   D2,<EA:3F>
        OR.L   D2,D1                            ; $265A88
        OR.L   D2,D3                            ; $265A8A
        OR.L   D2,D5                            ; $265A8C
        OR.L   D2,D5                            ; $265A8E
        OR.L   D1,D5                            ; $265A90
        OR.L   D1,D4                            ; $265A92
        OR.L   D1,D4                            ; $265A94
        OR.L   D4,D1                            ; $265A96
        OR.L   D5,D1                            ; $265A98
        OR.L   D0,D5                            ; $265A9A
        OR.L   D0,D5                            ; $265A9C
        OR.L   D5,D0                            ; $265A9E
        MOVE.W  D3,-$7E(A7,D7.L)                ; $265AA0
        MOVEQ   #-$80,D7                        ; $265AA4
        MOVEQ   #$7F,D7                         ; $265AA6
        MOVEQ   #$7E,D7                         ; $265AA8
        MOVEQ   #$7D,D7                         ; $265AAA
        DC.W    $7D7D,$7D7D         ; $265AAC MOVE.W  <EA:3D>,$7D7D(A6)
        MOVE.W  #$7D7B,$7D7B(A6)                ; $265AB0
        MOVE.W  $7C(PC,D7.L),$7C7D(A6)          ; $265AB6
        MOVEQ   #$7F,D6                         ; $265ABC
        MOVEQ   #-$7E,D6                        ; $265ABE
        MOVE.W  D5,-$79(A6,D7.L)                ; $265AC0
        MOVE.W  A0,-$79(A6,D7.L)                ; $265AC4
        MOVEQ   #-$7A,D6                        ; $265AC8
        MOVEQ   #-$7B,D6                        ; $265ACA
        MOVEQ   #-$7C,D6                        ; $265ACC
        MOVE.W  D3,-$7E(A6,D7.L)                ; $265ACE
        MOVE.W  D2,-$7D(A6,D7.L)                ; $265AD2
        MOVEQ   #-$7B,D7                        ; $265AD6
        MOVEQ   #-$7A,D7                        ; $265AD8
        MOVE.W  D7,-$79(A7,D7.L)                ; $265ADA
        OR.L   A0,D0                            ; $265ADE
        OR.L   D0,A2                            ; $265AE0
        OR.L   D0,A4                            ; $265AE2
        OR.L   A6,D1                            ; $265AE4
        OR.L   (A0),D1                          ; $265AE6
        OR.L   D1,(A1)                          ; $265AE8
        OR.L   D1,(A1)                          ; $265AEA
        OR.L   D1,(A0)                          ; $265AEC
        OR.L   D1,A5                            ; $265AEE
        OR.L   D1,A0                            ; $265AF0
        OR.L   D1,D4                            ; $265AF2
        OR.L   D1,D0                            ; $265AF4
        OR.W   D1,#$8379                        ; $265AF6
        OR.W   D1,$73(A6,A0.W)                  ; $265AFA
        OR.W   D0,$71(A2,A0.W)                  ; $265AFE
        MOVE.W  $70(A1,D7.L),$7E70(A7)          ; $265B02
        MOVE.W  $7D6F(A7),$7E6F(A6)             ; $265B08
        MOVEQ   #$6F,D7                         ; $265B0E
        MOVEQ   #$6F,D7                         ; $265B10
        MOVE.W  $7D6E(A7),$7C6E(A6)             ; $265B12
        MOVEQ   #$6D,D6                         ; $265B18
        MOVEQ   #$6D,D6                         ; $265B1A
        MOVEQ   #$6D,D6                         ; $265B1C
        MOVE.W  $7D70(A6),$7E71(A6)             ; $265B1E
        MOVEQ   #$72,D7                         ; $265B24
        MOVEQ   #$73,D7                         ; $265B26
        MOVEQ   #$75,D7                         ; $265B28
        MOVEQ   #$76,D7                         ; $265B2A
        MOVEQ   #$79,D7                         ; $265B2C
        MOVEQ   #$7B,D7                         ; $265B2E
        MOVEQ   #$7E,D7                         ; $265B30
        MOVEQ   #-$7F,D7                        ; $265B32
        MOVE.W  D4,-$79(A7,D7.L)                ; $265B34
        MOVE.W  D7,-$79(A7,D7.L)                ; $265B38
        MOVE.W  D6,-$7B(A7,A0.W)                ; $265B3C
        OR.L   D5,D0                            ; $265B40
        OR.L   D0,D4                            ; $265B42
        OR.L   D0,D3                            ; $265B44
        OR.L   D3,D1                            ; $265B46
        OR.L   D3,D1                            ; $265B48
        OR.L   D3,D1                            ; $265B4A
        OR.L   D2,D1                            ; $265B4C
        OR.L   D0,D0                            ; $265B4E
        DC.W    $817E               ; $265B50 OR.W   D0,<EA:3E>
        DC.W    $817D               ; $265B52 OR.W   D0,<EA:3D>
        OR.W   D0,$79(PC,A0.W)                  ; $265B54
        OR.W   $75(A6,A0.W),D1                  ; $265B58
        OR.W   $73(A4,A0.W),D1                  ; $265B5C
        OR.W   $73(A3,A0.W),D0                  ; $265B60
        OR.W   $75(A4,D7.L),D0                  ; $265B64
        MOVE.W  $77(A6,D7.L),$7E78(A7)          ; $265B68
        MOVEQ   #$79,D7                         ; $265B6E
        MOVEQ   #$7A,D7                         ; $265B70
        MOVEQ   #$7A,D7                         ; $265B72
        MOVE.W  $7C(PC,D7.L),$7E7D(A7)          ; $265B74
        MOVEQ   #$7E,D7                         ; $265B7A
        MOVEQ   #-$80,D7                        ; $265B7C
        MOVEQ   #-$7E,D7                        ; $265B7E
        MOVEQ   #-$7D,D7                        ; $265B80
        MOVEQ   #-$7C,D7                        ; $265B82
        MOVEQ   #-$7C,D7                        ; $265B84
        MOVEQ   #-$7D,D7                        ; $265B86
        MOVEQ   #-$7D,D7                        ; $265B88
        MOVEQ   #-$7E,D7                        ; $265B8A
        MOVEQ   #-$7D,D7                        ; $265B8C
        MOVEQ   #-$7C,D7                        ; $265B8E
        MOVE.W  D5,-$7A(A7,D7.L)                ; $265B90
        MOVE.W  D7,-$79(A7,A0.W)                ; $265B94
        MOVE.W  D7,-$78(A7,D7.L)                ; $265B98
        MOVE.W  A0,-$77(A7,D7.L)                ; $265B9C
        MOVE.W  A2,-$76(A7,D7.L)                ; $265BA0
        OR.L   A3,D0                            ; $265BA4
        OR.L   A3,D0                            ; $265BA6
        OR.L   D0,A3                            ; $265BA8
        OR.L   A3,D1                            ; $265BAA
        OR.L   D1,A2                            ; $265BAC
        OR.L   D1,A1                            ; $265BAE
        OR.L   A0,D1                            ; $265BB0
        OR.L   D0,D6                            ; $265BB2
        OR.L   D0,D3                            ; $265BB4
        OR.L   D0,D0                            ; $265BB6
        DC.W    $807E               ; $265BB8 OR.W   <EA:3E>,D0
        DC.W    $807D               ; $265BBA OR.W   <EA:3D>,D0
        DC.W    $817E               ; $265BBC OR.W   D0,<EA:3E>
        DC.W    $817F               ; $265BBE OR.W   D0,<EA:3F>
        OR.L   D0,D0                            ; $265BC0
        OR.L   D1,D0                            ; $265BC2
        OR.L   D3,D0                            ; $265BC4
        OR.L   D4,D0                            ; $265BC6
        MOVE.W  D5,-$7D(A7,D7.L)                ; $265BC8
        MOVEQ   #-$80,D7                        ; $265BCC
        MOVEQ   #$7D,D7                         ; $265BCE
        MOVEQ   #$7A,D7                         ; $265BD0
        MOVEQ   #$76,D7                         ; $265BD2
        MOVEQ   #$73,D7                         ; $265BD4
        MOVE.W  $6F(A1,D7.L),$7C6D(A6)          ; $265BD6
        MOVEQ   #$6C,D6                         ; $265BDC
        MOVE.W  $7D6D(A4),$7D6E(A6)             ; $265BDE
        MOVEQ   #$70,D7                         ; $265BE4
        MOVEQ   #$73,D7                         ; $265BE6
        MOVE.W  $77(A5,D7.L),$7F79(A7)          ; $265BE8
        OR.W   -$7E85(PC),D0                    ; $265BEE
        OR.W   $7A(PC,A0.W),D0                  ; $265BF2
        OR.W   $8079807A,D0                     ; $265BF6
        DC.W    $807D               ; $265BFC OR.W   <EA:3D>,D0
        DC.W    $807F               ; $265BFE OR.W   <EA:3F>,D0
        OR.L   D0,D2                            ; $265C00
        OR.L   D0,D4                            ; $265C02
        OR.L   D5,D0                            ; $265C04
        OR.L   D5,D0                            ; $265C06
        OR.L   D4,D0                            ; $265C08
        OR.L   D2,D0                            ; $265C0A
        DC.W    $807F               ; $265C0C OR.W   <EA:3F>,D0
        DC.W    $817E               ; $265C0E OR.W   D0,<EA:3E>
        DC.W    $817D               ; $265C10 OR.W   D0,<EA:3D>
        OR.W   D0,$7A(PC,A0.W)                  ; $265C12
        OR.W   D0,$81788077                     ; $265C16
        OR.W   $74(A6,A0.W),D0                  ; $265C1C
        OR.W   $71(A3,A0.W),D0                  ; $265C20
        OR.W   $6F(A0,D7.L),D0                  ; $265C24
        MOVEQ   #$6E,D7                         ; $265C28
        MOVEQ   #$6E,D7                         ; $265C2A
        MOVEQ   #$6F,D7                         ; $265C2C
        MOVE.W  $73(A0,D7.L),$7E76(A6)          ; $265C2E
        MOVEQ   #$7A,D7                         ; $265C34
        MOVEQ   #$7C,D7                         ; $265C36
        DC.W    $7D7E,$7D7E         ; $265C38 MOVE.W  <EA:3E>,$7D7E(A6)
        MOVEQ   #$7F,D6                         ; $265C3C
        MOVEQ   #$7E,D6                         ; $265C3E
        MOVEQ   #$7E,D6                         ; $265C40
        MOVEQ   #$7E,D6                         ; $265C42
        DC.W    $7D7E,$7E7F         ; $265C44 MOVE.W  <EA:3E>,$7E7F(A6)
        MOVEQ   #-$80,D7                        ; $265C48
        MOVEQ   #-$7F,D7                        ; $265C4A
        MOVE.W  D3,-$7B(A7,D7.L)                ; $265C4C
        MOVE.W  D6,-$79(A7,D7.L)                ; $265C50
        MOVE.W  A0,-$77(A7,A0.W)                ; $265C54
        OR.L   A3,D0                            ; $265C58
        OR.L   D0,A5                            ; $265C5A
        OR.L   D0,(A0)                          ; $265C5C
        OR.L   (A2),D1                          ; $265C5E
        OR.L   (A3),D1                          ; $265C60
        OR.L   D0,(A2)                          ; $265C62
        OR.L   (A1),D1                          ; $265C64
        OR.L   D0,(A0)                          ; $265C66
        OR.L   D0,A7                            ; $265C68
        OR.L   A5,D1                            ; $265C6A
        OR.L   A3,D1                            ; $265C6C
        OR.L   A2,D1                            ; $265C6E
        OR.L   A1,D1                            ; $265C70
        OR.L   D0,A0                            ; $265C72
        OR.L   D0,D7                            ; $265C74
        OR.L   D0,D5                            ; $265C76
        OR.L   D0,D4                            ; $265C78
        OR.L   D0,D2                            ; $265C7A
        OR.L   D1,D0                            ; $265C7C
        OR.L   D0,D0                            ; $265C7E
        DC.W    $807F               ; $265C80 OR.W   <EA:3F>,D0
        DC.W    $807D               ; $265C82 OR.W   <EA:3D>,D0
        MOVE.W  $78(PC,D7.L),$7E75(A7)          ; $265C84
        MOVE.W  $71(A3,D7.L),$7D70(A6)          ; $265C8A
        MOVEQ   #$70,D7                         ; $265C90
        MOVEQ   #$70,D7                         ; $265C92
        MOVE.W  $73(A1,D7.L),$7E75(A6)          ; $265C94
        MOVEQ   #$77,D7                         ; $265C9A
        DC.W    $7D79,$7D7B,$7E7E,$7E80; $265C9C MOVE.W  $7D7B7E7E,$7E80(A6)
        MOVE.W  D1,-$7E(A6,D7.L)                ; $265CA4
        MOVEQ   #-$7C,D7                        ; $265CA8
        MOVEQ   #-$7C,D7                        ; $265CAA
        MOVEQ   #-$7D,D7                        ; $265CAC
        MOVEQ   #-$7F,D7                        ; $265CAE
        MOVEQ   #$7F,D7                         ; $265CB0
        MOVEQ   #$7C,D7                         ; $265CB2
        MOVEQ   #$79,D7                         ; $265CB4
        MOVE.W  $75(A6,A0.W),-$7E8C(A7)         ; $265CB6
        OR.W   D0,$73(A4,A0.W)                  ; $265CBC
        OR.W   D0,$72(A3,A0.W)                  ; $265CC0
        OR.W   D0,$72(A2,A0.W)                  ; $265CC4
        OR.W   $76(A4,A0.W),D0                  ; $265CC8
        OR.W   $807A.W,D0                       ; $265CCC
        OR.W   #$7F7E,D0                        ; $265CD0
        DC.W    $7F7F,$7F7F         ; $265CD4 MOVE.W  <EA:3F>,$7F7F(A7)
        DC.W    $7F7F,$7F7F         ; $265CD8 MOVE.W  <EA:3F>,$7F7F(A7)
        DC.W    $7F7E,$807D         ; $265CDC MOVE.W  <EA:3E>,-$7F83(A7)
        OR.W   #$807B,D0                        ; $265CE0
        OR.W   $7F7A(PC),D0                     ; $265CE4
        OR.W   -$7F87(PC),D0                    ; $265CE8
        DC.W    $7F79,$7F79,$7E79,$7D7A; $265CEC MOVE.W  $7F797E79,$7D7A(A7)
        MOVEQ   #$7B,D7                         ; $265CF4
        MOVEQ   #$7C,D7                         ; $265CF6
        MOVE.W  #$7D7C,$7D7C(A6)                ; $265CF8
        MOVE.W  #$7D7B,$7E7C(A6)                ; $265CFE
        DC.W    $7F7E,$7F81         ; $265D04 MOVE.W  <EA:3E>,$7F81(A7)
        MOVE.W  D3,-$7D(A7,D7.L)                ; $265D08
        MOVE.W  D3,-$7F(A7,D7.L)                ; $265D0C
        MOVEQ   #$7F,D7                         ; $265D10
        DC.W    $7F7E,$7F7D         ; $265D12 MOVE.W  <EA:3E>,$7F7D(A7)
        MOVE.W  #$7F7B,-$7F86(A7)               ; $265D16
        OR.W   -$7E86(PC),D0                    ; $265D1C
        OR.W   D0,$8077.W                       ; $265D20
        OR.W   D0,$78(A6,A0.W)                  ; $265D24
        OR.W   -$7D84(PC),D1                    ; $265D28
        DC.W    $827F               ; $265D2C OR.W   <EA:3F>,D1
        OR.L   D1,D1                            ; $265D2E
        OR.L   D3,D1                            ; $265D30
        OR.L   D0,D6                            ; $265D32
        OR.L   D7,D1                            ; $265D34
        OR.L   D0,A0                            ; $265D36
        OR.L   A0,D0                            ; $265D38
        MOVE.W  D7,-$7A(A7,D7.L)                ; $265D3A
        MOVE.W  D5,-$7D(A7,D7.L)                ; $265D3E
        MOVE.W  D1,$7E(A7,D7.L)                 ; $265D42
        MOVE.W  $79(PC,D7.L),$7E78(A7)          ; $265D46
        MOVEQ   #$78,D7                         ; $265D4C
        DC.W    $7D79,$7D7B,$7D7C,$7D7E; $265D4E MOVE.W  $7D7B7D7C,$7D7E(A6)
        MOVE.W  D0,-$7E(A6,D7.L)                ; $265D56
        MOVE.W  D3,-$7B(A6,D7.L)                ; $265D5A
        MOVE.W  D6,-$77(A6,D7.L)                ; $265D5E
        MOVEQ   #-$76,D7                        ; $265D62
        MOVE.W  A4,-$74(A7,A0.W)                ; $265D64
        OR.L   A4,D0                            ; $265D68
        OR.L   D0,A3                            ; $265D6A
        OR.L   D0,A2                            ; $265D6C
        OR.L   D0,A2                            ; $265D6E
        OR.L   D0,A1                            ; $265D70
        OR.L   D0,A1                            ; $265D72
        OR.L   D0,A1                            ; $265D74
        OR.L   D0,A1                            ; $265D76
        OR.L   D0,A0                            ; $265D78
        OR.L   D0,D7                            ; $265D7A
        OR.L   D7,D0                            ; $265D7C
        OR.L   D5,D0                            ; $265D7E
        OR.L   D3,D0                            ; $265D80
        OR.L   D0,D2                            ; $265D82
        OR.L   D0,D1                            ; $265D84
        OR.L   D0,D1                            ; $265D86
        DC.W    $827F               ; $265D88 OR.W   <EA:3F>,D1
        DC.W    $827D               ; $265D8A OR.W   <EA:3D>,D1
        OR.W   #$827B,D1                        ; $265D8C
        OR.W   D0,$80788077                     ; $265D90
        OR.W   $75(A6,A0.W),D0                  ; $265D96
        OR.W   $75(A4,D7.L),D0                  ; $265D9A
        MOVE.W  $75(A5,D7.L),$7D74(A7)          ; $265D9E
        MOVE.W  $72(A3,D7.L),$7E72(A6)          ; $265DA4
        MOVEQ   #$73,D7                         ; $265DAA
        MOVEQ   #$73,D7                         ; $265DAC
        MOVEQ   #$74,D7                         ; $265DAE
        MOVE.W  $73(A4,D7.L),$7C72(A6)          ; $265DB0
        MOVEQ   #$70,D6                         ; $265DB6
        MOVEQ   #$6E,D6                         ; $265DB8
        MOVEQ   #$6D,D6                         ; $265DBA
        MOVE.W  $7D6D(A4),$7D6F(A6)             ; $265DBC
        MOVEQ   #$72,D7                         ; $265DC2
        MOVEQ   #$74,D7                         ; $265DC4
        MOVEQ   #$76,D7                         ; $265DC6
        MOVE.W  $78(A7,D7.L),$7E7A(A6)          ; $265DC8
        MOVE.W  #$807E,-$7F80(A7)               ; $265DCE
        OR.L   D1,D0                            ; $265DD4
        OR.L   D0,D2                            ; $265DD6
        OR.L   D2,D0                            ; $265DD8
        OR.L   D1,D0                            ; $265DDA
        DC.W    $807F               ; $265DDC OR.W   <EA:3F>,D0
        DC.W    $807F               ; $265DDE OR.W   <EA:3F>,D0
        OR.L   D0,D0                            ; $265DE0
        OR.L   D2,D0                            ; $265DE2
        OR.L   D0,D4                            ; $265DE4
        OR.L   D0,D5                            ; $265DE6
        OR.L   D0,D5                            ; $265DE8
        OR.L   D0,D5                            ; $265DEA
        OR.L   D0,D5                            ; $265DEC
        OR.L   D0,D5                            ; $265DEE
        OR.L   D5,D1                            ; $265DF0
        OR.L   D6,D1                            ; $265DF2
        OR.L   D6,D1                            ; $265DF4
        OR.L   D5,D1                            ; $265DF6
        OR.L   D0,D4                            ; $265DF8
        OR.L   D0,D2                            ; $265DFA
        OR.L   D0,D0                            ; $265DFC
        DC.W    $7F7D,$7F7B         ; $265DFE MOVE.W  <EA:3D>,$7F7B(A7)
        MOVE.W  $7F79(PC),-$7F86(A7)            ; $265E02
        OR.W   $7F787E75,D0                     ; $265E08
        MOVEQ   #$72,D7                         ; $265E0E
        MOVE.W  $6F(A0,D7.L),$7C6E(A6)          ; $265E10
        MOVEQ   #$6F,D6                         ; $265E16
        MOVEQ   #$72,D6                         ; $265E18
        MOVEQ   #$76,D6                         ; $265E1A
        MOVE.W  $7D7E(PC),$7E81(A6)             ; $265E1C
        MOVEQ   #-$7D,D7                        ; $265E22
        MOVEQ   #-$7B,D7                        ; $265E24
        MOVEQ   #-$7B,D7                        ; $265E26
        MOVEQ   #-$7B,D7                        ; $265E28
        MOVE.W  D5,-$79(A7,D7.L)                ; $265E2A
        OR.L   A2,D0                            ; $265E2E
        OR.L   D0,A5                            ; $265E30
        OR.L   A7,D0                            ; $265E32
        OR.L   (A0),D0                          ; $265E34
        OR.L   (A1),D0                          ; $265E36
        OR.L   (A2),D0                          ; $265E38
        OR.L   (A2),D0                          ; $265E3A
        OR.L   (A2),D0                          ; $265E3C
        OR.L   (A1),D0                          ; $265E3E
        OR.L   (A0),D0                          ; $265E40
        OR.L   (A0),D0                          ; $265E42
        OR.L   A6,D0                            ; $265E44
        OR.L   A3,D0                            ; $265E46
        OR.L   D7,D0                            ; $265E48
        OR.L   D3,D0                            ; $265E4A
        DC.W    $807E               ; $265E4C OR.W   <EA:3E>,D0
        OR.W   -$7E88(PC),D0                    ; $265E4E
        OR.W   D0,$78(A7,A0.W)                  ; $265E52
        OR.W   D0,-$7E84(PC)                    ; $265E56
        DC.W    $817D               ; $265E5A OR.W   D0,<EA:3D>
        DC.W    $817D               ; $265E5C OR.W   D0,<EA:3D>
        OR.W   D0,#$817B                        ; $265E5E
        OR.W   D0,$7B(PC,A0.W)                  ; $265E62
        OR.W   #$807B,D0                        ; $265E66
        OR.W   $7F79(PC),D0                     ; $265E6A
        MOVE.W  $74(A6,D7.L),$7D72(A7)          ; $265E6E
        MOVE.W  $70(A1,D7.L),$7C71(A6)          ; $265E74
        MOVEQ   #$72,D6                         ; $265E7A
        MOVEQ   #$74,D6                         ; $265E7C
        MOVEQ   #$75,D6                         ; $265E7E
        MOVE.W  $76(A6,D7.L),$7D74(A6)          ; $265E80
        MOVE.W  $75(A4,D7.L),-$7F88(A6)         ; $265E86
        OR.W   #$807E,D0                        ; $265E8C
        OR.L   D0,D0                            ; $265E90
        OR.L   D2,D0                            ; $265E92
        OR.L   D0,D4                            ; $265E94
        OR.L   D0,D5                            ; $265E96
        OR.L   D0,D6                            ; $265E98
        OR.L   D0,D7                            ; $265E9A
        OR.L   D0,A0                            ; $265E9C
        OR.L   D0,A0                            ; $265E9E
        OR.L   A0,D0                            ; $265EA0
        OR.L   D7,D0                            ; $265EA2
        OR.L   D5,D0                            ; $265EA4
        MOVE.W  D3,-$7F(A7,D7.L)                ; $265EA6
        DC.W    $7F7F,$7F7E         ; $265EAA MOVE.W  <EA:3F>,$7F7E(A7)
        MOVE.W  #$7F79,$7F77(A7)                ; $265EAE
        MOVE.W  $73(A5,D7.L),-$7F8E(A7)         ; $265EB4
        OR.W   $70(A1,A0.W),D0                  ; $265EBA
        OR.W   D0,$70(A0,A0.W)                  ; $265EBE
        OR.W   D0,$71(A1,A0.W)                  ; $265EC2
        OR.W   $70(A1,A0.W),D1                  ; $265EC6
        OR.W   $71(A0,A0.W),D1                  ; $265ECA
        OR.W   D0,$74(A2,A0.W)                  ; $265ECE
        MOVE.W  $79(A7,D7.L),$7E7B(A7)          ; $265ED2
        MOVE.W  #$7D7B,$7D7B(A6)                ; $265ED8
        MOVE.W  $7C78(PC),$7C77(A6)             ; $265EDE
        MOVEQ   #$76,D6                         ; $265EE4
        MOVE.W  $79(A7,D7.L),$7F7B(A6)          ; $265EE6
        DC.W    $807D               ; $265EEC OR.W   <EA:3D>,D0
        OR.L   D0,D0                            ; $265EEE
        OR.L   D0,D3                            ; $265EF0
        OR.L   D0,D6                            ; $265EF2
        OR.L   D0,A2                            ; $265EF4
        OR.L   A6,D1                            ; $265EF6
        OR.L   (A2),D1                          ; $265EF8
        OR.L   D0,(A6)                          ; $265EFA
        OR.L   D0,(A0)+                         ; $265EFC
        OR.L   D0,(A2)+                         ; $265EFE
        OR.L   (A2)+,D1                         ; $265F00
        OR.L   (A7),D1                          ; $265F02
        OR.L   (A5),D1                          ; $265F04
        OR.L   (A2),D1                          ; $265F06
        OR.L   D0,A7                            ; $265F08
        OR.L   A3,D0                            ; $265F0A
        MOVE.W  A0,-$7B(A7,D7.L)                ; $265F0C
        MOVEQ   #-$7D,D7                        ; $265F10
        MOVE.W  D0,$7D(A6,D7.L)                 ; $265F12
        MOVE.W  $7D78(PC),$7E76(A6)             ; $265F16
        MOVE.W  $75(A6,D7.L),-$7F8B(A7)         ; $265F1C
        OR.W   $78(A7,A0.W),D0                  ; $265F22
        OR.W   $817B817D,D0                     ; $265F26
        DC.W    $827F               ; $265F2C OR.W   <EA:3F>,D1
        OR.L   D0,D1                            ; $265F2E
        OR.L   D0,D0                            ; $265F30
        OR.L   D1,D0                            ; $265F32
        MOVE.W  D1,$7F(A7,D7.L)                 ; $265F34
        DC.W    $7D7D,$7C7B         ; $265F38 MOVE.W  <EA:3D>,$7C7B(A6)
        MOVE.W  $7B76.W,$7B74(A5)               ; $265F3C
        MOVE.W  $76(A5,D7.L),$7C78(A5)          ; $265F42
        MOVE.W  $7D(PC,D7.L),$7F80(A6)          ; $265F48
        OR.L   D2,D0                            ; $265F4E
        OR.L   D2,D0                            ; $265F50
        OR.L   D0,D1                            ; $265F52
        OR.L   D0,D1                            ; $265F54
        OR.L   D0,D0                            ; $265F56
        OR.L   D0,D1                            ; $265F58
        OR.L   D0,D1                            ; $265F5A
        OR.L   D1,D1                            ; $265F5C
        OR.L   D1,D1                            ; $265F5E
        OR.L   D0,D1                            ; $265F60
        OR.L   D1,D1                            ; $265F62
        OR.L   D0,D1                            ; $265F64
        OR.L   D0,D1                            ; $265F66
        OR.L   D0,D1                            ; $265F68
        OR.L   D1,D0                            ; $265F6A
        MOVEQ   #$7F,D7                         ; $265F6C
        DC.W    $7D7D,$7D7C         ; $265F6E MOVE.W  <EA:3D>,$7D7C(A6)
        MOVE.W  $7A(PC,D7.L),$7D78(A6)          ; $265F72
        MOVE.W  $75(A7,D7.L),$7F74(A6)          ; $265F78
        MOVE.W  $73(A3,D7.L),$7F73(A7)          ; $265F7E
        OR.W   $74(A4,A0.W),D0                  ; $265F84
        OR.W   $75(A4,A0.W),D0                  ; $265F88
        OR.W   D0,$79(A7,A0.W)                  ; $265F8C
        OR.W   D0,$7E(PC,A0.W)                  ; $265F90
        OR.L   D0,D0                            ; $265F94
        OR.L   D0,D2                            ; $265F96
        MOVE.W  D2,$7F(A7,D7.L)                 ; $265F98
        MOVE.W  #$7C78,$7B75(A6)                ; $265F9C
        MOVE.W  $72(A3,D7.L),$7C73(A5)          ; $265FA2
        MOVEQ   #$74,D6                         ; $265FA8
        MOVE.W  $78(A6,D7.L),$7E7B(A6)          ; $265FAA
        DC.W    $7F7D,$7F7F         ; $265FB0 MOVE.W  <EA:3D>,$7F7F(A7)
        DC.W    $807F               ; $265FB4 OR.W   <EA:3F>,D0
        DC.W    $817F               ; $265FB6 OR.W   D0,<EA:3F>
        DC.W    $827E               ; $265FB8 OR.W   <EA:3E>,D1
        DC.W    $827E               ; $265FBA OR.W   <EA:3E>,D1
        DC.W    $827E               ; $265FBC OR.W   <EA:3E>,D1
        DC.W    $827E               ; $265FBE OR.W   <EA:3E>,D1
        DC.W    $827D               ; $265FC0 OR.W   <EA:3D>,D1
        DC.W    $837E               ; $265FC2 OR.W   D1,<EA:3E>
        DC.W    $837F               ; $265FC4 OR.W   D1,<EA:3F>
        OR.L   D0,D1                            ; $265FC6
        OR.L   D2,D1                            ; $265FC8
        OR.L   D4,D1                            ; $265FCA
        OR.L   D0,D6                            ; $265FCC
        OR.L   D6,D0                            ; $265FCE
        OR.L   D4,D0                            ; $265FD0
        MOVE.W  D3,-$7E(A7,D7.L)                ; $265FD2
        MOVE.W  D0,$7E(A6,D7.L)                 ; $265FD6
        DC.W    $7D7D,$7D7C         ; $265FDA MOVE.W  <EA:3D>,$7D7C(A6)
        MOVE.W  $7A(PC,D7.L),$7E7A(A6)          ; $265FDE
        MOVEQ   #$7B,D7                         ; $265FE4
        MOVEQ   #$7B,D7                         ; $265FE6
        MOVE.W  #$7F7E,-$7F80(A7)               ; $265FE8
        OR.L   D0,D3                            ; $265FEE
        OR.L   D0,D5                            ; $265FF0
        OR.L   D0,D7                            ; $265FF2
        OR.L   D0,A0                            ; $265FF4
        OR.L   D0,A0                            ; $265FF6
        OR.L   D0,D7                            ; $265FF8
        OR.L   D5,D0                            ; $265FFA
        MOVEQ   #-$7F,D7                        ; $265FFC
        DC.W    $7D7E,$7C7D         ; $265FFE MOVE.W  <EA:3E>,$7C7D(A6)
        MOVEQ   #$7D,D6                         ; $266002
        DC.W    $7D7E,$7D80         ; $266004 MOVE.W  <EA:3E>,$7D80(A6)
        MOVE.W  D2,-$7D(A6,D7.L)                ; $266008
        MOVEQ   #-$7C,D7                        ; $26600C
        MOVEQ   #-$7C,D7                        ; $26600E
        MOVEQ   #-$7B,D7                        ; $266010
        MOVE.W  D5,-$7A(A7,D7.L)                ; $266012
        MOVE.W  A0,-$77(A7,A0.W)                ; $266016
        OR.L   D0,A3                            ; $26601A
        OR.L   A5,D1                            ; $26601C
        OR.L   D1,A6                            ; $26601E
        OR.L   D1,A7                            ; $266020
        OR.L   D1,A6                            ; $266022
        OR.L   A3,D1                            ; $266024
        OR.L   A0,D1                            ; $266026
        OR.L   D0,D5                            ; $266028
        OR.L   D0,D3                            ; $26602A
        OR.L   D1,D1                            ; $26602C
        DC.W    $817F               ; $26602E OR.W   D0,<EA:3F>
        DC.W    $807D               ; $266030 OR.W   <EA:3D>,D0
        MOVE.W  $7E77(PC),$7D74(A7)             ; $266032
        MOVE.W  $6E(A1,D7.L),$7C6C(A6)          ; $266038
        MOVE.W  $7E6D(A4),$7E6D(A6)             ; $26603E
        MOVEQ   #$6E,D7                         ; $266044
        MOVEQ   #$70,D7                         ; $266046
        MOVEQ   #$72,D7                         ; $266048
        MOVE.W  $76(A4,D7.L),-$7F89(A7)         ; $26604A
        OR.W   D0,$81788077                     ; $266050
        OR.W   $72(A4,D7.L),D0                  ; $266056
        MOVE.W  $6F(A0,D7.L),$7F70(A7)          ; $26605A
        MOVE.W  $75(A2,D7.L),$7F77(A7)          ; $266060
        MOVEQ   #$79,D7                         ; $266066
        MOVEQ   #$7A,D7                         ; $266068
        MOVE.W  $7D7A(PC),$7D7B(A6)             ; $26606A
        MOVEQ   #$7D,D7                         ; $266070
        DC.W    $7F7E,$7F80         ; $266072 MOVE.W  <EA:3E>,$7F80(A7)
        OR.L   D2,D0                            ; $266076
        OR.L   D4,D0                            ; $266078
        OR.L   D0,D6                            ; $26607A
        OR.L   D7,D1                            ; $26607C
        OR.L   D7,D1                            ; $26607E
        OR.L   D7,D1                            ; $266080
        OR.L   D5,D1                            ; $266082
        OR.L   D2,D1                            ; $266084
        DC.W    $817F               ; $266086 OR.W   D0,<EA:3F>
        DC.W    $807D               ; $266088 OR.W   <EA:3D>,D0
        OR.W   #$807C,D0                        ; $26608A
        DC.W    $807D               ; $26608E OR.W   <EA:3D>,D0
        DC.W    $807D               ; $266090 OR.W   <EA:3D>,D0
        DC.W    $7F7D,$7E7C         ; $266092 MOVE.W  <EA:3D>,$7E7C(A7)
        MOVEQ   #$7C,D7                         ; $266096
        MOVEQ   #$7B,D7                         ; $266098
        MOVEQ   #$7B,D7                         ; $26609A
        MOVE.W  $7A(PC,D7.L),$7D7A(A6)          ; $26609C
        DC.W    $7D79,$7D78,$7D78,$7E78; $2660A2 MOVE.W  $7D787D78,$7E78(A6)
        MOVEQ   #$78,D7                         ; $2660AA
        MOVEQ   #$79,D7                         ; $2660AC
        MOVEQ   #$7A,D7                         ; $2660AE
        MOVE.W  $7D78(PC),$7D77(A6)             ; $2660B0
        MOVE.W  $75(A5,D7.L),$7E76(A6)          ; $2660B6
        MOVE.W  $7F7B.W,-$7F81(A7)              ; $2660BC
        OR.L   D2,D0                            ; $2660C2
        OR.L   D4,D0                            ; $2660C4
        OR.L   D5,D0                            ; $2660C6
        OR.L   D6,D0                            ; $2660C8
        OR.L   D6,D0                            ; $2660CA
        OR.L   D7,D0                            ; $2660CC
        OR.L   D0,A0                            ; $2660CE
        OR.L   D0,A2                            ; $2660D0
        OR.L   D0,A4                            ; $2660D2
        OR.L   A6,D1                            ; $2660D4
        OR.L   A7,D1                            ; $2660D6
        OR.L   (A0),D1                          ; $2660D8
        OR.L   (A0),D1                          ; $2660DA
        OR.L   (A0),D1                          ; $2660DC
        OR.L   D1,A7                            ; $2660DE
        OR.L   D1,A5                            ; $2660E0
        OR.L   D1,A3                            ; $2660E2
        OR.L   A1,D1                            ; $2660E4
        OR.L   D0,A0                            ; $2660E6
        OR.L   D0,D6                            ; $2660E8
        OR.L   D4,D0                            ; $2660EA
        OR.L   D3,D0                            ; $2660EC
        MOVE.W  D1,-$7F(A7,D7.L)                ; $2660EE
        MOVE.W  D1,-$7F(A7,D7.L)                ; $2660F2
        MOVEQ   #-$7F,D7                        ; $2660F6
        MOVEQ   #-$7F,D7                        ; $2660F8
        MOVE.W  D1,-$7F(A6,D7.L)                ; $2660FA
        MOVEQ   #-$7D,D6                        ; $2660FE
        MOVE.W  D5,-$79(A6,D7.L)                ; $266100
        MOVEQ   #-$78,D7                        ; $266104
        MOVE.W  D7,-$7B(A7,D7.L)                ; $266106
        MOVE.W  D3,$7E(A7,D7.L)                 ; $26610A
        MOVEQ   #$78,D7                         ; $26610E
        MOVEQ   #$71,D7                         ; $266110
        MOVE.W  $7D66(A3),$7D64(A6)             ; $266112
        MOVEQ   #$64,D7                         ; $266118
        MOVEQ   #$67,D7                         ; $26611A
        MOVEQ   #$6B,D7                         ; $26611C
        MOVEQ   #$6E,D7                         ; $26611E
        MOVEQ   #$71,D7                         ; $266120
        MOVEQ   #$73,D7                         ; $266122
        MOVEQ   #$74,D7                         ; $266124
        MOVEQ   #$74,D7                         ; $266126
        MOVE.W  $76(A5,D7.L),-$7F88(A7)         ; $266128
        OR.W   -$7E84(PC),D0                    ; $26612E
        DC.W    $817E               ; $266132 OR.W   D0,<EA:3E>
        OR.L   D0,D1                            ; $266134
        OR.L   D1,D1                            ; $266136
        OR.L   D1,D3                            ; $266138
        OR.L   D5,D1                            ; $26613A
        OR.L   D4,D1                            ; $26613C
        OR.L   D0,D3                            ; $26613E
        OR.L   D0,D1                            ; $266140
        OR.L   D0,D0                            ; $266142
        DC.W    $807F               ; $266144 OR.W   <EA:3F>,D0
        DC.W    $807D               ; $266146 OR.W   <EA:3D>,D0
        MOVE.W  #$7F7B,-$7F85(A7)               ; $266148
        OR.W   #$817E,D0                        ; $26614E
        OR.L   D0,D0                            ; $266152
        OR.L   D2,D0                            ; $266154
        OR.L   D4,D0                            ; $266156
        OR.L   D4,D0                            ; $266158
        OR.L   D3,D0                            ; $26615A
        MOVE.W  D2,-$7F(A7,D7.L)                ; $26615C
        MOVEQ   #$7E,D7                         ; $266160
        MOVEQ   #$7C,D7                         ; $266162
        MOVEQ   #$7B,D7                         ; $266164
        MOVEQ   #$7A,D7                         ; $266166
        MOVE.W  $74(A7,D7.L),$7C70(A6)          ; $266168
        MOVEQ   #$6C,D6                         ; $26616E
        MOVE.W  $7C69(A2),$7C69(A5)             ; $266170
        MOVEQ   #$6C,D6                         ; $266176
        MOVE.W  $7D72(A7),$7E74(A6)             ; $266178
        MOVEQ   #$74,D7                         ; $26617E
        MOVEQ   #$74,D7                         ; $266180
        MOVE.W  $75(A5,D7.L),$7F76(A7)          ; $266182
        OR.W   $7A(A7,D7.L),D0                  ; $266188
        DC.W    $807F               ; $26618C OR.W   <EA:3F>,D0
        OR.L   D0,D4                            ; $26618E
        OR.L   D0,A0                            ; $266190
        OR.L   A5,D1                            ; $266192
        OR.L   D1,(A0)                          ; $266194
        OR.L   D1,(A3)                          ; $266196
        OR.L   D1,(A4)                          ; $266198
        OR.L   (A4),D2                          ; $26619A
        OR.L   D1,(A3)                          ; $26619C
        OR.L   (A1),D1                          ; $26619E
        OR.L   A6,D1                            ; $2661A0
        OR.L   D0,A4                            ; $2661A2
        OR.L   D0,A2                            ; $2661A4
        OR.L   A0,D0                            ; $2661A6
        MOVE.W  D6,-$7B(A7,A0.W)                ; $2661A8
        OR.L   D5,D0                            ; $2661AC
        MOVE.W  D4,-$7E(A7,D7.L)                ; $2661AE
        MOVE.W  D1,-$7F(A7,D7.L)                ; $2661B2
        MOVEQ   #-$7F,D7                        ; $2661B6
        MOVEQ   #-$7E,D7                        ; $2661B8
        MOVEQ   #-$7E,D7                        ; $2661BA
        MOVE.W  D3,-$7D(A6,D7.L)                ; $2661BC
        MOVE.W  D3,-$7E(A6,D7.L)                ; $2661C0
        MOVE.W  D1,$7F(A6,D7.L)                 ; $2661C4
        MOVEQ   #$7C,D6                         ; $2661C8
        MOVEQ   #$79,D6                         ; $2661CA
        MOVEQ   #$76,D6                         ; $2661CC
        MOVEQ   #$75,D6                         ; $2661CE
        MOVEQ   #$75,D6                         ; $2661D0
        MOVE.W  $77(A6,D7.L),$7E79(A6)          ; $2661D2
        MOVEQ   #$7B,D7                         ; $2661D8
        DC.W    $7F7D,$7F7F         ; $2661DA MOVE.W  <EA:3D>,$7F7F(A7)
        MOVE.W  D0,-$80(A7,D7.L)                ; $2661DE
        OR.L   D0,D0                            ; $2661E2
        OR.L   D1,D0                            ; $2661E4
        OR.L   D0,D2                            ; $2661E6
        OR.L   D2,D1                            ; $2661E8
        OR.L   D1,D2                            ; $2661EA
        OR.L   D1,D3                            ; $2661EC
        OR.L   D1,D3                            ; $2661EE
        OR.L   D1,D2                            ; $2661F0
        OR.L   D1,D1                            ; $2661F2
        OR.L   D0,D1                            ; $2661F4
        DC.W    $827E               ; $2661F6 OR.W   <EA:3E>,D1
        DC.W    $837D               ; $2661F8 OR.W   D1,<EA:3D>
        DC.W    $837D               ; $2661FA OR.W   D1,<EA:3D>
        OR.W   D1,$7A(PC,A0.W)                  ; $2661FC
