[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

$cat = $data.categories | Where-Object { $_.id -eq "de_thi_that" }
Write-Host "Category: $($cat.titleVi)"
$ex96 = $cat.exams | Where-Object { $_.id -eq "real_96" }
Write-Host "Exam 96 info:"
$ex96 | ConvertTo-Json

$existingQs = ($data.questions | Where-Object { $_.examId -eq "real_96" })
Write-Host "Existing questions count for real_96: $($existingQs.Count)"
