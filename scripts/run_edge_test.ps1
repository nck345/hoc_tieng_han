$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/debug_p5_split.html"
$outFile = "temp_edge_output.txt"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--dump-dom",
    "--virtual-time-budget=10000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardOutput $outFile

$proc.WaitForExit(15000)
Start-Sleep -Seconds 1

if (Test-Path $outFile) {
    $raw = [System.IO.File]::ReadAllText($outFile, [System.Text.Encoding]::UTF8)
    if ($raw -match '<pre id="output">([\s\S]*?)</pre>') {
        Write-Host $matches[1]
    }
}
