bzero_memory_init:
    xor rcx,rcx

    cmp rcx,rax

    jl bzero_memory_loop

    jmp bzero_memory_exit


bzero_memory_loop:
    
    mov [rsi],byte 0

    add rsi,1
    inc rcx

    cmp rcx,rax


    jle bzero_memory_loop

    jmp bzero_memory_exit

bzero_memory_exit:
    ret



    

