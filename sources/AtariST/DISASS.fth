\ *** Block No. 0 Hexblock 0 
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ 68000 Disassembler loadscreen                        05dec86we
                                                                
Onlyforth                                                       
                                                                
\needs >absaddr    : >absaddr     0 forthstart d+ ;             
\needs Code        .( Load assemble.scr first) abort            
                                                                
1 ?head !       \ alle Disassembler-Worte headerless            
1 $12 +thru                                                     
                                                                
0 ?head !                                                       
$13 +load       \ Benutzer-Worte mit Header                     
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ long words and presigns                              14oct86we
                                                                
: l+    ( n -- )    extend d+  ;                                
: l-    ( n -- )    extend d-  ;                                
: l+!   ( n addr -- )   >absaddr  ln+! ;                        
                                                                
: .#    Ascii # emit ;                                          
: .$    Ascii $ emit ;                                          
: .,    Ascii , emit ;                                          
: .-    Ascii - emit ;                                          
: ..    Ascii . emit ;                                          
                                                                
: .0r   ( n width --)   over abs swap                           
  <# 0 DO # LOOP swap sign #>  type space ;                     
                                                                
                                                                
\ *** Block No. 3 Hexblock 3 
\ signed / unsigned byte, word and long output         28jan86ma
                                                                
: .lformat   ( laddr --)  <# #s #> dup 8 swap - spaces type ;   
                                                                
: .lu   ( d -- )       <# #s #> type   ;                        
: .$lu  ( d -- )       .$ .lu ;                                 
                                                                
: .wo   ( n -- )       0  <# # # # # #>  type ;                 
: .$wu  ( n -- )       .$ .wo ;                                 
: .$ws  ( n -- )       dup $7FFF u>                             
                         IF .- 1.0000 rot d- THEN  .$ .wo  ;    
: .by   ( 8b -- )      0   <#  # #  #>   type ;                 
: .$bu  ( 8b -- )      .$ .by ;                                 
: .$bs  ( 8b -- )      $FF and dup $7F >                        
                         IF .- 100 swap - THEN .$ .by  ;        
: .lb  ( hi lo len -- )   bounds ?DO  I over lc@ .by  LOOP  ;   
\ *** Block No. 4 Hexblock 4 
\ Variables and tabs                                   18jan86ma
                                                                
2Variable addr    2Variable dispaddr    2Variable saveaddr      
Variable  opcode  Variable  mne         Variable  mode          
Variable  reg     Variable  length      Variable  sr            
Variable  predec                                                
                                                                
  &10 constant  bytfld       : tab     row  swap   at ;         
  &32 constant  mnefld                                          
  &40 constant  adrfld       : tab1    row  adrfld at ;         
                                                                
: getword                                                       
   addr 2@  2 l+  2dup  addr 2!  l@ ;                           
: getlong                                                       
   addr 2@  4 l+  2dup  addr 2!  2dup  2 l-  l@ >r  l@ r>   ;   
                                                                
\ *** Block No. 5 Hexblock 5 
\ print registernumber, dump                           18jan86ma
                                                                
: .reg      ( n -- )   7 and  Ascii 0 +  emit ;                 
: .(areg)   ( n -- )   Ascii A emit .reg ;                      
: .(dreg)   ( n -- )   Ascii D emit .reg ;                      
                                                                
: .areg                reg @ .(areg) ;                          
: .dreg                reg @ .(dreg) ;                          
                                                                
: .aind                Ascii ( emit .areg Ascii ) emit ;        
: .apost               .aind Ascii + emit ;                     
: .apre                .- .aind ;                               
                                                                
: dumpws               getword .$ws ;                           
: dumpw                getword .$wu ;                           
: dumpl                getlong .$lu ;                           
\ *** Block No. 6 Hexblock 6 
\ print length , bitmasking                            04mar86we
                                                                
: len.    length @                                              
      0   case? IF  ." .b"  tab1 exit  THEN                     
      1   case? IF  ." .w"  tab1 exit  THEN                     
      2   case? IF  ." .l"  tab1 exit  THEN                     
          tab1  drop ;                                          
                                                                
Code shift   ( n -- )   SP )+ D0 move  SP ) D1 move             
                        D0 D1 lsr  D1 SP ) move   Next end-code 
: 4shft   4 shift ;             : 8shft   8 shift  ;            
: cshft   $0C shift ;                                           
: bitce   $0C shift 7 and ;     : bit5     5 shift  1 and ;     
: bit6    6 shift   1 and ;     : bit7     7 shift  1 and ;     
: bit10   $0A shift 1 and ;     : bit11  $0B shift  1 and ;     
: bit8b   8 shift $0F and ;                                     
\ *** Block No. 7 Hexblock 7 
\ bitmasking 2                                         28jan86ma
                                                                
