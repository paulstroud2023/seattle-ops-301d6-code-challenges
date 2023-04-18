# Script: Ops 301 project
# Authors: Spencer Mitchell - static IP, hostname
#          Ademola Olatunbosun - AD domain services, AD forest
#          Justin Harrington - import OU and user info, add OUs to AD, add users to OUs
#          Paul Stroud - reboot persistence, phase integration
# Date of latest revision: 04/07/23
# Purpose: Automated setup of Active Directory and domain services on Windows Server 2019
#          Phase 1 - configure a predefined hostname and a static IP
#          Phase 2 - install domain services and deploy an AD forest with preset parameters
#          Phase 3 - install AD tools, create OUs, create user accts


# INSTRUCTIONS:
# Save this script, GreenGenius.csv, and GreenGenius_OU.txt to C:\
# When running this script, add the phase # as an argument (1-3)



############################
### FUNCTION DEFINITIONS ###
############################


# add an autorun key to the registry
Function AddRunOnceReg {
    param($val) # variable to hold the phase number, passed as an arg
    $cmd = "powershell.exe C:\AUTOMATION.ps1 $val" # command to execute
    $valueName = "TEST" # registry value to add
    $keyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" # path to the autorun key
    # create a new registry key
    New-ItemProperty -Path $keyPath -Name $valueName -Value "$cmd" -PropertyType String -Force | Out-Null
    Write-Host "Scheduled Phase $val for the next reboot..." # print message to console
   }

# change hostname, set static IP 
Function Phase1 {
    $newname = "GRNGNS-WINSVR" # new hostname
    $newip = "10.11.11.123"    # new ip address
    $newvlsm = 25              # subnet mask in slash notation
    $newgtwy = "10.11.11.126"  # new default gateway

    $adapter = Get-NetAdapter  # extract NIC index

    # delete the existing IP address and default gateway
    write-host "Clearing the existing IP address and the default gateway, if any..."
    Remove-NetIPAddress -InterfaceIndex $($adapter[0].ifIndex) -Confirm:$false
    Remove-NetRoute -InterfaceIndex $($adapter[0].ifIndex) -Confirm:$false
    sleep(1)

    # set the static IP using the variables as inputs
    write-host "Setting the static IP address to $newip"
    New-NetIPAddress -InterfaceIndex $adapter[0].ifIndex -IPAddress $newip -PrefixLength $newvlsm -DefaultGateway $newgtwy
    sleep(1)

    # change the hostname
    write-host "Renaming this computer to $newname"
    Rename-Computer -NewName $newname
    sleep(1)
   }


# install domain services, deploy AD forest
Function Phase2 {
    $adminPassword = ConvertTo-SecureString "Password123!@#" -AsPlainText -Force

    # install the necessary features and modules
    write-host "Installing pre-requisites..."
    Install-WindowsFeature -Name AD-Domain-Services
    Import-Module ADDSDeployment

    # deploy AD
    write-host "Deploying the new Windows domain..."
    sleep(1)
    # all options/switches were created by the AD export tool
    Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "WinThreshold" `
    -DomainName "corp.greengenius.com" `
    -DomainNetbiosName "GREENGENIUS" `
    -ForestMode "WinThreshold" `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -SafeModeAdministratorPassword $adminPassword `
    -Force:$true
   }


# install AD tools, add OUs, add user accts
Function Phase3 {
    Install-WindowsFeature RSAT-AD-Tools
    #Add-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDA.tool~~~~0.0.1.0 -Online
    #Import-Module ActiveDirectory

    # Step 1: Add OUs to AD
    $file = "C:\GreenGenius_OU.txt" # import OU names
    # loop through each line
    foreach ($line in Get-Content $file)
        {
         Write-Host "Adding the $line OU" # message to console
         # add OU
         New-ADOrganizationalUnit -name $line -path "DC=corp,DC=greengenius,DC=com" -ProtectedFromAccidentalDeletion:$false
        }

    # Step 2: Add users to respective OUs
    $ADUser = Import-Csv "c:\GreenGenius.csv" # import user info
    $password = "Password123!@#" # standard password (do NOT use this in production!)
    $count = 1 # counter var
    foreach ($User in $ADUser) # loop over the user list
       {
        # message to console, i.e. "3 > Adding user Bob Smith to Test Dept OU"
        Write-Host "$count > Adding user $($User.firstname) $($User.lastname) to $($User.OU) OU"
        # add a new user
        New-ADUser `
            -Name "$($User.firstname) $($User.lastname)" `
            -GivenName $User.firstname `
            -Surname $User.lastname `
            -Enabled $true `
            -Path "OU=$($User.OU),DC=corp,DC=greengenius,DC=com" `
            -Title $User.jobtitle `
            -Department $User.OU `
            -EmailAddress $User.email `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force)
        $count++ # increase the counter
       }
   }




#######################
### MAIN CODE BELOW ###
#######################


# check for admin privileges
if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
  { Write-Host "ADMIN ACCESS CHECK: OK" } # confirm admin privileges
 else # if no admin access, print to console and exit
  {
   Write-Host "ADMIN ACCESS CHECK: FAIL" 
   Write-Host "Please run this script as administrator"
   Exit
  }


$phase = $args[0] # save argument to the phase var

# select functions to perform based on phase number
switch  ($phase) {
    "1" {
         Write-Host "Executing Phase 1..."
         Phase1 # launch phase 1 function
         AddRunOnceReg -val "2"
        }
    "2" { 
         Write-Host "Executing Phase 2..."
         Phase2 # launch phase 2 function
         AddRunOnceReg -val "3" 
        }
    "3" {
         Write-Host "Executing Phase 3..." 
         Phase3 # launch phase 3 function
        }
    # exit script if invalid phase number
    Default { Write-Host "No phase specified. Please add a phase number (1-3) as an argument. Exiting..." }
}

Write-Host "PHASE $phase COMPLETE" # confirm phase completion

# reboot the system after phase 1 and 2
if (($phase -eq 1) -or ($phase -eq 2))
  {
   write-host "Rebooting in:    (press Ctrl+C to abort)"
   $countdown = 10 
   while ($countdown -gt 0)
        {
         write-host "$countdown " -NoNewline
         sleep(1)
         $countdown--
        }
   Restart-Computer -Force
  }
 else { pause } # otherwise prompt user to continue

# End