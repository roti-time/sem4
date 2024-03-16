#!/bin/bash
touch FROM.txt
touch TO.txt
echo "My name is Ahmad. My Roll# is 22i-1609" > FROM.txt
cat FROM.txt > TO.txt
rm FROM.txt
mv TO.txt FINAL_FILE.txt
