# 11. Solutions
This section provides a set of C functions written in Assembly. Their use makes it easier to accomplish operations such as copying strings, converting strings to integers, getting string length, and more.

## 11.1. strcpy
These  functions copy the string pointed to by <u>src</u>, into a string at the buffer pointed to by <u>dst</u>.  The programmer is responsible for allocating  a  destination  buffer  large enough,  that  is, <u>strlen(src)</u> <u>+</u> <u>1</u>. (Unix man page definition)

## 11.2. strlen
The  **strlen**() function calculates the length of the string pointed to by <u>s</u>, excluding the terminating null byte `'\0'`. (Unix man page definition)

## 11.3. memset
The **memset**() function fills the first <u>n</u> bytes of the memory area pointed to by <u>s</u> with the constant byte <u>c</u>. (Unix man page definition)

## 11.4. strcat
This function catenates the string pointed to by <u>src</u>, after the string  pointed  to  by <u>dst</u>  (overwriting  its terminating null byte).  The programmer is responsible for allocating a destination buffer large enough, that is, <u>strlen(dst)</u> <u>+</u> <u>strlen(src)</u> <u>+</u> <u>1</u>. (Unix man page definition)

## 11.5. atoi
The **atoi**() function converts the initial portion of the string pointed to by <u>nptr</u> to <u>int</u>. (Unix man page definition)

## 11.6. strcmp
The  **strcmp**()  function  compares the two strings <u>s1</u> and <u>s2</u>. The locale is not taken into account. (Unix man page definition)
