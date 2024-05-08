section .data
    result db 'El resultado de la multiplicación es: ', 0
    result_len equ $ - result
    newline db 10

section .bss
    res resb 5  

section .text
    global _start

_start:
    ; Asignar valores a las variables
    mov al, 4  ; Primer número
    mov bl, 2  ; Segundo número

    ; Multiplicar los números
    mul bl

    ; Convertir el resultado a ASCII
    add ax, '0'

    mov [res], ax

    ; Mostrar el mensaje de resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, result_len
    int 0x80

    ; Mostrar el resultado
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
