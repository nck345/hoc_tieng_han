$raw = Get-Content "js/exam_data.js" -Raw -Encoding UTF8
$rawClean = $raw -replace '^window\.EXAM_DATA\s*=\s*', '' -replace ';?\s*$', ''
$data = $rawClean | ConvertFrom-Json
$qs = $data.questions
$dummyCount = 0
$dummyRegex = [regex]::new([char]0xC120 + [char]0xD0DD + [char]0xC9C0)
foreach ($q in $qs) {
    if ($q.options) {
        foreach ($opt in $q.options) {
            if ($dummyRegex.IsMatch($opt)) {
                $dummyCount++
                Write-Host "Dummy found in $($q.id): $opt"
            }
        }
    }
}
Write-Host "Total questions analyzed: $($qs.Count)"
Write-Host "Total dummy options found: $dummyCount"
