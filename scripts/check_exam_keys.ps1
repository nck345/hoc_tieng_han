$js = [System.IO.File]::ReadAllText("js/exam_data.js", [System.Text.Encoding]::UTF8)
$m = [regex]::Matches($js, '^\s*"([a-zA-Z0-9_]+)"\s*:\s*[\[\{]', [System.Text.RegularExpressions.RegexOptions]::Multiline)
foreach ($match in $m) {
    Write-Host ("Key: " + $match.Groups[1].Value)
}
