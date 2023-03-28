#!/usr/bin/python 

# Script: Ops 301 Class 11 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/27/23
# Purpose: Python psutil


# Main

import psutil

# Get the CPU times
cpu_times = psutil.cpu_times()

# Print the desired CPU time information
print(f"Time spent by normal processes executing in user mode: {cpu_times.user:.2f} seconds")
print(f"Time spent by processes executing in kernel mode: {cpu_times.system:.2f} seconds")
print(f"Time when system was idle: {cpu_times.idle:.2f} seconds")
print(f"Time spent by priority processes executing in user mode: {cpu_times.nice:.2f} seconds")
print(f"Time spent waiting for I/O to complete: {cpu_times.iowait:.2f} seconds")
print(f"Time spent for servicing hardware interrupts: {cpu_times.irq:.2f} seconds")
print(f"Time spent for servicing software interrupts: {cpu_times.softirq:.2f} seconds")
print(f"Time spent by other operating systems running in a virtualized environment: {cpu_times.steal:.2f} seconds")
print(f"Time spent running a virtual CPU for guest operating systems under the control of the Linux kernel: {cpu_times.guest:.2f} seconds")


# End