.model small
.data
msg1      db       'Enter the string1:','$'
msg2      db       'Enter the string2:',"$"

strlist  label    byte   ;start of parameter list
 max     db     80
 len     db       ?
 buffer  db      80 dup(' ')
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
    call  cls
    call  printmsg1
    call  read_string
  ;5  call  cls
   ; call  delete_blank
    call  chap   
    mov      ax, 4c00h
    int      21h
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


delete_blank proc
    mov si,0
    mov cl,len
    mov ch,0
    mov al,' '
    for:
    cmp strlist[si],al
    jne label
    mov strlist[si],'f'
    label:
    inc si
    loop for
    ret
delete_blank  endp      

chap proc
    mov ah,2h   ;cursor move
    mov dh,18  ;row
    mov dl,10   ;column
    mov bh,0    ;page umber 
    int 10h
    lea dx,buffer ; print
    mov ah,9h
    int 21h  
    ret
chap endp
end      main         
      

        
         
         

        

