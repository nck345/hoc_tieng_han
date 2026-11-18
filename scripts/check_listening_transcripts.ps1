$utf8 = [System.Text.Encoding]::UTF8
$raw = [System.IO.File]::ReadAllText("js\exam_data.js", $utf8)
$json = ($raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', '') | ConvertFrom-Json
$l = @($json.questions | Where-Object { $_.examId -eq "real_96" -and $_.section -eq "listening" })

$withTranscript = 0
$withPassage = 0
$withoutBoth = 0
foreach ($q in $l) {
    $hasTr = ($q.transcript -and $q.transcript.Count -gt 0)
    $hasPassage = [bool]$q.passage
    if ($hasTr) { $withTranscript++ }
    if ($hasPassage) { $withPassage++ }
    if (-not $hasTr -and -not $hasPassage) { $withoutBoth++ }
}
Write-Host "Listening questions total: $($l.Count)"
Write-Host "With transcript: $withTranscript"
Write-Host "With passage: $withPassage"
Write-Host "Without both: $withoutBoth"
