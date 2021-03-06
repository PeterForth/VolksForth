
\ *** Block No. 0, Hexblock 0

\ System depended IO definitions for 6502 target     cas 26jan06
















\ *** Block No. 1, Hexblock 1

\ loadscreen for py65                             cas 15juli2020


 1  9 +thru

\\ The following IO definitions are for the py65
   emulator at https://github.com/mnaberez/py65

   A char can can be read by memory mapped IO at $f004
   A char can be written to memory mapped IO at $f001







\ *** Block No. 2, Hexblock 2

\ 65KEY? GETKEY              25JAN85RE)           cas 15july2020

CODE 65KEY? ( -- FLAG)  $f004 lda $9ff sta push0a jmp end-code

CODE GETKEY  ( -- 8B)   $9ff lda  push0a jmp  end-code

CODE CURON   ( --)  NEXT JMP END-CODE

CODE CUROFF   ( --) NEXT JMP END-CODE

: 65KEY  ( -- 8B)
          BEGIN PAUSE 65KEY?  UNTIL  GETKEY ;





\ *** Block No. 3, Hexblock 3

\ DECODE EXPECT KEYBOARD      BP28MAY85)          cas 18juli2020
7F CONSTANT #BS   0D CONSTANT #CR  &27 CONSTANT #ESC
                  0A CONSTANT #LF
: 65DECODE  ( ADDR CNT1 KEY -- ADDR CNT2)
   #BS CASE?  IF  DUP  IF DEL 1- THEN EXIT  THEN
   #CR CASE?  IF  DUP SPAN ! EXIT THEN
   >R  2DUP +  R@ SWAP C!  R> EMIT  1+ ;

: 65EXPECT ( ADDR LEN1 -- )  SPAN !  0
   BEGIN  DUP SPAN @  U<
   WHILE  KEY  DECODE
   REPEAT 2DROP SPACE ;

INPUT: KEYBOARD   [ HERE INPUT ! ]
 65KEY 65KEY? 65DECODE 65EXPECT [


\ *** Block No. 4, Hexblock 4

\ send? (emit 65emit                              cas 15july2020




\ | Code send? ( -- flg )
\    $01 # lda   push0a jmp  end-code


Code (emit ( 8b -- )
  SP X) lda        $f001 sta  (drop  jmp  end-code






\ *** Block No. 5, Hexblock 5

\ EMIT CR DEL PAGE AT AT?     25JAN85RE)          cas 15july2020

| Variable out    0 out !         | &80 Constant c/row

: 65emit   ( 8b -- ) pause  1 out +! (emit ;

: 65CR     #CR 65emit  #LF 65emit
           out @  c/row /  1+  c/row *  out ! ;

: 65DEL    #bs 65emit  SPACE  #bs 65emit -2 out +! ;

: 65PAGE   .( insert code for page )  out off ;

: 65at ( row col -- )
    .( insert code for at ) swap  c/row * + out ! ;
: 65AT?  ( -- ROW COL ) out @  c/row /mod  &24 min swap ;

\ *** Block No. 6, Hexblock 6

\ 65type                                           cas 15jul2020

: 65type ( adr len -- ) bounds ?DO I c@ emit LOOP ;














\ *** Block No. 7, Hexblock 7

\ TYPE DISPLAY (BYE       BP  28MAY85RE)               er14dez88

OUTPUT: DISPLAY   [ HERE OUTPUT ! ]
 65EMIT 65CR 65TYPE 65DEL 65PAGE 65AT 65AT? [


| : (bye ;










\ *** Block No. 8, Hexblock 8

\ B/BLK DRIVE >DRIVE DRVINIT  28MAY85RE)             cas 26jan06

$400 CONSTANT B/BLK    \ Bytes per physical Sector

$0AA CONSTANT BLK/DRV  \ number of Blocks per Drive

| VARIABLE (DRV    0 (DRV !

| : DISK ( -- DEV.NO )   (DRV @ 8 + ;

: DRIVE  ( DRV# -- )      BLK/DRV *  OFFSET ! ;






\ *** Block No. 9, Hexblock 9

\                                                 cas 18juli2020
: >DRIVE ( BLOCK DRV# -- BLOCK' )
    BLK/DRV * +   OFFSET @ - ;
: DRV?    ( BLOCK -- DRV# )
    OFFSET @ + BLK/DRV / ;

: DRVINIT  NOOP ;

: READBLOCK ( ADR BLK )
  $f011 ! $f013 ! 01 $f010 c! ;

: WRITEBLOCK ( ADR BLK )
  $f011 ! $f013 ! 02 $f010 c! ;




\ *** Block No. 10, Hexblock a

\  (r/w                                           cas 18juli2020

:  (R/W  ( ADR BLK FILE R/WF -- FLAG)
   swap abort" no file"
   IF readblock  ELSE writeblock  THEN false ;

' (R/W  IS   R/W









