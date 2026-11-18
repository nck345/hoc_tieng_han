param([string]$targetExam)

$numStr = $targetExam.Substring($targetExam.Length - 2)
$isTM = $targetExam.StartsWith("tm")
$examId = if ($isTM) { "tm_$numStr" } else { "hot_$numStr" }
$examCat = if ($isTM) { "topik_master" } else { "hot_topik" }
$audioFolder = if ($isTM) { "de/TOPIK MASTER/TOPIK MASTER_ĐỀ $numStr/audio" } else { "de/Hot topik/HOT TOPIK ĐỎ 2020 ĐỀ $numStr/audio" }

$ansRaw = Get-Content "scripts/${targetExam}_ans_full.txt" -Raw -Encoding UTF8
$deRaw = Get-Content "scripts/${targetExam}_de_full.txt" -Raw -Encoding UTF8

Write-Host "Target: $targetExam ($examId) -> Ans: $($ansRaw.Length), De: $($deRaw.Length)"

# Let's inspect all dialogue turns in ansRaw
$dialogueTurns = [regex]::Matches($ansRaw, "(?:여자|남자)\s*[:\s]\s*([^\n\r]+)")
Write-Host "Total dialogue turns found in ans: $($dialogueTurns.Count)"
