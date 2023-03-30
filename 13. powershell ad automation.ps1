# Script: Ops 301 Class 13 Ops Challenge Solution
# Author: Paul Stroud
# Date of latest revision: 03/29/23
# Purpose: Powershell AD automation


# Main

# the command will add a new user AD with the switches specifying the required information
# the password is entered directly through the command via ConverTo-SecureString command
# -AsPlainText will process the password as plaintext without any modifications
# -Force will suppress the powershell warning against using this method
New-ADUser -Name "Franz Ferdinand" -EmailAddress "ferdi@globexpower.com" -Department "TPS Dept" -Title "TPS Reporting Lead" -City "Springfield" -State "OR" -Company "Globex USA" -AccountPassword (ConvertTo-SecureString "Password123!@#" -AsPlainText -force) -Enabled $true

# End