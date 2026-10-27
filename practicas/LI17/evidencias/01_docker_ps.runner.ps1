$Host.UI.RawUI.WindowTitle = 'LI17 01_docker_ps'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 180
  $size.Height = 30000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
try { chcp 65001 | Out-Null } catch {}
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI17 - 01_docker_ps'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
docker ps -a --format 'table {{.Names}}	{{.Status}}	{{.Image}}'
Write-Host ''
Write-Host '--- fin 01_docker_ps ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\01_docker_ps.done' -Value (Get-Date -Format o) -Encoding ASCII
