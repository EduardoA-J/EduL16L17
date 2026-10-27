$ErrorActionPreference = "Stop"
$captura = "F:\BIG_DATA\li16\scripts\captura.ps1"
$pasos = @(
    @{ Nombre = "06_docker_ps_hive"; Comando = "& 'F:\BIG_DATA\li16\evidencias\cmd-06.ps1'" },
    @{ Nombre = "07_create_database"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '07_create_db' -SqlFile 'F:\BIG_DATA\li16\sql\07_create_db.sql'" },
    @{ Nombre = "08_create_table"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '08_create_table' -SqlFile 'F:\BIG_DATA\li16\sql\08_create_table.sql'" },
    @{ Nombre = "09_describe_formatted"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '09_describe' -SqlFile 'F:\BIG_DATA\li16\sql\09_describe.sql'" },
    @{ Nombre = "10_load_y_limit"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '10_load' -SqlFile 'F:\BIG_DATA\li16\sql\10_load.sql'" },
    @{ Nombre = "11_total_usuarios"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '11_total' -SqlFile 'F:\BIG_DATA\li16\sql\11_total.sql'" },
    @{ Nombre = "12_mayores_25"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '12_mayores_25' -SqlFile 'F:\BIG_DATA\li16\sql\12_mayores_25.sql'" },
    @{ Nombre = "13_amigos_genero"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '13_amigos_genero' -SqlFile 'F:\BIG_DATA\li16\sql\13_amigos_genero.sql'" },
    @{ Nombre = "14_likes_edad"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '14_likes_edad' -SqlFile 'F:\BIG_DATA\li16\sql\14_likes_edad.sql'" },
    @{ Nombre = "15_mes_cumpleanos"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '15_mes' -SqlFile 'F:\BIG_DATA\li16\sql\15_mes.sql'" },
    @{ Nombre = "16_jovenes_dispositivo"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '16_jovenes_dispositivo' -SqlFile 'F:\BIG_DATA\li16\sql\16_jovenes_dispositivo.sql'" },
    @{ Nombre = "17_adultos_dispositivo"; Comando = "& 'F:\BIG_DATA\li16\scripts\correr-hive.ps1' -Nombre '17_adultos_dispositivo' -SqlFile 'F:\BIG_DATA\li16\sql\17_adultos_dispositivo.sql'" }
)
foreach ($p in $pasos) {
    Write-Host "CAPTURANDO $($p.Nombre)"
    & $captura -Nombre $p.Nombre -Comando $p.Comando
}
Write-Host "TODAS_LAS_CAPTURAS_LISTAS"
