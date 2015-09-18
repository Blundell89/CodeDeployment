
param([Parameter(Mandatory=$True)][string]$serviceName, [Parameter(Mandatory=$True)][string]$timeOut)

if([string]::IsNullOrEmpty($serviceName))
{
  Write-Output "serviceName parameter is missing or does not have a value"
  Exit 15
}

if([string]::IsNullOrEmpty($timeOut))
{
   Write-Output "timeOut parameter is missing or does not have a value"
   Exit 15
}

Write-Output "Starting service: $serviceName"
Write-Output "serviceStartTimeOut : $timeOut"

$serviceInstance = Get-Service $serviceName
Start-Service $serviceName
$serviceInstance.WaitForStatus('Running', $timeOut)

Write-Output "Done"