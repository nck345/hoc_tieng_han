$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

Write-Host "Total lines: $($lines.Length)"
$indices = @(780, 895, 930, 995, 1020, 1085, 1150, 1280, 1315, 1325)
foreach ($idx in $indices) {
    Write-Host "--- Around line $idx ---"
    for ($i = [Math]::Max(0, $idx - 3); $i -le [Math]::Min($lines.Length - 1, $idx + 3); $i++) {
        Write-Host "$($i+1): $($lines[$i])"
    }
}
