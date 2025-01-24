# Import the module
Import-Module Microsoft.Graph

# Authenticate to Microsoft Graph
Connect-MgGraph

# Get all devices enrolled in Intune
$intuneDevices = Get-MgDeviceManagementManagedDevice

# Display the devices
$intuneDevices | Format-Table -Property deviceName, operatingSystem, complianceState, lastSyncDateTime

# $intuneDevices | Select-Object deviceName, id, AzureAdDeviceId, AzureAdRegistered, ComplianceState, LastSyncDateTime | Export-Csv -Path C:\Users\jose.simancas\Desktop\INTUNEdevices.csv -Delimiter ";" -NoTypeInformation
