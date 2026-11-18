$raw = Get-Content "js/exam_data.js" -Raw -Encoding UTF8
$rawClean = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';?\s*$', ''
$data = $rawClean | ConvertFrom-Json
$qs = $data.questions
$missingAudio = 0
$totalAudio = 0
$foundAudio = 0
foreach ($q in $qs) {
    if ($q.section -eq "listening") {
        $totalAudio++
        if (-not $q.audioUrl) {
            Write-Host "Missing audioUrl property for $($q.id)"
            $missingAudio++
        } else {
            $p = $q.audioUrl -replace '/', '\'
            if (-not (Test-Path $p)) {
                Write-Host "Audio file does not exist: $p for $($q.id)"
                $missingAudio++
            } else {
                $foundAudio++
            }
        }
    }
}
Write-Host "Total listening questions: $totalAudio"
Write-Host "Total audio files verified on disk: $foundAudio"
Write-Host "Missing or broken audio: $missingAudio"
