$Host.UI.RawUI.WindowTitle = 'LI16 15_mes_cumpleanos'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 15_mes_cumpleanos'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '15_mes' -SqlFile 'F:\BIG_DATA\li16\sql\15_mes.sql'
Write-Host ''
Write-Host '--- fin 15_mes_cumpleanos ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\15_mes_cumpleanos.done' -Value (Get-Date -Format o) -Encoding ASCII
