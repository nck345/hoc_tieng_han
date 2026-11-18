$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

# Unicode string for "선택지" (dummy keyword)
$dummyKeyword = [char]0xC120 + [char]0xD0DD + [char]0xC9C0

$examsToBuild = @('hot01', 'hot02', 'hot03', 'hot04', 'tm03', 'tm04', 'tm05')

Write-Host "=========================================================="
Write-Host "GENERATING 7 MASTER JSONs: $($examsToBuild -join ', ')"
Write-Host "=========================================================="

foreach ($exam in $examsToBuild) {
    Write-Host "`n---> Building $exam ..."
    $url = "file:///" + (Resolve-Path "scripts/build_authentic_exam.html").Path.Replace('\', '/') + "?exam=$exam"
    $outFile = "$((Resolve-Path .).Path)\temp_edge_output.txt"
    if (Test-Path $outFile) { Remove-Item $outFile -Force }
    
    $proc = Start-Process -FilePath $edgePath -ArgumentList @(
        "--headless=new",
        "--disable-gpu",
        "--allow-file-access-from-files",
        "--dump-dom",
        "--virtual-time-budget=12000",
        "`"$url`""
    ) -PassThru -NoNewWindow -RedirectStandardOutput $outFile
    
    $proc.WaitForExit(25000)
    Start-Sleep -Seconds 1
    
    if (-not (Test-Path $outFile)) {
        Write-Error "Output file not found for $exam!"
        continue
    }
    
    $raw = [System.IO.File]::ReadAllText($outFile, [System.Text.Encoding]::UTF8)
    if ($raw -match 'JSON_START([\s\S]*?)JSON_END') {
        $jsonStr = $matches[1].Trim()
        $data = ConvertFrom-Json $jsonStr
        
        $lCount = $data.listening.Count
        $rCount = $data.reading.Count
        $totalCount = $lCount + $rCount
        
        $lDummies = 0
        foreach ($q in $data.listening) {
            foreach ($opt in $q.options) {
                if ($opt -match $dummyKeyword) { $lDummies++; break }
            }
        }
        $rDummies = 0
        foreach ($q in $data.reading) {
            foreach ($opt in $q.options) {
                if ($opt -match $dummyKeyword) { $rDummies++; break }
            }
        }
        $totalDummies = $lDummies + $rDummies
        
        Write-Host "  Success: Total=$totalCount (L=$lCount, R=$rCount), Dummies=$totalDummies"
        
        if ($totalCount -eq 100 -and $totalDummies -eq 0) {
            $destPath = "scripts/${exam}_master_questions.json"
            [System.IO.File]::WriteAllText($destPath, $jsonStr, [System.Text.Encoding]::UTF8)
            Write-Host "  Saved master JSON to $destPath"
        } else {
            Write-Error "Validation failed for $exam! (Count=$totalCount, Dummies=$totalDummies)"
        }
    } else {
        Write-Error "Could not find JSON_START/JSON_END in Edge output for $exam!"
    }
}

Write-Host "`n=========================================================="
Write-Host "FINAL AUDIT OF ALL 10 MASTER QUESTION JSON FILES"
Write-Host "=========================================================="

$all10 = @('hot01', 'hot02', 'hot03', 'hot04', 'hot05', 'tm01', 'tm02', 'tm03', 'tm04', 'tm05')

$results = @()
$grandTotalQuestions = 0
$grandTotalDummies = 0
$grandTotalAudioMissing = 0

foreach ($ex in $all10) {
    $path = "scripts/${ex}_master_questions.json"
    if (-not (Test-Path $path)) {
        $results += [PSCustomObject]@{
            Exam = $ex
            Status = "MISSING"
            Total = 0
            Listening = 0
            Reading = 0
            Dummies = -1
            AudioOk = "N/A"
        }
        continue
    }
    
    $json = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
    $obj = ConvertFrom-Json $json
    $lCount = $obj.listening.Count
    $rCount = $obj.reading.Count
    $total = $lCount + $rCount
    
    $dummies = 0
    foreach ($q in $obj.listening) {
        foreach ($opt in $q.options) {
            if ($opt -match $dummyKeyword) { $dummies++; break }
        }
    }
    foreach ($q in $obj.reading) {
        foreach ($opt in $q.options) {
            if ($opt -match $dummyKeyword) { $dummies++; break }
        }
    }
    
    $missingAudio = 0
    foreach ($q in $obj.listening) {
        if (-not (Test-Path $q.audioUrl)) { $missingAudio++ }
    }
    
    $grandTotalQuestions += $total
    $grandTotalDummies += $dummies
    $grandTotalAudioMissing += $missingAudio
    
    $results += [PSCustomObject]@{
        Exam = $ex
        Status = "OK"
        Total = $total
        Listening = $lCount
        Reading = $rCount
        Dummies = $dummies
        AudioOk = if ($missingAudio -eq 0) { "50/50" } else { "MISSING $missingAudio" }
    }
}

$results | Format-Table -AutoSize
Write-Host "`nGrand Total Questions: $grandTotalQuestions / 1000"
Write-Host "Grand Total Dummies:   $grandTotalDummies"
Write-Host "Total Missing Audio:   $grandTotalAudioMissing"
