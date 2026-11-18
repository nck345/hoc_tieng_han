$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)
$rIdx = $ans.IndexOf([regex]::Unescape("\uC77D\uAE30 (1\uBC88"))
$ansRead = $ans.Substring($rIdx)

$bulletPattern = [regex]::Unescape("(?:^|\s)(?:[\u2460-\u2463\u2776-\u2779\u3260-\u3269@]|(?:\(\s*[0-9\uAC00-\uD7AFa-zA-Z\.]+\s*\))|(?:[1-4]\s*[\)\.]))\s*")

function Test-Extract($text) {
    $parts = [regex]::Split($text, $bulletPattern)
    $opts = @()
    $ignorePattern = [regex]::Unescape("^(?:\d+\.|\u203B|\[\d|\uB2E4\uC74C\uC744|\uB0A8\uC790\uC758|\uB4E4\uC740|\uC5EC\uC790\uAC00|\uC774 \uAE00\uC758)")
    foreach ($p in $parts) {
        $c = $p -replace "[\r\n]+", " "
        $c = $c -replace "\s+", " "
        $c = $c.Trim()
        $c = ($c -split [regex]::Unescape("\s+(?:\uC885\uB958|\uD574\uC124|\uB2E8\uC5B4|\uC5B4\uD718|Exp)"))[0].Trim()
        if ($c.Length -gt 1 -and -not ($c -match $ignorePattern)) {
            $opts += $c
        }
        if ($opts.Count -eq 4) { break }
    }
    return $opts
}

for ($q = 21; $q -le 30; $q++) {
    $m = [regex]::Match($ansRead, "(?:^|\n|\r|\s)$q\.\s*([\s\S]*?)(?=(?:^|\n|\r|\s)" + ($q + 1) + "\.\s*|=== PAGE|$)")
    if ($m.Success) {
        $raw = $m.Groups[1].Value
        $opts = Test-Extract $raw
        Write-Host ("Q$q opts count: " + $opts.Count)
        for ($i = 0; $i -lt $opts.Count; $i++) {
            Write-Host ("   [$($i+1)] " + $opts[$i])
        }
    }
}
