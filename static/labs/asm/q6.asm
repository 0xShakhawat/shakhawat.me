.model small
.stack 100h

.data
    arr db 0, 3, 8, 2, 7
    msg db 'Smallest: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, arr
    mov al, [si]
    mov cx, 4
    inc si

check:
    cmp al, [si]
    jb next
    mov al, [si]

next:
    inc si
    loop check

    mov bl, al

    mov ah, 09h
    lea dx, msg
    int 21h

    add bl, '0'
    mov dl, bl
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h

main endp
end main