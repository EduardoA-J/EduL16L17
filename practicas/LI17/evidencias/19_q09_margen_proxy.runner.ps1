$Host.UI.RawUI.WindowTitle = 'LI17 19_q09_margen_proxy'
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
Write-Host 'LI17 - 19_q09_margen_proxy'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
Write-Host 'hive -f /tmp/q09_margen_proxy.sql'
Write-Host '---- SQL ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\q09_margen_proxy.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
docker cp 'F:\BIG_DATA\li17\sql\q09_margen_proxy.sql' 'hive-server:/tmp/q09_margen_proxy.sql'
docker exec hive-server sed -i 's/\r$//' /tmp/q09_margen_proxy.sql
docker exec -e HADOOP_HEAPSIZE=2048 -e LANG=C.UTF-8 hive-server hive -f /tmp/q09_margen_proxy.sql
Write-Host ''
Write-Host '---- SQL ejecutado ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\q09_margen_proxy.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
Write-Host ''
Write-Host '--- fin 19_q09_margen_proxy ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\19_q09_margen_proxy.done' -Value (Get-Date -Format o) -Encoding ASCII
