$txt = [System.IO.File]::ReadAllText('scripts/tm03_ans_full.txt', [System.Text.Encoding]::UTF8)

# Find where Explanations Listening begins
$idx = $txt.IndexOf('Listening')
if ($idx -lt 0) { $idx = $txt.IndexOf('듣기') }
$sub = $txt.Substring($idx)

for ($q = 1; $q -le 5; $q++) {
    $nextQ = $q + 1
    # Find question q
    $p = '(?s)(?:^|[\n\r]|\.\s+)' + $q + '\.\s*(?:(?:남자|여자|대화)\s*[:\s].*?)(?=(?:(?:^|[\n\r]|\.\s+)' + $nextQ + '\.\s*|\[\d+~|===|$))'
    $m = [regex]::Match($sub, $p)
    if ($m.Success) {
        Write-Host "Q$q: $($m.Value.Substring(0, [Math]::Min(100, $m.Value.Length)) -replace '\s+', ' ')"
    } else {
        # Fallback search
        $p2 = '(?s)(?:^|[\n\r]|\.\s+)' + $q + '\.\s*(.*?)(?=(?:(?:^|[\n\r]|\.\s+)' + $nextQ + '\.\s*|\[\d+~|===|$))'
        $m2 = [regex]::Match($sub, $p2)
        if ($m2.Success) {
            Write-Host "Q$q (fallback): $($m2.Value.Substring(0, [Math]::Min(100, $m2.Value.Length)) -replace '\s+', ' ')"
        } else {
            Write-Host "Q$q: NOT FOUND"
        }
    }
}
