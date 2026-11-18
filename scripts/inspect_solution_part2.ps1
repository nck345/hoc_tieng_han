Get-Content "js\app.js" | Select-Object -Skip 1030 -First 60 | ForEach-Object {
    Write-Host $_
}
