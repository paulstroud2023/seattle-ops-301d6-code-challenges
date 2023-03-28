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
print(f"Time spent by normal processes executing in user mode: {cpu_times.user} sec")
print(f"Time spent by processes executing in kernel mode: {cpu_times.system} sec")
print(f"Time when system was idle: {cpu_times.idle} sec")
print(f"Time spent by priority processes executing in user mode: {cpu_times.nice} sec")
print(f"Time spent waiting for I/O to complete: {cpu_times.iowait} sec")
print(f"Time spent for servicing hardware interrupts: {cpu_times.irq} sec")
print(f"Time spent for servicing software interrupts: {cpu_times.softirq} sec")
print(f"Time spent by other operating systems running in a virtualized environment: {cpu_times.steal} sec")
print(f"Time spent running a virtual CPU for guest operating systems under the control of the Linux kernel: {cpu_times.guest} sec")


print("\nDONE")

# End