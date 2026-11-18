$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="
$p5 = $pages[5].Trim()
Write-Host "=== PAGE 5 (Q6..Q10) ==="
Write-Host $p5
