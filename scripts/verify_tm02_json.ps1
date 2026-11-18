$json = Get-Content 'scripts/tm02_master_questions.json' -Raw -Encoding UTF8 | ConvertFrom-Json
Write-Host "Listening count: $($json.listening.Count)"
Write-Host "Reading count: $($json.reading.Count)"
Write-Host "Sample L1: $($json.listening[0].passage)"
Write-Host "Sample L1 Ans: $($json.listening[0].correctAnswer)"
Write-Host "Sample R1: $($json.reading[0].passage)"
Write-Host "Sample R1 Ans: $($json.reading[0].correctAnswer)"
Write-Host "Sample R1 Opts: $($json.reading[0].options -join ' | ')"
