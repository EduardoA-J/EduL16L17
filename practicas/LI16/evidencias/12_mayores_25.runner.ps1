$Host.UI.RawUI.WindowTitle = 'LI16 12_mayores_25'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 12_mayores_25'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '12_mayores_25' -SqlFile 'F:\BIG_DATA\li16\sql\12_mayores_25.sql'
Write-Host ''
Write-Host '--- fin 12_mayores_25 ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\12_mayores_25.done' -Value (Get-Date -Format o) -Encoding ASCII
