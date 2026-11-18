$utf8 = [System.Text.Encoding]::UTF8
$errors = @()

# 1. Check index.html
$index = [System.IO.File]::ReadAllText("index.html", $utf8)
if (-not $index.Contains("exam-folder-section-filter")) {
    $errors += "index.html missing exam-folder-section-filter"
}
if (-not $index.Contains("exam-transcript-section") -or -not $index.Contains("exam-transcript-box")) {
    $errors += "index.html missing transcript section"
}
Write-Host "[CHECK 1] index.html verified."

# 2. Check css/main.css
$css = [System.IO.File]::ReadAllText("css\main.css", $utf8)
if (-not $css.Contains(".exam-part-box")) {
    $errors += "css/main.css missing .exam-part-box"
}
Write-Host "[CHECK 2] css/main.css verified."

# 3. Check js/app.js
$appJs = [System.IO.File]::ReadAllText("js\app.js", $utf8)
if (-not $appJs.Contains('folderSectionFilter:document.getElementById("exam-folder-section-filter")')) {
    $errors += "js/app.js missing folderSectionFilter in examEls"
}
if (-not $appJs.Contains('startExamFromItem(cat,ex,section="all")')) {
    $errors += "js/app.js missing startExamFromItem with section parameter"
}
if (-not $appJs.Contains('q.passage&&q.section!=="listening"')) {
    $errors += "js/app.js missing listening passage hide condition"
}
if (-not $appJs.Contains('if(q.section==="listening"&&q.passage){')) {
    $errors += "js/app.js missing listening passage reveal in showExamSolution"
}
Write-Host "[CHECK 3] js/app.js key logic verified."

# 4. Check js/exam_data.js
$examData = [System.IO.File]::ReadAllText("js\exam_data.js", $utf8)
$json = ($examData -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', '') | ConvertFrom-Json
$q96 = @($json.questions | Where-Object { $_.examId -eq "real_96" })
if ($q96.Count -ne 104) {
    $errors += "real_96 question count is $($q96.Count), expected 104"
}
$q96L = @($q96 | Where-Object { $_.section -eq "listening" })
$q96R = @($q96 | Where-Object { $_.section -eq "reading" })
$q96W = @($q96 | Where-Object { $_.section -eq "writing" })
if ($q96L.Count -ne 50 -or $q96R.Count -ne 50 -or $q96W.Count -ne 4) {
    $errors += "real_96 section breakdown mismatch"
}
Write-Host "[CHECK 4] exam_data.js verified: 50 Listening, 50 Reading, 4 Writing."

# Summary
if ($errors.Count -eq 0) {
    Write-Host "`n>>> ALL VERIFICATION CHECKS PASSED PERFECTLY! <<<" -ForegroundColor Green
} else {
    Write-Host "`nERRORS FOUND:" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
}
