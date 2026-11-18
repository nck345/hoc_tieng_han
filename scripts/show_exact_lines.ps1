$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

Write-Host "Line 793: $($lines[792])"
Write-Host "Line 834: $($lines[833])"
Write-Host "Line 835: $($lines[834])"
Write-Host "Line 896: $($lines[895])"
Write-Host "Line 931: $($lines[930])"
