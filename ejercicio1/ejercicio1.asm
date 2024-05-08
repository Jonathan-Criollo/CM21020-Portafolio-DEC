section .data
    result db 'El resultado de la resta es: ', 0
    result_len equ $ - result
    newline db 10

section .bss
    num1 resw 1
    num2 resw 1
    num3 resw 1
    res resb 2

section .text
    global _start

_start:
    ; Asignar valores a las variables
    mov word [num1], 9
    mov word [num2], 3
    mov word [num3], 2

    ; Convertir los números de ASCII a valores enteros
    mov ax, [num1]
    sub ax, [num2]
    sub ax, [num3]

    ; Convertir el resultado de nuevo a ASCII
    add ax, '0'

    ; Almacenar el resultado en la variable 'res'
    mov [res], ax

    ; Mostrar el mensaje de resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, result_len
    int 0x80

    ; Mostrar el resultado como un carácter ASCII
    mov eax, 4
    mov ebx, 1
    mov ecx, res
    mov edx, 1
    int 0x80

    ; Mostrar un salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
