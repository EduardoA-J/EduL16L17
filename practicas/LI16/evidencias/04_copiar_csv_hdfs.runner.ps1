$Host.UI.RawUI.WindowTitle = 'LI16 04_copiar_csv_hdfs'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 04_copiar_csv_hdfs'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\evidencias\cmd-04.ps1'
Write-Host ''
Write-Host '--- fin 04_copiar_csv_hdfs ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\04_copiar_csv_hdfs.done' -Value (Get-Date -Format o) -Encoding ASCII
