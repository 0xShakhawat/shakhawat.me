.model small
.stack 100h

.data
    msg1 db 'Enter a number: $'
    msg2 db 10, 13, 'Factorial: $'

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

    mov cl, al
    mov ch, 0

    mov ax, 1

fact:
    mul cx
    loop fact

    mov bx, ax

    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ax, bx
    mov cx, 0
    mov bx, 10

convert:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convert

display:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop display

    mov ah, 4ch
    int 21h

main endp
end main