# 9. Solutions
This section has the goal to present a number of useful solutions that can do the difference when working with the Assembly language, some of these solutions include string operations, like compare and copy, and other things. All source code are inside the src directory.

## 9.1 strcpy
strcpy is a procedure to copy a string from a source to a destiny, this works copying bytes until find a NULL byte. The *destiny* address must be passed to RDI register and the *source* address must be passed to RSI register. The function return the address of *destiny* in RAX register.