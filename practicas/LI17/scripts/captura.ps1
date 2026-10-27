param(
    [Parameter(Mandatory = $true)][string]$Nombre,
    [Parameter(Mandatory = $true)][string]$Comando,
    [int]$Ancho = 1680,
    [int]$Alto = 900
)

$ErrorActionPreference = "Stop"
$evidencias = "F:\BIG_DATA\li17\evidencias"
New-Item -ItemType Directory -Force -Path $evidencias | Out-Null

$marker = Join-Path $evidencias "$Nombre.done"
$png = Join-Path $evidencias "$Nombre.png"
if (Test-Path $marker) { Remove-Item $marker -Force }
if (Test-Path $png) { Remove-Item $png -Force }

$runner = Join-Path $evidencias "$Nombre.runner.ps1"
$runnerBody = @"
`$Host.UI.RawUI.WindowTitle = 'LI17 $Nombre'
try {
  `$size = `$Host.UI.RawUI.BufferSize
  `$size.Width = 180
  `$size.Height = 30000
  `$Host.UI.RawUI.BufferSize = `$size
} catch {}
try { chcp 65001 | Out-Null } catch {}
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
`$OutputEncoding = [System.Text.Encoding]::UTF8
`$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI17 - $Nombre'
Write-Host ('Equipo: ' + `$env:COMPUTERNAME + '    ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
Write-Host ''
$Comando
Write-Host ''
Write-Host '--- fin $Nombre ---'
Set-Content -Path '$marker' -Value (Get-Date -Format o) -Encoding ASCII
"@
Set-Content -Path $runner -Value $runnerBody -Encoding UTF8

$proc = Start-Process -FilePath "powershell.exe" -ArgumentList @(
    "-NoExit", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $runner
) -PassThru

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Li17Win {
  [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

$deadline = (Get-Date).AddMinutes(3)
$hwnd = [IntPtr]::Zero
while ((Get-Date) -lt $deadline -and $hwnd -eq [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 400
    $proc.Refresh()
    if ($proc.MainWindowHandle -ne [IntPtr]::Zero) { $hwnd = $proc.MainWindowHandle }
}
if ($hwnd -eq [IntPtr]::Zero) { throw "No aparecio la ventana de evidencia $Nombre" }
[void][Li17Win]::ShowWindow($hwnd, 9)
[void][Li17Win]::MoveWindow($hwnd, 20, 20, $Ancho, $Alto, $true)
[void][Li17Win]::SetForegroundWindow($hwnd)

$deadline = (Get-Date).AddMinutes(25)
while ((Get-Date) -lt $deadline -and -not (Test-Path $marker)) {
    Start-Sleep -Milliseconds 500
}
if (-not (Test-Path $marker)) { throw "La evidencia $Nombre no termino a tiempo" }

Start-Sleep -Milliseconds 900
[void][Li17Win]::ShowWindow($hwnd, 9)
[void][Li17Win]::MoveWindow($hwnd, 20, 20, $Ancho, $Alto, $true)
[void][Li17Win]::SetForegroundWindow($hwnd)
Start-Sleep -Milliseconds 700

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
$bmp.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

Get-Process -Id $proc.Id -ErrorAction SilentlyContinue | Stop-Process -Force
Write-Output "CAPTURA=$png"
