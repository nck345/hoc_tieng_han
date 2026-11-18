$lines = Get-Content "js\exam_data.js" -Encoding UTF8
for ($i = 0; $i -lt 310; $i++) {
    if ($lines[$i] -match '"real_96"') {
        Write-Host "real_96 found around line $($i+1)"
        for ($j = [Math]::Max(0, $i-2); $j -lt [Math]::Min($lines.Length, $i+12); $j++) {
            Write-Host "$($j+1): $($lines[$j])"
        }
    }
}
