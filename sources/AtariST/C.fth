\ *** Block No. 0 Hexblock 0 
( Target compiler commands for volksForth Atari ST/TTcas20130105
                                                                
include c.fb to build a new volksforth kernel named             
"4thimg.prg"                                                    
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
( load screen for target compilation )                          
                                                                
include assemble.fb  ( load assembler )                         
include target.fb    ( load target compiler )                   
include forth83.fb   ( compile volksForth from source )         
                                                                
save-target 4thimg.prg  ( save the new minimal image )          
                                                                
.( Done )                                                       
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
