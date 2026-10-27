$ErrorActionPreference = "Stop"
$captura = "F:\BIG_DATA\li17\scripts\captura.ps1"
$sql = "F:\BIG_DATA\li17\sql"

function Hive-Cmd([string]$file) {
    $leaf = Split-Path $file -Leaf
    @"
Write-Host 'hive -f /tmp/$leaf'
Write-Host '---- SQL ----'
Get-Content -LiteralPath '$file' | ForEach-Object { `$_.TrimEnd([char]13) } | Write-Host
docker cp '$file' 'hive-server:/tmp/$leaf'
docker exec hive-server sed -i 's/\r`$//' /tmp/$leaf
docker exec -e HADOOP_HEAPSIZE=2048 -e LANG=C.UTF-8 hive-server hive -f /tmp/$leaf
Write-Host ''
Write-Host '---- SQL ejecutado ----'
Get-Content -LiteralPath '$file' | ForEach-Object { `$_.TrimEnd([char]13) } | Write-Host
"@
}

$pasos = @(
    @{
        N = "01_docker_ps"
        C = "docker ps -a --format 'table {{.Names}}`t{{.Status}}`t{{.Image}}'"
    },
    @{
        N = "02_dataset_local"
        C = @"
Write-Host 'ZIP original (no se modifica):'
Get-Item 'C:\Users\pc\Downloads\data.csv.zip' | Format-List FullName, Length, LastWriteTime
Write-Host 'CSV extraido, copia de trabajo y CSV parcial previo:'
Get-Item 'F:\BIG_DATA\li17\fuente\data.csv','F:\BIG_DATA\li17\data_EduardoAntezana.csv','F:\BIG_DATA\data_EduardoAntezana.csv\data_EduardoAntezana.csv' | Format-Table FullName, Length -AutoSize
Write-Host 'Encabezado y primeras filas de la copia de trabajo:'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\data_EduardoAntezana.csv' -TotalCount 3 -Encoding UTF8
Write-Host ''
Write-Host 'Linea real con coma dentro de comillas:'
Select-String -LiteralPath 'F:\BIG_DATA\li17\data_EduardoAntezana.csv' -Pattern 'AIRLINE LOUNGE' -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { `$_.Line }
"@
    },
    @{
        N = "03_hdfs_li17"
        C = @"
docker exec namenode hdfs dfs -ls -h /li17/eduardoantezana
Write-Host ''
docker exec namenode bash -lc 'hdfs dfs -cat /li17/eduardoantezana/data_EduardoAntezana.csv | head -n 3'
Write-Host ''
Write-Host 'Warehouse de la practica anterior, conservado:'
docker exec namenode hdfs dfs -ls /user/hive/warehouse
"@
    },
    @{
        N = "04_show_databases"
        C = Hive-Cmd "$sql\06_create_database.sql"
    },
    @{
        N = "05_comas_vs_serde"
        C = Hive-Cmd "$sql\05_mostrar_prueba.sql"
    },
    @{
        N = "06_crear_y_cargar"
        C = Hive-Cmd "$sql\02_crear_y_cargar.sql"
    },
    @{
        N = "07_describe_formatted"
        C = Hive-Cmd "$sql\08_describe_stats.sql"
    },
    @{
        N = "08_conteo_y_diez_filas"
        C = Hive-Cmd "$sql\09_conteo_muestra.sql"
    },
    @{
        N = "09_conversion_fechas"
        C = Hive-Cmd "$sql\10_fechas.sql"
    },
    @{ N = "10_q01_ingreso_total"; C = Hive-Cmd "$sql\q01_ingreso_total.sql" },
    @{ N = "11_q02_top_productos"; C = Hive-Cmd "$sql\q02_top_productos.sql" },
    @{ N = "12_q03_clientes_pais"; C = Hive-Cmd "$sql\q03_clientes_pais.sql" },
    @{ N = "13_q04_ticket"; C = Hive-Cmd "$sql\q04_ticket.sql" },
    @{ N = "14_q05_evolucion_mensual"; C = Hive-Cmd "$sql\q05_evolucion_mensual.sql" },
    @{ N = "15_q06_devolucion"; C = Hive-Cmd "$sql\q06_devolucion.sql" },
    @{ N = "16_q07_hora"; C = Hive-Cmd "$sql\q07_hora.sql" },
    @{ N = "17_q08_estacionalidad"; C = Hive-Cmd "$sql\q08_estacionalidad.sql" },
    @{ N = "18_q08b_complemento"; C = Hive-Cmd "$sql\q08b_estacionalidad_complemento.sql" },
    @{ N = "19_q09_margen_proxy"; C = Hive-Cmd "$sql\q09_margen_proxy.sql" },
    @{ N = "20_q10_clientes_id"; C = Hive-Cmd "$sql\q10_clientes_id.sql" },
    @{ N = "21_q11_dia_semana"; C = Hive-Cmd "$sql\q11_dia_semana.sql" },
    @{ N = "22_q12_cancelacion_pais"; C = Hive-Cmd "$sql\q12_cancelacion_pais.sql" }
)

foreach ($p in $pasos) {
    Write-Host "CAPTURANDO $($p.N)"
    & $captura -Nombre $p.N -Comando $p.C
    if (-not (Test-Path "F:\BIG_DATA\li17\evidencias\$($p.N).png")) {
        throw "No se genero $($p.N).png"
    }
}
Write-Host "CAPTURAS LISTAS"
