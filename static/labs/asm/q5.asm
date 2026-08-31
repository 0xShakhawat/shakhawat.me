.model small
.stack 100h

.data
    msg1 db 'Enter a number: $'
    msg2 db 10, 13, 'Prime$'
    msg3 db 10, 13, 'Not Prime$'

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

    cmp al, 0
    je not_prime

    cmp al, 1
    je not_prime

    cmp al, 2
    je prime

    mov bl, al
    mov cl, 2

check:
    mov al, bl
    mov ah, 0
    div cl

    cmp ah, 0
    je not_prime

    inc cl
    cmp cl, bl
    jb check

prime:
    mov ah, 09h
    lea dx, msg2
    int 21h
    jmp exit

not_prime:
    mov ah, 09h
    lea dx, msg3
    int 21h

exit:
    mov ah, 4ch
    int 21h

main endp
end main