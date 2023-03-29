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
cmd_text = ("GET", "POST", "PUT", "DELETE", "HEAD", "PATCH", "OPTIONS")

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
print("\t1 GET")
print("\t2 POST")
print("\t3 PUT")
print("\t4 DELETE")
print("\t5 HEAD")
print("\t6 PATCH")
print("\t7 OPTIONS")

while True:
    i = int(input("\nPlease enter the number for the command you wish to perform [1-8]: "))
    if i in range(1, 8): break

print(f'This command will perform a {cmd_text[i-1]} command on the {url} URL')
confirm = input("Do you wish to continue? (y/n) ")
if confirm == "n":
    exit

#try:
    interwebz = http_cmd[i](url)
#except:
    # print("The URL is incorrect. Please try again.")
    # exit(1)



print("\nCommand complete!", end="")
print("\n\tStatus code: ", interwebz.status_code,
       "\n\tCode meaning: ", HTTP_response_codes.responses[interwebz.status_code][0],
       "\n\tDetailed description: ", HTTP_response_codes.responses[interwebz.status_code][1])


# End