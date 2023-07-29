# 9. Arrays
Arrays are the most common data structure of many programming languages, and here is also possible to use them, however, in a very low-level approach. In the C programming language, the only necessary thing to read or write to a position of the array is just pass the index of the element that you wan't use; around here it isn't really different, but is necessary do some calculations that the C does under the table. The calculation isn't that hard, basically follow this equation:
```txt
base_array_address + (index * sizeof_data) = correct_address_to_use.
```


## 9.1 Allocating an array
First of all, we must allocate a good space to put our array, there's no secret here at all, just moving the stack pointer like as we did before.

```asm
mov rbp, rsp
sub rsp, INT_SIZE * 10 ; INT_SIZE is a macro with the value: 4

; There's a 40 bytes space allocated in the stack now
```

## 9.1 Growing direction
Like moving strings into the stack using registers, the array here must start from the bottom and grow up to the top. Having it in mind we can now load the base array address.
```asm
lea rdi, [rbp+-INT_SIZE * 10]
```

## 9.2 Writing values into the array
With the base address of the array on hands, the rest is the easiest part, to write to a position we must add this address to the index multiplied by the size of the data stored there.
```txt
mov DWORD [rdi+INT_SIZE * 0], 1
mov DWORD [rdi+INT_SIZE * 1], 2
mov DWORD [rdi+INT_SIZE * 2], 4
mov DWORD [rdi+INT_SIZE * 3], 8
mov DWORD [rdi+INT_SIZE * 4], 4
mov DWORD [rdi+INT_SIZE * 5], 2
mov DWORD [rdi+INT_SIZE * 6], 1
mov DWORD [rdi+INT_SIZE * 7], 2
mov DWORD [rdi+INT_SIZE * 8], 4
mov DWORD [rdi+INT_SIZE * 9], 8
```
In this example some constants were used, however, the flexibility of use values that lies inside registers is also possible!

## 9.3 Read and write sizes alert
**Always remember of specify the correct data movement size (i.e. BYTE, WORD, DWORD, QWORD) or even using registers of the correct size of the data type inside the structure, wrong movement sizes can overwrite adjacent indexes whether bigger than the defined or lose some array cell capability whether smaller than the defined. This alert is also useful for read operations.**

## 9.4 Array size alert
**Like in the C programming language, the array in assembly starts at the index 0 and end at the index LENGTH - 1, don't let your code logic pass the boundaries of the array, if it is located at the beginning of the stack frame, very probably you will overwrite the RBP saved register and even the return address of the procedure located beyond the RBP, issuing a segmentation fault.**

## 9.5 Reading values from the array
Here we will create a small procedure that receives a int pointer and print all values of this array. There're some macros in the code, but all of them have a comment saying its value.
```asm
print_int_array:

    push rbp
    mov rbp, rsp
    sub rsp, 11

    ; LOOP_COUNTER_LOCATION = -1
    mov BYTE [rbp+LOOP_COUNTER_LOCATION], 0
    ; A new line is being put in the position -2, but a print 
    ; syscall will be made pointing to -3. This is just to
    ; make the print prettier.
    mov BYTE [rbp+-2], 0xa
    ; Saving the array pointer, each syscall clean everything
    ; from the rdi register
    ; INT_POINTER_LOCATION = -11
    mov [rbp+INT_POINTER_LOCATION], rdi

print_loop:
    ; Compare the counter to check whether we reached at
    ; the end of the array
    cmp BYTE [rbp+LOOP_COUNTER_LOCATION], 10
    jge print_loop_end

    ; Move counter to dl register
    mov dl, [rbp+LOOP_COUNTER_LOCATION]
    ; Loading the element from the array using rdx register
    ; (dl is the 8bit part of rdx).
    mov eax, [rdi+rdx * INT_SIZE] ; INT_SIZE = 4

    ; Here we know that the value inside is smaller than a byte
    ; so will be used the 8bit part of eax to transform the number
    ; to string.
    add al, '0'

    ; Move the number character to the position
    ; to be finally printed.
    mov [rbp+-3], al

    ; Syscall print to the position -3
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-3]
    mov rdx, 2
    syscall

    ; Increment counter to the next iteration
    inc BYTE [rbp+LOOP_COUNTER_LOCATION]

    ; Reload array pointer from RAM, this is because
    ; the syscall wiped out everything inside the rdi
    ; register
    mov rdi, [rbp+INT_POINTER_LOCATION]

    ; Jump to the loop again to print the next position
    jmp print_loop

print_loop_end:
    ; End of the procedure
    mov rsp, rbp
    pop rbp

    ret
```
The complete example is located at the same directory of this README.md.

## What's next
The array section is complete by now, with this is possible making more complex softwares. Even whether in high-level languages this is pretty simple and nobody really cares about an arrays, in the low-level language any resource is valuable, since here there's no built-in features, just metal. In the next section will be possible see some solutions, like C functions, that can really help in some situations.