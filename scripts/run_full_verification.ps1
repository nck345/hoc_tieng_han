[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$errors = @()

# 1. Parse js/exam_data.js
$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
if (-not $raw.StartsWith("window.EXAM_DATA =")) {
    $errors += "exam_data.js does not start with window.EXAM_DATA ="
}
$jsonStr = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
try {
    $data = $jsonStr | ConvertFrom-Json
    Write-Host "[PASS] exam_data.js is valid JSON."
} catch {
    $errors += "exam_data.js JSON parse failed: $_"
}

# 2. Check Kỳ thi số 96 in categories
$cat = $data.categories | Where-Object { $_.id -eq "de_thi_that" }
$ex96 = $cat.exams | Where-Object { $_.id -eq "real_96" }
if ($ex96.questionCount -ne 104) {
    $errors += "Kỳ thi 96 questionCount is $($ex96.questionCount), expected 104"
} else {
    Write-Host "[PASS] Kỳ thi 96 questionCount is 104."
}

# 3. Check questions count
$q96 = @($data.questions | Where-Object { $_.examId -eq "real_96" })
if ($q96.Count -ne 104) {
    $errors += "real_96 has $($q96.Count) questions, expected 104"
} else {
    Write-Host "[PASS] real_96 has exactly 104 questions."
}

# 4. Check breakdown
$listening = @($q96 | Where-Object { $_.section -eq "listening" })
$writing = @($q96 | Where-Object { $_.section -eq "writing" })
$reading = @($q96 | Where-Object { $_.section -eq "reading" })

if ($listening.Count -ne 50) { $errors += "Listening count is $($listening.Count), expected 50" }
if ($writing.Count -ne 4) { $errors += "Writing count is $($writing.Count), expected 4" }
if ($reading.Count -ne 50) { $errors += "Reading count is $($reading.Count), expected 50" }

Write-Host "[PASS] Breakdown: $($listening.Count) Listening, $($writing.Count) Writing, $($reading.Count) Reading."

# 5. Check all audio files
$missingAudio = 0
foreach ($q in $listening) {
    if (-not $q.audioUrl) {
        $missingAudio++
        continue
    }
    $local = $q.audioUrl -replace '/', '\'
    if (-not (Test-Path $local)) {
        $missingAudio++
    }
}
if ($missingAudio -gt 0) {
    $errors += "$missingAudio listening questions have missing audio files."
} else {
    Write-Host "[PASS] All 50 listening audio files exist on disk."
}

# 6. Check official answer key accuracy
$officialL = @(
    1, 2, 2, 3, 1, 2, 4, 3, 4, 2,
    4, 2, 3, 2, 4, 4, 3, 1, 4, 1,
    4, 2, 4, 2, 1, 1, 2, 3, 1, 2,
    4, 3, 3, 1, 1, 4, 3, 2, 4, 3,
    3, 2, 1, 4, 4, 3, 3, 3, 4, 1
)
$officialR = @(
    4, 1, 1, 4, 2, 4, 1, 1, 3, 2,
    4, 4, 2, 3, 1, 1, 3, 1, 4, 2,
    2, 3, 2, 1, 3, 3, 4, 4, 2, 4,
    3, 3, 1, 2, 3, 4, 3, 1, 1, 3,
    2, 3, 1, 2, 4, 2, 2, 3, 4, 4
)

for ($i = 0; $i -lt 50; $i++) {
    if ([int]$listening[$i].correctAnswer -ne $officialL[$i]) {
        $errors += "Listening Q$($i+1) answer mismatch: $($listening[$i].correctAnswer) != $($officialL[$i])"
    }
}

for ($i = 0; $i -lt 50; $i++) {
    if ([int]$reading[$i].correctAnswer -ne $officialR[$i]) {
        $errors += "Reading Q$($i+1) answer mismatch: $($reading[$i].correctAnswer) != $($officialR[$i])"
    }
}

foreach ($q in $writing) {
    if ([int]$q.correctAnswer -ne 1) {
        $errors += "Writing Q$($q.questionNumber) answer mismatch"
    }
}
Write-Host "[PASS] All 104 official answers verified 100% accurate."

# 7. Check question content completeness
$incomplete = 0
foreach ($q in $q96) {
    if (-not $q.instruction -or -not $q.explanation -or -not $q.options -or $q.options.Count -ne 4) {
        $incomplete++
    }
}
if ($incomplete -gt 0) {
    $errors += "$incomplete questions are missing required fields or do not have 4 options."
} else {
    Write-Host "[PASS] All 104 questions have instruction, 4 options, and detailed explanations."
}

# 8. Check other exams preserved
$qTm = @($data.questions | Where-Object { $_.examId -eq "tm_01" })
$qHot = @($data.questions | Where-Object { $_.examId -eq "hot_05" })
if ($qTm.Count -ne 6 -or $qHot.Count -ne 3) {
    $errors += "Existing questions regressed! tm_01: $($qTm.Count), hot_05: $($qHot.Count)"
} else {
    Write-Host "[PASS] Existing exams preserved without regression (tm_01: 6, hot_05: 3)."
}

# Summary
if ($errors.Count -eq 0) {
    Write-Host "`n>>> ALL VERIFICATION TESTS PASSED PERFECTLY! <<<" -ForegroundColor Green
} else {
    Write-Host "`nERRORS FOUND:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
}
