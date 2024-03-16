#!/bin/bash
input_string=$1

echo "$input_string" | aspell -a | tail -n +2 | awk '{print $5}'
