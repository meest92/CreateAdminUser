<#
.SYNOPSIS
  Create local user account
.DESCRIPTION
  Creates a local user account on de computer and disable the rest of local users. Requires RunAs permissions to run.
.OUTPUTS
  none
.NOTES
  Version:        1.0
  Author:         Meest
  Creation Date:  05 october 2022
  Purpose/Change: Initial script development
#>

$user='Adminacc' # Username that you want to create
$localuserpwd = ConvertTo-SecureString "MyPassword" -AsPlainText -Force # Password that you what to have the user
$logFile = "c:\%HOMEPATH%\Desktop\log.txt" # Log Path, if you don'to want logFile you can't comment this line

Function Write-Log {
  param(
      [Parameter(Mandatory = $true)][string] $message,
      [Parameter(Mandatory = $false)]
      [ValidateSet("INFO","WARN","ERROR")]
      [string] $level = "INFO"
  )
  # Create timestamp
  $timestamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
  # Append content to log file
  Add-Content -Path $logFile -Value "$timestamp [$level] - $message"
}

Function CreateLocalUser {
    process {
      try {
        # Create new user with default password and password never expires as policy
        New-LocalUser -Name $user -Password $localuserpwd -FullName $user -PasswordNeverExpires -ErrorAction stop
        Write-Log -message "$user local user created"
        # Add new user to administrator group
        Add-LocalGroupMember -Group Administradores -Member $user -ErrorAction stop
        Write-Log -message "$user added to the local users group"
      }catch{
        Write-log -message "Creating local account failed" -level "ERROR"
      }
    }    
}

Function Disable-LocalUsers {
process {
      try {
        # Disable all users exept our user local admin
        Get-WmiObject -ComputerName $env:computername -Class Win32_UserAccount -Filter "LocalAccount='True' and Disabled='False' and Name!='$user'"| Disable-LocalUser -ErrorAction stop
        Write-Log -message "All users disabled"
      }catch{
        Write-log -message "Error disabling users" -level "ERROR"
      }
    }    
}


if ( ! (Get-WmiObject -ComputerName $env:computername -Class Win32_UserAccount -Filter "Name='$user'")){
        Write-Log -message "#########"
        Write-Log -message "$env:COMPUTERNAME - Create local user account"
        CreateLocalUser
        Write-Log -message "#########"
        Write-Log -message "$env:COMPUTERNAME - Disable All Localusers"
        Disable-LocalUsers
    }else{
        Write-Log -message "#########"
        Write-Log -message "$env:COMPUTERNAME - Disable All Localusers"
        Disable-LocalUsers
    }
