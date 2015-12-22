$EnvTag = [Environment]::GetEnvironmentVariable("Liberis:Environment.Name");

$url = "https://hooks.slack.com/services/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";

$payload = @{
  "text" = "[$EnvTag] - Deployed: $env:APPLICATION_NAME - v$env:APPVEYOR_BUILD_VERSION";
  } | ConvertTo-Json;

Invoke-RestMethod $url -Method Post -Body $payload -ContentType 'application/json';
