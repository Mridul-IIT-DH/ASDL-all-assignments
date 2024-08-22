# Documentation for `count_files.sh`

## Overview

`count_files.sh` is a Bash script designed to count the number of text files in a specified directory that start with a given prefix. The script can operate in two modes: recursive and non-recursive. In recursive mode, it will search through all subdirectories, while in non-recursive mode, it will only count files in the specified directory.

## Features

- Counts `.txt` files that begin with a specified prefix.
- Supports both recursive and non-recursive searches.
- Validates input parameters and handles errors gracefully.
- Outputs the count of matching files to standard output.

## Usage

To run the script, use the following command format:

```bash
bash ./count_files.sh <directory_path> <prefix> <recursive>
```

### Parameters

- `<directory_path>`: The path to the directory where the script will search for files. This can be an absolute or relative path.
- `<prefix>`: The prefix that the filenames should start with. If an empty string is provided, all `.txt` files will be counted.
- `<recursive>`: A string that should be either "true" or "false". This determines whether the search should include subdirectories.

### Exit Codes

- **0**: Success. The script executed successfully and the count of files was printed.
- **-1**: Error. An error occurred due to invalid input parameters or directory issues.

## Error Handling

The script includes error handling for the following scenarios:

1. **Invalid Number of Arguments**: If the number of arguments provided is not equal to 3, an error message is printed, and the script exits with code -1.
   
   Example error message:
   ```
   Usage: ./count_files.sh <directory_path> <prefix> <recursive>
   ```

2. **Invalid Recursive Parameter**: If the `recursive` parameter is not "true" or "false", an error message is printed, and the script exits with code -1.
   
   Example error message:
   ```
   recursive should take only true or false values
   ```

3. **Invalid Directory Path**: If the specified directory path does not exist or is not a directory, an error message is printed, and the script exits with code -1.
   
   Example error message:
   ```
   ./path/to/directory is not a valid directory
   ```

## Implementation Details

### Script Code

```bash
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
```

### Explanation of Key Components

1. **Input Validation**:
   - The script checks if exactly three arguments are provided.
   - It verifies the validity of the `recursive` parameter.
   - It checks if the specified directory exists and is valid.

2. **File Counting**:
   - The script uses the `find` command to locate files:
     - In recursive mode: `find "$directory_path" -type f -name "$prefix*.txt"`
     - In non-recursive mode: `find "$directory_path" -maxdepth 1 -type f -name "$prefix*.txt"`
   - The `wc -l` command counts the number of lines output by `find`, which corresponds to the number of matching files.

3. **Output**:
   - The final count of matching files is printed to standard output.

## Examples

### Example 1: Count All Text Files in the Current Directory (Non-Recursive)

```bash
./count_files.sh . "" false
```
**Output**: `3` (if there are 3 `.txt` files in the current directory)

### Example 2: Count Text Files with a Specific Prefix (Recursive)

```bash
./count_files.sh ./sample "file" true
```
**Output**: `2` (if there are 2 `.txt` files starting with "file" in the current directory and subdirectories)

### Example 3: Invalid Directory Path

```bash
./count_files.sh ./invalid_directory "abc" false
```
**Output**: `./invalid_directory is not a valid directory`

### Example 4: Invalid Recursive Parameter

```bash
./count_files.sh ./sample "abc" true2
```
**Output**: `recursive should take only true or false values`

## Conclusion

The `count_files.sh` script is a useful tool for quickly counting text files based on specific criteria in a directory. Its ability to handle both recursive and non-recursive searches, along with robust error handling, makes it a versatile utility for file management tasks.