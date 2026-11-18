param(
    [string]$targetExam = "hot01"
)

. (Join-Path $PSScriptRoot "builder_helpers.ps1")

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

function Clean-Str($s) {
    if (-not $s) { return "" }
    $s = $s -replace "[\r\n]+", " "
    $s = $s -replace "\s+", " "
    return $s.Trim()
}

function Extract-OptionsFromText($text) {
    $bulletRegex = "(?:^|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|(?:\(\s*[0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\s*\))|(?:[1-4]\s*[\)\.]))\s*"
    $parts = [regex]::Split($text, $bulletRegex)
    $opts = @()
    foreach ($p in $parts) {
        $c = Clean-Str $p
        if ($c.Length -gt 1 -and -not ($c -match "^(?:\d+\.|\※|\[\d|다음을|남자의|들은|여자가)")) {
            $c = ($c -split "\s+(?:종류|해설|단어|어휘|Exp)")[0].Trim()
            if ($c.Length -gt 1) {
                $opts += $c
            }
        }
        if ($opts.Count -eq 4) { break }
    }
    return $opts
}

$numStr = $targetExam.Substring($targetExam.Length - 2)
$isTM = $targetExam.StartsWith("tm")
$examIdFull = if ($isTM) { "tm_$numStr" } else { "hot_$numStr" }
$examCat = if ($isTM) { "topik_master" } else { "hot_topik" }
$audioFolder = if ($isTM) { "de/TOPIK MASTER/TOPIK MASTER_ĐỀ $numStr/audio" } else { "de/Hot topik/HOT TOPIK ĐỎ 2020 ĐỀ $numStr/audio" }

$ansRaw = Get-Content "scripts/${targetExam}_ans_full.txt" -Raw -Encoding UTF8
$deRaw = Get-Content "scripts/${targetExam}_de_full.txt" -Raw -Encoding UTF8

$lAnswers = $ANSWERS["${targetExam}_l"]
$rAnswers = $ANSWERS["${targetExam}_r"]

Write-Host "Building $targetExam: Answers L=$($lAnswers.Count), R=$($rAnswers.Count)"
