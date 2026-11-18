[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$w = Get-Content "scripts\topik96_data\writing.json" -Raw -Encoding UTF8 | ConvertFrom-Json
foreach ($q in $w) {
    Write-Host "Q: $($q.id), Num: $($q.questionNumber), Section: $($q.section)"
    Write-Host "Instruction: $($q.instruction)"
    Write-Host "CorrectAnswer: $($q.correctAnswer)"
    Write-Host "Options: $($q.options -join ' | ')"
    Write-Host "---"
}
