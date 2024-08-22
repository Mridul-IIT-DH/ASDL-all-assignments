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