#!/usr/bin/python 

# Script: Ops 301 Class 06 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/20/23
# Purpose: Execute bash commands from python
#
# Resources used: google, chatgpt

# Main

# import os   # import the module that allows interacting with the OS
import subprocess   # using the subprocess module instead of os


### Original code, deprecated in favor of using `subprocess` lib
# os.system("whoami") # run whoami
# os.system("ip a")   # run ip a (show ip/adapter info)
# os.system("lshw -short")    # run lshw (show hardware info)



# run whoami and save output to cmd1
print("CURRENTLY LOGGED IN AS: ", end="")   # print w/o newline
cmd1 = subprocess.run(["whoami"], capture_output=True, text=True)
print(cmd1.stdout)  # print stdout of the command

# run ip a and save output to cmd2
print("NIC INFO: ")
cmd2 = subprocess.run(["ip", "a"], capture_output=True, text=True)
print(cmd2.stdout)  # print stdout of the command

# run lshw and save output to cmd3
print("HARDWARE INFO BRIEF: ")
cmd3 = subprocess.run(["lshw", "-short"], capture_output=True, text=True)
print(cmd3.stdout)  # print stdout of the command

exit



print("Goobye cruel world")

# End