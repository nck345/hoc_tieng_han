$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_de_full.txt
$p21 = $txt.IndexOf("=== PAGE 21 ===")
$p25 = $txt.IndexOf("=== PAGE 25 ===")
Write-Host $txt.Substring($p21, $p25 - $p21)
