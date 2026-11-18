$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="
$p29 = $pages[29].Trim()
Write-Host "=== PAGE 29 (Q23, Q24) ==="
Write-Host $p29
