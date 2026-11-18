$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_de_full.txt
$p4 = $txt.IndexOf("=== PAGE 4 ===")
$p7 = $txt.IndexOf("=== PAGE 7 ===")
Write-Host $txt.Substring($p4, $p7 - $p4)
