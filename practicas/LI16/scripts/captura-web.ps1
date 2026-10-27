param(
    [Parameter(Mandatory = $true)][string]$Nombre,
    [Parameter(Mandatory = $true)][string]$Url
)

$ErrorActionPreference = "Stop"
$evidencias = "F:\BIG_DATA\li16\evidencias"
New-Item -ItemType Directory -Force -Path $evidencias | Out-Null
$png = Join-Path $evidencias "$Nombre.png"

$edge = Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path -LiteralPath $edge)) {
    $edge = Join-Path $env:ProgramFiles "Microsoft\Edge\Application\msedge.exe"
}
if (-not (Test-Path -LiteralPath $edge)) {
    $edge = "$env:LOCALAPPDATA\Microsoft\Edge\Application\msedge.exe"
}
if (-not (Test-Path -LiteralPath $edge)) { throw "No encontre Microsoft Edge" }

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Li16Web {
  [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@

$before = @(Get-Process msedge -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Id)
Start-Process -FilePath $edge -ArgumentList @("--new-window", "--window-position=0,0", "--window-size=1320,640", $Url)
$hwnd = [IntPtr]::Zero
$deadline = (Get-Date).AddSeconds(25)
$procId = $null
while ((Get-Date) -lt $deadline -and $hwnd -eq [IntPtr]::Zero) {
    Start-Sleep -Milliseconds 500
    $nuevo = Get-Process msedge -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne [IntPtr]::Zero -and ($before -notcontains $_.Id) }
    foreach ($p in $nuevo) {
        $hwnd = $p.MainWindowHandle
        $procId = $p.Id
        break
    }
}
if ($hwnd -eq [IntPtr]::Zero) { throw "No aparecio la ventana de Edge para $Url" }
[void][Li16Web]::ShowWindow($hwnd, 9)
[void][Li16Web]::MoveWindow($hwnd, 0, 0, 1340, 680, $true)
[void][Li16Web]::SetForegroundWindow($hwnd)
Start-Sleep -Seconds 6
[void][Li16Web]::SetForegroundWindow($hwnd)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
$bmp.Save($png, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

if ($procId) {
    Stop-Process -Id $procId -Force -ErrorAction SilentlyContinue
}
Write-Output "CAPTURA=$png"
