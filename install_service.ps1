

param([Parameter(Mandatory=$True)][string]$servicePath)


if([string]::IsNullOrEmpty($servicePath))
{
   Write-Output "$servicePath parameter is missing or does not have a value"
   Exit 15
}

Write-Output "Installing service : $servicePath"

#$path = Resolve-Path "$servicePath"
Invoke-Expression "$servicePath install"

Write-Output "Done"