#!/bin/bash

# Check if the input file is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_file>"
  exit -1
fi

# Check if the input file exists and is a regular file
if [ ! -f "$1" ]; then
  echo "Error: $1 is not a valid file path."
  exit -1
fi

# Initialize the current value to 0
current_value=0

# Read the input file line by line
while read -r line; do
  # Split the line into operand1, operator, and operand2
  read -r operand1 operator <<< "$line"

  # Perform the arithmetic operation based on the operator
  case "$operator" in
    "+") current_value=$((current_value + operand1))
         ;;
    "-") current_value=$((current_value - operand1))
         ;;
    "*") current_value=$((current_value * operand1))
         ;;
    "/") 
        # Check for division by zero
        if [ "$operand1" -eq 0 ]; then
          echo "Error: Division by zero."
          exit -1
        fi
        current_value=$((current_value / operand1))
        ;;
    "%") 
        # Check for division by zero
        if [ "$operand1" -eq 0 ]; then
          echo "Error: Division by zero."
          exit -1
        fi
        current_value=$((current_value % operand1))
        ;;
    *)   echo "Error: Invalid operator '$operator'."
         exit -1
         ;;
  esac

  # Output the current value after the operation
  echo "$current_value"
done < "$1"

# Output the final value
echo "Final value: $current_value"