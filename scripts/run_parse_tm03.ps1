$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/parse_tm03_full.html"
$outFile = "temp_dump_tm03_json.txt"

Write-Host "Parsing TM03 via Edge headless..."
$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--dump-dom",
    "--virtual-time-budget=20000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardOutput $outFile

$proc.WaitForExit(25000)

if (Test-Path $outFile) {
    $raw = [System.IO.File]::ReadAllText($outFile, [System.Text.Encoding]::UTF8)
    if ($raw -match '<pre id="output">([\s\S]*?)</pre>') {
        $json = $matches[1]
        $json = $json.Replace('&lt;', '<').Replace('&gt;', '>').Replace('&amp;', '&').Replace('&quot;', '"')
        [System.IO.File]::WriteAllText("scripts/tm03_master_questions.json", $json, [System.Text.Encoding]::UTF8)
        Write-Host "Success! Saved scripts/tm03_master_questions.json ($($json.Length) chars)"
    } else {
        Write-Host "Could not find pre#output"
    }
    Remove-Item $outFile -Force -ErrorAction SilentlyContinue
}
