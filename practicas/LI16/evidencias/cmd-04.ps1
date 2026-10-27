$csv = "F:\BIG_DATA\li16\pseudo_facebook_EduardoAntezana.csv"
Write-Host "El directorio /user/hive/warehouse no existia. Se crea para poder subir el CSV."
Write-Host "docker exec namenode hdfs dfs -mkdir -p /user/hive/warehouse"
docker exec namenode hdfs dfs -mkdir -p /user/hive/warehouse
Write-Host ""
Write-Host "docker cp pseudo_facebook_EduardoAntezana.csv namenode:/tmp/"
docker cp $csv namenode:/tmp/pseudo_facebook_EduardoAntezana.csv
Write-Host "codigo_cp=$LASTEXITCODE"
Write-Host ""
Write-Host "ls -l /tmp/pseudo_facebook_EduardoAntezana.csv   (dentro del namenode)"
docker exec namenode ls -l /tmp/pseudo_facebook_EduardoAntezana.csv
Write-Host ""
Write-Host "hdfs dfs -put /tmp/pseudo_facebook_EduardoAntezana.csv /user/hive/warehouse/"
docker exec namenode hdfs dfs -put /tmp/pseudo_facebook_EduardoAntezana.csv /user/hive/warehouse/
Write-Host "codigo_put=$LASTEXITCODE"
Write-Host ""
Write-Host "hdfs dfs -ls /user/hive/warehouse/"
docker exec namenode hdfs dfs -ls /user/hive/warehouse/
