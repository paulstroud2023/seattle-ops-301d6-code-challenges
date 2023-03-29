#!/usr/bin/python 

# Script: Ops 301 Class 12 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/28/23
# Purpose: Python psutil


# Main

import HTTP_response_codes
import requests

# HTTP command dictionary to reference later
http_cmd = { 1:requests.get, 
             2:requests.post, 
             3:requests.put, 
             4:requests.delete, 
             5:requests.head, 
             6:requests.patch, 
             7:requests.options } 

#print(http_cmd[1]("http://pypi.org"))


# prompt user input
url = input("Please enter a URL: ")

# confirm whether a URL is valid by running a GET command against it
# request.get will execute without error is URL is correct
try:
    requests.get(url)   
except:         # catch any exceptions and terminate the scripts with an error message
    print("The URL is incorrect. Please try again.")
    exit(1)     # return error code on exit


#url = "http://pypi.org"
print("This program can perform one of the following HTTP commands:")
print("1 GET")
print("2 POST")
print("3 PUT")
print("4 DELETE")
print("5 HEAD")
print("6 PATCH")
print("7 OPTIONS")

while True:
    i = int(input("\nPlease enter the number for the command you wish to perform [1-8]: "))
    if i >= 1 and i <= 7: break

print("This command will perform a [PLACEHOLDER] command on the [PLACEHOLDER] URL")
input("Do you wish to continue? (y/n) ")

try:
    interwebz = http_cmd[i](url)
except:
    print("The URL is incorrect. Please try again.")
    exit(1)



print("\nCommand complete!", end="")
print("\n\tStatus code: ", interwebz.status_code,
       "\n\tMeaning: ", HTTP_response_codes.responses[interwebz.status_code][0],
       "\n\tDetailed description: ", HTTP_response_codes.responses[interwebz.status_code][1])


# End