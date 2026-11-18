$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
$lines = $raw -split "`n"
for ($i = 2862; $i -lt 2874; $i++) {
    Write-Host "$($i+1): [$($lines[$i])]"
}
