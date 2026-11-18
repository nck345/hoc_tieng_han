Get-Content "js\app.js" | Select-Object -Skip 145 -First 130 | ForEach-Object {
    Write-Host $_
}
