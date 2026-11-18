[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$obj = @{
    title = "한국어 및 Tiếng Việt"
    options = @("사과", "Bình đẳng")
}
$json = $obj | ConvertTo-Json -Depth 5
Write-Host "JSON:"
Write-Host $json
