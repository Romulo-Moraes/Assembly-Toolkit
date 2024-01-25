# 5. Jumps and conditional jumps
Jumps are a essential part of nowadays computers, with them we can create loops, conditional structures like if/else, switch and more.

There are many possible jumps, whether conditional or not. They are as follows:
```txt
JMP - Jump to a address given by its unique operand

JO - Jump on overflow (signed operation)
JNO - Jump on not overflow (signed operation)

JC - Jump on overflow (unsigned operation)
JNC - Jump on not overflow (unsigned operation)

JGE - Jump if greater or equal
JLE - Jump if less or equal

JZ - Jump if Zero
JNZ - Jump if not Zero

JL - Jump if less
JG - Jump if greater
JE - Jump if equal 
JNE - Jump if not equal 
```

Every jump takes a label located in the .text segment.

## 5.1 Labels in .text segment
A label represents an address in memory that points to the next instruction after the symbol. It can be created by typing a name that cannot start with numbers and may include '_', 'a-z', and 'A-Z' in its content, ending with a colon. For instance:
```asm
_append_number_in_rax:
    add rax, 0xa
	
	; We will talk about this command after
    ret
```

## 5.2 Comparing values
There is a special opcode for comparison called 'cmp,' which takes two operands. After that, we can invoke a jump and pass a label with it. For instance:
```asm
    cmp rax, rbx ; cmp subtract rbx from rax

    ; since cmp subtracts a operand from 
    ; another, jz can be used to check if 
    ; both are equal. 4 - 4 = 0.

	; Jump to <Symbol> if rax equals to rbx
    jz <Symbol>
```

## 5.3 Practice with jumps
In the current directory, some assembly source files with examples of programs were placed, including loops, if/else statements, etc. Take a look if necessary.