.model small
.data
msg1      db       'Enter the string1:','$'
msg2      db       'Enter the string2:',"$"

strlist  label    byte   ;start of parameter list
 max     db       20
 len     db       ?
 buffer  db       20 dup(' ')
dolar    db       '$'
strlist1  label    byte   ;start of parameter list
 max1     db       20
 len1     db       ?
 buffer1  db       20 dup(' ')
dolar1    db       '$'
      
.code
main  proc
    mov      ax, @data
    mov      ds, ax 
    call cls
    call printmsg1
    call read_string
    call printmsg2
    call read_srting1
    call etesal 
    call chap   
    mov ax, 4c00h
    int 21h
main     endp 

cls proc 
    mov ah, 6h   ;cursor move
    mov al, 25   ;number of rows
    mov ch, 0
    mov cl, 0
    mov dh, 24   ;row
    mov dl, 79   ;column
    mov bh, 7    ;attribute
    int 10h
    ret
    cls endp

printmsg1 proc
    mov ah, 2h   ;cursor move
    mov dh, 10   ;row
    mov dl, 30   ;column
    mov bh, 0    ;page number
    int 10h
    lea dx, msg1
    mov ah, 9h
    int 21h     
    ret
    printmsg1 endp

read_string proc
    mov      ah, 0ah
    lea      dx, strlist
    int      21h 
    ret
    read_string endp

printmsg2 proc
    mov ah, 2h   ;cursor move
    mov dh, 12   ;row
    mov dl, 30   ;column
    mov bh, 0    ;page number
    int 10h     
    mov dx, offset msg2
    mov ah, 9h
    int 21h
    ret    
    printmsg2 endp

read_srting1 proc 
    mov ah,0ah
    mov dx,strlist1
    int 21h    
    mov ah, 2h   ;cursor move
    mov dh, 14   ;row
    mov dl, 30   ;column
    mov bh, 0    ;page number
    int 10h 
    ret 
read_srting1 endp

etesal proc
    mov si,0 
    mov al,len
    mov ah,0
    mov di,ax
   
    mov cl,len1
    next:
    mov al,strlist1[si]
    mov strlist[di],al
    inc si
    inc di
    loop next
    mov strlist[di+1],'$'
    ret

chap proc
    lea      dx, buffer ; print
    mov      ah, 9h
    int      21h 
    mov      ah, 2h   ;cursor move
    mov      dh, 16   ;row
    mov      dl, 30   ;column
    mov      bh, 0    ;page number
    int      10h
    lea      dx,buffer1
    mov      ah,9h
    int      21h  
    ret
end      main
        
         
      

        
         
         

        

