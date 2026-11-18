Select-String -Path "js\app.js" -Pattern "activeExamQuestions" | ForEach-Object {
    Write-Host "$($_.LineNumber): $($_.Line.Trim())"
}
