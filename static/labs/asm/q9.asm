.model small
.stack 100h

.data
    arr db 2, 2, 8, 0, 6
    msg db 'Descending: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 4

outer:
    lea si, arr
    mov dx, cx

inner:
    mov al, [si]
    cmp al, [si+1]
    jae no_swap

    xchg al, [si+1]
    mov [si], al

no_swap:
    inc si
    dec dx
    jnz inner

    loop outer

    mov ah, 09h
    lea dx, msg
    int 21h

    lea si, arr
    mov cx, 5

display:
    mov dl, [si]
    add dl, '0'
    mov ah, 02h
    int 21h

    mov dl, ' '
    mov ah, 02h
    int 21h

    inc si
    loop display

    mov ah, 4ch
    int 21h

main endp
end main