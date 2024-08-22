# Documentation for `testurl.sh`

## Overview

The `testurl.sh` script is a Bash shell script designed to check the accessibility of a list of URLs provided in a text file. It uses the `curl` command to perform HTTP requests and determine if each URL is reachable. The script reports any URLs that are not accessible and exits with an appropriate status code.

## Features

- Reads a list of URLs from a specified file.
- Tests each URL for accessibility using `curl`.
- Reports any inaccessible URLs to standard output.
- Exits with a status code indicating success or failure.

## Usage

To run the script, use the following command format:

```bash
bash testurl.sh <url_file>
```

### Parameters

- `<url_file>`: A text file containing a list of URLs, each on a new line.

### Exit Codes

- **0**: All URLs are accessible.
- **1**: At least one URL is not accessible or incorrect usage.

## Script Breakdown

### Script Code

```bash
#!/bin/bash

# Check if the number of parameters is correct
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <url_file>" >&2
  exit 1
fi

url_file=$1

# Check if the provided file exists and is readable
if [ ! -f "$url_file" ]; then
  echo "$url_file is not a valid file" >&2
  exit 1
fi

# Initialize a flag to track if any URL is down
any_down=false

# Read the file line by line
while IFS= read -r url; do
  # Use curl to test the URL, suppress output and check HTTP response code
  if ! curl --output /dev/null --silent --head --fail "$url"; then
    echo "URL not found: $url"
    any_down=true
  fi
done < "$url_file"

# Exit with status code based on whether any URL was down
if [ "$any_down" = true ]; then
  exit 1
else
  exit 0
fi
```

### Explanation of Key Components

1. **Shebang Line**:
   ```bash
   #!/bin/bash
   ```
   - This line indicates that the script should be executed using the Bash shell. It tells the operating system which interpreter to use.

2. **Parameter Check**:
   ```bash
   if [ "$#" -ne 1 ]; then
     echo "Usage: $0 <url_file>" >&2
     exit 1
   fi
   ```
   - `"$#"`: This special variable holds the number of arguments passed to the script.
   - `-ne`: This operator checks if the number of arguments is not equal to (`ne`) 1.
   - If the condition is true, the script prints a usage message to standard error (`>&2`) and exits with status code 1.

3. **File Validation**:
   ```bash
   url_file=$1
   if [ ! -f "$url_file" ]; then
     echo "$url_file is not a valid file" >&2
     exit 1
   fi
   ```
   - `url_file=$1`: Assigns the first argument (the URL file) to the variable `url_file`.
   - `-f`: This flag checks if the specified path is a regular file.
   - If the file does not exist or is not a regular file, an error message is printed, and the script exits.

4. **URL Testing**:
   ```bash
   any_down=false
   while IFS= read -r url; do
     if ! curl --output /dev/null --silent --head --fail "$url"; then
       echo "URL not found: $url"
       any_down=true
     fi
   done < "$url_file"
   ```
   - `any_down=false`: Initializes a flag to track if any URL is down.
   - `while IFS= read -r url; do`: This loop reads the file line by line. `IFS=` prevents leading/trailing whitespace from being trimmed, and `-r` prevents backslashes from being interpreted as escape characters.
   - `curl`: This command is used to test the URL.
     - `--output /dev/null`: Suppresses the output of the command.
     - `--silent`: Prevents curl from showing progress or error messages.
     - `--head`: Fetches the headers only, which is sufficient to check if the URL is reachable.
     - `--fail`: Causes curl to return an error if the HTTP response code is 400 or higher.
   - If the URL is not accessible, the script prints a message indicating that the URL was not found and sets `any_down` to `true`.

5. **Exit Status**:
   ```bash
   if [ "$any_down" = true ]; then
     exit 1
   else
     exit 0
   fi
   ```
   - After processing all URLs, the script checks the `any_down` flag.
   - If any URL was down, the script exits with status code 1; otherwise, it exits with status code 0.

## Example Usage

1. **Create a File with URLs**:
   Create a text file named `urls.txt` with the following content:
   ```
   https://www.google.com
   https://www.nonexistentwebsite.com
   https://www.github.com
   ```

2. **Run the Script**:
   ```bash
   bash testurl.sh urls.txt
   ```

3. **Expected Output**:
   ```
   URL not found: https://www.nonexistentwebsite.com
   ```

4. **Exit Code**:
   The script will exit with code 1 because one of the URLs is not accessible.

## Conclusion

The `testurl.sh` script is a straightforward and effective tool for checking the accessibility of a list of URLs. It leverages the power of `curl` to perform HTTP requests and provides clear feedback on which URLs are unreachable. This script can be useful for monitoring website availability, validating links in documentation, or performing health checks on web services.