$Host.UI.RawUI.WindowTitle = 'LI16 08_create_table'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 08_create_table'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '08_create_table' -SqlFile 'F:\BIG_DATA\li16\sql\08_create_table.sql'
Write-Host ''
Write-Host '--- fin 08_create_table ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\08_create_table.done' -Value (Get-Date -Format o) -Encoding ASCII
