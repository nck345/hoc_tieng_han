$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="

function Clean-Str($s) {
    if (-not $s) { return "" }
    $s = $s -replace "[\r\n]+", " "
    $s = $s -replace "\s+", " "
    return $s.Trim()
}

$bulletRegex = [regex]::Unescape("(?:^|\s)(?:[\u2460-\u2463\u2776-\u2779\u3260-\u3269@]|(?:\(\s*[0-9\uAC00-\uD7AFa-zA-Z\.]+\s*\))|(?:[1-4]\s*[\)\.]))\s*")

function Split-Opts($txt) {
    $parts = [regex]::Split($txt, $bulletRegex)
    $opts = @()
    foreach ($p in $parts) {
        $c = Clean-Str $p
        $c = ($c -split [regex]::Unescape("\s+(?:\uC885\uB958|\uD574\uC124|\uB2E8\uC5B4|\uC5B4\uD718|Exp)"))[0].Trim()
        if ($c.Length -gt 1 -and -not ($c -match [regex]::Unescape("^(?:\d+\.|\u203B|\[\d|\uB2E4\uC74C|\uB0A8\uC790|\uC5EC\uC790|\uC774 \uAE00)"))) {
            $opts += $c
        }
        if ($opts.Count -eq 4) { break }
    }
    return $opts
}

# Page 28: Q21, Q22
$p28 = $pages[28]
Write-Host ">>> PARSING PAGE 28 (Q21, Q22) <<<"
$q21Block = [regex]::Match($p28, [regex]::Unescape("21\.\s*([\s\S]*?)22\.")).Groups[1].Value
if (-not $q21Block) {
    # If 21. was at top, match from prompt
    $q21Block = [regex]::Match($p28, [regex]::Unescape("\(\s*\)\uC5D0 \uB4E4\uC544\uAC08[\s\S]*?(?=\uC774 \uAE00\uC758 \uC911\uC2EC)")).Value
}
$opts21 = Split-Opts $q21Block
Write-Host "Q21 options ($($opts21.Count)):"
$opts21 | ForEach-Object { Write-Host " - $_" }

$q22Block = [regex]::Match($p28, [regex]::Unescape("\uC774 \uAE00\uC758 \uC911\uC2EC[\s\S]*?(?=TOPIK MASTER|$)")).Value
$opts22 = Split-Opts $q22Block
Write-Host "`nQ22 options ($($opts22.Count)):"
$opts22 | ForEach-Object { Write-Host " - $_" }

# Page 29: Q23, Q24
$p29 = $pages[29]
Write-Host "`n>>> PARSING PAGE 29 (Q23, Q24) <<<"
$q23Block = [regex]::Match($p29, [regex]::Unescape("\uB098\uC758 \uC2EC\uC815\uC73C\uB85C[\s\S]*?(?=\uC774 \uAE00\uC758 \uB0B4\uC6A9)")).Value
$opts23 = Split-Opts $q23Block
Write-Host "Q23 options ($($opts23.Count)):"
$opts23 | ForEach-Object { Write-Host " - $_" }

$q24Block = [regex]::Match($p29, [regex]::Unescape("\uC774 \uAE00\uC758 \uB0B4\uC6A9\uACFC \uAC19\uC740[\s\S]*?(?=\[25|$)")).Value
$opts24 = Split-Opts $q24Block
Write-Host "`nQ24 options ($($opts24.Count)):"
$opts24 | ForEach-Object { Write-Host " - $_" }
