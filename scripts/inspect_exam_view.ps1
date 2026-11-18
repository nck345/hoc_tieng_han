Get-Content "js\app.js" | Select-Object -Skip 750 -First 90 | ForEach-Object {
    Write-Host $_
}
