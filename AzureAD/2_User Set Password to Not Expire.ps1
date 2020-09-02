$User = Read-Host -Prompt 'Input user email'
cls

$Credential = Get-Credential -Message "Input Service Account Credentials"
$Credential.password.MakeReadOnly()
Connect-AzureAD -Credential $Credential | Out-Null

Write-Host "Setting Password to never expire for: $User"
Write-Host " "

Set-AzureADUser -ObjectId $User -PasswordPolicies DisablePasswordExpiration | Out-Null

Write-Host "PasswordNeverExpires should read True..."
Write-Host " "

Get-AzureADUser -ObjectId $User | Select-Object UserprincipalName,@{
    N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}
} | Out-Host


read-host "Press ENTER to exit..."