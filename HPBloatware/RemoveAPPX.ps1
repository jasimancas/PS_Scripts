# List of built-in apps to remove
$UninstallPackages = @(
    "AD2F1837.HPJumpStarts"
    "AD2F1837.HPPCHardwareDiagnosticsWindows"
    "AD2F1837.HPPowerManager"
    "AD2F1837.HPPrivacySettings"
    "AD2F1837.HPSupportAssistant"
    "AD2F1837.HPSureShieldAI"
    "AD2F1837.HPSystemInformation"
    "AD2F1837.HPQuickDrop"
    "AD2F1837.HPWorkWell"
    "AD2F1837.myHP"
    "AD2F1837.HPDesktopSupportUtilities"
    "AD2F1837.HPQuickTouch"
    "AD2F1837.HPEasyClean"
)

$HPidentifier = "AD2F1837"

# Get installed packages matching the list or identifier
$InstalledPackages = Get-AppxPackage -AllUsers `
    | Where-Object { ($UninstallPackages -contains $_.Name) -or ($_.Name -match "^$HPidentifier") }

# Get provisioned packages matching the list or identifier
$ProvisionedPackages = Get-AppxProvisionedPackage -Online `
    | Where-Object { ($UninstallPackages -contains $_.DisplayName) -or ($_.DisplayName -match "^$HPidentifier") }

# Remove appx provisioned packages - AppxProvisionedPackage
ForEach ($ProvPackage in $ProvisionedPackages) {
    Write-Host "Attempting to remove provisioned package: [$($ProvPackage.DisplayName)]..."
    try {
        $Null = Remove-AppxProvisionedPackage -PackageName $ProvPackage.PackageName -Online -ErrorAction Stop
        Write-Host "Successfully removed provisioned package: [$($ProvPackage.DisplayName)]"
    }
    catch {
        Write-Warning "Failed to remove provisioned package: [$($ProvPackage.DisplayName)]"
    }
}

# Remove appx packages - AppxPackage
ForEach ($AppxPackage in $InstalledPackages) {
    Write-Host "Attempting to remove Appx package: [$($AppxPackage.Name)]..."
    try {
        $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Stop
        Write-Host "Successfully removed Appx package: [$($AppxPackage.Name)]"
    }
    catch {
        Write-Warning "Failed to remove Appx package: [$($AppxPackage.Name)]"
    }
}