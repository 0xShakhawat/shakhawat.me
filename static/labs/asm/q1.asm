.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter a letter: $'
    msg2 DB 13,10,'Converted letter: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H

    CMP AL, 'a'
    JB CHECK_UPPER
    CMP AL, 'z'
    JA CHECK_UPPER

    SUB AL, 20H
    JMP DISPLAY

CHECK_UPPER:
    CMP AL, 'A'
    JB DISPLAY
    CMP AL, 'Z'
    JA DISPLAY

    ADD AL, 20H

DISPLAY:
    MOV BL, AL

    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
```
