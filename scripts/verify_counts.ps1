$files = @(
    "listening_part1.json",
    "listening_part2.json",
    "reading_part1.json",
    "reading_part2.json",
    "writing.json"
)

$total = 0
foreach ($f in $files) {
    $p = Join-Path "scripts\topik96_data" $f
    $data = Get-Content $p -Raw -Encoding UTF8 | ConvertFrom-Json
    Write-Host "$f : $($data.Count) items"
    $total += $data.Count
}
Write-Host "Total questions: $total"
