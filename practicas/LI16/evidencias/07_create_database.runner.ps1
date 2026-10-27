$Host.UI.RawUI.WindowTitle = 'LI16 07_create_database'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 07_create_database'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '07_create_db' -SqlFile 'F:\BIG_DATA\li16\sql\07_create_db.sql'
Write-Host ''
Write-Host '--- fin 07_create_database ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\07_create_database.done' -Value (Get-Date -Format o) -Encoding ASCII
