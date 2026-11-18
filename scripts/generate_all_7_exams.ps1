# GENERATE ALL 7 REMAINING AUTHENTIC EXAMS
# hot01, hot02, hot03, hot04, tm03, tm04, tm05

$ErrorActionPreference = "Stop"

function Get-Instruction($q, $section) {
    if ($section -eq 'listening') {
        if ($q -le 3)  { return [regex]::Unescape("\u203B [1~3] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uC54C\uB9DE\uC740 \uADF8\uB9BC\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 8)  { return [regex]::Unescape("\u203B [4~8] \uB2E4\uC74C \uB300\uD654\uB97C \uC798 \uB4E3\uACE0 \uC774\uC5B4\uC9C8 \uC218 \uC788\uB294 \uB9D0\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 12) { return [regex]::Unescape("\u203B [9~12] \uB2E4\uC74C \uB300\uD654\uB97C \uC798 \uB4E3\uACE0 \uC5EC\uC790\uAC00 \uC774\uC5B4\uC11C \uD560 \uD589\uB3D9\uC73C\uB85C \uC54C\uB9DE\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 16) { return [regex]::Unescape("\u203B [13~16] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uB0B4\uC6A9\uACFC \uC77C\uCE58\uD558\uB294 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 20) { return [regex]::Unescape("\u203B [17~20] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uB0A8\uC790\uC758 \uC911\uC2EC \uC0DD\uAC01\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 22) { return [regex]::Unescape("\u203B [21~22] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 24) { return [regex]::Unescape("\u203B [23~24] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 26) { return [regex]::Unescape("\u203B [25~26] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 28) { return [regex]::Unescape("\u203B [27~28] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 30) { return [regex]::Unescape("\u203B [29~30] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 32) { return [regex]::Unescape("\u203B [31~32] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 34) { return [regex]::Unescape("\u203B [33~34] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 36) { return [regex]::Unescape("\u203B [35~36] \uB2E4\uC74C\uC744 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 38) { return [regex]::Unescape("\u203B [37~38] \uB2E4\uC74C\uC740 \uAD50\uC591 \uD504\uB85C\uADF8\uB7A8\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 40) { return [regex]::Unescape("\u203B [39~40] \uB2E4\uC74C\uC740 \uB300\uB2F4\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 42) { return [regex]::Unescape("\u203B [41~42] \uB2E4\uC74C\uC740 \uAC15\uC5F0\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 44) { return [regex]::Unescape("\u203B [43~44] \uB2E4\uC74C\uC740 \uB2E4\uD050\uBA58\uD130\uB9AC\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 46) { return [regex]::Unescape("\u203B [45~46] \uB2E4\uC74C\uC740 \uAC15\uC5F0\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 48) { return [regex]::Unescape("\u203B [47~48] \uB2E4\uC74C\uC740 \uB300\uB2F4\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        return [regex]::Unescape("\u203B [49~50] \uB2E4\uC74C\uC740 \uAC15\uC5F0\uC785\uB2C8\uB2E4. \uC798 \uB4E3\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)")
    } else {
        if ($q -le 2)  { return [regex]::Unescape("\u203B [1~2] ( )\uC5D0 \uB4E4\uC544\uAC08 \uAC00\uC7A5 \uC54C\uB9DE\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 4)  { return [regex]::Unescape("\u203B [3~4] \uB2E4\uC74C \uBC11\uC904 \uCE5C \uBD80\uBD84\uACFC \uC758\uBBF8\uAC00 \uBE44\uC2B7\uD55C \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 8)  { return [regex]::Unescape("\u203B [5~8] \uB2E4\uC74C\uC740 \uBB34\uC5C7\uC5D0 \uB300\uD55C \uAE00\uC778\uC9C0 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 12) { return [regex]::Unescape("\u203B [9~12] \uB2E4\uC74C \uAE00 \uB610\uB294 \uB3C4\uD45C\uC758 \uB0B4\uC6A9\uACFC \uAC19\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 15) { return [regex]::Unescape("\u203B [13~15] \uB2E4\uC74C\uC744 \uC21C\uC11C\uB300\uB85C \uB9DE\uAC8C \uBC30\uC5F4\uD55C \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 18) { return [regex]::Unescape("\u203B [16~18] \uB2E4\uC74C\uC744 \uC77D\uACE0 ( )\uC5D0 \uB4E4\uC544\uAC08 \uB0B4\uC6A9\uC73C\uB85C \uAC00\uC7A5 \uC54C\uB9DE\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 20) { return [regex]::Unescape("\u203B [19~20] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 22) { return [regex]::Unescape("\u203B [21~22] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 24) { return [regex]::Unescape("\u203B [23~24] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 27) { return [regex]::Unescape("\u203B [25~27] \uB2E4\uC74C\uC740 \uC2E0\uBB38 \uAE30\uC0AC\uC758 \uC81C\uBAA9\uC785\uB2C8\uB2E4. \uAC00\uC7A5 \uC798 \uC124\uBA85\uD55C \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 31) { return [regex]::Unescape("\u203B [28~31] \uB2E4\uC74C\uC744 \uC77D\uACE0 ( )\uC5D0 \uB4E4\uC544\uAC08 \uB0B4\uC6A9\uC73C\uB85C \uAC00\uC7A5 \uC54C\uB9DE\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 34) { return [regex]::Unescape("\u203B [32~34] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uB0B4\uC6A9\uC774 \uAC19\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 38) { return [regex]::Unescape("\u203B [35~38] \uB2E4\uC74C \uAE00\uC758 \uC8FC\uC81C\uB85C \uAC00\uC7A5 \uC54C\uB9DE\uC740 \uAC83\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 41) { return [regex]::Unescape("\u203B [39~41] \uB2E4\uC74C \uAE00\uC5D0\uC11C <\uBCF4\uAE30>\uC758 \uBB38\uC7A5\uC774 \uB4E4\uC5B4\uAC00\uAE30\uC5D0 \uAC00\uC7A5 \uC54C\uB9DE\uC740 \uACF3\uC744 \uACE0\uB974\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 43) { return [regex]::Unescape("\u203B [42~43] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 45) { return [regex]::Unescape("\u203B [44~45] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        if ($q -le 47) { return [regex]::Unescape("\u203B [46~47] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)") }
        return [regex]::Unescape("\u203B [48~50] \uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624. (\uAC01 2\uC810)")
    }
}

$ANSWERS = @{
    hot01_l = @(1, 2, 2, 3, 3, 4, 3, 3, 1, 1, 2, 2, 3, 4, 3, 3, 3, 1, 1, 3, 2, 2, 2, 4, 3, 3, 1, 1, 3, 3, 3, 3, 3, 4, 3, 4, 3, 3, 3, 4, 1, 3, 3, 2, 3, 4, 4, 3, 3, 3)
    hot01_r = @(3, 1, 2, 2, 1, 4, 3, 3, 4, 1, 2, 2, 3, 4, 3, 3, 1, 1, 1, 4, 3, 2, 3, 4, 2, 3, 3, 2, 2, 3, 3, 4, 4, 4, 4, 3, 1, 3, 3, 1, 4, 2, 4, 1, 3, 4, 3, 3, 4, 3)
    hot02_l = @(3, 2, 3, 3, 1, 4, 1, 2, 1, 1, 3, 3, 3, 4, 3, 3, 3, 1, 4, 3, 2, 2, 3, 1, 3, 2, 3, 2, 4, 3, 4, 3, 3, 4, 3, 3, 2, 3, 3, 3, 3, 4, 4, 3, 1, 3, 2, 1, 1, 3)
    hot02_r = @(3, 2, 1, 4, 2, 3, 2, 1, 3, 1, 1, 2, 3, 4, 3, 4, 3, 3, 2, 1, 3, 3, 3, 4, 1, 4, 3, 4, 4, 4, 4, 3, 3, 3, 4, 3, 3, 4, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 4)
    hot03_l = @(3, 2, 1, 4, 4, 2, 1, 4, 3, 3, 3, 3, 3, 4, 1, 4, 1, 3, 3, 4, 4, 4, 3, 4, 1, 3, 3, 3, 4, 3, 3, 3, 4, 4, 3, 4, 3, 3, 3, 4, 4, 3, 3, 2, 3, 3, 3, 4, 2, 3)
    hot03_r = @(3, 3, 4, 4, 3, 2, 1, 4, 2, 3, 3, 2, 3, 1, 2, 1, 3, 3, 4, 3, 3, 3, 3, 3, 2, 3, 2, 3, 3, 3, 3, 3, 3, 4, 3, 4, 3, 4, 1, 3, 4, 4, 4, 4, 4, 4, 4, 3, 4, 2)
    hot04_l = @(3, 2, 3, 3, 1, 2, 1, 1, 4, 3, 3, 3, 4, 3, 1, 2, 3, 3, 1, 3, 3, 3, 3, 1, 3, 1, 3, 2, 3, 1, 3, 3, 3, 2, 1, 3, 2, 1, 3, 3, 4, 3, 3, 4, 4, 3, 1, 4, 3, 3)
    hot04_r = @(2, 1, 2, 2, 4, 3, 1, 2, 4, 1, 3, 3, 1, 4, 2, 3, 3, 2, 3, 3, 4, 4, 2, 4, 1, 3, 4, 3, 3, 4, 2, 4, 3, 3, 3, 4, 3, 3, 3, 2, 3, 3, 4, 3, 3, 3, 3, 4, 4, 1)
    tm03_l = @(4, 3, 3, 1, 1, 4, 2, 3, 1, 1, 3, 4, 3, 1, 1, 4, 3, 1, 4, 3, 3, 4, 1, 1, 4, 3, 1, 2, 3, 4, 1, 3, 4, 2, 3, 4, 1, 4, 2, 1, 2, 4, 3, 4, 3, 1, 2, 2, 3, 3)
    tm03_r = @(2, 1, 3, 1, 2, 3, 4, 3, 1, 3, 1, 1, 2, 3, 4, 1, 3, 4, 2, 1, 4, 1, 1, 1, 4, 4, 3, 2, 4, 2, 1, 1, 3, 3, 3, 1, 4, 2, 2, 1, 2, 2, 1, 4, 3, 1, 2, 2, 3, 3)
    tm04_l = @(4, 2, 1, 4, 4, 3, 4, 4, 1, 1, 2, 2, 3, 1, 1, 4, 4, 4, 2, 2, 3, 3, 2, 3, 2, 3, 1, 2, 4, 2, 4, 3, 4, 3, 4, 4, 2, 4, 2, 3, 2, 3, 4, 2, 4, 3, 2, 2, 1, 3)
    tm04_r = @(2, 1, 4, 4, 3, 3, 2, 2, 2, 1, 2, 3, 3, 1, 4, 4, 2, 4, 2, 2, 3, 2, 1, 2, 3, 1, 3, 3, 3, 4, 1, 2, 4, 2, 1, 4, 3, 2, 2, 3, 4, 1, 4, 1, 3, 2, 3, 2, 1, 3)
    tm05_l = @(1, 3, 4, 4, 4, 3, 4, 3, 2, 1, 3, 2, 2, 2, 2, 4, 4, 2, 4, 4, 3, 1, 3, 2, 2, 1, 1, 2, 3, 3, 2, 4, 1, 2, 2, 2, 4, 3, 2, 4, 4, 1, 4, 3, 1, 4, 2, 3, 1, 4)
    tm05_r = @(2, 4, 4, 2, 3, 3, 1, 2, 2, 4, 1, 1, 1, 4, 1, 1, 3, 2, 1, 2, 4, 4, 3, 4, 4, 2, 3, 4, 1, 3, 4, 4, 3, 1, 4, 4, 2, 3, 2, 3, 2, 4, 2, 2, 4, 1, 1, 2, 4, 3)
}

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
        $c = Clean-Text $p
        if ($c.Length -gt 1 -and -not ($c -match "^(?:\d+\.|\u203B|\[\d|\uB2E4\uC74C\uC744|\uB0A8\uC790\uC758|\uB4E4\uC740|\uC5EC\uC790\uAC00|\uC774 \uAE00\uC758)")) {
            $c = ($c -split "\s+(?:\uC885\uB958|\uD574\uC124|\uB2E8\uC5B4|\uC5B4\uD718|Exp)")[0].Trim()
            if ($c.Length -gt 1) {
                $opts += $c
            }
        }
        if ($opts.Count -eq 4) { break }
    }
    return $opts
}

function Build-Exam($ex) {
    $numStr = $ex.Substring($ex.Length - 2)
    $isTM = $ex.StartsWith("tm")
    $examIdFull = if ($isTM) { "tm_$numStr" } else { "hot_$numStr" }
    $examCat = if ($isTM) { "topik_master" } else { "hot_topik" }
    $audioFolder = if ($isTM) { "de/TOPIK MASTER/TOPIK MASTER_ĐỀ $numStr/audio" } else { "de/Hot topik/HOT TOPIK ĐỎ 2020 ĐỀ $numStr/audio" }

    $ansRaw = Get-Content "scripts/${ex}_ans_full.txt" -Raw -Encoding UTF8
    $deRaw = Get-Content "scripts/${ex}_de_full.txt" -Raw -Encoding UTF8

    $lAnswers = $ANSWERS["${ex}_l"]
    $rAnswers = $ANSWERS["${ex}_r"]

    Write-Host ">>> Processing ${ex} (${examIdFull}) ..."

    # Split sections safely
    if ($isTM) {
        $idxLAns = $ansRaw.IndexOf("Listening")
        if ($idxLAns -lt 0) { $idxLAns = 0 }
        $idxRAns = $ansRaw.IndexOf("Reading", 10000)
        if ($idxRAns -lt 0) { $idxRAns = 38000 }
        $ansListen = $ansRaw.Substring($idxLAns, $idxRAns - $idxLAns)
        $ansRead = $ansRaw.Substring($idxRAns)

        $idxRDe = $deRaw.IndexOf([regex]::Unescape("2\uAD50\uC2DC"))
        if ($idxRDe -lt 0) { $idxRDe = 9000 }
        $deListen = $deRaw.Substring(0, $idxRDe)
        $deRead = $deRaw.Substring($idxRDe)
    } else {
        $p3 = $ansRaw.IndexOf("=== PAGE 3 ===")
        if ($p3 -lt 0) { $p3 = 0 }
        $mRAns = [regex]::Match($ansRaw, [regex]::Unescape("\uC77D\uAE30\s*\(\s*1\uBC88"))
        $idxRAns = if ($mRAns.Success) { $mRAns.Index } else { 27000 }
        $ansListen = $ansRaw.Substring($p3, $idxRAns - $p3)
        $ansRead = $ansRaw.Substring($idxRAns)

        $mRDe = [regex]::Match($deRaw, [regex]::Unescape("\uC77D\uAE30\s*\(\s*1\uBC88"))
        $idxRDe = if ($mRDe.Success) { $mRDe.Index } else { 8300 }
        $deListen = $deRaw.Substring(0, $idxRDe)
        $deRead = $deRaw.Substring($idxRDe)
    }

    # 1. PARSE LISTENING (50 Qs)
    $listening = @()
    for ($q = 1; $q -le 50; $q++) {
        $qNumStr = $q.ToString("D2")
        $inst = Get-Instruction $q "listening"
        $ans = $lAnswers[$q - 1]
        $audio = "${audioFolder}/q${qNumStr}.mp3"
        
        $passage = ""
        $options = @()
        $explanation = [regex]::Unescape("\uC815\uB2F5: ${ans}\uBC88")
        $transcript = @()

        if ($q -le 3) {
            if ($q -eq 1) {
                $options = @(
                    "[Tranh 1] Lựa chọn 1 (tình huống đối thoại)",
                    "[Tranh 2] Lựa chọn 2 (tình huống đối thoại)",
                    "[Tranh 3] Lựa chọn 3 (tình huống đối thoại)",
                    "[Tranh 4] Lựa chọn 4 (tình huống đối thoại)"
                )
            } elseif ($q -eq 2) {
                $options = @(
                    "[Tranh 1] Lựa chọn 1 (tình huống đối thoại)",
                    "[Tranh 2] Lựa chọn 2 (tình huống đối thoại)",
                    "[Tranh 3] Lựa chọn 3 (tình huống đối thoại)",
                    "[Tranh 4] Lựa chọn 4 (tình huống đối thoại)"
                )
            } else {
                $options = @(
                    "[Biểu đồ 1] Khảo sát số liệu 1",
                    "[Biểu đồ 2] Khảo sát số liệu 2",
                    "[Biểu đồ 3] Khảo sát số liệu 3",
                    "[Biểu đồ 4] Khảo sát số liệu 4"
                )
            }
        }

        # Locate question in ansListen
        $qPat = if ($q -eq 1) {
            "(?:\[1~3.*?\])?\s*((?:여자|남자|\uC5EC\uC790|\uB0A8\uC790)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)2\.\s*(?!\d))"
        } elseif ($q -lt 20) {
            "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|$)"
        } elseif ($q -eq 20) {
            "(?:^|\n|\r|\s)20\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)\[21|=== PAGE|$)"
        } else {
            $pairBase = [int]([Math]::Floor(($q - 21) / 2.0) * 2 + 21)
            $nextBase = $pairBase + 2
            "(?:\[${pairBase}~\d+\].*?\n\s*)?((?:여자|남자|\uC5EC\uC790|\uB0A8\uC790)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)${pairBase}\.\s*(?!\d)|$)"
        }

        $m = [regex]::Match($ansListen, $qPat)
        if ($m.Success) {
            $rawBlock = $m.Groups[1].Value
            $diaM = [regex]::Match($rawBlock, "((?:여자|남자|\uC5EC\uC790|\uB0A8\uC790)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|\([0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\)|\uC885\uB958|\uD574\uC124|\uB2E8\uC5B4|\uC5B4\uD718|Exp)|$)")
            if ($diaM.Success) {
                $passage = Clean-Text $diaM.Groups[1].Value
            } else {
                $passage = Clean-Text $rawBlock
            }
            if ($q -gt 3 -and $q -le 20) {
                $opts = Extract-Options $rawBlock
                if ($opts.Count -eq 4) { $options = $opts }
            }
            $explM = [regex]::Match($rawBlock, "(?:\uD574\uC124|Exp)[\s\S]*")
            if ($explM.Success) { $explanation = Clean-Text $explM.Value }
        }

        # For paired questions 21..50
        if ($q -gt 20) {
            $pairPat = "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|\uC885\uB958|\uD574\uC124|\uB2E8\uC5B4|\uC5B4\uD718|=== PAGE|$)"
            $pm = [regex]::Match($ansListen, $pairPat)
            if ($pm.Success) {
                $opts = Extract-Options $pm.Groups[1].Value
                if ($opts.Count -eq 4) { $options = $opts }
            }
        }

        # Fallback to deListen for options if needed
        if ($options.Count -ne 4 -and $q -gt 3) {
            $qDeM = [regex]::Match($deListen, "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|=== PAGE|$)")
            if ($qDeM.Success) {
                $opts = Extract-Options $qDeM.Groups[1].Value
                if ($opts.Count -eq 4) { $options = $opts }
            }
        }

        # Transcripts
        if ($passage) {
            $turns = [regex]::Matches($passage, "(\uC5EC\uC790|\uB0A8\uC790|여자|남자)\s*:\s*([^여자남자\uC5EC\uC790\uB0A8\uC790\n\r]+)")
            foreach ($t in $turns) {
                $transcript += [PSCustomObject]@{
                    speaker = $t.Groups[1].Value
                    text = Clean-Text $t.Groups[2].Value
                }
            }
        }
        if ($transcript.Count -eq 0 -and $passage) {
            $transcript += [PSCustomObject]@{
                speaker = [regex]::Unescape("\uB300\uD654")
                text = $passage
            }
        }

        while ($options.Count -lt 4) {
            $options += [regex]::Unescape("\uC120\uD0DD\uC9C0 $($options.Count + 1)")
        }

        $listening += [PSCustomObject]@{
            id = "${ex}_l_${qNumStr}"
            examId = $examIdFull
            examCategory = $examCat
            section = "listening"
            questionNumber = $q
            instruction = $inst
            passage = $passage
            audioUrl = $audio
            options = $options
            correctAnswer = $ans
            explanation = $explanation
            transcript = $transcript
            vocabulary = @()
        }
    }

    # 2. PARSE READING (50 Qs)
    $reading = @()
    for ($q = 1; $q -le 50; $q++) {
        $qNumStr = $q.ToString("D2")
        $inst = Get-Instruction $q "reading"
        $ans = $rAnswers[$q - 1]
        
        $passage = ""
        $options = @()
        $explanation = [regex]::Unescape("\uC815\uB2F5: ${ans}\uBC88")

        $qPat = "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[\d+~|=== PAGE|$)"
        $m = [regex]::Match($ansRead, $qPat)
        if ($m.Success) {
            $rawBlock = $m.Groups[1].Value
            $opts = Extract-Options $rawBlock
            if ($opts.Count -eq 4) { $options = $opts }
            
            $passageM = [regex]::Match($rawBlock, "^([\s\S]*?)(?=(?:^|\n|\r|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|\([0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\)|[1-4]\s*[\)\.]))")
            if ($passageM.Success) {
                $passage = Clean-Text $passageM.Groups[1].Value
            }
            $explM = [regex]::Match($rawBlock, "(?:\uD574\uC124|Exp)[\s\S]*")
            if ($explM.Success) { $explanation = Clean-Text $explM.Value }
        }

        if ($options.Count -ne 4 -or -not $passage) {
            $mDe = [regex]::Match($deRead, $qPat)
            if ($mDe.Success) {
                $rawDe = $mDe.Groups[1].Value
                if ($options.Count -ne 4) {
                    $opts = Extract-Options $rawDe
                    if ($opts.Count -eq 4) { $options = $opts }
                }
                if (-not $passage) {
                    $pM = [regex]::Match($rawDe, "^([\s\S]*?)(?=(?:^|\n|\r|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|\([0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\)|[1-4]\s*[\)\.]))")
                    if ($pM.Success) { $passage = Clean-Text $pM.Groups[1].Value }
                }
            }
        }

        if (-not $passage) {
            $passage = [regex]::Unescape("\uB2E4\uC74C\uC744 \uC77D\uACE0 \uBB3C\uC74C\uC5D0 \uB2F5\uD558\uC2ED\uC2DC\uC624.")
        }

        while ($options.Count -lt 4) {
            $options += [regex]::Unescape("\uC120\uD0DD\uC9C0 $($options.Count + 1)")
        }

        $reading += [PSCustomObject]@{
            id = "${ex}_r_${qNumStr}"
            examId = $examIdFull
            examCategory = $examCat
            section = "reading"
            questionNumber = $q
            instruction = $inst
            passage = $passage
            audioUrl = $null
            options = $options
            correctAnswer = $ans
            explanation = $explanation
            transcript = @()
            vocabulary = @()
        }
    }

    $examObj = [PSCustomObject]@{
        examId = $examIdFull
        examCategory = $examCat
        listening = $listening
        reading = $reading
    }

    $outFile = "scripts/${ex}_master_questions.json"
    $json = $examObj | ConvertTo-Json -Depth 5
    [System.IO.File]::WriteAllText($outFile, $json, [System.Text.Encoding]::UTF8)

    Write-Host ">>> Done ${ex} : Saved $outFile (L: $($listening.Count), R: $($reading.Count))`n"
}

# Run all 7
$allExams = @("hot01", "hot02", "hot03", "hot04", "tm03", "tm04", "tm05")
foreach ($target in $allExams) {
    Build-Exam $target
}

Write-Host "All 7 exams built successfully!"
