# Detailed Documentation for `mean.sh`

### Purpose
The `mean.sh` script calculates the mean of a specified column from a comma-separated values (CSV) file. It can read from a specified file or from standard input if no file is provided. The script assumes that the selected column contains numerical data.

### Script Code
Here is the complete code for the `mean.sh` script:

```bash
#!/bin/bash

# Usage function to display how to use the script
usage() {
    echo "usage: $0 <column_number> [file.csv]" 1>&2
}

# Check if the number of arguments is correct
if [ "$#" -lt 1 ]; then
    echo "ERROR: Missing required argument." 1>&2
    usage
    exit 1
elif [ "$#" -gt 2 ]; then
    echo "ERROR: Too many arguments." 1>&2
    usage
    exit 1
fi

# Assign arguments to variables for clarity
COLUMN="$1"
FILE="${2:-/dev/stdin}"  # If no file is specified, read from stdin

# Check if the column number is a positive integer
if ! [[ "$COLUMN" =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR: Column number must be a positive integer." 1>&2
    exit 1
fi

# Initialize sum and count
sum=0
count=0

# Use cut to select the required column, skip the header, and calculate the mean
{
    # Skip the header line
    read

    # Read from the specified file or stdin
    while IFS= read -r line; do
        # Extract the specified column
        value=$(echo "$line" | cut -d',' -f"$COLUMN")

        # Check if the value is a number
        if [[ "$value" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
            sum=$(awk "BEGIN {print $sum + $value}")
            count=$((count + 1))
        fi
    done
} < "$FILE"

# Calculate the mean
if [ "$count" -gt 0 ]; then
    mean=$(awk "BEGIN {print $sum / $count}")
    echo "Mean of column $COLUMN: $mean"
else
    echo "ERROR: No valid data found in the specified column." 1>&2
    exit 1
fi

# Exit successfully
exit 0
```

### Usage
To run the script, follow these steps:
1. Save the script as `mean.sh`.
2. Make the script executable:
   ```bash
   chmod +x mean.sh
   ```
3. Execute the script with the desired column and file:
   ```bash
   ./mean.sh <column_number> [file.csv]
   ```
   For example, to find the mean of the third column of `mtcars.csv`:
   ```bash
   ./mean.sh 3 "Lab 2/mtcars.csv"
   ```
   Or read from standard input:
   ```bash
   cat "Lab 2/mtcars.csv" | ./mean.sh 3
   ```

### Script Breakdown
1. **Usage Function**:
   - The `usage` function prints the correct usage of the script to standard error (stderr) using `echo "usage: $0 <column_number> [file.csv]" 1>&2`. The `$0` variable contains the name of the script, ensuring that the usage message is accurate even if the script name changes.
   - Example:
     ```bash
     usage() {
         echo "usage: mean.sh <column_number> [file.csv]" 1>&2
     }
     ```

2. **Argument Count Check**:
   - The script checks if the number of arguments (`$#`) is less than 1 or greater than 2. If so, it prints an error message and calls the `usage` function before exiting with a status of 1.
   - Example:
     ```bash
     if [ "$#" -lt 1 ]; then
         echo "ERROR: Missing required argument." 1>&2
         usage
         exit 1
     elif [ "$#" -gt 2 ]; then
         echo "ERROR: Too many arguments." 1>&2
         usage
         exit 1
     fi
     ```

