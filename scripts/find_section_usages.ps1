$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Contains("q.section") -or $lines[$i].Contains(".section")) {
        Write-Host "Line $($i+1): $($lines[$i].Trim())"
    }
}
