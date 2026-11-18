Get-Content "js\app.js" | Select-Object -Skip 1115 -First 35 | ForEach-Object {
    Write-Host $_
}
