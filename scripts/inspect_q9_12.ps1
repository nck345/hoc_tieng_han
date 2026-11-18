$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)
$de = [System.IO.File]::ReadAllText("scripts/hot01_de_full.txt", [System.Text.Encoding]::UTF8)

# Check Q9 to Q12 in ans
$idx9 = $ans.IndexOf("9. ")
$idx13 = $ans.IndexOf("13. ")
Write-Host "=== ANS Q9..Q12 ==="
Write-Host $ans.Substring($idx9, $idx13 - $idx9)

# Check Q9 to Q12 in de
$p4 = $de.IndexOf("=== PAGE 4 ===")
$p5 = $de.IndexOf("=== PAGE 5 ===")
Write-Host "`n=== DE PAGE 4 ==="
Write-Host $de.Substring($p4, $p5 - $p4)
