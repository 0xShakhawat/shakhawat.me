.model small
.stack 100h

.data
  msg1 db 'Enter 1st number: $'
  msg2 db 10, 13, 'Enter 2nd number: $'
  msg3 db 10, 13, 'Smaller number: $'

.code
   main proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov bl, al
    
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov bh, al
    
    cmp bl, bh
    jb display
    
    mov bl, bh
    
  display:
   
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
      
     
    
    