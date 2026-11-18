$txt = [System.IO.File]::ReadAllText('scripts/tm03_ans_full.txt', [System.Text.Encoding]::UTF8)
$pages = $txt -split '=== PAGE \d+ ==='
$listeningTxt = ($pages[3..14] -join "`n`n")

function Clean-Text($s) {
    if (-not $s) { return '' }
    return ($s -replace '\s+', ' ').Trim()
}

Write-Host "Listening text length: $($listeningTxt.Length)"

for ($q = 1; $q -le 10; $q++) {
    $nextQ = $q + 1
    $pattern = '(?s)(?:^|\n)\s*' + $q + '\.\s*(.*?)(?=(?:\n\s*' + $nextQ + '\.\s*|\[\d+~|$))'
    $m = [regex]::Match($listeningTxt, $pattern)
    if ($m.Success) {
        $blk = $m.Groups[1].Value
        $dia = ''
        $diaM = [regex]::Match($blk, '(?s)((?:남자|여자|대화)\s*:?.*?(?=(?:[WM]\s+[A-Z]|\bSince\b|\bThe\b|\bAccording\b|\n\s*\d+\.|$)))')
        if ($diaM.Success) { $dia = Clean-Text $diaM.Groups[1].Value }
        Write-Host "Q$q : dia len = $($dia.Length) | $($dia.Substring(0, [Math]::Min(60, $dia.Length)))"
    } else {
        Write-Host "Q$q : NOT MATCHED"
    }
}
