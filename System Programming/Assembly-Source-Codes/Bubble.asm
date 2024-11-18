data segment                                               
    ProgramTitle db 'AscenDIng Bubble Sort$'
    BeforeSort db 0DH , 0AH  , 0DH , 0AH , '** Array Before Sort IS **$'
    AfterSort db  0DH , 0AH  , 0DH , 0AH , '** Array After Sort IS **' , '$'
    Enter db 0DH,0AH , '$'
    Space db '    $'
    TempForPrint db 6 dup (' '),'$'
    t db  6 dup (' '),'$'
    CountArrayTemp db ?
    VALueArray db 99 , 102 , 80 , 71 , 2 , 6 , 1 , '$'
    CountArray db 7     
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    MOV ax, data
    MOV ds, ax
    MOV es, ax
    
;****** CLEAR SCREEN ******
    MOV AH , 6h
    MOV AL , 25
    MOV CH , 0
    MOV CL , 0
    MOV DH , 24
    MOV DL , 79
    MOV BH , 7
    INT 10H
;****** CLEAR SCREEN ******  

;****** Print Title ******  
    LEA DX , ProgramTitle     
    MOV AH , 9
    INT 21H        
;****** Print Title ******  

;****** Print Text ******   
    LEA DX , BeforeSort     
    MOV AH , 9
    INT 21H        
    
    LEA DX , Enter
    MOV AH , 9
    INT 21H        
;****** Print Text ******  
  
    MOV CL , CountArray
    MOV CH , 0
    MOV SI , 0 
    

;****** Loop For Print Non-Sort Number ******  
Loop1:          
    MOV  AL     , 0
    MOV  [BX]   , AL
    MOV  [BX+1] , AL
    MOV  [BX+2] , AL
    MOV  [BX+3] , AL
    MOV  [BX+4] , AL
    MOV  [BX+5] , AL


    MOV   AH , 0
    MOV   AL , VALueArray + SI
    LEA   BX , TempForPrint
    ADD   BX , 2
    PUSH  CX
    MOV   CL , 10  

    CMP   AX , 10
    JAE   NumG10     
    
    LEA   BX , TempForPrint
    ADD   AL , 48
    MOV   [BX] , AL
    LEA   DX , TempForPrint
    MOV   AH , 9
    INT   21H
    JMP   EndLoop
   
NumG10: 

    DIV   CL
    ADD   AH , 48
    MOV   [BX] , AH
    MOV   AH , 0
    DEC   BX
    CMP   AX , 0
    JNE   NumG10

    LEA   DX, TempForPrint
    MOV   AH, 9
    INT   21H
EndLoop: 
    
   INC   SI 
   POP   CX
   LOOP  Loop1
;****** Loop For Print Non-Sort Number ******  

    MOV  AH , CountArray
    MOV  CountArrayTemp , AH 
    DEC CountArray                             
    
;****** Loop For Sort ******      
while:
    CMP   CountArray , 0
    JBE   end_while
    
    MOV   CH , 0
    MOV   CL , CountArray
    MOV   SI , 0
    MOV   DI , 1
for:
    MOV   AH , VALueArray + SI
    MOV   AL , VALueArray + DI
    
    CMP   AH , AL
    JBE   mamad
    XCHG  AH , AL
    MOV   VALueArray + SI , AH
    MOV   VALueArray + DI , AL
mamad:
    INC   SI
    INC   DI
    LOOP  for     
    DEC CountArray   
    JMP while       
end_while:        
;****** Loop For Sort ******      

;****** Loop For Print Non-Sort Number ******  
    LEA   DX , AfterSort     
    MOV   AH , 9
    INT   21H  
 
    LEA   DX , Enter
    MOV   AH , 9
    INT   21H

    MOV   CL , CountArrayTemp
    MOV   CH , 0
    MOV   SI , 0 
Loop2:     
    MOV   TempForPrint , 0
    MOV   AH , 0
    MOV   AL , VALueArray + SI
    LEA   BX , TempForPrint
    ADD   BX , 2
    PUSH  CX
    MOV   CL , 10  

    CMP   AX , 10
    JAE   NumG100
   
    ADD   AL , 48
    MOV   TempForPrint , AL
    LEA   DX , TempForPrint
    MOV   AH , 9
    INT   21H
    JMP   EndLoop1
NumG100: 
    DIV   CL
    ADD   AH , 48
    MOV   [BX] , AH
    MOV   AH , 0
    DEC   BX

    CMP   AX , 0
    JNE   NumG100

    LEA   DX , TempForPrint
    MOV   AH , 9
    INT   21H
EndLoop1: 
    INC   SI 
    POP   CX
    LOOP  Loop2
;****** Loop For Print Non-Sort Number ******
   
    MOV   AH , 1
    INT   21H
    MOV   AX , 4c00H 
    INT   21H    
ends
end start 