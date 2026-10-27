$Host.UI.RawUI.WindowTitle = 'LI17 04_show_databases'
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
Write-Host 'LI17 - 04_show_databases'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
Write-Host 'hive -f /tmp/06_create_database.sql'
Write-Host '---- SQL ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\06_create_database.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
docker cp 'F:\BIG_DATA\li17\sql\06_create_database.sql' 'hive-server:/tmp/06_create_database.sql'
docker exec hive-server sed -i 's/\r$//' /tmp/06_create_database.sql
docker exec -e HADOOP_HEAPSIZE=2048 -e LANG=C.UTF-8 hive-server hive -f /tmp/06_create_database.sql
Write-Host ''
Write-Host '---- SQL ejecutado ----'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\sql\06_create_database.sql' | ForEach-Object { $_.TrimEnd([char]13) } | Write-Host
Write-Host ''
Write-Host '--- fin 04_show_databases ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\04_show_databases.done' -Value (Get-Date -Format o) -Encoding ASCII
