#!/usr/bin/python 

# Script: Ops 301 Class 12 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/28/23
# Purpose: Python psutil


# Main

import HTTP_response_codes
import requests

url = input("Please enter a URL: ")

#url = "http://pypi.org"
interwebz = requests.get(url)


print("Status code: ", interwebz.status_code,
       "\nMeaning: ", HTTP_response_codes.responses[interwebz.status_code][0],
       "\nDetailed description: ", HTTP_response_codes.responses[interwebz.status_code][1])


# End