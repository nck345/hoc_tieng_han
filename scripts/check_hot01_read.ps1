$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)
$rIdx = $ans.IndexOf([regex]::Unescape("\uC77D\uAE30 (1\uBC88"))
$ansRead = $ans.Substring($rIdx)

for ($q = 21; $q -le 30; $q++) {
    $m = [regex]::Match($ansRead, "(?:^|\n|\r|\s)$q\.\s*([\s\S]*?)(?=(?:^|\n|\r|\s)" + ($q + 1) + "\.\s*|=== PAGE|$)")
    if ($m.Success) {
        $chunk = $m.Groups[1].Value
        Write-Host "=== Reading Q$q ==="
        $lines = $chunk -split "[\r\n]+" | Where-Object { $_.Trim().Length -gt 0 }
        $lines | Select-Object -First 6 | ForEach-Object { Write-Host "   $_" }
    } else {
        Write-Host "=== Reading Q$q NOT FOUND ==="
    }
}
