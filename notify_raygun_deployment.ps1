[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string] $raygunApiKey,
    [Parameter(Mandatory=$True)]
    [string] $version,
    [Parameter(Mandatory=$True)]
    [string] $ownerName,
    [Parameter(Mandatory=$True)]
    [string] $emailAddress,
    [Parameter()]
    [string] $scmIdentifier,
    [Parameter()]
    [string] $releaseNotes
)

Write-Host "Adding deployment in Raygun"
$url = "https://app.raygun.io/deployments?authToken=egz6yWcBUAtCt2EPTxONol8DfvSJpNYm"

$command = ConvertTo-Json @{ 
    apiKey = $raygunApiKey
    version = $version
    ownerName = $ownerName
    emailAddress = $emailAddress
    scmIdentifier = $scmIdentifier
    releaseNotes = $releaseNotes
}

$bytes = [System.Text.Encoding]::ASCII.GetBytes($command)
$web = [System.Net.WebRequest]::Create($url)
$web.Method = "POST"
$web.ContentLength = $bytes.Length
$web.ContentType = "application/json"
$stream = $web.GetRequestStream()
$stream.Write($bytes,0,$bytes.Length)
$stream.close()

$response = [System.Net.HttpWebResponse]$web.GetResponse()
if($response.StatusCode -eq [System.Net.HttpStatusCode]::OK) {
    Write-Host "Added deployment in Raygun"
} else {
    Write-Host "Error received when adding deployment in Raygun: " $response.StatusCode " - " $response.StatusDescription
}