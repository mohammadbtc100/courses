data segment
    Dot           DB   004H,'$' 
                     
    Hour          DB   ?  
    Minute        DB   ?
    Second        DB   ?
    
    HLine         DB   '--$' 
    VLine         DB   '|$'  
    
    Year          DW   ?
    Month         DB   ?
    Day           DB   ?
    Day_of_week   DB   ?
    
    Print_Year    DB   4 dup (' '),'$'
    Print_Day     DB   2 dup ('0'),'$'
    
    Sunday        DB   'Sunday$'
    Monday        DB   'Monday$'
    Tuesday       DB   'Tuesday$'
    Wednesday     DB   'Wednesday$'
    Thursday      DB   'Thursday$'
    Friday        DB   'Friday$'
    Saturday      DB   'Saturday$'
    
    January       DB   'January$'
    February      DB   'February$'
    March         DB   'March$'
    April         DB   'April$'
    May           DB   'May$'
    June          DB   'June$'
    July          DB   'July$'
    August        DB   'August$'
    September     DB   'September$'
    October       DB   'October$'
    November      DB   'November$'
    December      DB   'December$'    
ends

stack segment
    dw   128  dup(0)
ends                               

;*********** Main Menu ***********;
code segment
start:
    MOV AX, data
    MOV DS, AX
    MOV ES, AX   
    
   
    MOV  AH , 2Ch  ; System Time
    INT 21h
    
    MOV Hour   ,  CH
    MOV Minute ,  CL
    MOV Second ,  DH
   
    CALL Draw_Hour                            
    CALL Draw_Minute 
    CALL Print_System_Date
    
    
BLink:

;****** CLEAR SCREEN ******
    MOV AH , 6h
    MOV AL , 3
    MOV CH , 12
    MOV CL , 39
    MOV DH , 14
    MOV DL , 39
    MOV BH , 7
    INT 10H
;****** CLEAR SCREEN ******      
    
    MOV AH , 86H
    MOV CX , 15
    MOV DX , 0
    INT 15H
     
     
    INC Second
    CMP Second , 60
    JNE Not_Ope
    
    MOV Second , 0
    INC Minute  
    
    CMP Minute , 60
    JNE Just_Minute
   
    MOV Minute , 0
    INC Hour

    CMP Hour , 24
    JNE Refresh
    
    MOV Hour , 0
    MOV Minute , 0
    MOV Second , 0
    JMP Refresh
         
    JMP Not_Ope   
Refresh:    
    CALL Draw_Hour
    CALL Draw_Minute
    CALL Print_System_Date

    JMP Not_Ope

Just_Minute:    
  CALL Draw_Minute        
    
Not_Ope:
    
    MOV DH , 12
    MOV DL , 39
    CALL  Gotoxy
    
    LEA DX , Dot
    MOV AH , 9
    INT 21H    
    
    MOV DH , 14
    MOV DL , 39
    CALL  Gotoxy           
    
    LEA DX , Dot
    MOV AH , 9
    INT 21H      
    
    MOV AH , 86H
    MOV CX , 15
    MOV DX , 0
    INT 15H
    
    JMP BLink   
 
    MOV AH, 1
    INT 21h
    MOV AX, 4C00H 
    INT 21h    
ends
;*********** Main Menu ***********;

     
;*********** GotoXY **************;
GotoXY PROC 
    MOV AH , 2H
    MOV BH , 0
    INT 10H 
    RET
GotoXY ENDP     
;*********** GotoXY **************;
  
  
;*********** H-Line **************;
Draw_H_Line PROC
    LEA DX , HLine
    MOV AH , 9
    INT 21H
    RET
Draw_H_Line ENDP     
;*********** H-Line **************;


;*********** V-Line **************;
Draw_V_Line PROC
    LEA DX , VLine
    MOV AH , 9
    INT 21H
    RET
Draw_V_Line ENDP     
;*********** V-Line **************;          
      
      
;*********** System-Date **************;  
Print_System_Date Proc

 ;CX = year (1980-2099).
 ;DH = month.
 ;DL = day.
 ;AL = day of week (00h=Sunday)
   
    MOV AH, 2AH
    INT 21H
      
    MOV Year , CX
    MOV Month , DH
    MOV Day , DL
    MOV Day_of_week , AL   
     
     
    MOV DH , 11
    MOV DL , 52
    CALL GotoXY 
   
    CMP Day_of_week , 0
    JNE Day_Not_0
    LEA   DX, Sunday
    JMP Day_Not_6
Day_Not_0:    
   
    CMP Day_of_week , 1
    JNE Day_Not_1
    LEA   DX, Monday 
    JMP Day_Not_6
Day_Not_1:    

    CMP Day_of_week , 2
    JNE Day_Not_2
    LEA   DX, Tuesday
    JMP Day_Not_6
Day_Not_2:    

    CMP Day_of_week , 3
    JNE Day_Not_3
    LEA   DX, Wednesday
    JMP Day_Not_6
