$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

for ($i = 1022; $i -lt 1087; $i++) {
    Write-Host "$($i+1): $($lines[$i])"
}
