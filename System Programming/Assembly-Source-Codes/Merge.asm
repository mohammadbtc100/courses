data segment
    A   DB  5,4,3,2,1
    Len DB  4
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

;    int i , j , index
;    for (i = 1 ; i < n ; i++)
;    {
;        index = arr[i];
;        j = i;
;        while (j > 0 && arr[j-1] > index)
;        {
;            arr[j] = arr[j-1];
;            j=j-1;
;        }
;    arr[j] = index;
;    }       
  

    MOV CH , 0
    MOV CL , Len
    MOV SI , 1
    
    L1:
        MOV AL , A[SI]
        MOV DI , SI
        While:
            CMP DI , 0
            JBE End_While
            
            DEC DI
            CMP A[DI],AL
            INC DI
            JBE End_While
            
            DEC DI
            MOV AH , A[DI]
            INC DI
            
            MOV A[DI] , AH         
            DEC DI
        JMP While 
        
        END_While:
        
        MOV A[DI] , AL
        INC SI
    LOOP L1
   
    mov ax, 4c00h
    int 21h    
ends

end start
