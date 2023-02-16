# 5. Jumps and conditional jumps
Jumps is a essential part of nowadays computers, with this we can make loops, conditional structures like if/else and switch, constructing what we know today by modern languages.

There's many possible jumps, being conditional or not, they are the following:
```txt
JMP - Jump to a address given by it's unique operand

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
Each one accepts a symbol that lies in .text segment.

## 5.1 Symbols in .text segment
A symbol represents an address in memory, such address that points to the next instruction ahead the symbol, it can be made typing a name that can't start with numbers and can has '_', a-z and A-Z on it's content and ending with a colon, for instance:
```asm
_append_number_in_rax:
    add rax, 0xa

    ret
```

## 5.2 Comparing values
There's a special opcode that do the comparison called 'cmp', this accepts two operands, and after that we can call a jump and pass a flag with it. For instance:
```asm
    cmp rax, rbx ; cmp subtract rbx from rax

    ; since that cmp subtracts a operand from 
    ; another, jz can be used to check if 
    ; both are equal. 4 - 4 = 0.

    jz <Symbol>
```

## 5.3 Practice with jumps
In the current directory was put some assembly source files with examples of programs, being them: loops, if/else, etc... Give a look to know a bit more about.
