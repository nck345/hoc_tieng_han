Get-Content "js\app.js" | Select-Object -Skip 780 -First 30 | ForEach-Object {
    Write-Host $_
}
