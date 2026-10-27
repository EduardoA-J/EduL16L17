$Host.UI.RawUI.WindowTitle = 'LI16 16_jovenes_dispositivo'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 16_jovenes_dispositivo'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '16_jovenes_dispositivo' -SqlFile 'F:\BIG_DATA\li16\sql\16_jovenes_dispositivo.sql'
Write-Host ''
Write-Host '--- fin 16_jovenes_dispositivo ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\16_jovenes_dispositivo.done' -Value (Get-Date -Format o) -Encoding ASCII