3. **Column Number Check**:
   - The script checks if the first argument (`COLUMN`) is a positive integer using a regular expression. If not, it prints an error message and exits.
   - Example:
     ```bash
     if ! [[ "$COLUMN" =~ ^[1-9][0-9]*$ ]]; then
         echo "ERROR: Column number must be a positive integer." 1>&2
         exit 1
     fi
     ```

        #### Regular Expression Breakdown

        1. **`^` (Caret)**:
        - This symbol asserts that we are at the **start** of the string. It ensures that the match must begin at the first character of the input.

        2. **`[1-9]`**:
        - This part of the expression defines a **character class** that matches any single digit from **1 to 9**. 
        - The reason we start with `[1-9]` instead of `[0-9]` is to ensure that the column number is a **positive integer**. A positive integer cannot start with a zero (e.g., `01`, `02`, etc. are not valid positive integers in this context).

        3. **`[0-9]*`**:
        - The `*` is a **quantifier** that means "zero or more" occurrences of the preceding element. In this case, it means that after the first digit (which must be between 1 and 9), there can be **zero or more** digits that are between **0 and 9**.
        - This allows for numbers like `1`, `2`, `10`, `23`, `456`, etc. Essentially, it permits the column number to have any length as long as it starts with a non-zero digit.

        4. **`$` (Dollar Sign)**:
        - This symbol asserts that we are at the **end** of the string. It ensures that the match must conclude at the last character of the input.
        - This means that the entire string must conform to the pattern defined by the preceding characters.

        #### Summary of the Regular Expression

        Putting it all together, the regular expression `^[1-9][0-9]*$` checks for a string that:
        - Starts with a digit between **1 and 9** (ensuring it's not zero).
        - Is followed by zero or more digits between **0 and 9**.
        - Ends after these digits.

        #### Valid Examples
        - `1` (valid)
        - `5` (valid)
        - `10` (valid)
        - `23` (valid)
        - `456` (valid)

        #### Invalid Examples
        - `0` (invalid, does not start with a non-zero digit)
        - `01` (invalid, starts with a zero)
        - `-3` (invalid, negative number)
        - `abc` (invalid, contains non-numeric characters)
        - `12.5` (invalid, contains a decimal point)

        #### Implementation in the Script

        In the context of the `mean.sh` script, this check is crucial to ensure that the user provides a valid positive integer for the column number. If the input does not match this pattern, the script will print an error message and exit, preventing any further execution that could lead to incorrect behavior or results.

        #### Conclusion

        The regular expression `^[1-9][0-9]*$` is a robust way to validate that the user input for the column number is a positive integer, ensuring that the script operates correctly and avoids potential errors during execution.

4. **Reading from File or Standard Input**:
   - The script sets `FILE` to the second argument if provided; otherwise, it defaults to `/dev/stdin` to read from standard input.
   - Example:
     ```bash
     FILE="${2:-/dev/stdin}"
     ```

5. **Calculating the Mean**:
   - The script initializes `sum` and `count` to 0.
   - It reads each line from the specified file or stdin, skipping the header line.
   - It uses `cut` to extract the specified column and checks if the value is a valid number.
   - If valid, it adds the value to `sum` using `awk` for accurate arithmetic and increments `count`.
   - Example:
     ```bash
     {
         # Skip the header line
         read
         
         # Read from the specified file or stdin
         while IFS= read -r line; do
             # Extract the specified column
             value=$(echo "$line" | cut -d',' -f"$COLUMN")
             
             # Check if the value is a number
             if [[ "$value" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
                 sum=$(awk "BEGIN {print $sum + $value}")
                 count=$((count + 1))
             fi
         done
     } < "$FILE"
     ```

    #### Initialization
    ```bash
    sum=0
    count=0
    ```
    - **Purpose**: This initializes two variables:
    - `sum`: This will hold the cumulative total of the values in the specified column.
    - `count`: This will keep track of how many valid numeric entries are found in that column.

    #### Reading Lines
    ```bash
    {
        # Skip the header line
        read
    ```
    - **Purpose**: The `read` command here is used to read and discard the first line of the input, which is typically the header line in a CSV file. This is important because we only want to process the actual data rows.

    #### Looping Through Each Line
    ```bash
    while IFS= read -r line; do
    ```
    - **Purpose**: This starts a loop that reads each line from the input file or standard input (stdin). 
    - **IFS (Internal Field Separator)**: The `IFS=` part ensures that leading/trailing whitespace is preserved. The `-r` option prevents backslashes from being interpreted as escape characters.

    #### Extracting the Specified Column
    ```bash
    value=$(echo "$line" | cut -d',' -f"$COLUMN")
    ```
    - **Purpose**: This command extracts the value from the specified column of the current line.
    - **How it works**:
    - `echo "$line"`: Outputs the current line.
    - `cut -d',' -f"$COLUMN"`: Uses the `cut` command to split the line into fields using a comma (`,`) as the delimiter (`-d','`). The `-f"$COLUMN"` option specifies which field to extract based on the column number provided by the user.
    - **Example**: If `line` is `21.4,6,258,110,3.08,3.215,19.44,1,0,3,1` and `COLUMN` is `1`, then `value` will be `21.4`.

    #### Checking if the Value is a Number
    ```bash
    if [[ "$value" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    ```
    - **Purpose**: This line checks if the extracted `value` is a valid number (either an integer or a floating-point number).
    - **How it works**:
    - The regular expression `^-?[0-9]+(\.[0-9]+)?$` checks for:
        - `^-?`: An optional negative sign at the start.
        - `[0-9]+`: One or more digits.
        - `(\.[0-9]+)?`: An optional decimal point followed by one or more digits.
        - `$`: End of the string.
    - **Example**: This will match `-3.14`, `0`, `42`, and `3.5` but not `abc`, `12.34.56`, or empty strings.

    #### Adding the Value to Sum
    ```bash
    sum=$(awk "BEGIN {print $sum + $value}")
    ```
    - **Purpose**: This line updates the `sum` variable by adding the current `value` to it.
    - **How it works**:
    - `awk "BEGIN {print $sum + $value}"`: This uses `awk` to perform the arithmetic operation. The `BEGIN` block allows us to execute the addition without needing to process any input data.
    - The result of the addition is captured and assigned back to `sum`.
    - **Why `awk`?**: `awk` is used here for its ability to handle floating-point arithmetic accurately, which is important for calculating the mean.

    #### Incrementing the Count
    ```bash
    count=$((count + 1))
    ```
    - **Purpose**: This line increments the `count` variable by 1, indicating that a valid number has been found and processed.
    - **How it works**: The `$((...))` syntax is used for arithmetic expansion in Bash, allowing for simple mathematical calculations.

6. **Final Mean Calculation**:
   - After processing all lines, the script checks if there were valid data points.
   - It calculates the mean using `awk` with the formula `sum / count`.
   - Finally, it prints the mean of the specified column.
   - Example:
     ```bash
     if [ "$count" -gt 0 ]; then
         mean=$(awk "BEGIN {print $sum / $count}")
         echo "Mean of column $COLUMN: $mean"
     else
         echo "ERROR: No valid data found in the specified column." 1>&2
         exit 1
     fi
     ```

     #### Checking for Valid Data Points
    ```bash
    if [ "$count" -gt 0 ]; then
    ```
    - **Purpose**: This checks if there were any valid numeric entries found in the specified column. If `count` is greater than 0, it means we have valid data to calculate the mean.

    #### Calculating the Mean
    ```bash
    mean=$(awk "BEGIN {print $sum / $count}")
    ```
    - **Purpose**: This line calculates the mean of the values found.
    - **How it works**:
    - Similar to before, it uses `awk` to perform the division of `sum` by `count`.
    - This ensures that the division is done correctly, accounting for any floating-point numbers.
    - **Example**: If `sum` is `100.5` and `count` is `5`, then `mean` will be `20.1`.

    #### Printing the Mean
    ```bash
    echo "Mean of column $COLUMN: $mean"
    ```
    - **Purpose**: This line prints the calculated mean to standard output, formatted to indicate which column the mean corresponds to.

    #### Handling No Valid Data
    ```bash
    else
        echo "ERROR: No valid data found in the specified column." 1>&2
        exit 1
    fi
    ```
    - **Purpose**: If no valid numbers were found (i.e., `count` is 0), the script prints an error message to standard error (stderr) and exits with a status of 1 to indicate an error.

### Example
When you run the script:
```bash
./mean.sh 3 "Lab 2/mtcars.csv"
```

The output will display the mean of the specified column:
```
Mean of column 3: <calculated_mean>
```

### Important Notes
- Ensure that the specified column contains numerical data, as the script assumes this.
- The script handles errors gracefully and provides informative messages to guide the user.

### Conclusion
The `mean.sh` script provides a straightforward way to calculate the mean of a specified column in a CSV file or from standard input. It includes error handling for incorrect usage and validates the input to ensure accurate calculations. The detailed documentation explains the purpose, usage, script code, breakdown, and key commands used in the script, along with the reasoning behind specific options and commands to enhance understanding.