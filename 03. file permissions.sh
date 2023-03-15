#!/bin/bash

# Script: Ops 301 Class 03 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/15/23
# Purpose: Change permissions for user-selected files
#
# Resources used: google, chatgpt

# Main


# TASK: Prompts user for input directory path.

# display current dir
echo "Currently working in" $(pwd)


echo -n "Enter directory name: "
read DIR  # read user input

if [[ -d $DIR ]]  #check if dir exists
    then echo "Checking if" $DIR "exists... OK"
    else
      echo $DIR "does not exist. Exiting..."
      exit # terminate the script
fi


# TASK: Prompts user for input permissions number (e.g. 777 to perform a chmod 777)

PERM="" # variable to store permissions
REGEX='^[0-7]{3}$' # regex pattern to match a string of three numbers between 0-7 each
while ! [[ $PERM =~ $REGEX ]]; do # while loop for the regex match 
    echo -n "Enter the file permission as NNN, where each N is a number between 0 and 7: "
    read PERM  # read user input
done

# TASK: Navigates to the directory input by the user and changes all files inside it to the input setting.
echo "Changing permissions to" $PERM "for all files inside" $DIR
chmod $PERM $DIR/* # apply permissions to files inside of $DIR


# TASK: Prints to the screen the directory contents and the new permissions settings of everything in the directory.
ls -l $DIR # -l switch to show long format that includes permissions


# End