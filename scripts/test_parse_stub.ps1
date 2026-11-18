param([string]$examId)

$isTM = $examId.StartsWith("tm")
$numStr = $examId.Substring(2)
$cat = if ($isTM) { "topik_master" } else { "hot_topik" }
$fullExamId = if ($isTM) { "tm_$numStr" } else { "hot_$numStr" }
$audioFolder = if ($isTM) { "de/TOPIK MASTER/TOPIK MASTER_ĐỀ $numStr/audio" } else { "de/Hot topik/HOT TOPIK ĐỎ 2020 ĐỀ $numStr/audio" }

Write-Host "Parsing $examId -> $fullExamId ($cat) ..."
