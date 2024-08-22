# Makefile for linked list library and client programs

# Variables
CC      = gcc                     # Compiler
CFLAGS  = -Wall -g                # Compiler flags
SRC     = linkedlist.c            # Source file for the linked list library
OBJ     = linkedlist.o            # Object file for the linked list library
EXE1    = list_check               # First executable
EXE2    = list_run                 # Second executable
SRC1    = use_ll_2.c              # Source for list_check
SRC2    = use_linkedlist.c         # Source for list_run

# Default target
all: $(EXE1) $(EXE2)

# Build linkedlist.o from linkedlist.c
$(OBJ): $(SRC) linkedlist.h
	$(CC) $(CFLAGS) -c $<  # Using $< to refer to the first prerequisite

# Build list_check from use_ll_2.c and linkedlist.o
$(EXE1): $(SRC1) $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^  # Using $@ for target name and $^ for all prerequisites

# Build list_run from use_linkedlist.c and linkedlist.o
$(EXE2): $(SRC2) $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^  # Using $@ for target name and $^ for all prerequisites

# Clean target to remove executables and object files
clean:
	rm -f $(EXE1) $(EXE2) $(OBJ)

.PHONY: all clean  # Declaring phony targets