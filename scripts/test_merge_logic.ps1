[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

Write-Host "Categories count: $($data.categories.Count)"
Write-Host "Packs count: $($data.packs.Count)"
Write-Host "Questions count before: $($data.questions.Count)"

# Filter out old real_96 questions
$remainingQuestions = @($data.questions | Where-Object { $_.examId -ne "real_96" })
Write-Host "Remaining questions: $($remainingQuestions.Count)"

# Load all 5 parts
$l1 = Get-Content "scripts\topik96_data\listening_part1.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$l2 = Get-Content "scripts\topik96_data\listening_part2.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$r1 = Get-Content "scripts\topik96_data\reading_part1.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$r2 = Get-Content "scripts\topik96_data\reading_part2.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$w = Get-Content "scripts\topik96_data\writing.json" -Raw -Encoding UTF8 | ConvertFrom-Json

$new96Questions = @($l1) + @($l2) + @($w) + @($r1) + @($r2)
Write-Host "New TOPIK 96 questions count: $($new96Questions.Count)"

$allQuestions = $remainingQuestions + $new96Questions
Write-Host "Total questions after merge: $($allQuestions.Count)"
