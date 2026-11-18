[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

$data.questions | Group-Object examId | ForEach-Object {
    Write-Host "$($_.Name): $($_.Count) questions"
}
