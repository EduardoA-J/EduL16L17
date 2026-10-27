Write-Host "docker ps"
docker ps --format "{{.Names}} | {{.Status}} | {{.Ports}}" | ForEach-Object { $_ -replace ', \[::\]:[0-9.\-]+->[0-9]+/tcp', '' }
