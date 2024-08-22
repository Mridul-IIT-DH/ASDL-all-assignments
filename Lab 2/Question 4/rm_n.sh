#!/bin/bash

usage() {
    echo "usage: $0 <dir> <n>" 1>&2
}

if [ "$#" -ne 2 ]; then
    echo "ERROR: Incorrect number of arguments." 1>&2
    usage
    exit 1
fi

DIR="$1"
N="$2"

if [ ! -d "$DIR" ]; then
    echo "ERROR: input is not a directory." 1>&2
    exit 1
fi

find "$DIR" -type f -size +"$N"c -exec rm -f {} +

exit 0