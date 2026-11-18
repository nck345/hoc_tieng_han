Get-Content "js\app.js" | Select-Object -Skip 970 -First 60 | ForEach-Object {
    Write-Host $_
}
