#include <stdio.h>
#include <string.h>

/*int myStrCmp(char *string1, char *string2) {
    while(*string1 != '\0' && *string2 != '\0'){
	if(*string1 < *string2){
	    return -1;
	}else if (*string1 > *string2) {
	    return 1;
	}
	
	string1++;
	string2++;
    }

    if(*string1 == *string2){
	return 0;
    }else if(*string1 == '\0'){
	return -1;
    }else{
	return 1;
    }

    /*
    if(*string1 == '\0' && *string2 == '\0')
	return 0;
    else if(*string1 == '\0')
	return -1;
    else
	return 1;
    
	}*/

extern int strcmpp(char *string1, char *string2);

int main(void) {
    printf("%d\n", strcmpp("", ""));
    printf("%d\n", strcmp("", ""));
    
    return 0;
}
