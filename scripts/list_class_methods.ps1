$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '^\t([a-zA-Z0-9_]+)\s*\([^)]*\)\s*\{') {
        Write-Host "Line $($i+1): $($matches[1])"
    }
}
