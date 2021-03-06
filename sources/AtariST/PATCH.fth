\ *** Block No. 0 Hexblock 0 
\\         ***  Loadscreen f�r Arbeitssystem ***       03oct86we
                                                                
Die folgenden Screens werden benutzt, um von  FORTHKER.PRG  aus 
ein Arbeitssystem hochzuziehen.                                 
                                                                
Da der Kernal noch kein Filesystem enth�lt, mu� dieses zun�chst 
im Direktzugriff geladen werden. Assembler und Fileinterface    
m�ssen daher unbedingt am Anfang auf der Diskette liegen, damit 
die absoluten Blocknummern stimmen ($16 und $18).               
                                                                
Anschlie�end werden die Files FORTH_83.SCR und FILEINT.SCR er-  
zeugt und die View-Felder der Worte auf diese Files gepatched.  
Dazu m�ssen diese Files auf Diskette vorhanden sein.            
                                                                
Schlie�lich werden mit  INCLUDE  die Files geladen, die man in  
seinem System haben m�chte.                                     
\ *** Block No. 1 Hexblock 1 
                                                                
                                                                
  6 load      cr .( Internal Assembler loaded ) cr              
$18 load      cr .( File-Interface loaded)      cr              
 1 +load      cr .( now patch that stuff ... )  cr              
                                                                
path A:\;B:\                                                    
                                                                
use forth83.fb     0 0 patchviewfields                          
use fileint.fb     ' arguments >name 4-  -$17 patchviewfields   
                                                                
flush  save                                                     
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ patch view-fields                                   bp 25May86
                                                                
here         300 hallot    heap dp !                            
Variable blockoffset                                            
: patch            ( viewadr -- )   \ patch view field          
   viewoffset blockoffset @ +    swap +! ;                      
                                                                
: patchthread      ( thread adr -- )                            
   >r  BEGIN   @ dup   WHILE  dup 1-  r@  u>                    
                       WHILE  dup 2- patch  REPEAT  drop rdrop ;
                                                                
: patchviewfields  ( n adr -- )   \ adr is bottom of patch area 
   blockoffset !   voc-link                                     
   BEGIN  @ ?dup  WHILE   2dup 4- swap  patchthread  REPEAT     
   drop ;                                                       
dp !                                                            
\ *** Block No. 3 Hexblock 3 
\                                                      05oct86we
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
