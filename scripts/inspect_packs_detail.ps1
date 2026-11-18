[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = Get-Content "js\exam_data.js" -Raw -Encoding UTF8
$jsonStr = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json

foreach ($p in $data.packs) {
    Write-Host "Pack id: $($p.id), title: $($p.titleVi), questions: $($p.questions.Count)"
}
