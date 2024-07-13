# 9. Arrays
Arrays are the most common data structure in many programming languages, and it is also possible to use them in a low-level approach. In the C programming language, performing read and write operations on an array requires passing the array position where such operation will be performed. Passing a number to identify an element inside an array is an abstraction, something that does not exist in low-level programming. Therefore, we will need to perform some calculations to read and write to the correct array position.
```txt
effective_address = base_array_address + (index * sizeof_data)
```


## 9.1 Allocating an array
First of all, we have to allocate a good space on memory in order to create the array.

```asm
; INT_SIZE is a macro that represents the number 5
mov rbp, rsp
sub rsp, INT_SIZE * 10 
```

## 9.2 Defining the array base address
After allocating memory to create the array, it is time to set its base address. The `lea` opcode can easily accomplish this task: 

```asm
lea rdi, [rbp - INT_SIZE * 10]
```
The INT_SIZE macro contains the value 4, so after evaluating this instruction, the `rdi` register will contain an address value 40 positions smaller than `rbp`.

## 9.3 Writing values to the array
To write to the array, we have to execute the equation shown at the beginning of this section.

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
This example uses immediates as index, but 64-bits registers can be used too.


## 9.4 Read and write sizes
Always remember to specify the correct operation size (e.g. BYTE, WORD, DWORD, QWORD) or use registers of the correct size for the data type within the structure. Incorrect operation sizes can overwrite adjacent indexes if they are larger than the defined size, or waste array cell capacity if they are smaller than the defined size.

## 9.5 Array size
Similar to the C programming language, the array in assembly starts at index 0 and ends at index LENGTH - 1. Do not allow your code logic to override the array boundaries. If the array is allocated after the variables, it will likely overwrite them and possibly even the saved `RBP` value. In the worst case, it can destroy the return address of the procedure and cause your program to crash.

## 9.6 Array example
There is an assembly file in the same directory as this README named `example.asm`. This file provides an example of creating, writing, and reading from an array.