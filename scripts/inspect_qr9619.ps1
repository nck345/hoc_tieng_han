[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
$jsonStr = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json
$q = $data.questions | Where-Object { $_.id -eq "q_r_96_19" }

Write-Host "ID: $($q.id)"
Write-Host "QuestionNumber: $($q.questionNumber)"
Write-Host "Instruction: $($q.instruction)"
Write-Host "CorrectAnswer: $($q.correctAnswer)"
Write-Host "Options count: $($q.options.Count)"
for ($i = 0; $i -lt $q.options.Count; $i++) {
    Write-Host "Option $($i+1): $($q.options[$i])"
}
