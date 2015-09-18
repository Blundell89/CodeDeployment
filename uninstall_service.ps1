param([Parameter(Mandatory=$True)][string]$serviceName)
param([Parameter(Mandatory=$True)][string]$servicePath)
param([Parameter(Mandatory=$True)][string]$serviceStopTimeOut)


if([string]::IsNullOrEmpty($serviceName))
{
  Write-Output "Service Name parameter is missing or does not have a value"
  Exit 15
}

if([string]::IsNullOrEmpty($servicePath))
{
   Write-Output "InstallPath parameter is missing or does not have a value"
   Exit 15
}

if([string]::IsNullOrEmpty($serviceStopTimeOut))
{
   Write-Output "StopTimeOut parameter is missing or does not have a value"
   Exit 15
}


Write-Output "Stop and UnInstall Service: $serviceName , InstallPath: $servicePath, ServiceTimeOut $serviceStopTimeOut"


$serviceInstance = Get-Service $serviceName -ErrorAction SilentlyContinue

if ($serviceInstance -ne $null) {

	Write-Output "Service found - Stop service"
	
	# We stop without using the -Force option to allow graceful close down
    Stop-Service $serviceName 
    
    #$serviceInstance.WaitForStatus('Stopped', '00:04:00')
	$serviceInstance.WaitForStatus('Stopped', $serviceStopTimeOut)
	
	if ($serviceInstance.Status -ne "Stopped")
	 {
		Write-Output "Service was not successfully stopped - aborting"
        Write-Output "Service status is: $($serviceInstance.Status)"
        Exit 15
	 }
	 else
	 {
		Write-Output "Service is stopped - beginning uninstall"
	 }
	
} 
else
{
    Write-Output "service not found"
}

Write-Output "Un-install service"
 
Invoke-Expression "$servicePath uninstall"

Write-Output "Done"