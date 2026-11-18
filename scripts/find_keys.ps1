$lines = Get-Content "js\exam_data.js" -Encoding UTF8
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '^\s*"(categories|packs|questions)"\s*:') {
        Write-Host "Line $($i+1): $($lines[$i].Trim())"
    }
}
