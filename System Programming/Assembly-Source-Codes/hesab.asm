
data segment
    
    num1 db ?
    num2 db ? 
    cd db ?  
    p1 db ?
    p2 db ?
    p3 db ? 
    p4 db ?      
 ends

stack segment
    dw   128  dup(0)
ends

code segment
main proc far
    assume ds:data,cs:code,ss:stack
    mov ax, data
    mov ds, ax
    mov es, ax                    
    push ds  
    push 0
          
    call pointer    
    mov p1,2
    mov p2,20
    call  move_cur1
    mov p1,1
    mov p2,11 
    mov p3,3 
    mov p4,37
    mov cd,0111110b   
    call kadr    
   ;-=-=-=-=-=-=-=-=-=-=-=---
    mov p1,6
    mov p2,12
    call  move_cur1
    mov p1,5
    mov p2,11
    mov p3,7 
    mov p4,16  
    mov cd,01010111b 
    call kadr
    mov dx,'+'
    call print 
   ;-=-=-=-=-=-=-=-=-=-=-=---
    mov p1,6
    mov p2,20
    call  move_cur1
    mov p1,05
    mov p2,18
    mov p3,07 
    mov p4,23 
    mov cd,01010111b   
    call kadr 
    mov dx,'-'
    call print
   ;-=-=-=-=-=-=-=-=-=-=-=--- 
    mov p1,6
    mov p2,27
    call  move_cur1
    mov p1,5
    mov p2,25
    mov p3,7 
    mov p4,30  
    mov cd,01010111b  
    call kadr
    mov dx,'*'
    call print
   ;-=-=-=-=-=-=-=-=-=-=-=---
    mov p1,6
    mov p2,34
    call  move_cur1
    mov p1,5
    mov p2,32
    mov p3,7 
    mov p4,37 
    mov cd,01010111b      
    call kadr
    mov dx,'/'                             
    call print 
    ;-=-=-=-=-=-=-=-=-=-=-=---   

    mov p1,10
    mov p2,14
    call  move_cur1
    mov p1,9
    mov p2,11
    mov p3,11
    mov p4,16
    call kadr          
    mov dx,'1'                             
    call print  
  ;===================
    mov p1,10
    mov p2,21
    call  move_cur1
    mov p1,9
    mov p2,18
    mov p3,11
    mov p4,23
    call kadr 
    mov dx,'2'                             
    call print
 ;==============================
    mov p1,10
    mov p2,28
    call  move_cur1
    mov p1,9
    mov p2,25
    mov p3,11
    mov p4,30
    call kadr
    mov dx,'3'                             
    call print
;==============================
    mov p1,10
    mov p2,35
    call  move_cur1
    mov p1,9
    mov p2,32
    mov p3,11
    mov p4,37
    call kadr
    mov dx,'4'                             
    call print
 ;================================
    mov p1,14
    mov p2,14
    call  move_cur1
    mov p1,13
    mov p2,11
    mov p3,15
    mov p4,16
    call kadr
    mov dx,'5'                             
    call print 
;============================     
    
    mov p1,14
    mov p2,21
    call  move_cur1 
    mov p1,13
    mov p2,18
    mov p3,15
    mov p4,23
    call kadr 
    mov dx,'6'                             
    call print 
;=============================   
    mov p1,14
    mov p2,28
    call  move_cur1 
    mov p1,13
    mov p2,25
    mov p3,15
    mov p4,30
    call kadr
    mov dx,'7'                             
    call print  
    
 ;=========================   
        
    mov p1,14
    mov p2,35
    call  move_cur1 
    mov p1,13
    mov p2,32
    mov p3,15
    mov p4,37
    call kadr  
    mov dx,'8'                             
    call print
    
   ;============================      
    mov p1,18
    mov p2,17
    call  move_cur1 
    
    mov p1,17
    mov p2,14
    mov p3,19
    mov p4,20
    call kadr
    mov dx,'9'                             
    call print
  ;===================================  
    mov p1,18
    mov p2,31
    call  move_cur1
    mov p1,17
    mov p2,25
  mov p3,19
   mov p4,37
    call kadr
    mov dx,'C'                             
    call print 
  ;==================================
