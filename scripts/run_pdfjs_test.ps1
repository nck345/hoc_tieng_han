$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/test_pdfjs.html"
$errLog = "edge_pdfjs_err.log"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--enable-logging=stderr",
    "--v=1",
    "--virtual-time-budget=6000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardError $errLog

$proc.WaitForExit(8000)
Start-Sleep -Milliseconds 500

$errs = Get-Content -Raw -Encoding UTF8 $errLog
Write-Host $errs
Remove-Item $errLog -Force -ErrorAction SilentlyContinue
