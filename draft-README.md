Initial thoughts and breakdown before compiling into actual README.md

NOTES:

Intune Connector for Active Directory
- Install to configure Hybrid Joined Devices

Device Configuration Policy for Windows Autopilot Domain Join
- Sets computer name prefix
- Sets Domain Name such as company.lan
- Sets Organizational Unit like OU=<Condition 2/Team>,OU=<Condition 1/Department>,DC=COMPANY,DC=LAN

Group Tag based on naming Scheme
- Such as COMPANY_Department_HybridJoin
- Such as COMPANY_Department_EntraJoin
- Such as COMPANY_LOCATION_SelfDeploy
Security Group identifying Group Tag
- Dynamic Rule for: (device.devicePhysicalIds -any (_ -eq "[OrderID]:COMPANY_Department_HybridJoin"))

Deployment Profile
- Sets Out-of-box Eperience (OOBE)
- Defines computer name for Entra Joined devices (Not Hybrid)
- Allows conversion of existing devices to Autopilot
- Assign Dynamic Security Group for future and old groups for conversion

Enrollment Status Page
- Define error window such as 180 minutes depending on network speed and apps required
- Define Required Apps that block completion if failure installing
- Set Error Message to provide support contact and/or steps for Self-resolution
- Assign Dynamic Security Group for future devices

Apps for regular deployment (Non-blocking)
- Define Apps to be installed by User Groups versus Device Groups
- Apply Dynamic Security Group for these Autopilot Devices to streamline the process (These are not required but will be pushed in good faith)
- Define Required Apps (Non-blocking enrollment installs), Available (Self install via Company Portal), and Uninstall (Enforce removal for various reasons)
- Recommend deploying Company Portal as options for Self-Service

(Optional but recommended) Define Device Categories and Equivalent Security Groups
- This option in addition to Autopilot can allow branching of updates to handle Production, QA, and POC/Pilot standards
- Device Category can be updated from the Company Portal app allowing easy transition between branches
- Visible in Intune Portal and Manageable by Intune Administrators per Device

Define Group Tag on Windows Autopilot Devices
- Conversion of old groups will add their Serial automatically on check-in
- Manual adds to be completed be Vendor or Imported using Hash
- Define Group Tag on the Device by identifying its Serial Number and Set Group Tag field
- Good time to Assign User if applicable
- Good time to define Device Name (With in best faith override device name for Entra Joined devices)

(TO DO) Repository that has example scripts to identify each of these sections as a list and set specific items like Group Tag via powershell script.

PS: Hash is obtainable via Diagnostic Logs and identifiable via powershell with powershell:
md c:\HWID
Set-Location c:\HWID
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force
Install-Script -Name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo.ps1 -OutputFile AutopilotHWID.csv