: bit02   7 and ;                : bit8    8 shift  1 and ;     
: bit35   3 shift  7 and ;       : bit3    3 shift  1 and ;     
: bit68   6 shift  7 and ;       : bit9b   9 shift  7 and ;     
: bit67   6 shift  3 and ;       : bit37   3 shift  $1F and ;   
                                                                
: len!.      length ! len. ;                                    
: length6    opcode @ bit6 1+ len!. ;                           
: length67   opcode @ bit67   len!. ;                           
                                                                
: reg02!     opcode @ bit02   reg ! ;                           
: reg9b!     opcode @ bit9b   reg ! ;                           
                                                                
: bit9b.    .# opcode @ bit9b dup 0=                            
               IF drop 8 THEN  .$bu ;                           
\ *** Block No. 8 Hexblock 8 
\ list register                                        26jan86ma
                                                                
: reglist                                                       
  getword 10 0 DO                                               
     dup 2/ swap 1 and                                          
       IF I predec @                                            
          IF $0F swap -  THEN  dup 7 >                          
             IF .(areg)  ELSE  .(dreg) THEN  dup                
               IF  ." /"  THEN                                  
       THEN   LOOP drop ;                                       
                                                                
: mnext length6 reg02! .dreg ;                                  
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 9 Hexblock 9 
\ print adressing mode                                bp 28Aug86
                                                                
: .a/pcreg     mode @ 7 =                                       
               IF  ." PC" ELSE .areg THEN ;                     
: l?    ( ext.word -- )  $800 and IF ." .L" exit THEN ." .W" ;  
: i8bit                                                         
     getword dup .$bs                                           
     Ascii ( emit .a/pcreg ., dup $7FFF >                       
       IF  Ascii A emit ELSE Ascii D emit THEN                  
     dup  bitce .reg l? Ascii ) emit ;                          
                                                                
: imm                                                           
  .# length @                                                   
     0  case? IF  getword .$bu exit  THEN                       
     1  case? IF  dumpw        exit  THEN                       
     2  case? IF  dumpl        exit  THEN   drop  ;             
\ *** Block No. 10 Hexblock A 
\  print adressing mode                                28jan86ma
                                                                
: mode7      reg @                                              
     0  case? IF  dumpws                           exit THEN    
     1  case? IF  dumpl                            exit THEN    
     2  case? IF  dumpws ." (PC)"                  exit THEN    
     3  case? IF  i8bit                            exit THEN    
     4  case? IF  sr @ IF ." SR"  ELSE  imm  THEN  exit THEN    
        drop  ." ???"  ;                                        
                                                                
: effadr     mode @                                             
 0  case? IF .dreg exit THEN   1 case? IF .areg  exit THEN      
 2  case? IF .aind exit THEN   3 case? IF .apost exit THEN      
 4  case? IF .apre exit THEN   5 case? IF dumpws .aind exit THEN
 6  case? IF i8bit exit THEN   7 case? IF mode7 exit  THEN      
 drop    ;                                                      
\ *** Block No. 11 Hexblock B 
\ find register and mode                               28jan86ma
: .ea       opcode @  dup bit02 reg !  bit35 mode !  effadr ;   
: .eadest   opcode @  dup bit68 mode !  bit9b reg !  effadr ;   
: mnabcd                                                        
  tab1 opcode @ bit3                                            
  IF     reg02!  .apre  .,  reg9b!  .apre                       
  ELSE   reg02!  .dreg  .,  reg9b!  .dreg THEN ;                
: mnaddx      length67  mnabcd ;                                
: mncmpm      length67  reg02!  .apost  .,  reg9b!  .apost ;    
: mnexg                                                         
  tab1  reg9b!  opcode @  bit37                                 
  dup  9 = IF  .areg  ELSE  .dreg  THEN  .,  reg02!             
       8 = IF  .dreg  ELSE  .areg  THEN ;                       
: mnadd     length67  opcode @                                  
 bit8 IF    reg9b!  .dreg  .,  .ea                              
      ELSE  .ea  .,  reg9b!  .dreg  THEN ;                      