;start1: 

  
    mov p1,2
    mov p2,20
    call  move_cur1
    mov bx,0
    if:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if
    shr  cx,3
    shr  dx,3 
    
    call click
    
    if2:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if2
    shr  cx,3
    shr  dx,3 
        
    call amalgar
    
    mov num2,0 
    
    call1: 
     if3:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if3
    shr  cx,3
    shr  dx,3
    
    call click2 
    cmp num2,0
    je call1    
    call addc
  
    jmp exit4 
    
    call2: 
    
      if4:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if4
    shr  cx,3
    shr  dx,3
    
    call click2
    cmp num2,0
    je call2  
    call subb
    jmp exit4
    
    call3:
         
      if5:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if5
    shr  cx,3
    shr  dx,3     
         
    call click2
    cmp num2,0
    je call3
    call zarb
    jmp exit4
    
    call4:
    
      if6:
    call mouse 
    and bx,01h
    cmp bx,01
    jne if6
    shr  cx,3
    shr  dx,3
    
    call click2
    cmp num2,0
    je call4 
    call taghsim
    
    exit4:

    
    ; RESULT at ds:ax
    
     mov ax,2
     int 21h  
     

    
    ; wait for any key....    
    mov ah,1
    int 21h
    
      
    mov ax, 4c00h ; exit to OS
    int 21h  
  
  main endp   
  
  

pointer proc
    mov ax,0
    int 33h
    cmp ax,0
    je exit
    
    mov ax,1
    int 33h
    ret
pointer endp 
     
     
     
 move_cur1 proc
    mov ah,02h
    mov dh,p1
    mov dl,p2
    mov bh,0
    int 10h
  ret
 move_cur1 endp   
  
  
kadr proc
    mov ah,06h
    mov al,25
    mov ch,p1
    mov cl,p2
    mov dh,p3
    mov dl,p4
    mov bh,cd
    int 10h
   ret
 kadr endp   




 print proc
    mov ah,02
    int 21h
    ret
 print endp       



 input proc
     mov ah,01h
     int 21h
     ret 
 input endp


 mouse proc
    mov ax,3
    int 33h
    ret
 mouse endp



 subb proc
    mov al,num1
    sub al,num2  
    add al,48 
    mov cl,al
    mov dx,'='
    call print
    mov dl,cl
    call print
    ret
 subb endp

 addc proc
    mov al,num1
    add al,num2  
    add al,48 
    mov cl,al
    mov dx,'='
    call print
    mov dl,cl
    call print
    ret
 addc endp

 ;zarb------------------------
  zarb proc
    mov al,num1
    mul num2
    add al,48  
    mov cl,al
    mov dx,'='
    call print
    mov dl,cl 
    call print 
    ret                                                                 
 zarb endp 
 ;taghsim------------------------
 taghsim proc
    mov al,num1
    mov ah,0
    div num2
    add al,48  
    mov cl,al
    mov dx,'='
    call print
    mov dl,cl 
    call print 
    ret
  taghsim endp
  
  click proc
    
    cmp  cx,11
    jl L02
    cmp cx,16 
    jg L02
    cmp dx,09
    jl L02 
    cmp dx,11
    jg L02  
    mov dx,'1' 
    call print
    mov num1,1
    jmp exit2      
L02:
   cmp  cx,18
    jl L03 
    cmp cx,23 
    jg L03 
    cmp dx,09
    jl L03  
    cmp dx,11
    jg L03  
    mov dx,'2' 
    call print
    mov num1,2 
    jmp exit2 
L03:
    cmp  cx,25
    jl L04
    cmp cx,30 
    jg L04
    cmp dx,09
    jl L04 
    cmp dx,11
    jg L04  
    mov dx,'3' 
    call print
    mov num1,3
    jmp exit2  
L04:
  cmp  cx,32
    jl L05
    cmp cx,37 
    jg L05
    cmp dx,09
    jl L05 
    cmp dx,11
    jg L05  
    mov dx,'4' 
    call print
    mov num1,4
    jmp exit2  
L05:
   cmp  cx,11
    jl L06
    cmp cx,16 
    jg L06
    cmp dx,13
    jl L06 
    cmp dx,15
    jg L06  
    mov dx,'5' 
    call print
    mov num1,5 
    jmp exit2 
L06:
   cmp  cx,18
    jl L07
    cmp cx,23 
    jg L07
    cmp dx,13
    jl L07 
    cmp dx,15
    jg L07  
    mov dx,'6' 
    call print
    mov num1,6 
    jmp exit2 
L07:
    cmp  cx,25
    jl L08
    cmp cx,30 
    jg L08
    cmp dx,13
    jl L08 
    cmp dx,15
    jg L08  
    mov dx,'7' 
    call print
    mov num1,7
    jmp exit2  
