# 12. Useful opcodes
This section provides a set of useful opcodes that were not introduced before and may be useful for many cases.

## 12.1. Opcode list
```txt
sete <8bit register> - Set the specified register to 1 if both operands used in the 'cmp' opcode are equal; otherwise, set it to 0.

setl <8bit register> - Set the specified register to 1 if the first operand in the 'cmp' opcode is less than the second operand; otherwise, set it to 0.

setle <8bit register> - Set the specified register to 1 if the first operand in the 'cmp' opcode is less or equal than the second operand; otherwise, set it to 0.

setg <8bit register> - Set the specified register to 1 if the first operand in the 'cmp' opcode is greater than the second operand; otherwise, set it to 0.

setge <8bit register> - Set the specified register to 1 if the first operand in the 'cmp' opcode is greater or equal than the second operand; otherwise, set it to 0.

cmovg <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand if the first operand of the 'cmp' opcode is greater than the second.

cmovge <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand if the first operand of the 'cmp' opcode is greater or equal than the second.

cmovl <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand if the first operand of the 'cmp' opcode is less than the second.

cmovle <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand if the first operand of the 'cmp' opcode is less or equal than the second.

cmove <<16-64>bit register>, <<16-64>bit register or address> - Move the value of the second operand to the first operand if both operands of the 'cmp' opcode are equal.

leave - Copy the value in the RBP register to the RSP register, and then pop the top of the stack into RBP. This operation is useful to clear up the stack frame of a procedure and prepare it to return with the 'ret' opcode.

and <register or address>, <register, address or constant> - Perform a bitwise 'and' operation between the first and the second operand, and move the result of the operation to the first operand. This operation can only use one address.

xor <register or address>, <register, address or constant> - Perform a bitwise 'xor' operation between the first and the second operand, and move the result of the operation to the first operand. This operation can only use one address.

or <register or address>, <register, address or constant> - Perform a bitwise 'or' operation between the first and the second operand, and move the result of the operation to the first operand. This operation can only use one address.

xchg <register or address>, <register or address> - Swap the values between both operands. This opcode can swap the values between two registers at the same time but cannot do the same with memory addresses.

shl <register or address>, <constant> - Shift the binary representation of the first operand to the left N times, where N is the value in the second operand.

shr <register or address>, <constant> - Shift the binary representation of the first operand to the right N times, where N is the value in the second operand.

setc <8bit register or address> - Set the register or the address to 0x1 if the shifted-out binary digit of 'shl' and 'shr' opcodes is 1; otherwise, set it to 0x0.
```