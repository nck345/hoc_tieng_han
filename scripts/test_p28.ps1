$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="
$p28 = $pages[28].Trim()
Write-Host "=== PAGE 28 (Q21, Q22) ==="
Write-Host $p28
