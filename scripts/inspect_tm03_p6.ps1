$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="
$p6 = $pages[6].Trim()
Write-Host "=== PAGE 6 (Q11..Q15) ==="
Write-Host $p6