\ *** Block No. 12 Hexblock C 
\  find register and mode                              26jan86ma
: mnadda   opcode @  bit8 1+ len!.  .ea  .,  reg9b!  .areg ;    
: mnaddi   length67  imm  .,  1 sr !  .ea ;                     
: mnaddq   length67  bit9b.  .,  .ea ;                          
: mnmoveq  tab1  .#  opcode @ .$bs  .,  reg9b!  .dreg ;         
: mnswap   tab1  reg02!  .dreg ;                                
: mnunlk   tab1  reg02!  .areg ;                                
: mnclr    length67  .ea ;                                      
: mnjmp    tab1  .ea ;                                          
: mnchk    mnjmp  .,  reg9b!  .dreg ;                           
: mnlea    tab1  .ea  .,  reg9b!  .areg ;                       
: mnbchg   tab1  opcode @  bit8                                 
    IF  reg9b!  .dreg  ELSE  .# dumpw  THEN  .,  .ea ;          
: mnbchg2  tab1  reg9b!  .dreg  .,  .ea ;                       
: .dir     opcode @  bit8                                       
    IF Ascii l emit  ELSE Ascii r emit  THEN ;                  
\ *** Block No. 13 Hexblock D 
\  find register and mode                              23sep86we
                                                                
: mnshft                                                        
  .dir  length67  opcode @  bit5                                
    IF  reg9b!  .dreg  ELSE  bit9b. THEN  .,  reg02!  .dreg ;   
: mnshft2  .dir mnjmp ;                                         
: reladr2                                                       
  getword dup  $7FFF >                                          
   IF 1.0000 rot d-  THEN  2+ dispaddr 2@  rot l+ .$lu ;        
: reladr                                                        
  opcode  @ $FF and ?dup                                        
    IF  dup $7F > IF 100 - THEN 2+ dispaddr 2@ rot l+ .$lu      
    ELSE  reladr2 THEN ;                                        
: quote  Create $22 word drop $22 allot  Does> 1+ ;             
   quote  ctbl0 t f hilscccsneeqvcvsplmigeltgtle"               
   quote  ctbl1 rasrhilscccsneeqvcvsplmigeltgtle"               
\ *** Block No. 14 Hexblock E 
\  find register and mode                              18jan86ma
                                                                
: .cond ( ctblflag --> )                                        
    IF ctbl1 ELSE ctbl0 THEN                                    
   opcode  @ bit8b 2* + 2 type tab1 ;                           
: mnscc  0 .cond  .ea ;                                         
: mnbcc  1 .cond  reladr ;                                      
: mndbcc 0 .cond  reg02!  .dreg  .,  reladr2 ;                  
: mnlink tab1  reg02!  .areg  .,  .#  dumpws ;                  
: mnmove                                                        
  4 opcode @  bitce - dup 3 =  IF drop 0 THEN                   
  len!.  .ea  .,  .eadest ;                                     
: mnmoveccr  mnjmp  ." ,ccr" ;                                  
: mnmovesr   mnjmp  ." ,sr" ;                                   
: mnmovefsr  tab1  ." sr,"  .ea ;                               
                                                                
\ *** Block No. 15 Hexblock F 
\  find register and mode                              26jan86ma
                                                                
: mnmoveusp  tab1  reg02!  opcode @  bit3                       
    IF ." usp," .areg  ELSE  .areg  ." ,usp"  THEN ;            
: mnmovem                                                       
  length6 opcode  @ dup bit35 4 = predec ! bit10                
    IF .ea ., reglist  ELSE  reglist ., .ea  THEN ;             
: mnmovep                                                       
  length6 opcode  @ bit7                                        
     IF reg9b! .dreg ., dumpws reg02! .aind                     
     ELSE  dumpws  reg02! .aind ., reg9b! .dreg  THEN ;         
: mnstop tab1 .# dumpw ;                                        
: mntrap tab1 .# opcode  @ $0F and .$bu  ;                      
: mnimp ;                                                       
                                                                
: t,    swap  ,  ,  [compile] ' ,   bl word drop   8 allot ;    
\ *** Block No. 16 Hexblock 10 
\ mask- and opcode-table                               18jan86ma
                                                                
Create mntbl       base @ hex                                   
ff00 0600 t, mnaddi     addi    ff00 0200 t, mnaddi     andi    
ff00 0c00 t, mnaddi     cmpi    ff00 0a00 t, mnaddi     eori    
ff00 0000 t, mnaddi     ori     ff00 0400 t, mnaddi     subi    
ffc0 0840 t, mnbchg     bchg    ffc0 0880 t, mnbchg     bclr    
ffc0 08c0 t, mnbchg     bset    ffc0 0800 t, mnbchg     btst    
e1c0 2040 t, mnmove     movea   c000 0000 t, mnmove     move    
ffff 4afc t, mnimp      illegal ffff 4e71 t, mnimp      nop     
ffff 4e70 t, mnimp      reset   ffff 4e73 t, mnimp      rte     
ffff 4e77 t, mnimp      rtr     ffff 4e75 t, mnimp      rts     
ffff 4e76 t, mnimp      trapv   ffff 4e72 t, mnstop     stop    
fff0 4e40 t, mntrap     trap    fff8 4840 t, mnswap     swap    
fff8 4e58 t, mnunlk     unlk    fff8 4e50 t, mnlink     link    
ffb8 4880 t, mnext      ext     ffc0 44c0 t, mnmoveccr  move    
\ *** Block No. 17 Hexblock 11 
\  mask- and opcode-table                              18jan86ma
                                                                
