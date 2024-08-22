#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <directory_path> <search_string> <replacement_string>"
  exit 1
fi

directory_path=$1
search_string=$2
replacement_string=$3

# Check if the directory exists and is readable
if [ ! -d "$directory_path" ]; then
  echo "Error: Directory '$directory_path' does not exist."
  exit 1
fi

if [ ! -r "$directory_path" ]; then
  echo "Error: Directory '$directory_path' is not readable."
  exit 1
fi

# Find all text files and replace the search string with the replacement string
for file in $(find "$directory_path" -type f -name "*.txt"); do
  sed -i "s/$search_string/$replacement_string/g" "$file"
done

echo "Replacement complete."