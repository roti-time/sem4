#!/bin/bash
touch TO.txt
touch FROM.txt
echo "Hi, My name is Abdul Sami Qasim and my roll number is 22i-1725" > FROM.txt
cat FROM.txt > TO.txt
rm FROM.txt
mv TO.txt FINAL_FILE.txt
