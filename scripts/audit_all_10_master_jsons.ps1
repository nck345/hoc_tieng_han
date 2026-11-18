$files = @(
  'tm01_master_questions.json', 'tm02_master_questions.json', 'tm03_master_questions.json', 'tm04_master_questions.json', 'tm05_master_questions.json',
  'hot01_master_questions.json', 'hot02_master_questions.json', 'hot03_master_questions.json', 'hot04_master_questions.json', 'hot05_master_questions.json'
)

$errors = @()
$samples = @{}

foreach ($f in $files) {
    $path = Join-Path 'scripts' $f
    $json = Get-Content -Raw -Encoding UTF8 $path | ConvertFrom-Json
    
    # Store first reading passage to check distinctness
    $samples[$f] = $json.reading[0].passage + " | " + ($json.reading[0].options -join " | ")

    # Check listening
    if ($json.listening.Count -ne 50) {
        $errors += "$f listening count is $($json.listening.Count)"
    }
    for ($i = 0; $i -lt $json.listening.Count; $i++) {
        $q = $json.listening[$i]
        $qNum = $i + 1
        if ($q.questionNumber -ne $qNum) {
            $errors += "$f L$qNum has questionNumber $($q.questionNumber)"
        }
        if (-not $q.audioUrl) {
            $errors += "$f L$qNum missing audioUrl"
        } else {
            # Normalize path
            $audioOnDisk = $q.audioUrl.Replace('/', '\')
            if (-not (Test-Path $audioOnDisk)) {
                $errors += "$f L$qNum audioUrl not found on disk: $($q.audioUrl)"
            }
        }
        if (-not $q.options -or $q.options.Count -ne 4) {
            $errors += "$f L$qNum options count is $($q.options.Count)"
        } else {
            for ($optIdx = 0; $optIdx -lt 4; $optIdx++) {
                if ([string]::IsNullOrWhiteSpace($q.options[$optIdx])) {
                    $errors += "$f L$qNum option $optIdx is empty"
                }
            }
        }
        if ($q.correctAnswer -lt 1 -or $q.correctAnswer -gt 4) {
            $errors += "$f L$qNum invalid correctAnswer $($q.correctAnswer)"
        }
    }

    # Check reading
    if ($json.reading.Count -ne 50) {
        $errors += "$f reading count is $($json.reading.Count)"
    }
    for ($i = 0; $i -lt $json.reading.Count; $i++) {
        $q = $json.reading[$i]
        $qNum = $i + 1
        if ($q.questionNumber -ne $qNum) {
            $errors += "$f R$qNum has questionNumber $($q.questionNumber)"
        }
        if (-not $q.options -or $q.options.Count -ne 4) {
            $errors += "$f R$qNum options count is $($q.options.Count)"
        } else {
            for ($optIdx = 0; $optIdx -lt 4; $optIdx++) {
                if ([string]::IsNullOrWhiteSpace($q.options[$optIdx])) {
                    $errors += "$f R$qNum option $optIdx is empty"
                }
            }
        }
        if ($q.correctAnswer -lt 1 -or $q.correctAnswer -gt 4) {
            $errors += "$f R$qNum invalid correctAnswer $($q.correctAnswer)"
        }
    }
}

Write-Host "=== ERROR REPORT ==="
if ($errors.Count -eq 0) {
    Write-Host "SUCCESS: All 10 exams passed all checks (1000 questions, 500 audios verified)!" -ForegroundColor Green
} else {
    Write-Host "Found $($errors.Count) errors:" -ForegroundColor Red
    $errors | Select-Object -First 30 | ForEach-Object { Write-Host " - $_" -ForegroundColor Yellow }
}

Write-Host "`n=== DISTINCT SAMPLES (Q1 Reading) ==="
foreach ($key in $samples.Keys) {
    Write-Host ("[$key]: " + $samples[$key].Substring(0, [Math]::Min(120, $samples[$key].Length)))
}
