$lines = Get-Content "js\exam_data.js" -Encoding UTF8
$qLine = -1
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '^\s*"questions"\s*:\s*\[') {
        $qLine = $i
        break
    }
}
Write-Host "questions starts at line: $($qLine + 1)"
Write-Host "Total lines in file: $($lines.Length)"
