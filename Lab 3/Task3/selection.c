#include <stdio.h>

void selection_sort(int A[], int size) {
    int i, j, max, temp;

    for (i = size - 1; i > 0; i--) {
        max = 0; // Assume the first element is the largest
        for (j = 1; j <= i; j++) { // Correct loop condition
            if (A[j] > A[max]) {
                max = j; // Update max if a larger element is found
            }
        }
        // Swap the found maximum element with the last element of the unsorted portion
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