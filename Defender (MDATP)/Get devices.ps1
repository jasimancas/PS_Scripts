# Function to get an access token for MDATP
function Get-MDATPAccessToken {
    param (
        [string]$tenantId,
        [string]$clientId,
        [string]$clientSecret
    )

    $body = @{
        grant_type    = "client_credentials"
        scope         = "https://api.securitycenter.microsoft.com/.default"
        client_id     = $clientId
        client_secret = $clientSecret
    }

    $response = Invoke-RestMethod -Method Post -Uri "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token" -ContentType "application/x-www-form-urlencoded" -Body $body
    return $response.access_token
}

# Define your tenant ID, client ID, and client secret
$tenantId = "XX"
$clientId = "XX"
$clientSecret = "XX"

# Get the access token
$accessToken = Get-MDATPAccessToken -tenantId $tenantId -clientId $clientId -clientSecret $clientSecret

# Get devices from MDATP
$headers = @{
    "Authorization" = "Bearer $accessToken"
}

$mdatpDevices = Invoke-RestMethod -Method Get -Uri "https://api.securitycenter.microsoft.com/api/machines" -Headers $headers

# Display the MDATP devices
$mdatpDevices.value | Format-Table -Property computerDnsName, osPlatform, healthStatus, lastSeen

# $mdatpDevices.value | Export-Csv -Path C:\Users\jose.simancas\Desktop\DEFENDERdevices.csv -Delimiter ";"