ffc0 46c0 t, mnmovesr   move    ffc0 40c0 t, mnmovefsr  move    
fff0 4e60 t, mnmoveusp  move    ffc0 4ac0 t, mnjmp      tas     
ff00 4200 t, mnclr      clr     ff00 4400 t, mnclr      neg     
ff00 4000 t, mnclr      negx    ff00 4600 t, mnclr      not     
ff00 4a00 t, mnclr      tst     ffc0 4ec0 t, mnjmp      jmp     
ffc0 4e80 t, mnjmp      jsr     ffc0 4800 t, mnjmp      nbcd    
ffc0 4840 t, mnjmp      pea     f1c0 41c0 t, mnlea      lea     
f1c0 4180 t, mnchk      chk     fb80 4880 t, mnmovem    movem   
f0f8 50c8 t, mndbcc     db      f0c0 50c0 t, mnscc      s       
f100 5000 t, mnaddq     addq    f100 5100 t, mnaddq     subq    
f000 6000 t, mnbcc      b       f100 7000 t, mnmoveq    moveq   
f1f0 8100 t, mnabcd     sbcd    f1c0 81c0 t, mnchk      divs    
f1c0 80c0 t, mnchk      divu    f000 8000 t, mnadd      or      
                                                                
\ *** Block No. 18 Hexblock 12 
\  mask- and opcode-table                              18jan86ma
                                                                
f0c0 90c0 t, mnadda     suba    f130 9100 t, mnaddx     subx    
f000 9000 t, mnadd      sub     f000 a000 t, mnimp      ?ext0a  
f0c0 b0c0 t, mnadda     cmpa    f138 b108 t, mncmpm     cmpm    
f100 b100 t, mnadd      eor     f100 b000 t, mnadd      cmp     
f1f0 c100 t, mnabcd     abcd    f1c0 c1c0 t, mnchk      muls    
f1c0 c0c0 t, mnchk      mulu    f130 c100 t, mnexg      exg     
f000 c000 t, mnadd      and     f0c0 d0c0 t, mnadda     adda    
f130 d100 t, mnaddx     addx    f000 d000 t, mnadd      add     
fec0 e0c0 t, mnshft2    as      fec0 e2c0 t, mnshft2    ls      
fec0 e4c0 t, mnshft2    rox     fec0 e6c0 t, mnshft2    ro      
f018 e000 t, mnshft     as      f018 e008 t, mnshft     ls      
f018 e010 t, mnshft     rox     f018 e018 t, mnshft     ro      
f000 f000 t, mnimp      ?ext0f  0000 0000 t, mnimp      ???     
base !                                                          
\ *** Block No. 19 Hexblock 13 
\ search mne and dis a line                            05dec86we
                                                                
: searchmne     ( -- )                                          
  mntbl  0 sr !  0 predec !                                     
     BEGIN  dup @  opcode @ and  over 2+ @ =                    
       IF  dup 6 +  count type  4+ @ execute  exit  THEN        
     $0E + REPEAT  ;                                            
                                                                
: disline       ( -- )          base push  hex                  
    cr    dispaddr 2@ .lformat   mnefld tab                     
    addr 2@  2dup  saveaddr 2!  l@ opcode !                     
    searchmne   2 addr l+!   bytfld  tab                        
    addr 2@  saveaddr 2@  d- drop  dup >r  dispaddr l+!         
    saveaddr 2@ swap r>  .lb  drop   ;                          
                                                                
                                                                
\ *** Block No. 20 Hexblock 14 
\ addr! dis ldis disw                                  14oct86we
                                                                
: addr!   2dup addr 2! dispaddr 2! ;                            
                                                                
: disassline  addr! disline ;                                   
                                                                
: ldis    addr! BEGIN disline stop? UNTIL cr  ;                 
                                                                
: dis     >absaddr  ldis ;                                      
                                                                
: disw    ' 2+ dup ."  Adresse : " u.  cr  >absaddr  addr!      
          BEGIN                                                 
            BEGIN  disline  opcode @ $4EF3 = stop? or UNTIL     
          key   $FF and  #esc = UNTIL                           
          cr ;                                                  
                                                                
