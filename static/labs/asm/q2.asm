.model small
.stack 100h

.data
    msg1 db 'Enter a letter: $'
    msg2 db 10, 13, 'Dispaly: $'
    
.code
   main  proc
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov bl, al
    
    cmp al, 'y'
    je display
    cmp al, 'Y'
    je display
    jmp exit
    
  display:
     
     mov ah, 09h
     lea dx, msg2
     int 21h
     
     mov dl, bl
     mov ah, 02h
     int 21h
  
  exit:
     mov ah, 4ch
     int 21h
     
    main endp
   end main