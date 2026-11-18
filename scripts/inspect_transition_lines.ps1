$lines = Get-Content "js\exam_data.js" -Encoding UTF8
Write-Host "Lines 310-315:"
for ($i = 309; $i -lt 315; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}
Write-Host "`nLines 1785-1792:"
for ($i = 1784; $i -lt 1792; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}
