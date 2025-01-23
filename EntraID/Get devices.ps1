# Import the module
Import-Module AzureAD

# Authenticate to Microsoft Graph and Azure AD
Connect-AzureAD

# Get all devices from Azure AD
$aadDevices = Get-AzureADDevice -All $true

# Display the Azure AD devices
$aadDevices | Format-Table -Property DisplayName, DeviceId, DeviceOSType, DeviceTrustType