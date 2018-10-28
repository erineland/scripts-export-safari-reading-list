#!/bin/bash
# Script to iterate over the lines in a text file and send each line to pocket.
# Change Bash's Internal Feld Separator variable to read each new link from http
IFS = $'http://'

while read line; do
    echo $line
done < readinglistlinksfromsafari.txt