$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)
for ($q = 9; $q -le 20; $q++) {
    $idx = $ans.IndexOf("$q. ")
    if ($idx -ge 0) {
        $chunk = $ans.Substring($idx, [Math]::Min(300, $ans.Length - $idx))
        Write-Host "=== Q$q ==="
        Write-Host ($chunk -replace "[\r\n]+", " ")
    } else {
        Write-Host "=== Q$q NOT FOUND ==="
    }
}
