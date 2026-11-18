$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

Write-Host "Total lines: $($lines.Length)"
for ($i = 785; $i -lt [Math]::Min($lines.Length, 815); $i++) {
    Write-Host "$($i+1): [$($lines[$i])]"
}
