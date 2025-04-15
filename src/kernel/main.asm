org 0x7C00
bits 16

; a NASM macro
%define ENDL 0x0D, 0x0A

start:
    jmp main


; prints a string on the screen
; Params:
;   -ds:si points to the string
puts:
    push si
    push ax

.loop:
    lodsb               ; loads the next character in al
    or al, al           ; verify if next character is null
    jz .done

    mov ah, 0x0e
    int 0x10
    
    jmp .loop

.done:
    pop ax
    pop si
    ret

main:
    ; setting up data segments
    mov ax, 0            ; doing this since we can't write to ds/es directly
    mov ds, ax
    mov es, ax

    ; setting stack positions
    mov ss, ax
    mov sp, 0x7C00        ; since stack grows downwards assing it to the start of the OS
                          ; else it will overwrite the OS itself

    
    ; print message
    mov si, msg_hello
    call puts

    
    hlt

.halt:
    jmp .halt


msg_hello: db 'Hello World! :)', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
