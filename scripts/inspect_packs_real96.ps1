[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

foreach ($p in $data.packs) {
    $real96Count = ($p.questions | Where-Object { $_.examId -eq "real_96" }).Count
    Write-Host "$($p.typeId): $($p.questions.Count) total, $real96Count are real_96"
}
