$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_ans_full.txt
$p4 = $txt.IndexOf("=== PAGE 4 ===")
$p6 = $txt.IndexOf("=== PAGE 6 ===")
Write-Host $txt.Substring($p4, $p6 - $p4)
