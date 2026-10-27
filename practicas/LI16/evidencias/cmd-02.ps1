Write-Host "docker exec namenode hdfs dfs -ls /user/hive/warehouse/"
docker exec namenode hdfs dfs -ls /user/hive/warehouse/
Write-Host "codigo_salida=$LASTEXITCODE"
Write-Host ""
Write-Host "docker exec namenode hdfs dfs -ls /"
docker exec namenode hdfs dfs -ls /
