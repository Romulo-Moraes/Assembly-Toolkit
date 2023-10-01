# 10. Macros
Macro is a utility that has the goal of make the life of someone easier. Was shown previously the macro %define, that is very helpful in some situations, however, this isn't the only one that can comes in handy.

## 10.1. How does a macro works ?
A macro on it's essence is just a name that will be replaced on the code by the value assigned to it. The macro %define is useful for explanation. Each time that the assembler finds a macro created like this:
```asm
%define SYS_exit 60
```
It will replace every 'SYS_exit' by 60, that is easier to remember than a decimal number.

## 10.2. The macro named macro
Using macro allow us to create 'function' calls on the C style, that is the function name followed by the arguments. This is how it works:
```asm
; A macro must start with %macro, followed
; by its name and  a number that is how many 
; arguments it takes, and finally closed with 
; %endmacro.

; The arguments of the macro can be acessed
; by %x, where x is the argument index. This
; value starts from 1.

%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro
```
The above macro created with the name 'print' can be used by the following way:
```asm
print rodata_message, rodata_message_len
```
It is also possible call a function inside the macro to automatically get the length of the message to print, without pass it manually.


## 10.2.1. Warnings about the macros
As said previously, the assembler will replace any name that match with a macro by its value, and this may be a bad thing. A macro with many instructions may makes your final executable bigger whether used many times, a macro that calls functions is much better. Print a message is a good example of using macros, moving values to registers and issuing a system call will be always required, and transform it to a procedure don't give you great advantages.

Even being not explicit, a macro will use and modify the values of the registers that it is programmed to use. Be aware of what you are doing inside a macro and how it may affect the program's flow, that code will be put where you called it.

## 10.2.2. Real example of the macro
A example using macros is inside the directory './src'. There's the use of the macros exit, print and strlen.

## 10.3. The include macro
The include macro was not presented formally before, but is also very useful to split your source code into files and let the assembler join them while doing its job. This is how it works:
```asm
; When the assembler finds this macro,
; it will replace this line by the entire
; content of the 'strlen.asm' file. Basically
; joining them, to make the assembly process.
%include 'strlen.asm'
```

## 10.4. Undefining macros
Like in C language, there's a macro to undefine another macro, its name is %undef. Here's how it works:
```asm
; Defines a macro named 'NAME'
%define NAME 'Francisco'

; Undefine the macro
%undef NAME
```

## 10.5. Conditional macros
Another handful macro that is also present in the C language is the %ifdef. This macro will make the assembler ignore or assemble its contents depending of the 'if' result, that is given by testing the existence of the macro. The conditional structure ends with %endif:
```asm
; Undefining this macro with %undef
; or just not creating it will make
; the message be not printed
%define ALLOW_PRINT

%ifdef ALLOW_PRINT
    ; Is the same print macro
    ; created previously
    print msg, msg_len
%endif
```
A complement of the %ifdef macro is the %else and %elifdef. Here's a basic explanation of them:
```asm
%define ALLOW_PRINT

%ifdef ALLOW_PRINT
    ; Print if ALLOW_PRINT is defined
    print msg, msg_len
%elifdef ALLOW_PRINT2
    ; Print if ALLOW_PRINT is not defined but
    ; the ALLOW_PRINT2 is defined
    print msg2, msg2_len
%else
    ; Print if ALLOW_PRINT and 
    ; ALLOW_PRINT2 are not defined
    print msg3, msg3_len
%endif
```
The last one is the %ifndef macro. This macro does the same thing as the %ifdef, but in a negated way.
```asm
%ifndef DENY_PRINT
    ; Will print if the macro
    ; DENY_PRINT is not defined
    print msg, msg_len
%endif
```
## 10.6. Last notes about macros
Although macros be presented in C compilers and another assemblers, each one may implement this feature on different ways. So macros and coding structure from Nasm won't be the same in another assembler. Talking about the assembly instructions like add, cmp, mul... they will only change in another computer architecture.

The macros shown in this section are very simple, but the Nasm contains more complex macros that may help sometime. Here's the full documentation about macros using the Nasm: https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc4.html

## What's next
The use of macros really help us to make through repetitives tasks and have more control about the execution flow. In the next section a group of simple solutions using Assembly will be shown.