
\ *** Block No. 0, Hexblock 0

\ Multitasking Extension to volksFORTH               cas 26jan06
















\ *** Block No. 1, Hexblock 1

\ Tasker Loadscreen

\NEEDS CODE     abort( Assembler needed )
hex
 1 5 +thru      \ load Tasker
   7 load       \ Task-Demo
decimal










\ *** Block No. 2, Hexblock 2

\ MULTITASKER               BP 13.9.84 )

CODE STOP
 SP 2DEC  IP    LDA  SP X) STA  IP 1+ LDA  SP )Y STA
 SP 2DEC  RP    LDA  SP X) STA  RP 1+ LDA  SP )Y STA
 6 # LDY  SP    LDA  UP )Y STA  INY  SP 1+ LDA  UP )Y STA
 1 # LDY  TYA  CLC  UP ADC  W STA
 TXA  UP 1+ ADC  W 1+ STA   W 1- JMP   END-CODE

| CREATE TASKPAUSE   ASSEMBLER
   2C # LDA  UP X) STA  ' STOP @ JMP   END-CODE

: SINGLETASK [ ' PAUSE @ ] LITERAL  ['] PAUSE ! ;

: MULTITASK   TASKPAUSE ['] PAUSE ! ;


\ *** Block No. 3, Hexblock 3

\ PASS  ACTIVATE           KS 8 MAY 84 )

: PASS  ( N0 .. NR-1 TADR R -- )
   BEGIN  [ ROT ( TRICK ! ) ]
    SWAP  02C OVER C! \ AWAKE TASK
    R> -ROT           \ IP R ADDR
    8 + >R            \ S0 OF TASK
    R@ 2+ @  SWAP     \ IP R0 R
    2+ 2*             \ BYTES ON TASKSTACK
                      \ INCL. R0 & IP
    R@ @ OVER -       \ NEW SP
    DUP R> 2- !       \ INTO SSAVE
    SWAP BOUNDS  ?DO  I !  2 +LOOP  ; RESTRICT




\ *** Block No. 4, Hexblock 4

\

: ACTIVATE ( TADR --)
     0 [ -ROT ( TRICK ! ) ]  REPEAT ; -2 ALLOT  RESTRICT

: SLEEP  ( TADR --) 4C SWAP C! ;       \ JMP-OPCODE

: WAKE  ( TADR --)  2C SWAP C! ;       \ BIT-OPCODE

| : TASKERROR  ( STRING -)
     STANDARDI/O  SINGLETASK  ." TASK ERROR : " COUNT TYPE
     MULTITASK STOP ;





\ *** Block No. 5, Hexblock 5

\ BUILDING A TASK           BP 13.9.84 )

: TASK ( RLEN  SLEN -- )
    ALLOT              \ STACK
    HERE 00FF AND 0FE =
    IF 1 ALLOT THEN    \ 6502-ALIGN
    UP@ HERE 100 CMOVE \ INIT USER AREA
    HERE  04C C,       \ JMP OPCODE TO SLEEP TASK
    UP@ 1+ @ ,
    DUP  UP@ 1+ !      \ LINK TASK
    3 ALLOT            \ ALLOT JSR WAKE
    DUP  6 -  DUP , ,  \ SSAVE AND S0
    2DUP +  ,          \ HERE + RLEN = R0
    UNDER  + HERE - 2+ ALLOT ['] TASKERROR  OVER
    [ ' ERRORHANDLER >BODY C@ ] LITERAL + ! CONSTANT ;


\ *** Block No. 6, Hexblock 6

\ MORE TASKS           KS/BP  26APR85RE)

: RENDEZVOUS  ( SEMAPHORADR -) DUP UNLOCK PAUSE LOCK ;

| : STATESMART  STATE @ IF [COMPILE] LITERAL THEN ;

: 'S  ( TADR - ADR.OF.TASKUSERVAR)
           ' >BODY C@ + STATESMART ; IMMEDIATE

\ SYNTAX:  2 DEMOTASK 'S BASE ! \ MAKES DEMOTASK WORKING BINARY

: TASKS  ( -)  ." MAIN " CR UP@ DUP 1+ @
   BEGIN  2DUP - WHILE
    DUP [ ' R0 >BODY C@ ] LITERAL + @ 6 + NAME> >NAME .NAME
    DUP C@ 04C = IF ." SLEEPING" THEN CR 1+ @ REPEAT  2DROP ;


\ *** Block No. 7, Hexblock 7

\ TASKDEMO                    27APR85RE)
: TASKMARK ;

VARIABLE COUNTER  COUNTER OFF

100 100 TASK BACKGROUND

: >COUNT  ( N -) BACKGROUND 1 PASS COUNTER !
    BEGIN  COUNTER @  DUP 1- COUNTER ! ?DUP
    WHILE  PAUSE 0 <# #S #> type REPEAT stop ;

: WAIT  BACKGROUND SLEEP ;

: GO    BACKGROUND WAKE ;



\ *** Block No. 8, Hexblock 8


















\ *** Block No. 9, Hexblock 9

















