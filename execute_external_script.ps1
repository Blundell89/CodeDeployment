Function ExecuteExternalScript([string]$url, [hashtable]$data)
{
	Write-Output "Downloading script $url"
	$scriptString = (new-object net.webclient).DownloadString($url)

	Write-Output "Creating script block with params"
	$data | Out-String | Write-Host
	$scriptBlock = [scriptblock]::create(".{$scriptString} $(&{$args} @data)")
	Invoke-Command -ScriptBlock $scriptBlock
}