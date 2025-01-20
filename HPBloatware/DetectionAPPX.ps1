# This script will detect the presence of HP bloatware / crapware
# and return an exit code of 1 if any are found, or 0 if none are found.
# This script is intended to be used in conjunction with the removal script.
# The list of packages to detect can be found in the UninstallPackages array.
$UninstallPackages = @(
    "AD2F1837.HPDesktopSupportUtilities"
    "AD2F1837.HPEasyClean"
    "AD2F1837.HPJumpStarts"
    "AD2F1837.HPPCHardwareDiagnosticsWindows"
    "AD2F1837.HPPowerManager"
    "AD2F1837.HPPrivacySettings"
    "AD2F1837.HPQuickDrop"
    "AD2F1837.HPQuickTouch"
    "AD2F1837.HPSupportAssistant"
    "AD2F1837.HPSureShieldAI"
    "AD2F1837.HPSystemInformation"
    "AD2F1837.HPWorkWell"
    "AD2F1837.myHP"
)
# HP identifier
$HPidentifier = "AD2F1837"

# Get installed packages matching the list or identifier
$InstalledPackages = Get-AppxPackage -AllUsers `
    | Where-Object {($UninstallPackages -contains $_.Name) -or ($_.Name -match "^$HPidentifier")}

# Get provisioned packages matching the list or identifier
$ProvisionedPackages = Get-AppxProvisionedPackage -Online `
    | Where-Object {($UninstallPackages -contains $_.DisplayName) -or ($_.DisplayName -match "^$HPidentifier")}

if (($InstalledPackages) -or ($ProvisionedPackages)) {
    # Apps detected, need to run removal script
    Write-Host "Apps detected, starting removal script"
    exit 1
}

Write-Host "No apps detected"
exit 0