\ *** Block No. 0 Hexblock 0 
    ERRORBOX.SCR                                       26oct86we
                                                                
Dieses File gibt ABORT"-Fehlermeldungen in ALERT-Boxen aus.     
                                                                
Diese Box enth�lt die Buttons "Cancel" und "Editor", falls der  
   Fehler beim Laden eines Files auftrat. Der Button "Editor"   
   verzweigt in den Editor, "Cancel" zum Kommandointerpreter.   
   "Editor" ist der Defaultwert, der bei Dr�cken von <Return>   
   ausgel�st wird.                                              
Trat der Fehler bei Ausf�hrung von Tastatureingaben auf, gibt   
   es nur den OK-Button.                                        
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 1 Hexblock 1 
\ Loadscreen for errorbox                              26oct86we
                                                                
Onlyforth Gem also definitions                                  
                                                                
0 list                                                          
                                                                
1 +load                                                         
                                                                
' boxhandler errorhandler !                                     
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 2 Hexblock 2 
\ Display all errors in an ALERT-Box                   26oct86we
                                                                
| : addstring     ( string -- )        \ add a string to pad    
       count  $add ;                                            
                                                                
: boxhandler    ( string -- )                                   
   show_c       pad   dup off  $sum !                           
   " [3][" addstring                                            
   here addstring                                               
   " |" addstring    addstring                                  
   blk @ ?dup IF    scr !   >in @ r# !                          
                    2 " ][Cancel|Editor]"                       
              ELSE  1 " ][Ok]"  THEN  addstring                 
   pad c>0"   pad  form_alert  hide_c                           
   2 = IF  v THEN  quit ;                                       
                                                                
\ *** Block No. 3 Hexblock 3 
    ERRORBOX.SCR                                       26oct86we
                                                                
Zugleich wollen wir zeigen, wie einfach unter volksFORTH Alert- 
 Boxen programmiert werden k�nnen. Bei unserem Beispiel handelt 
 es sich sogar um einen komplizierten Fall, weil der auszu-     
 gebende String erst in PAD zusammengestellt werden mu�.        
                                                                
Ansonsten k�nnte eine Alert-Box z.B. so programmiert werden.    
 (Das folgende Beispiel k�nnen Sie ausprobieren, indem Sie den  
  Cursor in die n�chste Zeile setzen und CTRL-L eingeben.       
                                                                
 Create boxtext ," [3][Dies ist eine Alert-Box][Seh ich selbst]"
        boxtext c>0"                                            
                                                                
  : test    1 boxtext form_alert drop ;                         
                                                                
\ *** Block No. 4 Hexblock 4 
\ Loadscreen for errorbox                              26oct86we
                                                                
setzt Searchorder auf       GEM GEM FORTH ONLY     GEM          
                                                                
gibt Screen 0 mit der Anleitung aus.                            
                                                                
kompiliert den folgenden Screen.                                
                                                                
setzt BOXHANDLER als neuen errorhandler. Alle Fehlermeldungen,  
 die �ber abort"  laufen, erscheinen jetzt in Boxen.            
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
\ *** Block No. 5 Hexblock 5 
\ Display all errors in an ALERT-Box                   26oct86we
                                                                
ADDSTRING  h�ngt den String bei Adresse string an den String    
 bei $SUM an. Benutzt $ADD aus dem File STRINGS.SCR             
                                                                
BOXHANDLER   gibt den String von ABORT" in einer Alert-Box aus. 
 Maus einschalten und PAD als Ziel f�r ADDSTRING vorbereiten.   
 Die 3 sorgt f�r das STOP-Icon in der Box.                      
 Bei HERE steht das Wort, das den Fehler verursacht hat.        
 In die n�chste Zeile kommt die Fehlermeldung von ABORT"        
 Wenn der Fehler beim Kompilieren auftrat, werden Screen und    
   Cursorposition gemerkt und zwei Buttons ausgegeben.          
 Sonst kann man den Fehler nur quittieren.                      
 Bei PAD ist jetzt der gesamte Boxtext zusammengestellt.        
 Falls 'EDITOR' angeklickt wurde, wird der Editor mit dem       
 fehlerhaften Screen aufgerufen.                                
