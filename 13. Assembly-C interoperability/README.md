# 13. Assembly-C interoperability
Assembly and C can work together to accomplish tasks, with each technology contributing in its own way. It is possible to write functions in C and run them in Assembly, as well as write Assembly procedures to run them in a C executable. This entire process is only possible due to the linker's capability to join both together.


## 13.1. The object file
Upon compiling a C source file, the compiler generates an object file (.o) that contains all the instructions for the functions defined in the source. Similarly, the assembler produces an object file that must be passed to the linker to create the final executable. Despite being generated from different sources, both files can be linked by the linker, allowing them to interact with one another

## 13.2. Calling Assembly from C
To call Assembly from C we create a procedure that prints a message and export it through the linker in order to make it accessible inside the C environment.
```asm
global helloMsg ; making the procedure globally 
                ; visible to the linker

%define SYS_WRITE 1
%define STDOUT 1

segment .text

helloMsg:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    ; we will cover about this line
    ; in the next section
    lea rsi, [rel message]
    mov rdx, message.sz
    syscall

    ret
    

segment .rodata
    message db "Hello, C lang!", 0xa
    message.sz equ $-message
```
To call an Assembly procedure from C, you have to explicitly declare the procedure as global; otherwise, the linker will ignore any request from the C code that tries to reference it.


Let's write a program in C to call this procedure written in Assembly.
```c
// Asking the linker to give us the address
// of the helloMsg() procedure
extern void helloMsg();

int main(void){
    // Calling the procedure
    helloMsg();

    return 0;
}
```
Assembling the source file will generate the object file:
```sh
nasm -f elf64 assembly.asm -o assembly.o
```

After that, we can provide the C source file and the Assembly object file to the GCC.
```txt
gcc ccode.c assembly.o -o executable
```
Running the executable:
```txt
./executable
Hello, C lang!
```

## 13.3. Calling C from Assembly
One advantage of invoking C functions from Assembly is that C provides high-level control structures, such as `if/else`, `switch`, `while`, and `for`.

Performing operations in Assembly using C procedures makes the entire process easier.
```c
#define MAX_UNSIGNED_INT_DIGITS_COUNT 10

void fillArrayIncrementally(unsigned int *array, unsigned int begin, int arraySize){
    int i = 0;

    while(i < arraySize){
        array[i++] = begin++;
    }
}

unsigned sumArray(unsigned *array, int arraySize){
    int total = 0;

    for(int i = 0; i < arraySize; i++){
        total += array[i];
    }

    return total;
}

void intToString(unsigned int number, char *output){
    char numberAsString[MAX_UNSIGNED_INT_DIGITS_COUNT + 1] = {0};
    unsigned short i = MAX_UNSIGNED_INT_DIGITS_COUNT;

    // Converting the number to string
    while(number != 0){
        numberAsString[i--] = (number % 10) + '0';
        number /= 10;
    }

    // Copying the result to output
    for(i = i + 1; i <= MAX_UNSIGNED_INT_DIGITS_COUNT; i++){
        *output = numberAsString[i];
        output++;
    }

    *output = '\0';
}

int strLen(char *string){
    int len = 0;

    while(*string){
        len++;
        string++;
    }

    return len;
}
```
Assembly code that will call the C functions.
```asm
global _start

; importing external procedures
extern fillArrayIncrementally, sumArray, intToString, strLen

; macros
%define SYS_WRITE 1
%define SYS_EXIT 60
%define STDOUT 1
%define EXIT_SUCCESS 0
%define SIZEOF_INTEGER 4
%define INTEGER_ARRAY_SIZE 10

%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro

%macro print 1
    mov rdi, %1
    call strLen

    mov rdx, rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, %1
    syscall
%endmacro

segment .text

_start:
    ; Allocating memory
    mov rbp, rsp
    sub rsp, SIZEOF_INTEGER * INTEGER_ARRAY_SIZE

    ; calling the fillArrayIncrementally C code function
    lea rdi, [rbp+-SIZEOF_INTEGER * INTEGER_ARRAY_SIZE]
    mov rsi, 4
    mov rdx, INTEGER_ARRAY_SIZE
    call fillArrayIncrementally

    ; calling the sumArray C code function
    mov rsi, INTEGER_ARRAY_SIZE
    call sumArray

    ; calling the intToString C code function
    mov rdi, rax
    mov rsi, numberAsString
    call intToString

    ; printing the result
    print msg
    print numberAsString
    print newLine

    exit EXIT_SUCCESS

segment .bss
    numberAsString resb 11

segment .rodata
    msg db "The sum of all elements of the array is: ", 0x0
    newLine db 0xa

```
Compiling the C source code...
```txt
gcc -c -o ccode.o ccode.c -fno-stack-protector
```
Assembling the Assembly source code...
```txt
nasm -f elf64 assembly.asm -o assembly.o
```
By default, the compiler installs protections against memory violations. However, in doing so, the compiler may insert some function calls inside your procedures. The problem is that these functions are not linked statically to your program, so an undefined reference will crash the linker.

The flag `-fno-stack-protector` instructs the compiler not to insert these memory violation countermeasures, making it possible to link your C code to the Assembly code without additional issues.

Linking everything...
```txt
ld assembly.o ccode.o -o assembly
```
Running the executable: 
```txt
./assembly
The sum of all elements of the array is: 85
```
Using primarily C procedures, this assembly program can populate, sum, and print the values of an integer array.

### 13.3.1 The importance of calling conventions
We can see that two different sets of instructions generated by different sources can friendly communicate with each other. This is due to the calling conventions, functions that follow these conventions can also expect that other functions are also following the same conventions, making it possible to send and receive data among them.

## 13.4. Using libc functions in Assembly
Unfortunately, the C standard functions (Glibc) are dynamically linked to the programs. Due to this, we can only use the C functions that we write ourselves. However, there is nothing preventing us from linking the Glibc against our executable and using all functions from there.
```asm
segment .text
; Import anything you want to use from the Glibc
extern exit
extern puts
extern fgets
extern stdin
extern fflush
extern printf
global _start

_start: 
    mov rbp, rsp
    sub rsp, 50

    ; Glibc puts function
    mov rdi, message1
    call puts

    ; Glibc fgets
    lea rdi, [rbp+-50]
    mov rsi, 49
    mov rdx, [stdin]
    call fgets

    ; Glibc printf
    xor rax, rax ; printf requires to rax be 0
    mov rdi, message2
    call printf

    ; Glibc fflush
    mov rdi, [stdin]
    call fflush

    lea rdi, [rbp+-50]
    call puts

    ; Exiting the program calling the glibc exit function
    mov rdi, 0
    call exit

segment .rodata
    message1 db 'Hey! type a message: ', 0x0
    message2 db 'You typed: ', 0x0
```
The `extern` keyword behaves in exactly the same way for functions coming from shared objects.

The program above can't run yet, it have to be linked against the glibc shared object first.

The following set of commands accomplish the assembling and the linking tasks:
```sh
nasm -f elf64 assembly.asm

# The path to the library may be different
# in your system
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc assembly.o -o assembly
```
This should run the program and make the following output:
```txt
./assembly 

Hey! type a message: 
Hello from GLIBC!!!
You typed: Hello from GLIBC!!!
```
## 13.5. Conclusion of Assembly-C interoperability
Assembly can effectively control the CPU, while the C language excels in managing memory and high-level structures such as `if/else` and `while`. Working together, they can accomplish complex tasks without encountering significant issues.
