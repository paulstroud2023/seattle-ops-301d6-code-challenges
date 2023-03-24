#!/usr/bin/python 

# Script: Ops 301 Class 10 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/24/23
# Purpose: Python file handling


# Main

import os   # need this module to delete the file

print("Opening testfile.txt...")
FILE = open("testfile.txt", "w")    # open testfile.txt for write access, create it if needed

# write three lines to file
print("Writing three lines of text to testfile.txt...")
for i in range(0, 3):
    FILE.write("Writing line " + str(i) + "\n")

# reopen the file for read access
print("The first line is:")
FILE = open("testfile.txt", "r")
print("\t" + FILE.readline(), end="")  # read and print the first line, don't add a newline

# wait for user input
input("Press any key to delete the file and exit: ")

print("Deleting testfile.txt...")
os.remove("testfile.txt")   # nuke the file

print("DONE")
# End