// Asking the linker to give us the address
// of the hello_msg() procedure
extern void helloMsg();

int main(void){
    // Calling the procedure
    helloMsg();

    return 0;
}