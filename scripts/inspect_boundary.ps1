$lines = Get-Content "js\exam_data.js" -Encoding UTF8
for ($i = 1140; $i -lt 1155; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}
