data segment                                               
    Milady_Year    DW    2010
    Milady_Month   DW    5
    Milady_Day     DW    3
    
    Shamsi_Year    DW   ?
    Shamsi_Month   DW   ?
    Shamsi_Day     DW   ?  
    
    Intercalary   DB   0 
    
    SumDayMiladyMonth DW 0,31,59,90,120,151,181,212,243,273,304,334
    SumDayMiladyMonthLeap DW 0,31,60,91,121,152,182,213,244,274,305,335
    
    Day_Count  DW   ? 
    DayDayDiff DW   ?
ends
          
stack segment
    dw   128  dup(0)
ends
             
code segment
start:
    MOV ax, data
    MOV ds, ax
    MOV es, ax
    
    CALL Check_Intercalary   ; the Function Check Kabiseh
    
    CMP Intercalary, 1
    JNE CON1
    
    MOV AX , 0 
    LEA BX , SumDayMiladyMonthLeap
    MOV CX , Milady_Month
    DEC CX
    
    ADD BX , CX
    ADD BX , CX
    
    MOV AX , [BX]
    ADD AX , Milady_Day        
    MOV Day_Count , AX       
    JMP Next2
   
CON1:  
    MOV AX , 0 
    LEA BX , SumDayMiladyMonth
    MOV CX , Milady_Month
    DEC CX

    ADD BX , CX
    ADD BX , CX

    MOV AX , [BX]
    ADD AX , Milady_Day        
    MOV Day_Count , AX

Next2:

    DEC Milady_Year
    MOV Intercalary , 0
    
    CALL Check_Intercalary
    INC  Milady_Year
    
    CMP Intercalary , 1
    JNE Next
    MOV DayDayDiff , 11
    JMP NotEqual
Next:     
    MOV DayDayDiff , 10
NotEqual:

    CMP Day_Count , 79
    JBE Else_IF
             
    SUB Day_Count,79
    
    CMP Day_Count , 186
    JA Else_IF_2
    
    MOV AX , Day_Count
    MOV DX , 0
    MOV CX , 31
    DIV CX             
    
    CMP DX , 0
    JNE Switch_Defult_1 
    
    MOV Shamsi_Month , AX
    MOV Shamsi_Day , 31
    JMP Switch_End_1
    
Switch_Defult_1:
    ADD AX , 1   
    MOV Shamsi_Month , AX
    MOV Shamsi_Day , DX
    JMP Switch_End_2: 
    
Switch_End_1:

Else_IF_2:
    
    SUB Day_Count , 186
    MOV AX , Day_Count
    MOV DX , 0
    MOV CX , 30
    DIV CX
    
    CMP DX , 0
    JNE Switch_Defult_2
    
    ADD AX , 6
    MOV Shamsi_Month , AX
    MOV Shamsi_Day , 30      
    JMP Switch_End_2

Switch_Defult_2:    
    ADD AX , 7 
    MOV Shamsi_Month , AX
    MOV Shamsi_Day , DX
Switch_End_2:   

    MOV AX , Milady_Year
    SUB AX , 621
    MOV Shamsi_Year , AX  
    
    JMP Finish
Else_IF:

   MOV AX ,  Day_Count
   ADD AX ,  DayDayDiff
   MOV Day_Count , AX
   
   MOV DX , 0
   MOV CX , 30
   DIV CX
   
   CMP DX , 0
   JNE Switch_Defult_3
   
   ADD AX , 9
   MOV Shamsi_Month , AX
   MOV Shamsi_Day , 30
   JMP Switch_End_3   
   
Switch_Defult_3:    
    ADD AX , 10
    MOV Shamsi_Month , AX
    MOV Shamsi_Day , DX
    
Switch_End_3:
    MOV AX , Milady_Year
    SUB AX , 622
    MOV Shamsi_Year , AX
   
Finish:   

    MOV   AH , 1
    INT   21H
    MOV   AX , 4c00H 
    INT   21H    
ends   
  

;*** Check Intercalary (Kabiseh) *** 
Check_Intercalary proc
   
    mov ax ,  0
     
    mov ax ,  Milady_Year
    mov cl , 100
    div cl
    
    cmp Ah , 0
    je Fin
        
    mov dx , 0
    mov ax ,  Milady_Year
    mov CX , 4
    div CX
    
    cmp DX , 0
    jne Fin
    
    mov Intercalary , 1
    JMP Fin1
      
Fin:

    mov ax ,  Milady_Year
    mov cl , 100
    div cl
    
    cmp ah , 0
    Jne Fin2
    
    mov dx , 0
    mov ax , Milady_Year
    mov CX , 400
    div CX
    
    cmp DX , 0
    
    jne Fin2
    mov Intercalary , 1
    
    JMP Fin1

Fin2:
    mov Intercalary , 0
Fin1:   
    ret  
Check_Intercalary endp    
;*** Check Intercalary (Kabiseh) ***
end start







