$EnvTag = [Environment]::GetEnvironmentVariable("Liberis:Environment.Name");

$urls = @{
  "LIVE" = "https://hooks.slack.com/services/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";
  "DEV" = "https://hooks.slack.com/services/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";
};

$payload = @{
  "text" = "[$EnvTag] - Deployed: $env:APPLICATION_NAME - v$env:APPVEYOR_BUILD_VERSION";
} | ConvertTo-Json;

Invoke-RestMethod $urls.$EnvTag -Method Post -Body $payload -ContentType 'application/json';

