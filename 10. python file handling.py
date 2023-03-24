#!/usr/bin/python 

# Script: Ops 301 Class 10 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/24/23
# Purpose: Python file handling


# Main

FILE = open("testfile.txt", "w")    # open testfile.txt for write access, create it if needed

# write three lines to file
for i in range(0, 3):
    FILE.write("Writing line " + str(i) + "\n")

# reopen the file for read access
FILE = open("testfile.txt", "r")
print(FILE.readline(), end="")  # read and print the first line, don't add a newline

# End