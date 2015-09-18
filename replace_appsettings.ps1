param([Parameter(Mandatory=$True)][string]$config)

$configPath = "$env:APPLICATION_PATH\$config"

Write-Output "Loading config file from $configPath"
$xml = [xml](Get-Content $configPath)

ForEach($ap in $xml.configuration.appSettings.add)
{
	Write-Output "Processing AppSetting key $($ap.key)"
	
	$matchingEnvVar = [Environment]::GetEnvironmentVariable($ap.key)

	if($matchingEnvVar)
	{
		Write-Output "Found matching environment variable for key: $($ap.key)"
		Write-Output "Replacing value $($ap.value)  with $matchingEnvVar"

		$ap.value = $matchingEnvVar
	}
}

$xml.Save($configPath)