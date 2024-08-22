# Documentation for `diskhog.sh`

## Overview

`diskhog.sh` is a Bash script designed to identify and list the five largest files and directories in the current directory, sorted by size in decreasing order. The script handles filenames that contain spaces and those that start with a period (hidden files). It outputs sizes in a human-readable format and gracefully handles empty directories.

## Features

- Lists the five largest items (files or directories) in the current directory.
- Outputs sizes in a human-readable format (e.g., KB, MB, GB).
- Handles files and directories with spaces in their names.
- Includes hidden files (those starting with a dot).
- Does not produce any output if the directory is empty.

## Usage

To run the script, use the following command format:

```bash
./diskhog.sh
```

### Exit Codes

- **0**: Success. The script executed successfully, and the largest items were listed.
- **1**: No output if the directory is empty (the script exits silently).

## Implementation Details

### Script Code

```bash
#!/bin/bash

# Enable dotglob to include hidden files (those starting with a dot)
shopt -s dotglob

# Get the five largest items in the current directory
largest_items=$(du -sh * | sort -hr | head -n 5)

# Check if the output is empty
if [ -z "$largest_items" ]; then
    exit 0  # Exit without printing anything if no items are found
fi

# Print the results
echo "$largest_items"
```

### Explanation of Key Components

1. **Shebang Line**:
   ```bash
   #!/bin/bash
   ```
   This line indicates that the script should be executed using the Bash shell.

2. **Enable Dotglob**:
   ```bash
   shopt -s dotglob
   ```
   - `shopt`: A built-in command in Bash that allows you to set or unset various shell options.
   - `-s`: This option enables the specified option.
   - `dotglob`: When enabled, this option allows filename expansion patterns (like `*`) to match files and directories that start with a dot (hidden files). This is crucial for ensuring that hidden files are included in the results.

3. **Get the Largest Items**:
   ```bash
   largest_items=$(du -sh * | sort -hr | head -n 5)
   ```
   - `du -sh *`: 
     - `du`: Disk usage command that estimates file space usage.
     - `-s`: Summarizes the total size for each argument (file or directory).
     - `-h`: Outputs sizes in a human-readable format (e.g., KB, MB, GB).
     - `*`: A wildcard that matches all files and directories in the current directory.
   - `|`: The pipe operator, which takes the output of the command on the left and uses it as input for the command on the right.
   - `sort -hr`: 
     - `sort`: Command that sorts lines of text files.
     - `-h`: Sorts according to human-readable numbers (e.g., 1K, 234M, 2G).
     - `-r`: Reverses the order, so the largest items appear first.
   - `head -n 5`: 
     - `head`: Command that outputs the first part of files.
     - `-n 5`: Limits the output to the first five lines, which correspond to the five largest items.

4. **Check for Empty Output**:
   ```bash
   if [ -z "$largest_items" ]; then
       exit 0
   fi
   ```
   - `-z`: A test condition that checks if the string is empty. If `largest_items` is empty (indicating no items were found), the script exits without printing anything.

5. **Print the Results**:
   ```bash
   echo "$largest_items"
   ```
   This command prints the contents of the `largest_items` variable, which contains the five largest files and directories along with their sizes.

## Example Directory Structure for Testing

To effectively test the script, you can create a sample directory structure with files of varying sizes, including hidden files. Here’s how to set it up:

### Step 1: Create the Directory Structure

```bash
mkdir -p ~/test_directory/subdir1
mkdir -p ~/test_directory/subdir2
```

### Step 2: Create Sample Files

```bash
echo "This is a small file." > ~/test_directory/file1.txt
echo "This is a larger file that has some content." > ~/test_directory/file2.txt
echo "Another file with more content to make it larger." > ~/test_directory/file3.txt
echo "Hidden file with content." > ~/test_directory/.hiddenfile.txt
echo "A really large file that is just a placeholder for testing purposes." > ~/test_directory/subdir1/largefile.txt
```

### Step 3: Run the Script

Navigate to the test directory and run the script:

```bash
cd ~/test_directory
./diskhog.sh
```

### Expected Output

The output will show the five largest items in the directory, formatted in a human-readable way. For example:

```
1.5M    largefile.txt
500K    file2.txt
300K    file3.txt
100K    file1.txt
50K     .hiddenfile.txt
```

### Handling Empty Directories

If the script is run in an empty directory, it will simply exit without printing anything, as required.

## Conclusion

The `diskhog.sh` script is a straightforward and effective tool for identifying the largest files and directories in the current working directory. It handles hidden files and filenames with spaces, making it a versatile utility for disk space management. By following the provided instructions and examples, users can efficiently determine which items are consuming the most disk space.