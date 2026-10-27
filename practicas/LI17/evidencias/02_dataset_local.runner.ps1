$Host.UI.RawUI.WindowTitle = 'LI17 02_dataset_local'
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
Write-Host 'LI17 - 02_dataset_local'
Write-Host ('Equipo: ' + $env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
Write-Host 'ZIP original (no se modifica):'
Get-Item 'C:\Users\pc\Downloads\data.csv.zip' | Format-List FullName, Length, LastWriteTime
Write-Host 'CSV extraido, copia de trabajo y CSV parcial previo:'
Get-Item 'F:\BIG_DATA\li17\fuente\data.csv','F:\BIG_DATA\li17\data_EduardoAntezana.csv','F:\BIG_DATA\data_EduardoAntezana.csv\data_EduardoAntezana.csv' | Format-Table FullName, Length -AutoSize
Write-Host 'Encabezado y primeras filas de la copia de trabajo:'
Get-Content -LiteralPath 'F:\BIG_DATA\li17\data_EduardoAntezana.csv' -TotalCount 3 -Encoding UTF8
Write-Host ''
Write-Host 'Linea real con coma dentro de comillas:'
Select-String -LiteralPath 'F:\BIG_DATA\li17\data_EduardoAntezana.csv' -Pattern 'AIRLINE LOUNGE' -Encoding UTF8 | Select-Object -First 1 | ForEach-Object { $_.Line }
Write-Host ''
Write-Host '--- fin 02_dataset_local ---'
Set-Content -Path 'F:\BIG_DATA\li17\evidencias\02_dataset_local.done' -Value (Get-Date -Format o) -Encoding ASCII
