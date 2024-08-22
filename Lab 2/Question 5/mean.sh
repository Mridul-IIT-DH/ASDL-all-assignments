#!/bin/bash

usage() {
    echo "usage: $0 <column_number> [file.csv]" 1>&2
}

if [ "$#" -lt 1 ]; then
    echo "ERROR: Missing required argument." 1>&2
    usage
    exit 1
elif [ "$#" -gt 2 ]; then
    echo "ERROR: Too many arguments." 1>&2
    usage
    exit 1
fi

COLUMN="$1"
FILE="${2:-/dev/stdin}" 

if ! [[ "$COLUMN" =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR: Column number must be a positive integer." 1>&2
    exit 1
fi

sum=0
count=0

{
    read

    while IFS= read -r line; do
        value=$(echo "$line" | cut -d',' -f"$COLUMN")

        if [[ "$value" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
            sum=$(awk "BEGIN {print $sum + $value}")
            count=$((count + 1))
        fi
    done
} < "$FILE"

if [ "$count" -gt 0 ]; then
    mean=$(awk "BEGIN {print $sum / $count}")
    echo "Mean of column $COLUMN: $mean"
else
    echo "ERROR: No valid data found in the specified column." 1>&2
    exit 1
fi

exit 0