$Host.UI.RawUI.WindowTitle = 'LI16 06_docker_ps_hive'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 06_docker_ps_hive'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\evidencias\cmd-06.ps1'
Write-Host ''
Write-Host '--- fin 06_docker_ps_hive ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\06_docker_ps_hive.done' -Value (Get-Date -Format o) -Encoding ASCII
