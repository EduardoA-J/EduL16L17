$Host.UI.RawUI.WindowTitle = 'LI16 11_total_usuarios'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 11_total_usuarios'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '11_total' -SqlFile 'F:\BIG_DATA\li16\sql\11_total.sql'
Write-Host ''
Write-Host '--- fin 11_total_usuarios ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\11_total_usuarios.done' -Value (Get-Date -Format o) -Encoding ASCII
