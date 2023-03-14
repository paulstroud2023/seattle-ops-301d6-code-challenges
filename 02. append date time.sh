#!/bin/bash

# Script: Ops 301 Class 02 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/13/23
# Purpose: Copy syslog and append current date/time to the filename
#
# Resources used: google, chatgpt, https://google.github.io/styleguide/shellguide.html

# Main


# change the OS timezone to local time
export TZ=US/Pacific

# copy the syslog file to pwd and append date and time to the filename
cp /var/log/syslog ./syslog.$(date +'%Y%m%d.%H%M')

# End