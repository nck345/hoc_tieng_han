$app = [System.IO.File]::ReadAllText('js/app.js', [System.Text.Encoding]::UTF8)
$lines = $app -split "`n"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match 'fallback|startExam|openExam|filter.*examId') {
        Write-Host "$($i+1): $($lines[$i])"
    }
}
