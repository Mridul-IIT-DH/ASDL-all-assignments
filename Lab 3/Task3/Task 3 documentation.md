# Documentation for Task 3: Debugging `insertion.c` and `selection.c`

This document provides a detailed explanation of the debugging process for the `insertion.c` and `selection.c` programs. It includes the full code for both files, the commands used in gdb, the corrections made to resolve issues, and the reasoning behind each change based on gdb messages.

## Overview

The purpose of this task was to debug two sorting algorithms: insertion sort and selection sort. The debugging process involved using the GNU Debugger (gdb) to identify and fix logical errors and segmentation faults in the implementations.

## Debugging `insertion.c`

### Initial Code

The initial version of `insertion.c` contained logical errors in the insertion sort implementation. Here’s the original code snippet:

```c
#include <stdio.h>

void insertion_sort(int A[], int size) {
    for (int i = 1; i < size; i++) {
        int j = i;
        while (j >= 0 && A[j] < A[j-1]) { // Incorrect condition
            int temp = A[j];
            A[j] = A[j-1];
            A[j-1] = temp;
            j--;
        }
    }
}

int main() {
    int length = 8;
    int list[] = { 28, 4, 100, 9, 224, 111, 72, 53 };
    printf("unsorted list: \n");
    for (int i = 0; i < length; i++) {
        printf("%10d\n", list[i]);
    }

    insertion_sort(list, length);
    printf("list in order: \n");
    for (int i = 0; i < length; i++) {
        printf("%10d\n", list[i]);
    }

    return 0;
}
```

### gdb Commands Used

1. **Compile the Program with Debugging Information**:
   ```bash
   gcc -g insertion.c -o insertion
   ```

2. **Start gdb**:
   ```bash
   gdb ./insertion
   ```

3. **Run the Program**:
   ```gdb
   run
   ```

4. **Set Breakpoints**:
   Set a breakpoint at the `main` function:
   ```gdb
   break main
   ```

5. **Continue Execution**:
   After hitting the breakpoint:
   ```gdb
   continue
   ```

6. **Step into the `insertion_sort` Function**:
   Set a breakpoint in the `insertion_sort` function:
   ```gdb
   break insertion_sort
   continue
   ```

7. **Step Through the Code**:
   Use the `step` command to go through the lines of the `insertion_sort` function:
   ```gdb
   step
   ```

### Identified Issues and Fixes

1. **Incorrect Loop Condition**:
   The condition in the `while` loop should be:
   ```c
   while (j > 0 && A[j] < A[j-1]) { // Correct condition
   ```
   **Reason for Change**: The original condition `j >= 0` could lead to an out-of-bounds access when `j` is `0`, which would cause undefined behavior. The corrected condition ensures that `j` is always greater than `0` before accessing `A[j-1]`.

### Corrected Code for `insertion.c`

Here’s the corrected version of the `insertion.c` code:

```c
#include <stdio.h>

void insertion_sort(int A[], int size) {
    for (int i = 1; i < size; i++) {
        int j = i;
        while (j > 0 && A[j] < A[j-1]) { // Corrected condition
            int temp = A[j];
            A[j] = A[j-1];
            A[j-1] = temp;
            j--;
        }
    }
}

int main() {
    int length = 8;
    int list[] = { 28, 4, 100, 9, 224, 111, 72, 53 };
    printf("unsorted list: \n");
    for (int i = 0; i < length; i++) {
        printf("%10d\n", list[i]);
    }

    insertion_sort(list, length);
    printf("list in order: \n");
    for (int i = 0; i < length; i++) {
        printf("%10d\n", list[i]);
    }

    return 0;
}
```

### Final Output

After making the necessary corrections, the output of the program should correctly display the sorted list.

## Debugging `selection.c`

### Initial Code

The initial version of `selection.c` also contained logical errors. Here’s the original code snippet:

```c
#include <stdio.h>

void selection_sort(int A[], int size) {
    int i, j, max, temp;

    for (i = size - 1; i > 0; i--) {
        max = 0;
        for (j = 1; i <= size; j++) { // Incorrect condition
            if (A[j] > A[max])
                max = j;
        }
        temp = A[max];
        A[max] = A[i];
        A[i] = temp;
    }
}

int binary_search(int item, int A[], int size) {
    int lo = 0; 
    int hi = size; // Incorrect initialization
    while (1) {
        if (hi < lo)
            return 0; // not found
        int mid = (hi + lo) / 2;
        if (A[mid] == item)
            return 1; // found
        if (item < A[mid])
            hi = mid; // move hi to eliminate 2nd half of A
        else
            lo = mid; // move lo to eliminate 1st half of A
    }
}

int main() {
    int list[] = { 100, 45, 89, 27, 317, 17 };
    printf("unsorted list: \n");
    for (int i = 0; i < 6; i++) {
        printf("%10d\n", list[i]);
    }

    selection_sort(list, 6);
    printf("list in order: \n");
    for (int i = 0; i < 6; i++) {
        printf("%10d\n", list[i]);
    }

    printf("test if 42 is in the array...\n");
    if (binary_search(42, list, 6))
        printf(" YES\n");
    else
        printf(" NO\n");

    return 0;
}
```

