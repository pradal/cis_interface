#include <stdio.h>
// Include methods for input/output channels
#include "PsiInterface.h"

int main(int argc, char *argv[]) {
  // Initialize input/output channels
  psiInput_t in_channel = psiInput("input");
  psiOutput_t out_channel = psiOutput("output");

  // Declare resulting variables and create buffer for received message
  int flag = 1;
  const int bufsiz = 1000;
  char buf[bufsiz];

  // Loop until there is no longer input or the queues are closed
  while (flag >= 0) {
    
    // Receive input from input channel
    // If there is an error or the queue is closed, the flag will be negative
    // Otherwise, it is the size of the received message
    flag = psi_recv(in_channel, buf, bufsiz);
    if (flag < 0) {
      printf("No more input.\n");
      break;
    }

    // Print received message
    printf("%s\n", buf);

    // Send output to output channel
    // If there is an error, the flag will be negative
    flag = psi_send(out_channel, buf, flag);
    if (flag < 0) {
      printf("Error sending output.\n");
      break;
    }

  }
  
  return 0;
}
