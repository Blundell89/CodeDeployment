Function ExecuteExternalScript([string]$url, [hashtable]$params)
{
	Write-Output "Downloading script $url"
	$replace_appsettings = (new-object net.webclient).DownloadString($url)

	Write-Output "Creating script block with params"
	$params | Out-String | Write-Host
	$scriptBlock = [scriptblock]::create(".{$replace_appsettings} $(&{$args} @params)")
	Invoke-Command -ScriptBlock $scriptBlock
}