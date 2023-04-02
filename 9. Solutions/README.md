# 9. Solutions
This section has the goal to present a number of useful solutions that can do the difference when working with the Assembly language, some of these solutions include string operations, like compare and copy, and other things. All source code are inside the src directory.

## 9.1 strcpy
strcpy is a function to copy a string from a source to a destiny, this works copying bytes until find a NULL byte. The *destiny* **address** must be passed to RDI register and the *source* **address** must be passed to RSI register. The function return the address of *destiny* in RAX register.

## 9.2 strlen
strlen is a function to calculate the size of a string in memory, the calculation keep going until the function face with a NULL byte. The **address** of the string must be passed to RDI register. The function returns an integer meaning the size of the string in RAX register. The function doesn't count the NULL byte as part of the string size.

## 9.3 memset
memset is a function that fills the first x bytes pointed by an address, with the value y. The **address** to fill must be passed to RDI register, the **byte** used to fill the area must be passed to RSI register, the **number** of bytes to fill with the value must be passed to RDX register. The function returns the address of the filled area in RAX register.