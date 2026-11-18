function Clean-Text($s) {
    if (-not $s) { return "" }
    $s = $s -replace "[\r\n]+", " "
    $s = $s -replace "\s+", " "
    return $s.Trim()
}

function Extract-Options($text) {
    $bulletRegex = "(?:^|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|(?:\(\s*[0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\s*\))|(?:[1-4]\s*[\)\.]))\s*"
    $parts = [regex]::Split($text, $bulletRegex)
    $opts = @()
    foreach ($p in $parts) {
        $clean = Clean-Text $p
        if ($clean.Length -gt 1 -and -not ($clean -match "^(?:\d+\.|\※|\[\d|다음을|남자의|들은|여자가)")) {
            # remove trailing annotations
            $clean = ($clean -split "\s+(?:종류|해설|단어|어휘|Exp)")[0].Trim()
            if ($clean.Length -gt 1) {
                $opts += $clean
            }
        }
        if ($opts.Count -eq 4) { break }
    }
    return $opts
}

# Test on hot01 de text
$de = Get-Content "scripts/hot01_de_full.txt" -Raw -Encoding UTF8
$idxRead = $de.IndexOf("읽기 (1번~50번)")
$deListen = $de.Substring(0, $idxRead)

for ($q = 4; $q -le 8; $q++) {
    $pat = "(?:^|\n|\r|\s)${q}\.\s*([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*|\[|$)"
    $m = [regex]::Match($deListen, $pat)
    if ($m.Success) {
        $opts = Extract-Options $m.Groups[1].Value
        Write-Host "Q$q Options ($($opts.Count)): $($opts -join ' | ')"
    } else {
        Write-Host "Q$q : FAILED"
    }
}