L08:
    cmp  cx,25
    jl L09
    cmp cx,37 
    jg L09
    cmp dx,13
    jl L09 
    cmp dx,15
    jg L09  
    mov dx,'8' 
    call print
    mov num1,8
    jmp exit2  
L09:
    cmp  cx,11
    jl L10
    cmp cx,23 
    jg L10
    cmp dx,17
    jl L10 
    cmp dx,19
    jg L10  
    mov dx,'9' 
    call print
    mov num1,9 
    jmp exit2  
L10:
    cmp  cx,25
    jl exit2
    cmp cx,37 
    jg exit2
    cmp dx,17
    jl exit2 
    cmp dx,19
    jg exit2  

    exit2:
    ret
    click endp
   
 ;click2   
    
click2 proc 
  while2:  
    cmp  cx,11
    jl L002
    cmp cx,16 
    jg L002
    cmp dx,09
    jl L002 
    cmp dx,11
    jg L002  
    mov dx,'1' 
    call print
    mov num2,1
    jmp exit3      
L002:
   cmp  cx,18
    jl L003 
    cmp cx,23 
    jg L003 
    cmp dx,09
    jl L003  
    cmp dx,11
    jg L003  
    mov dx,'2' 
    call print
    mov num2,2 
    jmp exit3 
L003:
    cmp  cx,25
    jl L004
    cmp cx,30 
    jg L004
    cmp dx,09
    jl L004 
    cmp dx,11
    jg L004  
    mov dx,'3' 
    call print
    mov num2,3
    jmp exit3  
L004:
  cmp  cx,32
    jl L005
    cmp cx,37 
    jg L005
    cmp dx,09
    jl L005 
    cmp dx,11
    jg L005  
    mov dx,'4' 
    call print
    mov num2,4
    jmp exit3  
L005:
   cmp  cx,11
    jl L006
    cmp cx,16 
    jg L006
    cmp dx,13
    jl L006 
    cmp dx,15
    jg L006  
    mov dx,'5' 
    call print
    mov num2,5 
    jmp exit3 
L006:
   cmp  cx,18
    jl L007
    cmp cx,23 
    jg L007
    cmp dx,13
    jl L007 
    cmp dx,15
    jg L007  
    mov dx,'6' 
    call print
    mov num2,6 
    jmp exit3 
L007:
    cmp  cx,25
    jl L008
    cmp cx,30 
    jg L008
    cmp dx,13
    jl L008 
    cmp dx,15
    jg L008  
    mov dx,'7' 
    call print
    mov num2,7
    jmp exit3  
L008:
    cmp  cx,25
    jl L009
    cmp cx,37 
    jg L009
    cmp dx,13
    jl L009 
    cmp dx,15
    jg L009  
    mov dx,'8' 
    call print
    mov num2,8
    jmp exit3  
L009:
    cmp  cx,11
    jl exit3
    cmp cx,23 
    jg exit3 
    cmp dx,17
    jl exit3  
    cmp dx,19
    jg exit3   
    mov dx,'9' 
    call print
    mov num2,9 
    jmp exit3 
    
    
   jmp while2 
    exit3:
    ret
  
    click2 endp  
    
    
    
amalgar proc  
    
    
L1:        
    cmp  cx,11
    jl L2
    cmp cx,16 
    jg L2
    cmp dx,05
    jl L2 
    cmp dx,07
    jg L2  
    mov dx,'+' 
    call print
    jmp call1

    jmp exit
L2:           

    cmp  cx,18
    jl L3
    cmp cx,23 
    jg L3

    cmp dx,05
    jl L3 
    cmp dx,07
    jg L3 
    mov dx,'-'
    call print   
    jmp call2
    ;call click2   
       
   ; call subb  ,
    jmp exit
L3: 

    cmp  cx,25
    jl L4
    cmp cx,30 
    jg L4

    cmp dx,05
    jl L4 
    cmp dx,07
    jg L4
    mov dx,'*'
    call print
    jmp call3
    ;call click2    
    ;call zarb
    jmp exit 
L4:

    cmp  cx,32
    jl L5
    cmp cx,35 
    jg L5

    cmp dx,05
    jl L5
    cmp dx,07
    jg L5  
    mov dx,'/'
    call print
    jmp call4
 
    jmp exit
       
 L5:       
     exit:
    ret
   amalgar endp
 
ends   
