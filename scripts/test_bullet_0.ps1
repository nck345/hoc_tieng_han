$ans = [System.IO.File]::ReadAllText("scripts/hot01_ans_full.txt", [System.Text.Encoding]::UTF8)

# Test Q6, Q7, Q8 in ans
$p5Idx = $ans.IndexOf("=== PAGE 5 ===")
$p6Idx = $ans.IndexOf("=== PAGE 6 ===")
$page5 = $ans.Substring($p5Idx, $p6Idx - $p5Idx)

$bulletPattern = "(?:^|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩㉭@]|(?:\(\s*[0-9가-힣A-Za-z\.]+\s*\))|(?:[1-4]\s*[\)\.])|(?:0\s+))\s*"

function Extract-Opts($text) {
    # remove explanation
    $text = ($text -split "(?:종류|해설|단어|어휘|Exp)")[0]
    $parts = [regex]::Split($text, $bulletPattern)
    $opts = @()
    foreach ($p in $parts) {
        $c = $p -replace "[\r\n]+", " "
        $c = $c -replace "\s+", " "
        $c = $c.Trim()
        if ($c.Length -gt 1 -and -not ($c -match "^(?:남자|여자|\d+\.)")) {
            $opts += $c
        }
    }
    return $opts
}

$m6 = [regex]::Match($page5, "6\.\s*([\s\S]*?)7\.\s*")
if ($m6.Success) {
    Write-Host "Q6 Options:"
    (Extract-Opts $m6.Groups[1].Value) | ForEach-Object { Write-Host " - $_" }
}

$m7 = [regex]::Match($page5, "7\.\s*([\s\S]*?)8\.\s*")
if ($m7.Success) {
    Write-Host "`nQ7 Options:"
    (Extract-Opts $m7.Groups[1].Value) | ForEach-Object { Write-Host " - $_" }
}

$m8 = [regex]::Match($page5, "8\.\s*([\s\S]*?)\[9~")
if ($m8.Success) {
    Write-Host "`nQ8 Options:"
    (Extract-Opts $m8.Groups[1].Value) | ForEach-Object { Write-Host " - $_" }
}
