Write-Host "Adding deployment in Raygun"
$url = "https://app.raygun.io/deployments?authToken=egz6yWcBUAtCt2EPTxONol8DfvSJpNYm"
$apiKey = [Environment]::GetEnvironmentVariable("Liberis:Environment.Raygun.APIKey")

$command = ConvertTo-Json @{ 
    apiKey = $apiKey
    version = $env:APPVEYOR_BUILD_VERSION
    ownerName = $env:APPVEYOR_REPO_COMMIT_AUTHOR
    emailAddress = $env:APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL
    scmIdentifier = $env:APPVEYOR_REPO_COMMIT
    releaseNotes = $env:APPVEYOR_REPO_COMMIT_MESSAGE
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
