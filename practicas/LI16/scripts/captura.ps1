param(
    [Parameter(Mandatory = $true)][string]$Nombre,
    [Parameter(Mandatory = $true)][string]$Comando,
    [int]$Ancho = 1340,
    [int]$Alto = 680
)

$ErrorActionPreference = "Stop"
$evidencias = "F:\BIG_DATA\li16\evidencias"
New-Item -ItemType Directory -Force -Path $evidencias | Out-Null

$marker = Join-Path $evidencias "$Nombre.done"
$log = Join-Path $evidencias "$Nombre.log"
$png = Join-Path $evidencias "$Nombre.png"
if (Test-Path $marker) { Remove-Item $marker -Force }
if (Test-Path $png) { Remove-Item $png -Force }

$runner = Join-Path $evidencias "$Nombre.runner.ps1"
$runnerBody = @"
`$Host.UI.RawUI.WindowTitle = 'LI16 $Nombre'
try {
  `$size = `$Host.UI.RawUI.BufferSize
  `$size.Width = 160
  `$size.Height = 4000
  `$Host.UI.RawUI.BufferSize = `$size
} catch {}
`$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
Clear-Host
Write-Host 'LI16 - $Nombre'
Write-Host ('Equipo: ' + `$env:COMPUTERNAME)
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
public class Li16Win {
  [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

$deadline = (Get-Date).AddMinutes(8)
$hwnd = [IntPtr]::Zero
while ((Get-Date) -lt $deadline -and $hwnd -eq [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 400
    $proc.Refresh()
    if ($proc.MainWindowHandle -ne [IntPtr]::Zero) { $hwnd = $proc.MainWindowHandle }
}
if ($hwnd -eq [IntPtr]::Zero) { throw "No aparecio la ventana de evidencia $Nombre" }
[void][Li16Win]::ShowWindow($hwnd, 9)
[void][Li16Win]::MoveWindow($hwnd, 0, 0, $Ancho, $Alto, $true)
[void][Li16Win]::SetForegroundWindow($hwnd)

$deadline = (Get-Date).AddMinutes(20)
while ((Get-Date) -lt $deadline -and -not (Test-Path $marker)) {
    Start-Sleep -Milliseconds 500
}
if (-not (Test-Path $marker)) { throw "La evidencia $Nombre no termino a tiempo" }

Start-Sleep -Milliseconds 800
[void][Li16Win]::ShowWindow($hwnd, 9)
[void][Li16Win]::MoveWindow($hwnd, 0, 0, $Ancho, $Alto, $true)
[void][Li16Win]::SetForegroundWindow($hwnd)
Start-Sleep -Milliseconds 600

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
