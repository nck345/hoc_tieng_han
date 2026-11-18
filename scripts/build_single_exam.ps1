param(
    [string]$targetExam
)

$ErrorActionPreference = "Stop"

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

function Extract-Options($text) {
    $bulletRegex = "(?:^|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|(?:\(\s*[0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\s*\))|(?:[1-4]\s*[\)\.]))\s*"
    $parts = [regex]::Split($text, $bulletRegex)
    $opts = @()
    foreach ($p in $parts) {
        $c = Clean-Str $p
        if ($c.Length -gt 1 -and -not ($c -match "^(?:\d+\.|\※|\[\d|다음을|남자의|들은|여자가|이 글의)")) {
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

Write-Host "Building ${targetExam} (${examIdFull}) ..."

# --- Split sections ---
if ($isTM) {
    $idxLAns = $ansRaw.IndexOf("Listening")
    $idxRAns = $ansRaw.IndexOf("Reading [1-2]")
    if ($idxRAns -lt 0) { $idxRAns = 40000 }
    $ansListen = $ansRaw.Substring($idxLAns, $idxRAns - $idxLAns)
    $ansRead = $ansRaw.Substring($idxRAns)

    $idxRDe = $deRaw.IndexOf("2교시")
    $deListen = $deRaw.Substring(0, $idxRDe)
    $deRead = $deRaw.Substring($idxRDe)
} else {
    $p3 = $ansRaw.IndexOf("=== PAGE 3 ===")
    $idxRAns = $ansRaw.IndexOf("읽기 (1번~50번)")
    $ansListen = $ansRaw.Substring($p3, $idxRAns - $p3)
    $ansRead = $ansRaw.Substring($idxRAns)

    $idxRDe = $deRaw.IndexOf("읽기 (1번~50번)")
    $deListen = $deRaw.Substring(0, $idxRDe)
    $deRead = $deRaw.Substring($idxRDe)
}

# --- PARSE 50 LISTENING QUESTIONS ---
$listening = @()
for ($q = 1; $q -le 50; $q++) {
    $qNumStr = $q.ToString("D2")
    $inst = Get-Instruction $q "listening"
    $ans = $lAnswers[$q - 1]
    $audio = "${audioFolder}/q${qNumStr}.mp3"
    
    # 1. Dialogue / Passage
    $passage = ""
    $transcript = @()
    $options = @()
    $explanation = "정답: ${ans}번"
    
    if ($q -le 3) {
        if ($q -eq 1) {
            $options = @(
                "[Tranh 1] Người nam và nữ gặp nhau trò chuyện",
                "[Tranh 2] Tình huống đối thoại 2",
                "[Tranh 3] Tình huống đối thoại 3",
                "[Tranh 4] Tình huống đối thoại 4"
            )
        } elseif ($q -eq 2) {
            $options = @(
                "[Tranh 1] Lựa chọn 1",
                "[Tranh 2] Lựa chọn 2",
                "[Tranh 3] Lựa chọn 3",
                "[Tranh 4] Lựa chọn 4"
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
    
    # Search for question block in ansListen
    $pat = if ($q -eq 1) {
        "(?:\[1~3.*?\])?\s*((?:여자|남자)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)2\.\s*(?!\d))"
    } elseif ($q -lt 20) {
        "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|$)"
    } elseif ($q -eq 20) {
        "(?:^|\n|\r|\s)20\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)\[21|=== PAGE|$)"
    } else {
        # Paired questions 21..50
        $pairBase = [int]([Math]::Floor(($q - 21) / 2.0) * 2 + 21)
        $nextBase = $pairBase + 2
        "(?:\[${pairBase}~\d+\].*?\n\s*)?((?:여자|남자)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)${pairBase}\.\s*(?!\d)|$)"
    }
    
    $m = [regex]::Match($ansListen, $pat)
    if ($m.Success) {
        $rawBlock = $m.Groups[1].Value
        # Extract dialogue
        $diaM = [regex]::Match($rawBlock, "((?:여자|남자)\s*:[\s\S]*?)(?=(?:^|\n|\r|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|\([0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\)|종류|해설|단어|어휘|Exp)|$)")
        if ($diaM.Success) {
            $passage = Clean-Str $diaM.Groups[1].Value
        } else {
            $passage = Clean-Str $rawBlock
        }
        
        # Options if q > 3
        if ($q -gt 3 -and $q -le 20) {
            $opts = Extract-Options $rawBlock
            if ($opts.Count -eq 4) { $options = $opts }
        }
        
        # Explanation
        $explM = [regex]::Match($rawBlock, "(?:해설|Exp)[\s\S]*")
        if ($explM.Success) {
            $explanation = Clean-Str $explM.Value
        }
    }
    
    # For paired questions 21..50, search option and question prompt
    if ($q -gt 20) {
        $qPat = "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|종류|해설|단어|어휘|=== PAGE|$)"
        $qMatch = [regex]::Match($ansListen, $qPat)
        if ($qMatch.Success) {
            $opts = Extract-Options $qMatch.Groups[1].Value
            if ($opts.Count -eq 4) { $options = $opts }
        }
        if ($options.Count -ne 4) {
            # Try deListen
            $qDeM = [regex]::Match($deListen, "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|=== PAGE|$)")
            if ($qDeM.Success) {
                $opts = Extract-Options $qDeM.Groups[1].Value
                if ($opts.Count -eq 4) { $options = $opts }
            }
        }
    }
    
    # If options still < 4, extract from deListen for any question
    if ($options.Count -ne 4 -and $q -gt 3) {
        $qDeM = [regex]::Match($deListen, "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[|=== PAGE|$)")
        if ($qDeM.Success) {
            $opts = Extract-Options $qDeM.Groups[1].Value
            if ($opts.Count -eq 4) { $options = $opts }
        }
    }
    
    # Parse transcript
    if ($passage) {
        $turns = [regex]::Matches($passage, "(여자|남자)\s*:\s*([^여자남자\n\r]+)")
        foreach ($t in $turns) {
            $transcript += [PSCustomObject]@{
                speaker = $t.Groups[1].Value
                text = Clean-Str $t.Groups[2].Value
            }
        }
    }
    if ($transcript.Count -eq 0 -and $passage) {
        $transcript += [PSCustomObject]@{
            speaker = "대화"
            text = $passage
        }
    }
    
    # Ensure 4 valid options
    while ($options.Count -lt 4) {
        $options += "선택지 $($options.Count + 1)"
    }
    
    $listening += [PSCustomObject]@{
        id = "${targetExam}_l_${qNumStr}"
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

# --- PARSE 50 READING QUESTIONS ---
$reading = @()
for ($q = 1; $q -le 50; $q++) {
    $qNumStr = $q.ToString("D2")
    $inst = Get-Instruction $q "reading"
    $ans = $rAnswers[$q - 1]
    
    $passage = ""
    $options = @()
    $explanation = "정답: ${ans}번"
    
    # Search in ansRead or deRead
    $qPat = "(?:^|\n|\r|\s)${q}\.\s*(?!\d)([\s\S]*?)(?=(?:^|\n|\r|\s)$($q+1)\.\s*(?!\d)|\[\d+~|=== PAGE|$)"
    $m = [regex]::Match($ansRead, $qPat)
    if ($m.Success) {
        $rawBlock = $m.Groups[1].Value
        $opts = Extract-Options $rawBlock
        if ($opts.Count -eq 4) { $options = $opts }
        
        # Passage
        $passageM = [regex]::Match($rawBlock, "^([\s\S]*?)(?=(?:^|\n|\r|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩@]|\([0-9\uAE30\uC774\uC804\uACFC\uC384\uC1E0\uACB0\u3141\u3139]\)|[1-4]\s*[\)\.]))")
        if ($passageM.Success) {
            $passage = Clean-Str $passageM.Groups[1].Value
        }
        
        $explM = [regex]::Match($rawBlock, "(?:해설|Exp)[\s\S]*")
        if ($explM.Success) {
            $explanation = Clean-Str $explM.Value
        }
    }
    
    # Fallback to deRead
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
                if ($pM.Success) { $passage = Clean-Str $pM.Groups[1].Value }
            }
        }
    }
    
    if (-not $passage) {
        $passage = "다음을 읽고 물음에 답하십시오."
    }
    
    while ($options.Count -lt 4) {
        $options += "선택지 $($options.Count + 1)"
    }
    
    $reading += [PSCustomObject]@{
        id = "${targetExam}_r_${qNumStr}"
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

$outJsonPath = "scripts/${targetExam}_master_questions.json"
$jsonStr = $examObj | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText($outJsonPath, $jsonStr, [System.Text.Encoding]::UTF8)

Write-Host "Success! Created $outJsonPath (Listening: $($listening.Count), Reading: $($reading.Count))"
