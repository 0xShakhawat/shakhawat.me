.model small
.stack 100h

.data
    arr db 2, 0, 5, 8, 5
    msg db 'Average: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, arr
    mov cx, 5
    mov al, 0

sum:
    add al, [si]
    inc si
    loop sum

    mov ah, 0
    mov bl, 5
    div bl

    add al, '0'
    mov bl, al

    mov ah, 09h
    lea dx, msg
    int 21h

    mov dl, bl
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h

main endp
end main