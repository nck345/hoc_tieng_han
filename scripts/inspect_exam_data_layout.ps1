$lines = Get-Content "js\exam_data.js" -Encoding UTF8
Write-Host "Lines 305 to 330:"
for ($i = 304; $i -lt 330; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}

Write-Host "`nLast 25 lines of file:"
for ($i = $lines.Length - 25; $i -lt $lines.Length; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}
