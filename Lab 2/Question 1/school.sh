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