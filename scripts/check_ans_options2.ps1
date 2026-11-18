$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)
$p3Idx = $ans.IndexOf("=== PAGE 3 ===")
$ansAfterP3 = $ans.Substring($p3Idx)

for ($q = 9; $q -le 24; $q++) {
    $m = [regex]::Match($ansAfterP3, "(?:^|\n|\r|\s)$q\.\s*([\s\S]*?)(?=(?:^|\n|\r|\s)" + ($q + 1) + "\.\s*|=== PAGE|$)")
    if ($m.Success) {
        $chunk = $m.Groups[1].Value
        Write-Host "=== Q$q ==="
        $lines = $chunk -split "[\r\n]+" | Where-Object { $_.Trim().Length -gt 0 }
        $lines | Select-Object -First 6 | ForEach-Object { Write-Host "   $_" }
    } else {
        Write-Host "=== Q$q NOT FOUND ==="
    }
}
