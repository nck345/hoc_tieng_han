$raw = [System.IO.File]::ReadAllText("temp_edge_output.txt", [System.Text.Encoding]::UTF8)
if ($raw -match '<pre id="output">([\s\S]*?)</pre>') {
    Write-Host $matches[1]
} else {
    Write-Host "Output tag not found"
}
