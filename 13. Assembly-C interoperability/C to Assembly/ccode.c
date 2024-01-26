#define MAX_UNSIGNED_INT_DIGITS_COUNT 10

void fillArrayIncrementally(unsigned int *array, unsigned int begin, int arraySize){
    int i = 0;

    while(i < arraySize){
        array[i++] = begin++;
    }
}

unsigned sumArray(unsigned *array, int arraySize){
    int total = 0;

    for(int i = 0; i < arraySize; i++){
        total += array[i];
    }

    return total;
}

void intToString(unsigned int number, char *output){
    char numberAsString[MAX_UNSIGNED_INT_DIGITS_COUNT + 1] = {0};
    unsigned short i = MAX_UNSIGNED_INT_DIGITS_COUNT;

    // Converting the number to string
    while(number != 0){
        numberAsString[i--] = (number % 10) + '0';
        number /= 10;
    }

    // Copying the result to output
    for(i = i + 1; i <= MAX_UNSIGNED_INT_DIGITS_COUNT; i++){
        *output = numberAsString[i];
        output++;
    }

    *output = '\0';
}

int strLen(char *string){
    int len = 0;

    while(*string){
        len++;
        string++;
    }

    return len;
}