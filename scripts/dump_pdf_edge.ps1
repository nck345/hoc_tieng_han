$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///C:/Users/Nguyen%20Thao/Downloads/TOPIK%20(1).pdf"
$outFile = "pdf_out.txt"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--dump-dom",
    "--virtual-time-budget=5000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardOutput $outFile

$proc.WaitForExit(7000)

if (Test-Path $outFile) {
    $text = Get-Content -Raw -Encoding UTF8 $outFile
    Write-Host "Length: $($text.Length)"
    Write-Host $text.Substring(0, [Math]::Min(2000, $text.Length))
    Remove-Item $outFile -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "No output generated"
}