### gdb Commands Used

1. **Compile the Program with Debugging Information**:
   ```bash
   gcc -g selection.c -o selection
   ```

2. **Start gdb**:
   ```bash
   gdb ./selection
   ```

3. **Run the Program**:
   ```gdb
   run
   ```

4. **Set Breakpoints**:
   Set a breakpoint at the `main` function:
   ```gdb
   break main
   ```

5. **Continue Execution**:
   After hitting the breakpoint:
   ```gdb
   continue
   ```

6. **Step into the `selection_sort` Function**:
   Set a breakpoint in the `selection_sort` function:
   ```gdb
   break selection_sort
   continue
   ```

7. **Step Through the Code**:
   Use the `step` command to go through the lines of the `selection_sort` function:
   ```gdb
   step
   ```

### Identified Issues and Fixes

1. **Segmentation Fault**:
   The segmentation fault was caused by an incorrect loop condition in the `selection_sort` function. The condition should be changed from:
   ```c
   for (j = 1; i <= size; j++)
   ```
   To:
   ```c
   for (j = 1; j <= i; j++)
   ```
   **Reason for Change**: The original condition `i <= size` caused the loop to run out of bounds, leading to a segmentation fault. The corrected condition ensures that `j` iterates correctly within the bounds of the array.

2. **Correct Binary Search Logic**:
   Ensure that `hi` is initialized correctly in the `binary_search` function:
   ```c
   int hi = size - 1; // Correct initialization
   ```

3. **Ensure Proper Swapping Logic**:
   Make sure that the swapping logic is outside the inner loop after finding the maximum index.

### Corrected Code for `selection.c`

Here’s the corrected version of the `selection.c` code:

```c
#include <stdio.h>

void selection_sort(int A[], int size) {
    int i, j, max, temp;

    for (i = size - 1; i > 0; i--) {
        max = 0; // Assume the first element is the largest
        for (j = 1; j <= i; j++) { // Correct condition
            if (A[j] > A[max]) {
                max = j; // Update max if a larger element is found
            }
        }
        // Swap the found maximum element with the last element
        temp = A[max];
        A[max] = A[i];
        A[i] = temp;
    }
}

int binary_search(int item, int A[], int size) {
    int lo = 0; 
    int hi = size - 1; // Correct initialization
    while (lo <= hi) { // Correct loop condition
        int mid = (hi + lo) / 2;
        if (A[mid] == item)
            return 1; // found
        if (item < A[mid])
            hi = mid - 1; // Move hi to eliminate 2nd half of A
        else
            lo = mid + 1; // Move lo to eliminate 1st half of A
    }
    return 0; // not found
}

int main() {
    int list[] = {100, 45, 89, 27, 317, 17};
    printf("unsorted list: \n");
    for (int i = 0; i < 6; i++) {
        printf("%10d\n", list[i]);
    }

    selection_sort(list, 6);
    printf("list in order: \n");
    for (int i = 0; i < 6; i++) {
        printf("%10d\n", list[i]);
    }

    printf("test if 42 is in the array...\n");
    if (binary_search(42, list, 6))
        printf(" YES\n");
    else
        printf(" NO\n");

    return 0;
}
```

### Final Output

After making the necessary corrections, the output of the program should correctly display the sorted list:

```
unsorted list: 
       100
        45
        89
        27
       317
        17
list in order: 
        17
        27
        45
        89
       100
       317
```

## Conclusion

This documentation provides a comprehensive overview of the debugging process for both `insertion.c` and `selection.c`. By utilizing gdb effectively, we identified and resolved segmentation faults and logical errors, ensuring that both sorting algorithms function correctly. The full code for both programs is included for reference, along with the commands used throughout the debugging process.

### Interpreting gdb Messages

Understanding the messages from gdb is crucial for effective debugging. Here are some key points on how to interpret these messages:

- **Segmentation Fault**: This indicates that the program tried to access memory that it shouldn't. This usually happens when an array index is out of bounds. You should check your loop conditions and ensure they do not exceed the array limits.

- **Backtrace**: When you use the `backtrace` command after a crash, it shows the call stack leading to the error. This helps you identify which function caused the problem.

- **Variable Inspection**: Using the `print` command allows you to check the values of variables at any point in your code. This is useful for understanding the state of your program and identifying logical errors.

By following these guidelines and understanding the feedback from gdb, you can effectively debug your C programs and enhance your coding skills.