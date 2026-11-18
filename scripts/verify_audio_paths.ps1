$l1 = Get-Content "scripts\topik96_data\listening_part1.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$l2 = Get-Content "scripts\topik96_data\listening_part2.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$allListening = @($l1) + @($l2)

$missing = 0
foreach ($q in $allListening) {
    if (-not $q.audioUrl) {
        Write-Host "Missing audioUrl for $($q.id)"
        $missing++
        continue
    }
    $localPath = $q.audioUrl -replace '/', '\'
    if (-not (Test-Path $localPath)) {
        Write-Host "Audio file not found: $localPath for $($q.id)"
        $missing++
    }
}

if ($missing -eq 0) {
    Write-Host "All $($allListening.Count) audio files verified and exist on disk!"
} else {
    Write-Host "$missing audio issues found."
}
