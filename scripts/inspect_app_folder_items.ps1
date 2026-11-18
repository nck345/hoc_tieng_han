Get-Content "js\app.js" | Select-Object -Skip 760 -First 45 | ForEach-Object {
    Write-Host $_
}
