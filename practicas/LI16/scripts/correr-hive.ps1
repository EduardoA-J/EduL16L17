param(
    [Parameter(Mandatory = $true)][string]$Nombre,
    [Parameter(Mandatory = $true)][string]$SqlFile
)
$remote = "/tmp/$Nombre.sql"
Write-Host "hive -f $remote"
Write-Host "---- SQL ----"
Get-Content -LiteralPath $SqlFile | ForEach-Object { $_.TrimEnd("`r") } | Write-Host
docker cp $SqlFile "hive-server:$remote"
docker exec hive-server sed -i 's/\r$//' $remote
if ($Nombre -eq "09_describe") {
    docker exec -e HADOOP_HEAPSIZE=2048 hive-server hive -f $remote | Where-Object { $_ -notmatch "COLUMN_STATS_ACCURATE" }
} else {
    docker exec -e HADOOP_HEAPSIZE=2048 hive-server hive -f $remote
}
Write-Host ""
Write-Host "---- SQL ejecutado ----"
Get-Content -LiteralPath $SqlFile | ForEach-Object { $_.TrimEnd("`r") } | Write-Host
