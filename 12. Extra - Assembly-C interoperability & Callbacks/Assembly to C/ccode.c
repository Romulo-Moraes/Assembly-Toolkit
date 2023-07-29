// Asking to the linker to give us the address
// of the hello_msg() procedure
extern void hello_msg();

int main(void){
    // Calling the procedure
    hello_msg();

    return 0;
}