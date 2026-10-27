$Host.UI.RawUI.WindowTitle = 'LI16 17_adultos_dispositivo'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 17_adultos_dispositivo'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '17_adultos_dispositivo' -SqlFile 'F:\BIG_DATA\li16\sql\17_adultos_dispositivo.sql'
Write-Host ''
Write-Host '--- fin 17_adultos_dispositivo ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\17_adultos_dispositivo.done' -Value (Get-Date -Format o) -Encoding ASCII
