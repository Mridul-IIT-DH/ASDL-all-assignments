# Detailed Documentation for `school.sh`

#### Purpose
The `school.sh` script calculates the average `TotalAssessedValue` for properties located in the "MADISON SCHOOL" district from a CSV file named `Property_Tax_Roll.csv`. This script processes the data in a single pipeline without creating any intermediate files.

### Script Code
Here is the complete code for the `digits.sh` script:

```bash
#!/bin/bash

cat "./Lab 2/Property_Tax_Roll.csv" | grep "MADISON SCHOOL" | cut -d',' -f7 | { 
  declare -i sum=0
  declare -i num_lines=0
  while read x; do
    sum=$((sum + x))
    num_lines=$((num_lines + 1))
  done
  echo Average of $((sum / num_lines))
}
```

### Prerequisites
- Ensure that the `Property_Tax_Roll.csv` file is located in the same directory as the script.
- The CSV file must be properly formatted, with the first row containing headers and subsequent rows containing property data.

### Script Breakdown
1. **Reading the CSV File**: 
   - The script uses `cat` to read the contents of `Property_Tax_Roll.csv`.

2. **Filtering Rows**:
   - `grep "MADISON SCHOOL"` filters the lines to include only those that contain "MADISON SCHOOL", identifying properties within that school district.

3. **Extracting the Relevant Column**:
   - `cut -d',' -f7` extracts the 7th column from the filtered lines, which corresponds to the `TotalAssessedValue` of the properties.

4. **Calculating the Average**:
   - A brace-enclosed group command is used to calculate the average:
     - Two integer variables, `sum` and `num_lines`, are initialized to zero using the `declare` command.
     - A `while read x` loop reads each line (value of `TotalAssessedValue`) into the variable `x`.
     - The script updates `sum` by adding the current value of `x`, and increments `num_lines` by 1 for each line read.
     - After processing all lines, the average is calculated by dividing `sum` by `num_lines` and printed to the command line.

### Usage
To run the script, use the following command in the terminal:

```bash
bash school.sh
```

### Explanation of Key Commands and Options

#### 1. `grep`
- **Definition**: `grep` stands for "global regular expression print". It is a command-line utility used to search for specific patterns within files or input data.
  
- **Syntax**: 
  ```
  grep [OPTION...] PATTERN [FILE...]
  ```
  - **OPTION**: Modifiers that change the behavior of `grep`.
  - **PATTERN**: The string or regular expression to search for.
  - **FILE**: One or more files to search. If no file is specified, `grep` reads from standard input.

- **Functionality**: `grep` scans each line of input and prints lines that match the specified pattern. It supports regular expressions, allowing for complex search patterns.

- **Common Options**:
  - `-i`: Ignores case distinctions in patterns and input data.
  - `-v`: Inverts the match, displaying lines that do not match the pattern.
  - `-n`: Displays line numbers with matching lines.
  - `-c`: Counts the number of matching lines.

#### Example Usage of `grep`
To find the string "fruit" in a file called `fruits.txt`:
```bash
grep "fruit" fruits.txt
```

#### 2. `cut`
- **Definition**: The `cut` command is used to remove sections from each line of input. It can extract specific fields from a file or input stream.

- **Syntax**:
  ```
  cut [OPTION]... [FILE]...
  ```
  
- **Common Options**:
  - `-d`: Specifies the delimiter that separates fields in the input. For example, `-d','` indicates that fields are separated by commas.
  - `-f`: Specifies which fields to extract. For example, `-f7` extracts the 7th field.

#### Example Usage of `cut`
To extract the 7th column from a CSV file:
```bash
cut -d',' -f7 Property_Tax_Roll.csv
```

#### 3. `declare`
- **Definition**: The `declare` command is a built-in command in the Bash shell used to declare variables and functions, set their attributes, and display their values. It provides a way to enforce specific types and behaviors for variables.

- **Syntax**:
  ```
  declare [OPTION] [name[=value]]...
  ```

- **Common Options**:
  - `-i`: Declares an integer variable. Values assigned to this variable are treated as integers.
  - `-a`: Declares an indexed array.
  - `-A`: Declares an associative array.
  - `-l`: Converts the variable's value to lowercase.
  - `-u`: Converts the variable's value to uppercase.
  - `-x`: Exports the variable to the environment, making it available to child processes.
  - `-p`: Prints the attributes and values of the variable.

#### Example Usage of `declare`
To declare an integer variable and assign a value:
```bash
declare -i my_integer=10
```

To declare an array:
```bash
declare -a my_array=("apple" "banana" "cherry")
```

To export a variable:
```bash
declare -x my_var="Hello"
```

### Example
Assume the contents of `Property_Tax_Roll.csv` are as follows:

