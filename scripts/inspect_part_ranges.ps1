[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$files = @(
    "listening_part1.json",
    "listening_part2.json",
    "reading_part1.json",
    "reading_part2.json",
    "writing.json"
)

foreach ($f in $files) {
    $p = Join-Path "scripts\topik96_data" $f
    $items = Get-Content $p -Raw -Encoding UTF8 | ConvertFrom-Json
    $first = $items[0]
    $last = $items[-1]
    Write-Host "$f => Count: $($items.Count), First: $($first.id) (#$($first.questionNumber), $($first.section)), Last: $($last.id) (#$($last.questionNumber), $($last.section))"
}
