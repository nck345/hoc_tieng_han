$lines = Get-Content "js\exam_data.js" -Encoding UTF8
$inQuestions = $false
$currentId = ""
$currentExamId = ""
$qStarts = @()
for ($i = 310; $i -lt 1788; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*"id":\s*"(.*)",') {
        $currentId = $matches[1]
    }
    if ($line -match '^\s*"examId":\s*"(.*)",') {
        $currentExamId = $matches[1]
        Write-Host "Q: $currentId, examId: $currentExamId (around line $($i+1))"
    }
}
