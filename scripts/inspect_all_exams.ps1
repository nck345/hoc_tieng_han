[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
$json = ($raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', '') | ConvertFrom-Json

foreach ($cat in $json.categories) {
    Write-Host "Category: $($cat.id) - $($cat.name)"
    foreach ($ex in $cat.exams) {
        Write-Host "  Exam: $($ex.id) - $($ex.name) (questions: $($ex.questionCount), audio: $($ex.audioFile -ne $null -or $ex.hasSeparatedAudio))"
    }
}
