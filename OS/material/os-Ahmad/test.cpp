#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <iostream>
#include <sys/wait.h>

int factorial(int n) {
  if (n == 0) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}

int main() {
  int arr[] = {5, 3, 2, 4, 1};
  int n = sizeof(arr) / sizeof(arr[0]);

  pid_t pid = fork();

  if (pid == 0) { // Child process

    for (int i = n / 2; i < n; i++) {
      int fact = factorial(arr[i]);
      printf("Factorial of by child %d: %d\n", arr[i], fact);
    }

  } else if (pid > 0) { // Parent process
    for (int i = 0; i < n / 2; i++) {
      int fact = factorial(arr[i]);
      printf("Factorial of by parent %d: %d\n", arr[i], fact);
    }
    wait(NULL); // Wait for child to finish
  } else {
    perror("Fork failed!");
    exit(1);
  }

  return 0;
}