$json = Get-Content "scripts/patch_session_data.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$utf8 = [System.Text.Encoding]::UTF8
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$text = [System.IO.File]::ReadAllText("js/app.js", $utf8)

# 1. Insert submitExamAnswer right before showExamSolution
$submitBlock = $json.submitAnswer_block + "`r`n`r`n`tshowExamSolution(q,userAns,isCorrect){"
if (-not $text.Contains("submitExamAnswer(){")) {
    $text = $text.Replace("`tshowExamSolution(q,userAns,isCorrect){", $submitBlock)
    Write-Host "1. submitExamAnswer inserted"
} else {
    Write-Host "1. submitExamAnswer already present"
}

# 2. Insert nextExamQuestion right before renderCommunicationView
$nextBlock = $json.nextExam_block + "`r`n`r`n`trenderCommunicationView(){"
if (-not $text.Contains("nextExamQuestion(){")) {
    $text = $text.Replace("`trenderCommunicationView(){", $nextBlock)
    Write-Host "2. nextExamQuestion inserted"
} else {
    Write-Host "2. nextExamQuestion already present"
}

[System.IO.File]::WriteAllText("js/app.js", $text, $utf8NoBom)
Write-Host "All missing methods inserted cleanly!"
