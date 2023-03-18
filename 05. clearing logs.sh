#!/bin/bash

# Script: Ops 301 Class 05 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/17/23
# Purpose: Log backup and erasing tracks
#
# Resources used: google, chatgpt

# Main


rm -r LOG_BKP/  # remove backup dir if it exists

# change the OS timezone to local time
export TZ=US/Pacific


# TASK: Print to the screen the file size of the log files before compression
echo "Original file sizes:"
stat -c "%n %s" /var/log/syslog
stat -c "%n %s" /var/log/wtmp

# TASK: Compress the contents of the log files listed below to a backup directory 
#       /var/log/syslog
#       /var/log/wtmp

echo -n "Creating backup dir (LOG_BKP)... "
mkdir LOG_BKP && echo "OK"
echo "Compressing log files..."

# append date/time to file name and save to a var
FNAME1=syslog.$(date +'%Y%m%d.%H%M').gz
FNAME2=wtmp.$(date +'%Y%m%d.%H%M').gz

# compress log files and save the backup to LOG_BKP
gzip -c /var/log/syslog > LOG_BKP/$FNAME1
gzip -c /var/log/wtmp > LOG_BKP/$FNAME2


sleep 1 # timeout



# TASK: The file name should contain a time stamp with the following format -YYYYMMDDHHMMSS 
#       Example: /var/log/backups/syslog-20220928081457.zip
# TASK: Clear the contents of the log file

# Copying log files to demonstrate erasing tracks
# In a real scenario, these commands would execute on the original logs, not copies
cp /var/log/syslog ./syslog_copy
cp /var/log/wtmp ./wtmp_copy

# first method: corrupt the file
LOG_SIZE=$(stat -c%s syslog_copy)   # calculate file size and hold it in a var
echo -e "\nOverwriting syslog_copy with random data... "
echo "First pass..."
# dd overwrite with random data from /dev/random
dd if=/dev/random of=syslog_copy bs=$LOG_SIZE count=1 conv=notrunc &> /dev/null
echo "Second pass..."
dd if=/dev/random of=syslog_copy bs=$LOG_SIZE count=1 conv=notrunc &> /dev/null
echo "DONE"

# second method: shred and remove the file
echo -e "\nShredding wtmp_copy"
# shred the file using the built-in command
shred -vzfu wtmp_copy   # verbose, force, zero out, remove
echo "DONE"


sleep 1

# TASK: Print to screen the file size of the compressed file
# TASK: Compare the size of the compressed files to the size of the original log files

echo -e "\nCompressed file stats:"
# list gzip stats for each archive
gzip -l LOG_BKP/$FNAME1
gzip -l LOG_BKP/$FNAME2

# End