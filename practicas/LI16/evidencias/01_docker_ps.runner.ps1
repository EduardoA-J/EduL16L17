$Host.UI.RawUI.WindowTitle = 'LI16 01_docker_ps'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 01_docker_ps'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\evidencias\cmd-01.ps1'
Write-Host ''
Write-Host '--- fin 01_docker_ps ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\01_docker_ps.done' -Value (Get-Date -Format o) -Encoding ASCII
