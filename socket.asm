section .data    
    response db "HTTP/1.0 200 OK",13,10,"Content-Type: text/plain",13,10,13,10,"Hello from ASM!",10
    response_len equ $ - response

section .bss
    sockfd resd 1
    clientfd resd 1
    addr resb 16

section .text
    global _start

_start:
    mov eax, 102
    mov ebx, 2
    mov ecx, 1
    mov edx, 0
    int 80h
    mov [sockfd], eax

    mov dword [addr], 0x00020000
    mov word [addr+2], 0x1F90
    mov dword [addr+4], 0
    mov dword [addr+8], 0

    mov eax, 104
    mov ebx, [sockfd]
    mov ecx, addr
    mov edx, 16
    int 80h

    mov eax, 106
    mov ebx, [sockfd]
    mov ecx, 1
    int 80h

    mov eax, 105
    mov ebx, [sockfd]
    mov ecx, 0
    mov edx, 0
    int 80h
    mov [clientfd], eax

    mov eax, 4
    mov ebx, [clientfd]
    mov ecx, response
    mov edx, response_len
    int 80h

    mov eax, 6
    mov ebx, [clientfd]
    int 80h

    mov eax, 6
    mov ebx, [sockfd]
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h
