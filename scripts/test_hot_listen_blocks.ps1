$txt = [System.IO.File]::ReadAllText('scripts/hot01_ans_full.txt', [System.Text.Encoding]::UTF8)
$lStart = [regex]::Match($txt, '\[1\s*~\s*3\]\s*다음을\s*듣고').Index
$lEnd = [regex]::Match($txt, '(?:\b쓰기\b|\b읽기\s*\([^\)]*50번\))').Index
$listenTxt = $txt.Substring($lStart, $lEnd - $lStart)

function Clean-Text($s) {
    if (-not $s) { return '' }
    return ($s -replace '\s+', ' ').Trim()
}

$foundCount = 0
for ($q = 1; $q -le 50; $q++) {
    $nextQ = $q + 1
    # For Q1, it starts from beginning of listenTxt
    if ($q -eq 1) {
        $p = '(?s)^(.*?)(?=(?:^|\n|[\.\!\?]\s+|\b)2\.\s*)'
    } elseif ($q -eq 50) {
        $p = '(?s)(?:^|\n|[\.\!\?]\s+|\b)50\.\s*(.*)$'
    } else {
        $p = '(?s)(?:^|\n|[\.\!\?]\s+|\b)' + $q + '\.\s*(.*?)(?=(?:^|\n|[\.\!\?]\s+|\b)' + $nextQ + '\.\s*)'
    }
    
    $m = [regex]::Match($listenTxt, $p)
    if ($m.Success) {
        $foundCount++
        $blk = Clean-Text $m.Groups[1].Value
        # Write-Host "Q$q : $($blk.Substring(0, [Math]::Min(50, $blk.Length)))"
    } else {
        Write-Host "Q$q : MISSING"
    }
}
Write-Host "Total matched questions out of 50: $foundCount"
