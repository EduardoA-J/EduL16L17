$Host.UI.RawUI.WindowTitle = 'LI16 13_amigos_genero'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 13_amigos_genero'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '13_amigos_genero' -SqlFile 'F:\BIG_DATA\li16\sql\13_amigos_genero.sql'
Write-Host ''
Write-Host '--- fin 13_amigos_genero ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\13_amigos_genero.done' -Value (Get-Date -Format o) -Encoding ASCII
