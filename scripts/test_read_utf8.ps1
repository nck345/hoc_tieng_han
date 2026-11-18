$raw = [System.IO.File]::ReadAllText("scripts/hot01_de_full.txt", [System.Text.Encoding]::UTF8)
Write-Host "Length: $($raw.Length)"
$p4 = $raw.IndexOf("=== PAGE 4 ===")
$p5 = $raw.IndexOf("=== PAGE 5 ===")
$page4 = $raw.Substring($p4, $p5 - $p4)
Write-Host $page4
