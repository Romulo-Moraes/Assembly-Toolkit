# 5. Jumps and conditional jumps
Jumps are a essential part of nowadays computers, with them we can create loops, conditional structures like if/else, switch and more.

There are many jumps that you can use in different circumstances, based on a condition or an unconditional jump.

<ul>
    <li>JMP - Jump to a address given by its unique operand</li>
    <li>JO - Jump on overflow (signed operation)</li>
    <li>JNO - Jump on not overflow (signed operation)</li>
    <li>JC - Jump on overflow (unsigned operation)</li>
    <li>JNC - Jump on not overflow (unsigned operation)</li>
    <li>JGE - Jump if greater or equal</li>
    <li>JLE - Jump if less or equal</li>
    <li>JZ - Jump if Zero</li>
    <li>JNZ - Jump if not Zero</li>
    <li>JL - Jump if less</li>
    <li>JG - Jump if greater</li>
    <li>JE - Jump if equal </li>
    <li>JNE - Jump if not equal </li>
</ul>

Every jump takes a label located in the .text segment.

## 5.1 Labels in .text segment
A label represents the memory address of the next instruction from its definition. A label can be created using the characters  `_`, `a-z`, `A-Z` and `0-9`, followed by a `:`; however, the name cannot start with numbers. Here is a small example:
```asm
my_first_label:
MY_SECOND_LABEL:
int2float:
```

## 5.2 Comparing values
There is a opcode that is often used to compare two values called `cmp`. Using this opcode, you can tell if a values is less, less or equal, equal, greater or greater or equal than another value, performing a conditional jump depending on the result whether necessary.
```asm
    ; cmp subtracts rbx from rax
    cmp rax, rbx 

    ; since cmp subtracts a operand from 
    ; another, jz can be used to check if 
    ; both are equal. 4 - 4 = 0.
    ; je can also be used to achieve the same results here

	; Jump to <label> if rax equals to rbx
    jz <label>
```

## 5.3. Overflow jumps
Overflow jumps make it possible to handle overflow on arithmetic operations, avoiding unexpected values after performing them. Here are some small examples using a 8-bit register (max unsigned: 255, max signed: 127): 

### 5.3.1. Triggering a signed operation overflow
The jump `JO` can be used here to handle this overflow
```asm
mov al, 127
add al, 1
```

### 5.3.2. Triggering an unsigned operation overflow
The jump `JC` can be used here to handle this overflow
```asm
mov al, 255
add al, 1
```

### 5.3.3. Notes
If you didn't notice, both code snippets are exactly the same, except for the value assigned to the `al` register. The CPU will always set the necessary flags that indicate an overflow when the most significant bit is changed (signed), and will always set the necessary flags that indicate an overflow when the most significant bit is carried out (unsigned) as well.

The behavior of your assembly program relies entirely on what kind of data you are using to perform your operations, the CPU will always notify you on both cases.

## 5.4 Practice with jumps
There are a few assembly files on the same directory as this README, each file performs different tasks using conditional and unconditional jumps. Use them as examples to see how they work in practice.