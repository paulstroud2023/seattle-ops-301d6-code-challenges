#!/usr/bin/python 

# Script: Ops 301 Class 08 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/22/23
# Purpose: Python lists, arrays, etc


# Main

# list/array declaration
my_strings = ["Alaska", "Colorado", "Wyoming", "Utah", "Washington", "Idaho", "Montana", "Oregon", "Arizona", "Texas"]
print("The complete list:", my_strings)

print("The fourth element:", my_strings[3]) # index starts at zero

print("Elements 6-10:", my_strings[5:10])    # list slice

print("Changing element #7 from:", my_strings[6], end=" to ")
my_strings[6] = "Maine" # new value for element #7
print(my_strings[6])

print("Aaand it's gone!")
# End