Get-Content "js\app.js" | Select-Object -Skip 890 -First 45 | ForEach-Object {
    Write-Host $_
}
