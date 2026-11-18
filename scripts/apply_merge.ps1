[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Backup
Copy-Item "js\exam_data.js" "js\exam_data.js.bak" -Force
Write-Host "Created backup js\exam_data.js.bak"

# Move test to actual
Move-Item "js\exam_data_test.js" "js\exam_data.js" -Force
Write-Host "Moved exam_data_test.js to js\exam_data.js"

# Verify actual
$utf8 = [System.Text.Encoding]::UTF8
$raw = [System.IO.File]::ReadAllText("js\exam_data.js", $utf8)
$json = $raw -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$data = $json | ConvertFrom-Json

Write-Host "Verification of js\exam_data.js:"
Write-Host "- Categories: $($data.categories.Count)"
Write-Host "- Packs: $($data.packs.Count)"
Write-Host "- Questions: $($data.questions.Count)"
$q96 = @($data.questions | Where-Object { $_.examId -eq "real_96" })
Write-Host "- Questions for real_96: $($q96.Count)"
