; Set a value for each address position in memory

; Input: Address in RSI, range size in RAX, value to set in bl,

memset:
    xor rcx,rcx

memset_memory_loop:
    
    cmp rcx,rax

    jge memset_memory_exit

    mov [rsi], bl

    inc rsi
    inc rcx

    jmp memset_memory_loop

memset_memory_exit:
    ret



    

