$l1 = Get-Content -Raw -Encoding UTF8 scripts/topik96_data/listening_part1.json | ConvertFrom-Json
$l2 = Get-Content -Raw -Encoding UTF8 scripts/topik96_data/listening_part2.json | ConvertFrom-Json
$r1 = Get-Content -Raw -Encoding UTF8 scripts/topik96_data/reading_part1.json | ConvertFrom-Json
$r2 = Get-Content -Raw -Encoding UTF8 scripts/topik96_data/reading_part2.json | ConvertFrom-Json

# Read current exam_data.js
$raw = Get-Content -Raw -Encoding UTF8 js/exam_data.js
$jsonStr = $raw.Substring($raw.IndexOf('{'))
$jsonStr = $jsonStr.Substring(0, $jsonStr.LastIndexOf('}') + 1)
$data = $jsonStr | ConvertFrom-Json

# Collect authentic existing tm_01 reading questions
$existingTmR = @{}
foreach ($q in $data.questions) {
    if ($q.examId -eq "tm_01" -or $q.id -like "tm01_r_*") {
        $num = [int]$q.questionNumber
        $existingTmR[$num] = $q
    }
}

# 1. Build 50 Listening Questions for TOPIK MASTER
$tmListening = [System.Collections.Generic.List[Object]]::new()
$allL = @($l1) + @($l2)
foreach ($q in $allL) {
    $num = [int]$q.questionNumber
    $qCopy = [PSCustomObject]@{
        id = "tm01_l_$($num.ToString('D2'))"
        examCategory = "topik_master"
        examId = "tm_01"
        examTitle = "TOPIK MASTER ĐỀ 01 (Nghe)"
        section = "listening"
        questionNumber = $num
        typeId = $q.typeId
        typeName = $q.typeName
        instruction = $q.instruction
        passage = $q.passage
        audioUrl = $null
        options = $q.options
        correctAnswer = $q.correctAnswer
        isAiAnswer = $q.isAiAnswer
        explanation = $q.explanation
        transcript = $q.transcript
        grammar = $q.grammar
        vocabulary = $q.vocabulary
    }
    $tmListening.Add($qCopy)
}

# 2. Build 50 Reading Questions for TOPIK MASTER
$tmReading = [System.Collections.Generic.List[Object]]::new()
$allR = @($r1) + @($r2)
foreach ($q in $allR) {
    $num = [int]$q.questionNumber
    if ($existingTmR.ContainsKey($num)) {
        $orig = $existingTmR[$num]
        $qCopy = [PSCustomObject]@{
            id = "tm01_r_$($num.ToString('D2'))"
            examCategory = "topik_master"
            examId = "tm_01"
            examTitle = "TOPIK MASTER ĐỀ 01 (Đọc)"
            section = "reading"
            questionNumber = $num
            typeId = $orig.typeId
            typeName = $orig.typeName
            instruction = $orig.instruction
            passage = $orig.passage
            audioUrl = $null
            options = $orig.options
            correctAnswer = $orig.correctAnswer
            isAiAnswer = $orig.isAiAnswer
            explanation = $orig.explanation
            transcript = $orig.transcript
            grammar = $orig.grammar
            vocabulary = $orig.vocabulary
        }
    } else {
        $qCopy = [PSCustomObject]@{
            id = "tm01_r_$($num.ToString('D2'))"
            examCategory = "topik_master"
            examId = "tm_01"
            examTitle = "TOPIK MASTER ĐỀ 01 (Đọc)"
            section = "reading"
            questionNumber = $num
            typeId = $q.typeId
            typeName = $q.typeName
            instruction = $q.instruction
            passage = $q.passage
            audioUrl = $null
            options = $q.options
            correctAnswer = $q.correctAnswer
            isAiAnswer = $q.isAiAnswer
            explanation = $q.explanation
            transcript = $q.transcript
            grammar = $q.grammar
            vocabulary = $q.vocabulary
        }
    }
    $tmReading.Add($qCopy)
}

Write-Host "Created TM Listening count: $($tmListening.Count)"
Write-Host "Created TM Reading count: $($tmReading.Count)"

# Filter out old tm_01 questions from data.questions
$filteredQs = [System.Collections.Generic.List[Object]]::new()
foreach ($q in $data.questions) {
    if ($q.examId -ne "tm_01" -and $q.examCategory -ne "topik_master" -and $q.id -notlike "tm01_*") {
        $filteredQs.Add($q)
    }
}

# Append new 50 listening and 50 reading
foreach ($q in $tmListening) { $filteredQs.Add($q) }
foreach ($q in $tmReading) { $filteredQs.Add($q) }

Write-Host "Total questions after merge: $($filteredQs.Count)"

$data.questions = $filteredQs

# Serialize back to JSON
$newJson = $data | ConvertTo-Json -Depth 10
$finalJs = "window.EXAM_DATA = " + $newJson + ";"

# Write backup first
Copy-Item js/exam_data.js js/exam_data.js.bak -Force

[System.IO.File]::WriteAllText("f:\github\hoc_tieng_han\js\exam_data.js", $finalJs, [System.Text.Encoding]::UTF8)

Write-Host "Updated js/exam_data.js successfully!"
