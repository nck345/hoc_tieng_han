Get-Content "js\app.js" | Select-Object -First 120 | ForEach-Object {
    Write-Host $_
}
