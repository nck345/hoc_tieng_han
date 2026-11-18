$raw = [System.IO.File]::ReadAllText("js\exam_data.js", [System.Text.Encoding]::UTF8)
$lines = $raw -split "`n"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Contains('"q_r_96_19"')) {
        Write-Host "Found q_r_96_19 around line $($i+1)"
        for ($j = $i; $j -lt $i + 25; $j++) {
            Write-Host "$($j+1): $($lines[$j])"
        }
        break
    }
}
