#!/usr/bin/python 

# Script: Ops 301 Class 07 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/21/23
# Purpose: Traverse/map specified directory

# Main


# Import libraries
import os

# Declaration of variables

### Read user input here into a variable
user_dir = input("Enter a directory path: ")

# Declaration of functions

def map_dir(path):  # maps/walks the given directory path
    for (root, dirs, files) in os.walk(path):   # iterate over the values returned by os.walk
        print("\tContents of ", root, "/:", sep="")     # print the top-level dir

        if len(dirs) == 0 and len(files) == 0: print("\t<empty>")   # if no files or subdirs, print that it's empty
        else:
            if len(dirs) > 0: print("\tSubdirectories in ", root, ":", dirs, sep="")    # print subdirs
            if len(files) > 0: print("\tFiles in ", root,": " , files, sep="")          # print files

# Main

### Pass the variable into the function here
map_dir(user_dir)   # call the function for the entered path

# End

# End