# Documentation for t4_msg.c

## Introduction
The `t4_msg.c` program is designed to decode a secret message using the ROT13 cipher. It includes two functions: `len` to calculate the length of a string and `rot13` to perform the ROT13 transformation on a character.

## Steps to Complete the Task

### Step 1: Download the Source C File
Make sure to download the source C file named `t4_msg.c` to your working directory.

### Step 2: Create a Makefile
Create a file named `Makefile` in the same directory as `t4_msg.c`. Here is a sample Makefile with the required targets:

```Makefile
# Makefile for t4_msg program

# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall

# Targets
TARGET = program
SRC = t4_msg.c

# Release target
release: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC)

# Debug target
debug: CFLAGS += -g
debug: $(TARGET)

clean:
	rm -f $(TARGET)
```

### Explanation of the Makefile:
- **CC**: Specifies the compiler to use (GCC).
- **CFLAGS**: Compiler flags; `-Wall` enables all compiler's warning messages.
- **TARGET**: The name of the output executable.
- **SRC**: The source file.
- **release**: Compiles the program normally.
- **debug**: Compiles the program with debug symbols (`-g`).
- **clean**: A target to remove the compiled executable.

### Step 3: Build and Run the Program
Run the following commands in your terminal:

```bash
make debug
./program
```

### Expected Output
After running the corrected program, the output should be:

```
The secret message is: Well Done!!!
```

The encoded message "Jryy Qbar!!!" is decoded using ROT13 and displayed as "Well Done!!!".

## Incorrect Code
The initial version of `t4_msg.c` had a bug in the `len` function:

```c
int len(char* s) {
  int l = 0;
  while (*s) s++;
  return l;
}
```

In this implementation, the `len` function increments the pointer `s` for each character in the string but never updates the length counter `l`. As a result, the function always returns 0, leading to incorrect behavior in the main function.

## Corrected Code
Here's the corrected version of `t4_msg.c`:

```c
#include <stdio.h>

int len(char* s) {
  int l = 0;
  while (*s++) l++;  // Increment l for each character in the string
  return l;
}

int rot13(int l) {
  if (l >= 'A' && l <= 'Z') l = (l - 'A' + 13) % 26 + 'A';
  if (l >= 'a' && l <= 'z') l = (l - 'a' + 13) % 26 + 'a';
  return l;
}

char* msg = "Jryy Qbar!!!\n";

int main() {
  int i = 0;
  printf("The secret message is: ");
  while (i < len(msg)) printf("%c", rot13(msg[i++]));

  return 0;
}
```

### Changes Made
1. In the `len` function, I modified the while loop to increment the length counter `l` for each character using `l++;` inside the loop.
2. The post-increment operator `s++` is used to move the pointer to the next character in the string after checking the current character.

### Explanation
The corrected `len` function now correctly calculates the length of the string by incrementing the `l` variable for each character in the string. The loop continues until it reaches the null terminator `\0`.

The `rot13` function remains unchanged. It takes a character as input and applies the ROT13 transformation if the character is an uppercase or lowercase letter. The transformation is done by shifting the character by 13 positions within its respective case range (A-Z or a-z).

In the `main` function, the program first prints the message "The secret message is: ". Then, it enters a loop that iterates from 0 to the length of the `msg` string (calculated using the corrected `len` function). Inside the loop, it applies the `rot13` function to each character of the `msg` string and prints the transformed character.

## Conclusion
The corrected version of `t4_msg.c` fixes the bug in the `len` function by properly incrementing the length counter. This ensures that the program correctly calculates the length of the string and applies the ROT13 transformation to decode the secret message.