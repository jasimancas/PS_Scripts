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

$body2 = @{
    "Value"      = "Offboarded"
    "Action"     = "Add"
    "MachineIds" = @(
        "89d6253cf2bed12d710b9e2c7fe0d9a027bab174",
        "9799deb64a28b768399d5ca0314aa55fe7161175")
}

Invoke-RestMethod -Method Post -Uri "https://api.securitycenter.microsoft.com/api/machines/AddOrRemoveTagForMultipleMachines" -Headers $headers -Body ($body2 | ConvertTo-Json) -ContentType "application/json"