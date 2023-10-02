void integer_to_string(int number, char *output){
    int i;
    int bufferIndex = 0;
    char buffer[128];

    while(number >= 10){
        i = number % 10;

        buffer[bufferIndex] = (i + '0');
        bufferIndex++;

        number /= 10;
    }

    buffer[bufferIndex] = (number + '0');

    for(;bufferIndex >= 0; bufferIndex--){
        *output = buffer[bufferIndex];
        output += 1;
    }

    *output = '\n';
}