$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$exams = @('hot01', 'hot02', 'hot03', 'hot04', 'tm03', 'tm04', 'tm05')

foreach ($ex in $exams) {
    Write-Host "=== Generating $ex master JSON via Edge headless ==="
    $url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/build_exam_json.html?exam=" + $ex
    $tempDump = "temp_dump_$ex.txt"
    
    if (Test-Path $tempDump) {
        Remove-Item $tempDump -Force -ErrorAction SilentlyContinue
    }
    
    $proc = Start-Process -FilePath $edgePath -ArgumentList @(
        "--headless=new",
        "--disable-gpu",
        "--allow-file-access-from-files",
        "--dump-dom",
        "--virtual-time-budget=15000",
        "`"$url`""
    ) -PassThru -NoNewWindow -RedirectStandardOutput $tempDump
    
    $proc.WaitForExit(20000)
    Start-Sleep -Milliseconds 600
    
    if (Test-Path $tempDump) {
        $raw = [System.IO.File]::ReadAllText($tempDump, [System.Text.Encoding]::UTF8)
        if ($raw -match '<pre id="output">([\s\S]*?)</pre>') {
            $jsonStr = $matches[1].Trim()
            if ($jsonStr.StartsWith('{') -and $jsonStr.EndsWith('}')) {
                # Clean HTML entities
                $jsonStr = $jsonStr.Replace('&lt;', '<').Replace('&gt;', '>').Replace('&amp;', '&').Replace('&quot;', '"')
                $targetFile = "scripts/${ex}_master_questions.json"
                [System.IO.File]::WriteAllText($targetFile, $jsonStr, [System.Text.Encoding]::UTF8)
                
                # Check question counts
                $obj = $jsonStr | ConvertFrom-Json
                Write-Host "SUCCESS: Saved $targetFile (L=$($obj.listening.Count), R=$($obj.reading.Count))"
            } else {
                Write-Host "ERROR: Output not JSON: $($jsonStr.Substring(0, [Math]::Min(200, $jsonStr.Length)))"
            }
        } else {
            Write-Host "ERROR: Could not find pre#output in $tempDump"
        }
        Remove-Item $tempDump -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "ERROR: $tempDump not generated"
    }
}
Write-Host "ALL EXAM JSON GENERATION COMPLETE!"
