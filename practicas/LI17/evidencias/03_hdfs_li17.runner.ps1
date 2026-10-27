$Host.UI.RawUI.WindowTitle = 'LI17 03_hdfs_li17'
try {
  $size = $Host.UI.RawUI.BufferSize
  $size.Width = 180
  $size.Height = 30000
  $Host.UI.RawUI.BufferSize = $size
} catch {}
try { chcp 65001 | Out-Null } catch {}
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI17 - 03_hdfs_li17'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
docker exec namenode hdfs dfs -ls -h /li17/eduardoantezana
Write-Host ''
Write-Host 'Primeras lineas del CSV en HDFS:'
docker exec namenode hdfs dfs -cat /li17/eduardoantezana/data_EduardoAntezana.csv | Select-Object -First 3
Write-Host ''
Write-Host 'Warehouse de la practica anterior, conservado:'
docker exec namenode hdfs dfs -ls /user/hive/warehouse
Write-Host ''
Write-Host '--- fin 03_hdfs_li17 ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\03_hdfs_li17.done' -Value (Get-Date -Format o) -Encoding ASCII
