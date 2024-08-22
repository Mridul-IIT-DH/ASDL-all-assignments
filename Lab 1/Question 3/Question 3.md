# Documentation for `replace_text_sequential.sh`

## Overview

`replace_text_sequential.sh` is a Bash script designed to search for a specified string in all text files within a given directory and its subdirectories, replacing occurrences of that string with a new specified string. This script processes files sequentially, making it straightforward to use without the need for additional dependencies.

## Features

- Accepts a directory path, a search string, and a replacement string as arguments.
- Validates the existence and readability of the specified directory.
- Finds all `.txt` files in the directory and its subdirectories.
- Utilizes `sed` for in-place text replacement.
- Processes files sequentially, making it simple and reliable.

## Usage

To run the script, use the following command format:

```bash
./replace_text_sequential.sh <directory_path> <search_string> <replacement_string>
```

### Parameters

- `<directory_path>`: The path to the directory where the script will search for text files. This can be an absolute or relative path.
- `<search_string>`: The string that you want to search for in the text files.
- `<replacement_string>`: The string that will replace occurrences of the search string.

### Exit Codes

- **0**: Success. The script executed successfully, and the replacements were made.
- **1**: Error. An error occurred due to invalid input parameters or directory issues.

## Error Handling

The script includes error handling for the following scenarios:

1. **Invalid Number of Arguments**: If the number of arguments provided is not equal to 3, an error message is printed, and the script exits with code 1.
   
   Example error message:
   ```
   Usage: ./replace_text_sequential.sh <directory_path> <search_string> <replacement_string>
   ```

2. **Invalid Directory Path**: If the specified directory path does not exist, an error message is printed, and the script exits with code 1.

   Example error message:
   ```
   Error: Directory '/path/to/directory' does not exist.
   ```

3. **Non-Readable Directory**: If the specified directory is not readable, an error message is printed, and the script exits with code 1.

   Example error message:
   ```
   Error: Directory '/path/to/directory' is not readable.
   ```

## Implementation Details

### Script Code

```bash
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
```

### Explanation of Key Components

1. **Input Validation**:
   - The script checks if exactly three arguments are provided. If not, it prints a usage message and exits.
   
2. **Directory Validation**:
   - It checks if the specified directory exists and is readable. If either check fails, an appropriate error message is printed, and the script exits.

3. **Finding and Replacing Text**:
   - The `find` command is used to locate all `.txt` files in the specified directory and its subdirectories.
   - A `for` loop iterates over each file found, and the `sed` command performs in-place replacement of the `search_string` with the `replacement_string`.

4. **Completion Message**:
   - After all replacements are done, the script outputs a completion message.

## Example Directory Structure

To effectively test the script, you can create a sample directory structure as follows:

### Step 1: Create the Directory Structure

```bash
mkdir -p ~/test_directory/subdir1
mkdir -p ~/test_directory/subdir2
```

### Step 2: Create Sample Text Files

```bash
echo "This is the old_text that needs to be replaced." > ~/test_directory/file1.txt
echo "Another line with old_text in it." > ~/test_directory/file2.txt
echo "This file does not contain the search term." > ~/test_directory/file3.txt
echo "old_text appears here too." > ~/test_directory/subdir1/file4.txt
echo "No old_text in this one." > ~/test_directory/subdir1/file5.txt
echo "Let's replace old_text with new_text." > ~/test_directory/subdir2/file6.txt
echo "old_text is in this file as well." > ~/test_directory/subdir2/file7.txt
```

### Step 3: Verify the Directory Structure

After executing the commands, your directory structure should look like this:

```
~/test_directory/
├── file1.txt
├── file2.txt
├── file3.txt
├── subdir1/
│   ├── file4.txt
│   └── file5.txt
└── subdir2/
    ├── file6.txt
    └── file7.txt
```

## Testing the Script

### Example Command to Run the Script

```bash
./replace_text_sequential.sh ~/test_directory "old_text" "new_text"
```

### Expected Output

After running the script, you should see the output:

```
Replacement complete.
```

### Check the Results

You can use the `cat` command to verify the changes:

```bash
cat ~/test_directory/file1.txt
cat ~/test_directory/file2.txt
cat ~/test_directory/subdir1/file4.txt
cat ~/test_directory/subdir2/file6.txt
cat ~/test_directory/subdir2/file7.txt
```

### Expected File Contents After Replacement

- **file1.txt**:
  ```
  This is the new_text that needs to be replaced.
  ```

- **file2.txt**:
  ```
  Another line with new_text in it.
  ```

- **file3.txt**:
  ```
  This file does not contain the search term.
  ```

- **file4.txt**:
  ```
  new_text appears here too.
  ```

- **file5.txt**:
  ```
  No old_text in this one.
  ```

- **file6.txt**:
  ```
  Let's replace new_text with new_text.
  ```

- **file7.txt**:
  ```
  new_text is in this file as well.
  ```

## Conclusion

The `replace_text_sequential.sh` script is a simple yet effective tool for replacing text in multiple files across a directory structure. It is easy to use, requires no additional dependencies, and includes robust error handling. By following the provided instructions and examples, users can efficiently perform text replacements in their files.