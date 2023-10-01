# Extra. Assembly-C interoperability
Assembly and the C programming language are kinda brothers when the subject is work together, it's possible to write functions in C and run it on Assembly and even write Assembly procedures to run in a C executable, this process is easily done by the linker, and we will cover it now.


## Extra. The object file
After just compile a C source file, the compiler will spit out a object file (.o), basically having all the instructions that the functions of the file contains. The Nasm does the same thing, and spit out a object file after assemblying an Assembly source file. Theses files even being generated from diferent sources, they can work as whether they were just one thing, and the linker will be used to do this.


## Extra. Writing a procedure in assembly that is callable from the C source code
First of all, we need write some bits inside a procedure to then it be possible to be called in a C program, a simple example that we can do is a procedure named as 'hello_msg' that prints 'Hello, C lang!'.
```asm
segment .text
global hello_msg ; export the procedure

hello_msg:
    push rbp
    mov rbp, rsp
    sub rsp, 15

    mov rax, 'Hello, C'
    mov [rbp+-15], rax
    mov rax, ' lang!'
    mov [rbp+-7], rax
    mov BYTE [rbp+-1], 0xa

    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-15]
    mov rdx, 15
    syscall

    mov rsp, rbp
    
    pop rbp
    ret
```
It's important to say that if you want to a procedure be visible by the linker to link to another executable, the procedure name must be defined in the global keyword, this keyword accepts values separated by commas.

Now let's write a program in C to call this procedure written in Assembly.
```c
// Asking to the linker to give us the address
// of the hello_msg() procedure
extern void hello_msg();

int main(void){
    // Calling the procedure
    hello_msg();

    return 0;
}
```
Now we have to assemble our Assembly source file:
```sh
nasm -f elf64 assembly.asm -o assembly.o
```
This will generate the object file with the name 'assembly.o', the next step is pass the C source code to the C compiler together with the assembly object, the compiler will compile the C source code and link both object to become an unique executable.
```txt
gcc ccode.c assembly.o -o ccode
```
Executing the ccode executable we get the expected output.
```txt
./ccode
Hello, C lang!
```

## Extra. Writing a function in C that is callable from the Assembly source code
Now is the turn of the C show its power, lets write a function that does something great and export it to Assembly.
```c
void integer_to_string(int number, char *output){
    int i;
    int bufferIndex = 0;
    char buffer[128];

    while(number >= 10){
        i = number % 10;

        buffer[bufferIndex] = (i + '0');
        bufferIndex++;

        number /= 10;
    }

    buffer[bufferIndex] = (number + '0');

    for(;bufferIndex >= 0; bufferIndex--){
        *output = buffer[bufferIndex];
        output += 1;
    }

    *output = '\n';
}
```
And now a Assembly code that will call this function.
```asm
segment .text
; Extern keyword, like in C, ask to the linker
; to give us a reference of an external function
extern integer_to_string
global _start

_start:
    mov rbp, rsp
    sub rsp, 8
    mov QWORD [rbp+-8], 0x0 ; Cleaning stack

    ; Prepare function arguments
    mov rdi, 51423;
    lea rsi, [rbp+-8]
    ; Function call
    call integer_to_string

    ;; Preparing print to show the string
    mov rax, 1
    mov rdi, 1
    lea rsi, [rbp+-8]
    ; I know how many characters will
    ; back from the function... it's a cheat.
    ; The correct would be a strlen function to get
    ; the length of this string
    mov rdx, 6; +1 for '\n' set in C code
    syscall


    mov rax, 60
    mov rdi, 0
    syscall
```
Assemblying the Assembly file...
```txt
nasm -f elf64 assembly.asm -o assembly.o
```
Compiling the C source code...
```txt
gcc -c -o ccode.o ccode.c -fno-stack-protector
```
Explanation of the **-fno-stack-protector**: By default, the GCC compiler install some protections against memory violations, such thing that isn't hard to occur in a C program, however, with this feature, the compiler may inject some functions calls inside the object file, the problem is that these functions aren't statically linked with the program, issuing a reference problem when linking the object files. Using this compiler flag, the compiler will remove some protections against these violations, but in this way we can finally link our binary files. About security... don't worry, there's no thing more memory-unsafe than Assembly, the language that whether you forget of pop the rbp before the ret opcode the world gets on fire.

Linking everything...
```txt
ld assembly.o ccode.o -o assembly
```
Now we just need to run the executable.
```txt
sh-5.1$ ./assembly 
51423
```
Great! The number that we put into the rdi register became a printable string calling it from Assembly!!!

