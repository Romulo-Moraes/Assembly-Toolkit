# 10. Macros
The objective of macros is to reduce the amount of complex code that a programmer has to write. A piece of code or a numeric constant can be replaced by a label, making it easier to remember and understand.

## 10.1. How does a macro works ?
A macro is identified by a name, and this name represents something useful assigned by the programmer. Every time the assembler encounters a macro in the code, that name will be replaced by the value assigned to that macro. A good example of this is the `%define` macro:
```asm
%define SYS_EXIT 60
```
The assembler will replace every 'SYS_EXIT' by 60, which is easier to remember than a decimal number.

## 10.2. C functions using macros
Macros make it possible to use C-like functions in assembly language.

```asm
; this macro have to start with '%macro',
; followed by its name and a number 
; that represents how many arguments
; it takes. The end of the macro
; is defined by '%endmacro'

; The macro arguments can be acessed
; by %x, where x is the argument index,
; beginning from 1

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
Everything provided to these macros will be used to replace the %x's in their definition


## 10.2.1. Warnings about the macros
The task of a macro is to replace the identifier with its value. A large instruction set inside a macro may create a final executable with an unexpected size; therefore, macros that call functions may be a better approach. Tasks such as writing data on the screen can be accomplished by macros without further trouble; all moves and the syscall in this operation would be performed anyway.

Although not explicitly stated, macros will use and modify the registers during their execution. So be aware of how your code will behave before and after using a macro.

## 10.2.2. Examples
There is a file called `example.asm` inside the `src` directory that provides examples of how macros may be useful.

## 10.3. The include macro
The `include` macro is useful for splitting your source code into different files, making it easier to build a low-level application.
```asm
; when the assembler reads this macro,
; it will replace this line with the
; entire content of the 'strlen.asm' file.
%include 'strlen.asm'
```

## 10.4. Undefining macros
Similar to the C programming language, there is a macro to undefine a previously created macro.
```asm
; Defines a macro named 'NAME'
%define NAME 'Francisco'

; Undefine the macro
%undef NAME
```

## 10.5. Conditional macros
Conditional macros are useful for inserting or removing a block of instructions based on the result of a conditional test.
```asm
; Undefining this macro with %undef
; or just not creating it will make
; the message don't be printed
%define ALLOW_PRINT

%ifdef ALLOW_PRINT
    ; this print is the same macro
    ; created previously
    print msg, msg_len
%endif
```
A complement to the `%ifdef` macro is the `%else` and `%elifdef`. Here is a basic explanation of them:
```asm
%define ALLOW_PRINT

%ifdef ALLOW_PRINT
    ; Prints if ALLOW_PRINT is defined
    print msg, msg_len
%elifdef ALLOW_PRINT2
    ; only prints if the ALLOW_PRINT2 is defined
    ; and the ALLOW_PRINT is not defined
    print msg2, msg2_len
%else
    ; Prints if ALLOW_PRINT and 
    ; ALLOW_PRINT2 are not defined
    print msg3, msg3_len
%endif
```
The last one is the `%ifndef` macro. This macro does the same thing as the `%ifdef`. However, the result will be true if the given definition is not defined.
```asm
%ifndef DENY_PRINT
    ; Will print if the macro
    ; DENY_PRINT is not defined
    print msg, msg_len
%endif
```
## 10.6. Last notes about macros
The macros provided in this section are very simple and commonly used. However, the Nasm assembler implements more complex macros that may be helpful in some cases. You can find the full documentation about macros here: https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc4.html
