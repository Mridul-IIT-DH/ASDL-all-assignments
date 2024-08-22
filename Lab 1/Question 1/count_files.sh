#!/bin/bash

# Validate input arguments
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <directory_path> <prefix> <recursive>"
  exit -1
fi

directory_path=$1
prefix=$2
recursive=$3

# Check if recursive parameter is valid
if [ "$recursive" != "true" ] && [ "$recursive" != "false" ]; then
  echo "recursive should take only true or false values"
  exit -1
fi

# Check if directory path is valid
if ! [ -d "$directory_path" ]; then
  echo "$directory_path is not a valid directory"
  exit -1
fi

# Count the files
if [ "$recursive" == "true" ]; then
  file_count=$(find "$directory_path" -type f -name "$prefix*.txt" | wc -l)
else
  file_count=$(find "$directory_path" -maxdepth 1 -type f -name "$prefix*.txt" | wc -l)
fi

# Output the result
echo "$file_count"