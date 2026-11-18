$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
$jsonStr = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $jsonStr | ConvertFrom-Json
$q96 = @($data.questions | Where-Object { $_.examId -eq "real_96" })

foreach ($q in $q96) {
    if (-not $q.instruction) {
        Write-Host "Missing instruction: $($q.id)"
    }
    if (-not $q.explanation) {
        Write-Host "Missing explanation: $($q.id)"
    }
    if (-not $q.options) {
        Write-Host "Missing options: $($q.id)"
    } elseif ($q.options.Count -ne 4) {
        Write-Host "Options count not 4: $($q.id) (has $($q.options.Count) options)"
    }
}