```
Id,TaxYear,Parcel,address,AssessedValueLand,AssessedValueImprovement,TotalAssessedValue,MortgageHolder,MillRate,EstFairMkt,DrainageDist,DrainageAmt,AvgAsmtRatio,EstFairMktLand,EstFairMktImp,SchoolLevyTax,TaxJuris1,TaxJuris2,TaxJuris3,TaxJuris4,TaxJuris5,PriorNet1,CurNet1,PctTaxChange1,PriorNet2,CurNet2,PctTaxChange2,PriorNet3,CurNet3,PctTaxChange3,PriorNet4,CurNet4,PctTaxChange4,PriorNet5,CurNet5,PctTaxChange5,PriorTotal,CurTotal,PctTaxChangeTotal,PriorDollarCR,CurDollarCR,PctDollarCR,PriorLottery,CurLottery,PctLottery,PriorNetTotal,CurNetTotal,PctNetTotal,OtherDesc1,OtherDesc2,OtherDesc3,OtherDesc4,OtherDesc5,OtherDesc6,OtherDesc7,OtherDesc8,OtherDesc9,OtherDesc10,OtherDesc11,OtherAmt1,OtherAmt2,OtherAmt3,OtherAmt4,OtherAmt5,OtherAmt6,OtherAmt7,OtherAmt8,OtherAmt9,OtherAmt10,OtherAmt11,FirstDueDate,SecondDueDate,ThirdDueDate,FourthDueDate,FullDueDate,FirstAmt,SecondAmt,ThirdAmt,FourthAmt,FullAmt
1,2023,60801101019,2001 Rae Ln,95400,214100,309500,,0.01827846,311243,,,99.44,95937,215306,-578.69,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,708.13,782.32,10.5,206.34,205.95,-0.2,2107.99,2199.44,4.3,2404.97,2469.47,2.7,,,,5427.43,5657.18,4.2,-84.75,-88.15,4,-278.17,-328.13,18,5064.51,5240.9,3.5,DELINQUENT MUNICIPAL SERVICES BILL,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,1609.73,1392.29,1392.29,1392.29,5786.6
2,2023,60801101027,2005 Rae Ln,101800,207800,309600,,0.01827846,311343,,,99.44,102373,208970,-578.87,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,708.39,782.58,10.5,206.42,206.01,-0.2,2108.76,2200.15,4.3,2405.84,2470.28,2.7,,,,5429.41,5659.02,4.2,-84.75,-88.15,4,-278.17,-328.13,18,5066.49,5242.74,3.5,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,1064.58,1392.72,1392.72,1392.72,5242.74
3,2023,60801101035,2009 Rae Ln,107700,198000,305700,,0.01827846,307422,,,99.44,108307,199115,-571.58,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,699.34,772.72,10.5,203.78,203.42,-0.2,2081.82,2172.43,4.4,2375.11,2439.16,2.7,,,,5360.05,5587.73,4.2,-84.75,-88.15,4,-278.17,-328.13,18,4997.13,5171.45,3.5,DELINQUENT MUNICIPAL SERVICES BILL,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,2371.31,1374.91,1374.91,1374.91,6496.04
```

### Dry Run of the Example

1. **Initial Input**:
   The script reads `Property_Tax_Roll.csv` and finds the following lines that contain "MADISON SCHOOL":

   ```
   1,2023,60801101019,2001 Rae Ln,95400,214100,309500,,0.01827846,311243,,,99.44,95937,215306,-578.69,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,708.13,782.32,10.5,206.34,205.95,-0.2,2107.99,2199.44,4.3,2404.97,2469.47,2.7,,,,5427.43,5657.18,4.2,-84.75,-88.15,4,-278.17,-328.13,18,5064.51,5240.9,3.5,DELINQUENT MUNICIPAL SERVICES BILL,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,1609.73,1392.29,1392.29,1392.29,5786.6
   2,2023,60801101027,2005 Rae Ln,101800,207800,309600,,0.01827846,311343,,,99.44,102373,208970,-578.87,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,708.39,782.58,10.5,206.42,206.01,-0.2,2108.76,2200.15,4.3,2405.84,2470.28,2.7,,,,5429.41,5659.02,4.2,-84.75,-88.15,4,-278.17,-328.13,18,5066.49,5242.74,3.5,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,1064.58,1392.72,1392.72,1392.72,5242.74
   3,2023,60801101035,2009 Rae Ln,107700,198000,305700,,0.01827846,307422,,,99.44,108307,199115,-571.58,DANE COUNTY,MATC,CITY OF MADISON,MADISON SCHOOL,,,,699.34,772.72,10.5,203.78,203.42,-0.2,2081.82,2172.43,4.4,2375.11,2439.16,2.7,,,,5360.05,5587.73,4.2,-84.75,-88.15,4,-278.17,-328.13,18,4997.13,5171.45,3.5,DELINQUENT MUNICIPAL SERVICES BILL,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,31-01-2024 00:00,31-03-2024 00:00,31-05-2024 00:00,31-07-2024 00:00,31-01-2024 00:00,2371.31,1374.91,1374.91,1374.91,6496.04
   ```

2. **Extracting TotalAssessedValue**:
   The `cut` command extracts the 7th column (TotalAssessedValue) from these lines:

   ```
   309500
   309600
   305700
   ```

3. **Calculating the Average**:
   - **Sum Calculation**:
     - `sum = 309500 + 309600 + 305700 = 924800`
   - **Number of Lines**:
     - `num_lines = 3`
   - **Average Calculation**:
     - `average = sum / num_lines = 924800 / 3 = 308266` (using integer division)

4. **Final Output**:
   The script echoes the calculated average:

   ```
   308266
   ```

### Conclusion
The `school.sh` script effectively calculates the average `TotalAssessedValue` for properties in the "MADISON SCHOOL" district by utilizing a simple yet powerful pipeline in bash. This documentation provides clarity on how the script works, along with a practical example and a dry run to illustrate its functionality. The detailed explanations of `grep`, `cut`, and `declare` enhance understanding of the tools used within the script.