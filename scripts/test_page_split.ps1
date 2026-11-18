$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_de_full.txt
$pages = $txt -split "=== PAGE \d+ ==="

# Page 21 is Reading Q1..Q4 (index 21)
Write-Host "--- TEST PAGE 21 ---"
$p21 = $pages[21].Trim()
Write-Host $p21

# Let's inspect how to split Q1, Q2, Q3, Q4 on Page 21
Write-Host "`n--- TEST PAGE 22 ---"
$p22 = $pages[22].Trim()
Write-Host $p22
