$Host.UI.RawUI.WindowTitle = 'LI16 10_load_y_limit'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 10_load_y_limit'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '10_load' -SqlFile 'F:\BIG_DATA\li16\sql\10_load.sql'
Write-Host ''
Write-Host '--- fin 10_load_y_limit ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\10_load_y_limit.done' -Value (Get-Date -Format o) -Encoding ASCII
