#!/bin/bash

# Script: Ops 301 Class 04 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/16/23
# Purpose: Conditional execution in bash
#
# Resources used: google, chatgpt

# Main

$INPUT=""
while [[ $INPUT -ne 4 ]]; do # while loop for the regex match 
    
    # Print the menu
    echo -e "\n*** Please select one of the following options: ***"
    echo "1. Print 'Hello World'"
    echo "2. Ping the loopback address"
    echo "3. Show IP info"
    echo "4. Exit the program"

    # prompt and read user input
    echo -n "Please enter a number [1-4]: " && read INPUT
    echo ""

    # case match for 1-4
    case $INPUT in
        1)  # is this thing on...
            echo "Hello World"
            ;;
        2)  # go ping yourself
            ping 127.0.0.1 -c 5
            ;;
        3)  # show network adapters and addressing
            ip address show
            ;;
        4)  # print a message and exit (on the next loop test)
            echo "Exiting..."
            ;;
        *)  # any invalid option
            echo "The number is not valid. Please try again."
            ;;
    esac
done

# End