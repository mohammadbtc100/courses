.model 
.stack
.data  
   
msg1 db "+",'$'
msg2 db "/",'$'
msg3 db "1",'$'
msg4 db "3",'$'
msg5 db "c",'$'
msg6 db "enter first number:",'$'
msg7 db "enter second number:",'$'

p1 db ?
p2 db ?
z db ?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code
main proc far   
   
   push ds
   push 0     
   mov ax,@data
   mov ds,ax
   
call cls1 
call mov_curser1    
call disp_msg1

call cls2
call mov_curser2
call disp_msg2

call cls3
call mov_curser3
call disp_msg3

call cls4
call mov_curser4
call disp_msg4

call cls5
call mov_curser5
call disp_msg5  

call clear
call input
  
   tryagain:
   mov ax,03h
   int 33h                
   
   and bx,0000000000000001b
   cmp bx,1
   jne tryagain
   
   shr cx,3
   shr dx,3
   call compare
   
   mov ax,4c00h
   int 21h
   
   ret
   main endp 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
cls1 proc
    mov ah,06h
    mov al,25
    mov ch,6
    mov cl,10
    mov dh,9
    mov dl,20
    mov bh,01110000b
    int 10h 
    
 ret
    cls1 endp    
 
mov_curser1 proc
    mov ah,02h
    mov dh,8
    mov dl,15
    mov bh,0
    int 10h

 ret
    mov_curser1 endp   
   
disp_msg1 proc                   
    lea dx,msg1
    mov ah,09h
    int 21h   
   
 ret
  disp_msg1 endp     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls2 proc
    mov ah, 6h
    mov al,25
    mov ch,6
    mov cl,30
    mov dh,9
    mov dl,40
    mov bh,01010000b
    int 10h
 
 ret           
    cls2 endp    
   
mov_curser2 proc
    mov ah,02h
    mov dh,8
    mov dl,35
    mov bh,0
    int 10h
 
 ret
    mov_curser2 endp   
   
disp_msg2 proc                      
    lea dx,msg2
    mov ah,09h
    int 21h   
   
 ret
   disp_msg2 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls3 proc
    mov ah, 6h
    mov al,25
    mov ch,12
    mov cl,10
    mov dh,15
    mov dl,20
    mov bh,00100000b
    int 10h
 
 ret
    cls3 endp    

mov_curser3 proc
    mov ah,02h
    mov dh,14
    mov dl,15
    mov bh,0
    int 10h

 ret
    mov_curser3 endp   
   
disp_msg3 proc
    lea dx,msg3
    mov ah,09h
    int 21h   
   
 ret
    disp_msg3 endp     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls4 proc
    mov ah, 6h
    mov al,25
    mov ch,12
    mov cl,30
    mov dh,15
    mov dl,40
    mov bh,011000000b
    int 10h
 
 ret           
    cls4 endp    

mov_curser4 proc
    mov ah,02h
    mov dh,14
    mov dl,35
    mov bh,0
    int 10h
 
 ret
   
   mov_curser4 endp   

disp_msg4 proc                      
    lea dx,msg4
    mov ah,09h
    int 21h   
   
 ret
    
    disp_msg4 endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls5 proc
    mov ah, 6h
    mov al,25
    mov ch,8
    mov cl,50
    mov dh,13
    mov dl,60
    mov bh,011100000b
    int 10h
    
 ret               
    cls5 endp    
mov_curser5 proc
    mov ah,02h
    mov dh,10
    mov dl,55
    mov bh,0
    int 10h
    
 ret
    mov_curser5 endp      

disp_msg5 proc                      
    lea dx,msg5
    mov ah,09h
    int 21h   
 
 ret
    disp_msg5 endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
input proc
  mov ah,02h
  mov dh,0
  mov dl,0
  mov bh,0
  int 10h
    
  lea dx,msg6
  mov ah,09h
  int 21h
  mov ah,01h
  int 21h
  sub al,48
  mov p1,al 

  lea dx,msg7
  mov ah,09h
  int 21h
  mov ah,01h
  int 21h
  sub al,48
  mov p2,al
   
   input endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
compare proc 
  cmp dx,06
  jl tryagain  
  cmp dx,09
  jg r1
  cmp cx,10
  jl tryagain
  cmp cx,20
  jg t  
  mov dl,'+'
  mov z,'+'
  call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
t:
  cmp dx,06
  jl tryagain  
  cmp dx,09
  jg r1
  cmp cx,30
  jl tryagain
  cmp cx,40
  jg r1  
  mov dl,'/'
  mov z,'/'
  call print
r1:
  cmp dx,12
  jl tryagain  
  cmp dx,15
  jg r2
  cmp cx,10
  jl tryagain
  cmp cx,20
  jg t1  
  mov dl,'1' 
  mov p1,'1'
  call print
t1:
  cmp dx,12
  jl tryagain  
  cmp dx,15
  jg r2
  cmp cx,30
  jl tryagain
  cmp cx,40
  jg r2  
  mov dl,'3'
  mov p1,'3'
  call print 
r2:
  cmp dx,08
  jl tryagain  
  cmp dx,13
  jg tryagain
  cmp cx,50
  jl tryagain
  cmp cx,60
  jg tryagain
  mov dl,'c'
  call clear 
 ret
   compare endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print proc
  mov ah,02
  mov dh,20
  mov dl,15
  mov bh,0
  int 10h 
  mov dl,'+'  
  cmp z,'+'
  jne taghsim 
  mov ah,02
  int 21h
  call add1
  jmp tryagain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
taghsim:
  mov dl,'/'
  cmp z,'/'
  jne taghsim
  mov ah,02
  int 21h 
  call div1
  jmp tryagain   
 ret
   print endp   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
clear proc
  mov ah,06h  
  mov al,25
  mov ch,18
  mov cl,10
  mov dh,21
  mov dl,20
  mov bh,01001111b
  int 10h   

  mov ah,02  
  mov dh,20
  mov dl,15
  mov bh,0
  int 10h   

  mov p1,0
  mov p2,0
  mov z,0
  ret 
clear endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
add1 proc 
  mov cl,p1
  add cl,p2 
  add cl,48
  mov ah,02h
  mov dl,cl
  int 21h
 ret  
   add1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
div1 proc
  mov al,p1
  mov ah,0
  div p2
  mov dl,al
  add dl,48
  mov ah,02
  int 21h 
 ret 
   div1 endp
  
