; Set a value for each address position in memory

; Input: Address in ESI, range size in EAX, value to set in EDX,


memset:
    xor ECX,ECX
    
    cmp ECX,EAX

    jl memset_memory_loop

    jmp memset_memory_exit

memset_memory_loop:

    mov [ESI],EDX

    add ESI,1
    inc ECX

    cmp ECX,EAX

    jle memset_memory_loop

    jmp memset_memory_exit

memset_memory_exit:
    ret