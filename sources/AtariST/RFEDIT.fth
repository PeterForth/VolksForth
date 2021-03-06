\ *** Block No. 0 Hexblock 0 
\\ Retro Forth Editor                                cas20130106
                                                                
This is a port of the Retro Forth Editor from                   
http://retroforth.org                                           
                                                                
Functions:                                                      
<b> s           Select a new block <b>                          
p               Previous block                                  
n               Next block                                      
<l> i ...       Insert ... into line <l>                        
<c> <l> ia ...  Insert ... into line <l> at column <c>          
x               Clear (erase) the current block                 
<l>             Clear line <l>                                  
v               Display current block                           
e               Evaluate (load) current block                   
                                                                
\ *** Block No. 1 Hexblock 1 
.( Retro Forth block editor volksForth Atari ST)   \ cas20130106
$10 constant l/b cr                                             
: (block) scr @ block ;  : (line) c/l * (block) + ;             
: row dup c/l type c/l + cr ; : .rows l/b 0 do i . row loop ;   
: .block ." Block: " scr @ dup . updated? abs $2A + emit space ;
 : +--- ." +---" ; : :--- ." :---" ;                            
: x--- +--- :--- +--- :--- ;                                    
: --- space space x--- x--- x--- x--- cr ;                      
: vb --- scr @ block .rows drop --- ;                           
: .stack ." Stack: " .s ; : status .block .stack ;              
: v cr vb status ; : v* update v ; : s dup scr ! block drop v ; 
: ia (line) + >r &10 parse r> swap move v* ;                    
: i 0 swap ia ;  : d (line) c/l bl fill v* ;                    
: x (block) l/b c/l * bl fill v* ; : p -1 scr +! v ;            
: n 1 scr +! v ; : e scr @ load ;                               
cr .( editor loaded ) cr                                        
\ *** Block No. 2 Hexblock 2 
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
