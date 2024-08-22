#!/bin/bash

# Enable dotglob to include hidden files (those starting with a dot)
shopt -s dotglob

# Get the five largest items in the current directory
# -h: human-readable sizes
# -s: summarize (only show total size per item)
# -d 1: only check the current directory (not recursive)
# sort -hr: sort in human-readable format, reverse order
# head -n 5: get the top 5 results
largest_items=$(du -sh * | sort -hr | head -n 5)

# Check if the output is empty
if [ -z "$largest_items" ]; then
    exit 0  # Exit without printing anything if no items are found
fi

# Print the results
echo "$largest_items"