#!/bin/bash

mkdir -p ten

for i in $(seq -w 1 10); do
    dir_name="ten/dir$i"
    mkdir -p "$dir_name"

    echo "1" > "$dir_name/file1.txt"
    echo -e "2\n2" > "$dir_name/file2.txt"
    echo -e "3\n3" > "$dir_name/file3.txt"
    echo -e "4\n4\n4\n4" > "$dir_name/file4.txt"
done