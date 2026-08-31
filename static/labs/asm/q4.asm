.model small
.stack 100h

.data
  msg1 db 'Enter 1st number: $'
  msg2 db 10, 13, 'Enter 2nd number: $'
  msg3 db 10, 13, 'Sum: $'

.code
   main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al
    
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, al 
    
    add bl, bh
    add bl, '0'
    
    mov ah, 09h
    lea dx, msg3
    int 21h
    
    mov dl, bl
    mov ah, 02h
    int 21h
    
    mov ah, 4ch
    int 21h
    
    main endp
   end main
    