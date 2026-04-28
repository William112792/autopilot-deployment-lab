# Create Directory
md c:\HWID

# Set Location to the Directory
Set-Location c:\HWID

# Set Execution to allow running of scripts
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

# Install Script for AutopilotInfo
## Installs the script with NuGET and adds variable to $env:PATH array
Install-Script -Name Get-WindowsAutopilotInfo -Force

# Get AutopilotInfo and output to CSV
## Executes for the $env:PATH for the script file
Get-WindowsAutopilotInfo.ps1 -OutputFile AutopilotHWID.csv

# Optional: Set back to Restricted
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted -Force
