#!/usr/bin/python 

# Script: Ops 301 Class 11 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/27/23
# Purpose: Python psutil


# Main

import psutil   # import the psutil module

# save the return values' array from psutil.cpu_times()
cpu_times = psutil.cpu_times()

# print specific times with a corresponding prompt
# formatting output as f-strings that include the array/variable
print("[ PSUTIL INFO ]")
print("System/CPU time spent on:")
print(f"- normal processes executing in user mode: {cpu_times.user} sec")
print(f"- processes executing in kernel mode: {cpu_times.system} sec")
print(f"- system idle: {cpu_times.idle} sec")
print(f"- priority processes executing in user mode: {cpu_times.nice} sec")
print(f"- waiting for I/O to complete: {cpu_times.iowait} sec")
print(f"- servicing hardware interrupts: {cpu_times.irq} sec")
print(f"- servicing software interrupts: {cpu_times.softirq} sec")
print(f"- other OSs/virtualization: {cpu_times.steal} sec")
print(f"- running a vCPU for a guest OS: {cpu_times.guest} sec")


print("\nDONE")

# End