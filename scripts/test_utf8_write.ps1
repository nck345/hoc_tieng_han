$testContent = "window.EXAM_DATA = { test: '한국어 & Tiếng Việt' };"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText("scripts\test_utf8.js", $testContent, $utf8NoBom)
$readBack = [System.IO.File]::ReadAllText("scripts\test_utf8.js", $utf8NoBom)
Write-Host "Read back: $readBack"
Remove-Item "scripts\test_utf8.js"