Day_Not_3:    

    CMP Day_of_week , 4
    JNE Day_Not_4
    LEA   DX, Thursday 
    JMP Day_Not_6
Day_Not_4:    

    CMP Day_of_week , 5
    JNE Day_Not_5
    LEA   DX, Friday
    JMP Day_Not_6
Day_Not_5:    

    LEA   DX, Saturday 
Day_Not_6:    
   
    MOV AH , 09H
    INT 21H 
   
   

   
    MOV AL , Day ; AX=Day
    MOV AH , 0
    MOV CL , 10
    LEA BX , Print_Day
    ADD BX , 1
   
YearG1: 
    DIV CL
    ADD AH , 48
    MOV [BX] , AH
    MOV AH , 0
    DEC BX
    CMP AX , 0
    JNE YearG1
  
    MOV DH , 12
    MOV DL , 52
    CALL GotoXY
  
    LEA DX, Print_Day
    MOV AH, 9
    INT 21H




    MOV DH , 13
    MOV DL , 52
    CALL GotoXY 
    
    CMP Month , 1
    JNE Month_Not_1
    LEA DX, January
    JMP Month_Not_12
Month_Not_1:    
   
    CMP Month , 2
    JNE Month_Not_2
    LEA DX , February 
    JMP Month_Not_12
Month_Not_2:    

    CMP Month , 3
    JNE Month_Not_3
    LEA DX, March
    JMP Month_Not_12
Month_Not_3:    

    CMP Month , 4
    JNE Month_Not_4
    LEA DX, April
    JMP Month_Not_12
Month_Not_4:    

    CMP Month , 5
    JNE Month_Not_5
    LEA DX, May 
    JMP Month_Not_12
Month_Not_5:    

    CMP Month , 6
    JNE Month_Not_6
    LEA DX, June
    JMP Month_Not_12
Month_Not_6:    

    CMP Month , 7
    JNE Month_Not_7
    LEA DX, July 
    JMP Month_Not_12
Month_Not_7:  

    CMP Month , 8
    JNE Month_Not_8
    LEA DX, August
    JMP Month_Not_12
Month_Not_8:    

    CMP Month , 9
    JNE Month_Not_9
    LEA DX, September 
    JMP Month_Not_12
Month_Not_9:  


    CMP Month , 10
    JNE Month_Not_10
    LEA DX, October
    JMP Month_Not_12
Month_Not_10:    

    CMP Month , 11
    JNE Month_Not_11
    LEA DX, November 
    JMP Month_Not_12
Month_Not_11: 

    LEA DX, December
Month_Not_12:    
    MOV AH , 09H
    INT 21H 
   

 
    MOV AX , Year ; AX=Year
    MOV CL , 10
    LEA BX , Print_Year
    ADD BX , 3
   
YearG10: 
    DIV CL
    ADD AH , 48
    MOV [BX] , AH
    MOV AH , 0
    DEC BX
    CMP AX , 0
    JNE YearG10

    MOV DH , 14
    MOV DL , 52
    CALL GotoXY
  
    LEA   DX, Print_Year
    MOV   AH, 9
    INT   21H
      
    RET
Print_System_Date ENDP
;*********** System-Date **************;        
  

;*********** Hour **************;  
Draw_Hour PROC
    
;****** CLEAR SCREEN ******
    MOV AH , 6h
    MOV AL , 4
    MOV CH , 11
    MOV CL , 30
    MOV DH , 14
    MOV DL , 37
    MOV BH , 7
    INT 10H
;****** CLEAR SCREEN ******      

    MOV AL , Hour
    MOV AH , 0
    MOV CL , 10
    DIV CL
    PUSH AX

    CMP AL , 0
    JNE Next1
   
    ;Print 0 (Left) 
    MOV DH , 11
    MOV DL , 30
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 29
    CALL GotoXY
    CALL Draw_V_Line 
    
    
    MOV DH , 12
    MOV DL , 32
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 29
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 14
    MOV DL , 32
    CALL GotoXY
    CALL Draw_V_Line
        
    MOV DH , 15
    MOV DL , 30
    CALL GotoXY
    CALL Draw_H_Line     
    JMP Fin    
Next1:
    CMP AL , 1
    JNE Next2
               
    ;Print 1 (Left)
    MOV DH , 12
    MOV DL , 32
    CALL GotoXY
    CALL Draw_V_Line  
       
    MOV DH , 14
    MOV DL , 32
    CALL GotoXY
    CALL Draw_V_Line
    
    JMP Fin
Next2:
       
    ;Print 2 (Left)
    MOV DH , 11
    MOV DL , 30
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 13
    MOV DL , 30
    CALL GotoXY
    CALL Draw_H_Line
   
    MOV DH , 12
    MOV DL , 32
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 29
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 15
    MOV DL , 30
    CALL GotoXY
    CALL Draw_H_Line

Fin:
    POP AX    
    CMP AH , 0
    JNE Next3 
        
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line
       
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin1     
Next3:    
    CMP AH , 1
    JNE Next4
         
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    JMP Fin1
Next4:
    CMP AH , 2
    JNE Next5
    
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
     
    MOV DH , 14
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin1    
Next5:
    CMP AH ,3
    JNE Next6
       
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line    
 
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
    JMP Fin1
