# 9. Arrays
Arrays are the most common data structure in many programming languages, and it is also possible to use them in a low-level approach. In the C programming language, performing read and write operations on an array requires passing the position index. Passing a number to identify an element inside an array is an abstraction, something that doesn't exist in low-level programming. Therefore, we will need to perform some calculations to read and write to the correct array position.
```txt
correct_address_to_use = base_array_address + (index * sizeof_data)
```


## 9.1 Allocating an array
First of all, we have to allocate a good space on memory in order to create the array.

```asm
mov rbp, rsp
sub rsp, INT_SIZE * 10 ; INT_SIZE is a macro that represent the number 4

; We have just allocated 40 bytes, enough to store 10 x64 integers
```

## 9.1 Growing direction
Similar to moving strings into the stack, the array has to begin from the bottom and grow up to the top. Keeping that in mind, we can now load the base array address.
```asm
lea rdi, [rbp+-INT_SIZE * 10]
```

## 9.2 Writing values to the array
To write to the array, we have to perform the equation shown at the beginning of this section.

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
This example uses some contants, however, registers can also be used.


## 9.3 Read and write sizes
Always remember to specify the correct data movement size (i.e., BYTE, WORD, DWORD, QWORD) or use registers of the correct size for the data type inside the structure. Incorrect movement sizes can overwrite adjacent indexes if larger than the defined size or lose some array cell capability if smaller than the defined size.

## 9.4 Array size
Similar to the C programming language, the array in assembly begins at index 0 and ends at index LENGTH - 1. Do not allow your code logic to pass the boundaries of the array. If the array is allocated after variables, it will probably overwrite them and possibly the saved `RBP` value. In the worst case, it may destroy the return address of the procedure located outside the frame.

## 9.5 Array example
There is an assembly file in the same directory as this README named `example.asm`. This file provides an example of creating, writing, and reading from an array.