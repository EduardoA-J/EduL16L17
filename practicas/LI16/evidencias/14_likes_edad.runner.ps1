$Host.UI.RawUI.WindowTitle = 'LI16 14_likes_edad'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 14_likes_edad'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '14_likes_edad' -SqlFile 'F:\BIG_DATA\li16\sql\14_likes_edad.sql'
Write-Host ''
Write-Host '--- fin 14_likes_edad ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\14_likes_edad.done' -Value (Get-Date -Format o) -Encoding ASCII