## Extra. Use of the C standard function ?
Unfortunately, the C standard functions collection (i.e. Glibc) is dynamically linked, and this process that we made until now only does static links, without this we still can enjoy some power of the C without the library, that allows you to use arithmetic, loops, conditional statements, easy declaration of variables and arrays, etc... But this isn't the end of the line, it's possible to link the Glibc to our Assembly programs and use everything from there, being the possibilities: printf, scanf, strlen, strcmp, and more. Here is how to dinamically link the Glibc to our executables.
```asm
segment .text
; Import anything you want to from the Glibc
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
The extern keyword works exactly in the same way for function coming from shared objects, after importing, is just pass the arguments to the functions and use the opcode 'call' on them. All functions follow the same rule of arguments supply that was shown to you in the section **8. Functions**, **8.8 Calling conventions** to be exact.

The program can't run yet, we must link with the shared object that is present on the filesystem, in my system it's in the path '/lib64/ld-linux-x86-64.so.2', verify the same path there and be ready to link. The following set of commands do the work very well:
```txt
nasm -f elf64 assembly.asm
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -lc assembly.o -o assembly
./assembly
```
This should run the program and make the following output:
```txt
sh-5.1$ ./assembly 
Hey! type a message: 
Hello, world!!!
You typed: Hello, world!!!
```
## Extra. Conclusion of Assembly-C interoperability
Assembly has the maximum control over the CPU and C is very good at memory manipulation; and still having high-level structures, like if/else, while, etc... Beyond also having a magic shared library, Mixing both... perfect match, isn't it ?

# Extra of the extra. Position-independent code
Position-independent code, or just PIC, is a program that doesn't uses absolute addresses on its execution, this usually happens when you use an address from segments like .rodata or .data. What happens is that when you refer to symbols that lies in those segment you are calling a fixed address that the linker addressed to you, however, when the program is loaded into the memory for execution, these fixed addresses doesn't hold meaning anymore, even because the program may be loaded in a random location in memory,  requiring that the OS loader update these addresses at the loading time to the executable be able to access the correct data in run-time. With the PIC, we can access RIP relative addresses, giving more flexibility. RIP is a special register from the CPU that points to the next instruction to be executed in memory, when the CPU finish of executing the current instruction, it will fetch from that address, and then, update the RIP again. With the RIP pointing to the next instruction (That's very close) we can just order to the CPU use the RIP address plus a offset to make a jump, read/write an address or even a procedure call.
```asm
segment .text
global _start

_start:

    mov rax, 1
    mov rdi, 1
    ; Passing the address of msg relative to the RIP
    lea rsi, [rel msg]
    ; It isn't necessary with msg.sz
    ; this is a macro, not an address, so
    ; it is resolved at Assemble time
    mov rdx, msg.sz
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    msg db 'Hello, people.', 0xa, 0x0
    msg.sz equ $-msg
```
Without this, some problems would be found when moving a Assembly code to execute alongside a C lang code. A example of this is the following:
```txt
sh-5.1$ gcc main.c rel_hello_world.o -o main
/usr/bin/ld: rel_hello_world.o: relocation R_X86_64_32S against `.data' can not be used when making a PIE object; recompile with -fPIE
/usr/bin/ld: failed to set dynamic section sizes: bad value
collect2: error: ld returned 1 exit status
```
This is a try of print the msg symbol using absolute address, like we have been doing until now. (In this example the global entry and the name of the procedure was changed to printtt, there's no possibility of link a object file that contain the _start procedure using the GCC, that's because a conflict will happen when the compiler try to link the files. The GCC compiler when building the program will try implement its own _start procedure (which one that call the programmable procedure main)).

## Extra of the extra. Callbacks!!!!
There's the possibility of callbacks, even being in the low-level. We can move the address of a symbol from the .text to a register and then call it any time we want to, or do anything with it, store this address on the stack or in any other memory segment is also possible. Here's a example of callbacks, this source code is also available inside the directory ./Callbacks.
```asm
segment .text
global _start

function2:
    push rbp
    mov rbp, rsp

    ; Insert the number into the string
    add rdi, '0'
    mov [rel function2_msg+function2_msg.sz-3], dil

    ; Print it
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel function2_msg]
    mov rdx, function2_msg.sz
    syscall

    pop rbp

    ret

function1:
    push rbp
    mov rbp, rsp

    ; Insert the number into the string
    add rdi, '0'
    mov [rel function1_msg+function1_msg.sz-3], dil

    ; Print it
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel function1_msg]
    mov rdx, function1_msg.sz
    syscall

    pop rbp

    ret

; chooser_procedure(int, fpointer, fpointer, int)
chooser_procedure:
    push rbp
    mov rbp, rsp

    ; Comparing the rdi to decide which function
    ; pointer will be called
    cmp rdi, 1

    ; Move the content of rcx to rdi,
    ; this will be the value printed from 
    ; any called function
    mov rdi, rcx

    ; Ignore 'call rsi' and jump to call the function2
    jne not_1

    ; Calls the function1
    call rsi
    jmp chooser_procedure_end
not_1:
    ; Calls the function2
    call rdx
chooser_procedure_end:
    pop rbp
    ret

_start:
    ; This function call will call the function1
    ; in the end
    mov rdi, 1
    ; Both rsi and rdx are callbacks
    lea rsi, [rel function1]
    lea rdx, [rel function2]
    mov rcx, 5
    call chooser_procedure

    ; This function call will call the function2
    ; in the end
    mov rdi, 2
    ; Both rsi and rdx are callbacks
    lea rsi, [rel function1]
    lea rdx, [rel function2]
    mov rcx, 5
    call chooser_procedure

    ; Exit the program
    mov rax, 60
    mov rdi, 0
    syscall

segment .data
    function1_msg db 'The FIRST function option printing the number: ', 0x1, 0xa, 0x0
    function1_msg.sz equ $-function1_msg

    function2_msg db 'The SECOND function option printing the number: ', 0x1, 0xa, 0x0
    function2_msg.sz equ $-function2_msg
```
Callbacks is a really interessant concept, there's not the necessity of passing a argument to the 'chooser_procedure', in usual cases the 'chooser_procedure' generate the data and give to your function to handle with it.


# The syscall 60
After having even the 'Extra of the extra' section, this reached to the end, Was left a good content here, and will be really good for any basic doubt about the Assembly language of anyone. Thanks :)