Next6:
    CMP AH , 4 
    JNE Next7
       
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line
       
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
     
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line 
    JMP Fin1
Next7:
    CMP AH , 5
    JNE Next8

    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line  
   
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 

    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
  
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin1
Next8:    
    CMP AH , 6
    JNE Next9 
        
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
    
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line
    
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin1
Next9:
    CMP AH , 7
    JNE Next10     
    
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line   
   
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line 
  
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line
    JMP Fin1
Next10:
    CMP AH , 8
    JNE Next11
  
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line   
    
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line   
    
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line     
    
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line
     
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin1   
Next11:     
    MOV DH , 11
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 34
    CALL GotoXY
    CALL Draw_V_Line 
      
    MOV DH , 12
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line  
      
    MOV DH , 13
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 14
    MOV DL , 37
    CALL GotoXY
    CALL Draw_V_Line
      
    MOV DH , 15
    MOV DL , 35
    CALL GotoXY
    CALL Draw_H_Line 
Fin1:
    RET
Draw_Hour ENDP    
;*********** Hour **************; 


;*********** Minute **************;  
Draw_Minute PROC
    
;****** CLEAR SCREEN ******
    MOV AH , 6h
    MOV AL , 4
    MOV CH , 11
    MOV CL , 42
    MOV DH , 14
    MOV DL , 49
    MOV BH , 7
    INT 10H
;****** CLEAR SCREEN ******      

    MOV AL , Minute
    MOV AH , 0
    MOV CL , 10
    DIV CL
    PUSH AX

    CMP AL , 0
    JNE Next12
   
    ;Print 0 (Left) 
    MOV DH , 11
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 12
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line  
        
    MOV DH , 14
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line    
   
    MOV DH , 15
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line     
    JMP Fin2    
Next12:
    CMP AL , 1
    JNE Next13
               
    ;Print 1 (Left)
    MOV DH , 12
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line      
    
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line    
    JMP Fin2     
Next13:       
    CMP AL , 2
    JNE Next14
             
    ;Print 2 (Left)
    MOV DH , 11
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 13
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line     
       
    MOV DH , 12
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line     
     
    MOV DH , 15
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    JMP Fin2    
Next14:  
    CMP AL , 3
    JNE Next15
   
    ;Print 0 (Left) 
    MOV DH , 11
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line     
    
    MOV DH , 13
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line 
   
    MOV DH , 15
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line     
    JMP Fin2      
Next15:  
    CMP AL , 4
    JNE Next16
   
    ;Print 0 (Left) 
    MOV DH , 12
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line
    
    MOV DH , 12
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line     
    
    MOV DH , 13
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line 
    JMP Fin2     
Next16:
    
    CMP AL , 5
    JNE Next17
   
    ;Print 5 (Left) 
    MOV DH , 11
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line     
    
    MOV DH , 13
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 15
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line  
    JMP Fin2        
Next17:

    ;Print 6 (Left) 
    MOV DH , 11
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line 
        
    MOV DH , 13
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 41
    CALL GotoXY
    CALL Draw_V_Line   
    
    MOV DH , 14
    MOV DL , 44
    CALL GotoXY
    CALL Draw_V_Line
     
    MOV DH , 15
    MOV DL , 42
    CALL GotoXY
    CALL Draw_H_Line     
  
Fin2:  
 
    POP AX
    CMP AH , 0
    JNE Next18 
       
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
       
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line     
    
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
       
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin3     
Next18:    
    CMP AH , 1
    JNE Next19
       
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    JMP Fin3 
Next19:
    CMP AH , 2
    JNE Next20
    
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
      
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin3   
Next20:  
    CMP AH ,3
    JNE Next21
       
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
     
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line 
       
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    JMP Fin3
Next21: 

    CMP AH , 4 
    JNE Next22
     
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line
       
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line 
    JMP Fin3
Next22:

    CMP AH , 5
    JNE Next23

    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
    
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin3
Next23:    
    CMP AH , 6
    JNE Next24 
 
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
      
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
      
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line  
    
    MOV DH , 14
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
     
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
    
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin3
Next24:  
    CMP AH , 7
    JNE Next25 
     
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
     
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line 
     
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
    JMP Fin3
Next25:
   
    CMP AH , 8
    JNE Next26
    
    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
    
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
    
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
    JMP Fin3     
Next26:     

    MOV DH , 11
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 12
    MOV DL , 46
    CALL GotoXY
    CALL Draw_V_Line 
     
    MOV DH , 12
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line  
    
    MOV DH , 13
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line
    
    MOV DH , 14
    MOV DL , 49
    CALL GotoXY
    CALL Draw_V_Line
     
    MOV DH , 15
    MOV DL , 47
    CALL GotoXY
    CALL Draw_H_Line 
     
Fin3:
    RET
Draw_Minute ENDP    
;*********** Minute **************; 
end start
