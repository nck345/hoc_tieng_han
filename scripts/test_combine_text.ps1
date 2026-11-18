[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function Get-ArrayInnerJson($filePath) {
    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8).Trim()
    if ($raw.StartsWith("[") -and $raw.EndsWith("]")) {
        $inner = $raw.Substring(1, $raw.Length - 2).Trim()
        return $inner
    } else {
        throw "File $filePath is not a JSON array"
    }
}

$partFiles = @(
    "scripts\topik96_data\listening_part1.json",
    "scripts\topik96_data\listening_part2.json",
    "scripts\topik96_data\writing.json",
    "scripts\topik96_data\reading_part1.json",
    "scripts\topik96_data\reading_part2.json"
)

$combinedParts = @()
foreach ($f in $partFiles) {
    $inner = Get-ArrayInnerJson $f
    $combinedParts += $inner
}

$fullJsonArray = "[" + ($combinedParts -join ",`n") + "]"
Write-Host "Combined text length: $($fullJsonArray.Length) characters"

$parsed = $fullJsonArray | ConvertFrom-Json
Write-Host "Successfully parsed! Total items: $($parsed.Count)"

$first = $parsed[0]
$last = $parsed[-1]
Write-Host "First item: $($first.id) (#$($first.questionNumber) $($first.section))"
Write-Host "50th item: $($parsed[49].id) (#$($parsed[49].questionNumber) $($parsed[49].section))"
Write-Host "51st item: $($parsed[50].id) (#$($parsed[50].questionNumber) $($parsed[50].section))"
Write-Host "54th item: $($parsed[53].id) (#$($parsed[53].questionNumber) $($parsed[53].section))"
Write-Host "55th item: $($parsed[54].id) (#$($parsed[54].questionNumber) $($parsed[54].section))"
Write-Host "Last item: $($last.id) (#$($last.questionNumber) $($last.section))"
