[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

Write-Host "Total existing questions in data.questions: $($data.questions.Count)"
$firstQ = $data.questions[0]
Write-Host "Sample existing question:"
$firstQ | ConvertTo-Json -Depth 3

Write-Host "`nPacks count: $($data.packs.Count)"
foreach ($p in $data.packs) {
    Write-Host "Pack id: $($p.id), name: $($p.name), questions count: $($p.questions.Count)"
}
