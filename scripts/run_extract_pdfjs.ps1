$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/extract_with_pdfjs.html"
$errLog = "edge_pdf_err.log"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--enable-logging=stderr",
    "--v=1",
    "--virtual-time-budget=20000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardError $errLog

$proc.WaitForExit(20000)
Start-Sleep -Milliseconds 600

$errs = Get-Content -Raw -Encoding UTF8 $errLog
Write-Host "=== PDF EXTRACT OUTPUT ==="
$lines = $errs -split "`r?`n"
foreach ($line in $lines) {
    if ($line -match "PDF_PAGES" -or $line -match "PAGE_" -or $line -match "EXTRACT_ERROR" -or $line -match "FETCHED") {
        Write-Host $line
    }
}
Remove-Item $errLog -Force -ErrorAction SilentlyContinue
