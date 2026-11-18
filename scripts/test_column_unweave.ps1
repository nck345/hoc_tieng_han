$txt = [System.IO.File]::ReadAllText("scripts/hot01_de_full.txt", [System.Text.Encoding]::UTF8)
$p4 = $txt.IndexOf("=== PAGE 4 ===")
$p5 = $txt.IndexOf("=== PAGE 5 ===")
$page4 = $txt.Substring($p4, $p5 - $p4)

$lines = $page4 -split "[\r\n]+" | ForEach-Object { $_.Trim() } | Where-Object { $_.Length -gt 0 }

# The first section before [9~1기
$sec1 = @()
foreach ($l in $lines) {
    if ($l -match "\[9~") { break }
    if ($l -match "^6\.\s*7\.") { continue }
    if ($l -match "=== PAGE") { continue }
    $sec1 += $l
}

Write-Host "Sec1 total lines: $($sec1.Count)"
$sec1 | ForEach-Object { Write-Host " - $_" }

if ($sec1.Count -eq 12) {
    $half = 6
    $left = $sec1[0..($half-1)]
    $right = $sec1[$half..($sec1.Count-1)]
    
    # Q6, Q7, Q8
    for ($k = 0; $k -lt 3; $k++) {
        $qNum = 6 + $k
        $opt1 = $left[$k * 2]
        $opt2 = $right[$k * 2]
        $opt3 = $left[$k * 2 + 1]
        $opt4 = $right[$k * 2 + 1]
        Write-Host "`n>>> Q$qNum OPTIONS:"
        Write-Host "   (1) $opt1"
        Write-Host "   (2) $opt2"
        Write-Host "   (3) $opt3"
        Write-Host "   (4) $opt4"
    }
}
