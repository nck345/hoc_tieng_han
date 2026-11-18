$raw = Get-Content "js/exam_data.js" -Raw -Encoding UTF8
$rawClean = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';?\s*$', ''
$data = $rawClean | ConvertFrom-Json
$qs = $data.questions

Write-Host "=== Listening Question 5 across all 10 exams ==="
foreach ($ex in @("hot_01","hot_02","hot_03","hot_04","hot_05","tm_01","tm_02","tm_03","tm_04","tm_05")) {
    $q = $qs | Where-Object { $_.examId -eq $ex -and $_.questionNumber -eq 5 -and $_.section -eq "listening" } | Select-Object -First 1
    Write-Host "$ex [L-05]: $($q.options[0])"
}

Write-Host "`n=== Reading Question 10 across all 10 exams ==="
foreach ($ex in @("hot_01","hot_02","hot_03","hot_04","hot_05","tm_01","tm_02","tm_03","tm_04","tm_05")) {
    $q = $qs | Where-Object { $_.examId -eq $ex -and $_.questionNumber -eq 10 -and $_.section -eq "reading" } | Select-Object -First 1
    Write-Host "$ex [R-10]: $($q.options[0])"
}

Write-Host "`n=== Reading Question 25 across all 10 exams ==="
foreach ($ex in @("hot_01","hot_02","hot_03","hot_04","hot_05","tm_01","tm_02","tm_03","tm_04","tm_05")) {
    $q = $qs | Where-Object { $_.examId -eq $ex -and $_.questionNumber -eq 25 -and $_.section -eq "reading" } | Select-Object -First 1
    Write-Host "$ex [R-25]: $($q.options[0])"
}
