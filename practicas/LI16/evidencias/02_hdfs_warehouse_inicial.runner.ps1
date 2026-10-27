$Host.UI.RawUI.WindowTitle = 'LI16 02_hdfs_warehouse_inicial'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 160
  $size.Height = 4000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - 02_hdfs_warehouse_inicial'
Write-Host ('Equipo: ' + $env:COMPUTERNAME)
Write-Host ''
& 'F:\BIG_DATA\li16\evidencias\cmd-02.ps1'
Write-Host ''
Write-Host '--- fin 02_hdfs_warehouse_inicial ---'
Set-Content -Path 'F:\BIG_DATA\li16\evidencias\02_hdfs_warehouse_inicial.done' -Value (Get-Date -Format o) -Encoding ASCII
