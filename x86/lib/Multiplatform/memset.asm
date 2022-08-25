; Set a value for each address position in memory

; Input: Address in ESI, range size in EAX, value to set in bl

memset:
    xor ecx, ecx

memset_memory_loop:
    cmp ecx, eax

    jge memset_memory_exit

    mov [esi], bl

    inc esi
    inc ecx

    jmp memset_memory_loop

memset_memory_exit:
    ret