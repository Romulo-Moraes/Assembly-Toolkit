# 11. Useful opcodes
Here's the official end of the Assembly toolkit framework, and for a great goodbye, will be shown a collection of useful assembly opcodes that can make the difference when working with this language.

## 11.1 Opcode list
```txt
sete <8bit register> - Set the given register to 1 whether both operands used in 'cmp' opcode were equal, 0 otherwise.

setl <8bit register> - Set the given register to 1 whether the first operand was less than the second operand in the 'cmp' opcode, 0 otherwise

setle <8bit register> - Set the given register to 1 whether the first operand was less or equal than the second operand in the 'cmp' opcode, 0 otherwise.

setg <8bit register> - Set the given register to 1 whether the first operand was greater than the second in the 'cmp' opcode, 0 otherwise.

setge <8bit register> - Set the given register to 1 whether the first operand was greater or equal than the second in the 'cmp' opcode, 0 otherwise.

cmovg <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand whether the first operand of the previous 'cmp' opcode was greater than the second.

cmovge <<16-64>bit register>, <<16-64><16-64>bit register or address> - Move the value of the second operand to the first operand whether the first operand of the previous 'cmp' opcode was greater or equal than the second.

cmovl <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand whether the first operand of the previous 'cmp' opcode was less thann the second.

cmovle <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand whether the first operand of the previous 'cmp' opcode was less or equal than the second.

cmove <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand whether the first operand of the previous 'cmp' opcode was equal to the second.

leave - Copy rbp to rsp and then pop the top of the stack into rbp, it's useful to clean up the stack frame of a procedure and prepare it to return with the 'ret' opcode.

and <register or address>, <register, address or constant> - Does a bitwise and operation between the first and the second operand, the result of the operation is moved to the first operand. Both operands can be any data register usually, but can also be used with index registers. Different of registers, the 'and' opcode can't do the same operation with two addresses, allowing only one address in any operand.

xor <register or address>, <register, address or constant> - Does a bitwise xor operation between the first and the second operand, the result of the operation is moved to the first operand. Both operands can be any data register usually, but can also be used with index registers. Different of registers, the 'xor' opcode can't do the same operation with two addresses, allowing only one address in any operand.

or <register or address>, <register, address or constant> - Does a bitwise or operation between the first and the second operand, the result of the operation is moved to the first operand. Both operands can be any data register usually, but can also be used with index registers. Different of registers, the 'or' opcode can't do the same operation with two addresses, allowing only one address in any operand.

xchg <register or address>, <register or address> - Swap the values between both operands, the 'xchg' opcode support the use of two register at the same time in different operands, but can't do the same with memory addresses, allowing only one address either in the first operand or in the second.

shl <register or address>, <constant> - Shift the binary content of the first operand to the left N times, being N the value in the second operand.

shr <register or address>, <constant> - Shift the binary content of the first operand to the right N times, being N the value in the second operand.

setc <8bit register or address> - Set the register or the address in the range of 1 byte to 0x1 if the shifted out binary digit of 'shl' and 'shr' opcodes was 1, 0x0 otherwise.
```