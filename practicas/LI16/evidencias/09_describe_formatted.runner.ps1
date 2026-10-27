$Host.UI.RawUI.WindowTitle = 'LI16 09_describe_formatted'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 09_describe_formatted'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '09_describe' -SqlFile 'F:\BIG_DATA\li16\sql\09_describe.sql'
Write-Host ''
Write-Host '--- fin 09_describe_formatted ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\09_describe_formatted.done' -Value (Get-Date -Format o) -Encoding ASCII
