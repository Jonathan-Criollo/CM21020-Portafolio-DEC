section .data
    divisor dd 5         ; Divisor
    dividendo dd 25      ; Dividendo
    resultado dd 0       ; Resultado de la división

    mensaje_resultado db 'El resultado es: ', 0xA, 0 ; Mensaje a imprimir con salto de línea al final

section .text
    global _start

_start:
    ; Cargar el dividendo en eax
    mov eax, [dividendo]

    ; Dividir eax por el divisor
    mov ebx, [divisor]
    xor edx, edx        ; Limpiar edx para almacenar el residuo
    div ebx

    ; Almacenar el cociente en la variable de resultado
    mov [resultado], eax

    ; Mostrar el mensaje de resultado
    mov eax, 4          ; Llamada al sistema para imprimir
    mov ebx, 1          ; Descriptor de archivo (STDOUT)
    mov ecx, mensaje_resultado
    mov edx, 18         ; Longitud del mensaje
    int 0x80            ; Llamada al sistema para imprimir

    ; Convertir el resultado a una cadena de texto
    mov eax, [resultado]
    mov ebx, 10
    mov ecx, resultado_str
    call convertir_a_cadena

    ; Mostrar el resultado convertido
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado_str
    call imprimir_cadena
    int 0x80

    ; Imprimir un salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Subrutina para convertir un entero en una cadena de caracteres
convertir_a_cadena:
    add ecx, MAX_DIGITS
    mov byte [ecx], 0

    dec ecx

next_digit:
    xor edx, edx
    div ebx

    add dl, '0'
    dec ecx
    mov [ecx], dl

    test eax, eax
    jnz next_digit

    ret

; Subrutina para imprimir una cadena de caracteres
imprimir_cadena:
    mov eax, 4
    mov ebx, 1
    mov edx, MAX_DIGITS
    int 0x80
    ret

section .bss
    resultado_str resb MAX_DIGITS

section .data
    MAX_DIGITS equ 11
    new_line db 0xA
