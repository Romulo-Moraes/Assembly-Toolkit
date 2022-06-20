; Set a value for each address position in memory

; Input: Address in RSI, range size in RAX, value to set in RDX,

memset:
    xor rcx,rcx

    cmp rcx,rax

    jl memset_memory_loop

    jmp memset_memory_exit


memset_memory_loop:
    
    mov [rsi],rdx

    add rsi,1
    inc rcx

    cmp rcx,rax


    jle memset_memory_loop

    jmp memset_memory_exit

memset_memory_exit:
    ret



    

