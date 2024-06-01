#!/bin/bash

# Read the sentence from the command line argument
sentence="$1"

# Run aspell and check for spelling mistakes
output=$(echo "$sentence" | aspell -a)

# Extract the misspelled words from the output
misspelled_words=$(echo "$output" | awk '/^\&/ { print $2 }')

# Print the misspelled words
echo "$misspelled_words" > misspelled_words.txt
