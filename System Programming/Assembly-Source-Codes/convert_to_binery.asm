.model small

.data
  buflen equ 14
  maxlena db 5
  actlena db ?
  numa    db 5 dup(?)
  messagea db 0DH,0AH,'please enter number:',0AH,0DH,'$'
  numc db buflen dup(' '),'B','$'
  messagec db 0dh,0ah,'reasult is:',0dh,0ah,'$'

.code
  main proc
    mov ax,@data
    mov ds,ax
    call cls
    lea dx,messagea
    call print_string
    lea dx,maxlena
    call read_string 
    lea  si,numa
    call asctobin
    lea  si,numc
    call bintoasc
    lea dx,messagec
    call print_string
    lea dx,numc
    call print_string
    mov ah,1
    int 21h
    mov ah,4ch
    int 21h
  main endp 
  cls proc
    mov ah,6
    mov al,25
    mov cl,0
    mov ch,0
    mov dh,24
    mov dl,79
    mov bh,71
    int 10h
    ret
  endp cls
  print_string proc
    mov ah,9h
    int 21h
    ret 
    print_string endp
  read_string proc
    mov ah,10
    int 21h
    ret
    read_string endp 
  asctobin proc
    mov ax,0
    count:
    mov bl,[si]
    cmp bl,0dh
    je  exit
    mov dx,10
    mul dx
    sub bl,'0'
    mov bh,0
    add ax,bx
    inc si
    jmp count
    exit:
    ret
    asctobin endp
  bintoasc proc
    mov bx,2
    add si,buflen-1
    conti:
    mov dx,0
    div bx
    add dl,'0'
    mov [si],dl
    cmp ax,0
    je  fin
    dec si
    jmp conti
    fin:
    ret
    bintoasc endp
  end main
    
    
  