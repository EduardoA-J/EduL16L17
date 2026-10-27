$Host.UI.RawUI.WindowTitle = 'LI17 12_q03_clientes_pais'
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
Write-Host 'LI17 - 12_q03_clientes_pais'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
Write-Host 'hive -f /tmp/q03_clientes_pais.sql'
Write-Host '---- SQL ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\q03_clientes_pais.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
docker cp 'F:\BIG_DATA\li17\sql\q03_clientes_pais.sql' 'hive-server:/tmp/q03_clientes_pais.sql'
docker exec hive-server sed -i 's/\r$//' /tmp/q03_clientes_pais.sql
docker exec -e HADOOP_HEAPSIZE=2048 -e LANG=C.UTF-8 hive-server hive -f /tmp/q03_clientes_pais.sql
Write-Host ''
Write-Host '---- SQL ejecutado ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\q03_clientes_pais.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
Write-Host ''
Write-Host '--- fin 12_q03_clientes_pais ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\12_q03_clientes_pais.done' -Value (Get-Date -Format o) -Encoding ASCII
