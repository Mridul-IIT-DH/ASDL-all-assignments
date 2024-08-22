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