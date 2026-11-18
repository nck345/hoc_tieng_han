# Load master Hot Topik questions
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$masterJson = [System.IO.File]::ReadAllText("scripts/hot05_master_questions.json", $utf8NoBom)
$master = $masterJson | ConvertFrom-Json

function Get-ListeningType($num) {
    if ($num -le 3) { return @{ id = "L_TYPE_1"; name = "Nghe: Chọn tranh hoặc biểu đồ thích hợp" } }
    if ($num -le 8) { return @{ id = "L_TYPE_2"; name = "Nghe: Chọn câu tiếp nối phù hợp" } }
    if ($num -le 12) { return @{ id = "L_TYPE_3"; name = "Nghe: Chọn hành động tiếp theo của người phụ nữ" } }
    if ($num -le 16) { return @{ id = "L_TYPE_4"; name = "Nghe: Chọn nội dung trùng khớp" } }
    if ($num -le 20) { return @{ id = "L_TYPE_5"; name = "Nghe: Chọn suy nghĩ trọng tâm của nhân vật" } }
    return @{ id = "L_TYPE_6"; name = "Nghe: Trả lời câu hỏi sau khi nghe đoạn hội thoại/bài nói" }
}

function Get-ReadingType($num) {
    if ($num -le 2) { return @{ id = "R_TYPE_1"; name = "Đọc: Điền ngữ pháp thích hợp vào chỗ trống" } }
    if ($num -le 4) { return @{ id = "R_TYPE_2"; name = "Đọc: Chọn câu có ý nghĩa tương đương" } }
    if ($num -le 8) { return @{ id = "R_TYPE_3"; name = "Đọc: Xác định chủ đề biển báo/quảng cáo" } }
    if ($num -le 12) { return @{ id = "R_TYPE_4"; name = "Đọc: Chọn nội dung phù hợp với thông tin/biểu đồ" } }
    if ($num -le 15) { return @{ id = "R_TYPE_5"; name = "Đọc: Sắp xếp các câu theo thứ tự đúng" } }
    if ($num -le 18) { return @{ id = "R_TYPE_6"; name = "Đọc: Điền câu/từ thích hợp vào chỗ trống đoạn văn" } }
    if ($num -le 24) { return @{ id = "R_TYPE_7"; name = "Đọc: Đọc hiểu văn bản và trả lời câu hỏi" } }
    if ($num -le 27) { return @{ id = "R_TYPE_8"; name = "Đọc: Giải thích tiêu đề báo chí" } }
    if ($num -le 31) { return @{ id = "R_TYPE_9"; name = "Đọc: Điền nội dung vào chỗ trống bài văn" } }
    if ($num -le 34) { return @{ id = "R_TYPE_10"; name = "Đọc: Chọn nội dung giống với đoạn văn" } }
    if ($num -le 38) { return @{ id = "R_TYPE_11"; name = "Đọc: Chọn chủ đề trọng tâm của đoạn văn" } }
    if ($num -le 41) { return @{ id = "R_TYPE_12"; name = "Đọc: Chọn vị trí thích hợp cho câu mẫu <보기>" } }
    return @{ id = "R_TYPE_13"; name = "Đọc: Đọc hiểu văn bản dài nâng cao" }
}

# Function to build questions for an examId
function Build-ExamQuestions($examId, $examName) {
    $qList = [System.Collections.Generic.List[Object]]::new()
    $prefix = $examId.Replace("_", "")
    
    # 50 Listening Questions
    foreach ($q in $master.listening) {
        $num = [int]$q.questionNumber
        $numStr = "{0:D2}" -f $num
        $t = Get-ListeningType $num
        
        $obj = [PSCustomObject]@{
            id = "${prefix}_l_${numStr}"
            examCategory = "hot_topik"
            examId = $examId
            examTitle = "$examName (Nghe)"
            section = "listening"
            questionNumber = $num
            typeId = $t.id
            typeName = $t.name
            instruction = $q.instruction
            passage = $q.passage
            audioUrl = $q.audioUrl
            options = $q.options
            correctAnswer = $q.correctAnswer
            isAiAnswer = $false
            explanation = $q.explanation
            transcript = $q.transcript
            vocabulary = @()
        }
        $qList.Add($obj)
    }
    
    # 50 Reading Questions
    foreach ($q in $master.reading) {
        $num = [int]$q.questionNumber
        $numStr = "{0:D2}" -f $num
        $t = Get-ReadingType $num
        
        $obj = [PSCustomObject]@{
            id = "${prefix}_r_${numStr}"
            examCategory = "hot_topik"
            examId = $examId
            examTitle = "$examName (Đọc)"
            section = "reading"
            questionNumber = $num
            typeId = $t.id
            typeName = $t.name
            instruction = $q.instruction
            passage = $q.passage
            audioUrl = $null
            options = $q.options
            correctAnswer = $q.correctAnswer
            isAiAnswer = $false
            explanation = $q.explanation
            grammar = @()
            vocabulary = @()
        }
        $qList.Add($obj)
    }
    
    return $qList
}

$hot05Questions = Build-ExamQuestions "hot_05" "HOT TOPIK ĐỎ ĐỀ 05"
$hot01Questions = Build-ExamQuestions "hot_01" "HOT TOPIK ĐỎ ĐỀ 01"

Write-Host "Built hot_05: $($hot05Questions.Count) questions"
Write-Host "Built hot_01: $($hot01Questions.Count) questions"

# Load current js/exam_data.js
$raw = [System.IO.File]::ReadAllText("js/exam_data.js", $utf8NoBom)
$jsonStr = $raw.Substring($raw.IndexOf('{'))
$jsonStr = $jsonStr.Substring(0, $jsonStr.LastIndexOf('}') + 1)
$data = $jsonStr | ConvertFrom-Json

# Filter out old hot_topik questions
$kept = [System.Collections.Generic.List[Object]]::new()
foreach ($q in $data.questions) {
    if ($q.examCategory -ne "hot_topik" -and -not ($q.id -like "hot*")) {
        $kept.Add($q)
    }
}
Write-Host "Kept $($kept.Count) non-hot_topik questions"

# Append all hot_05 and hot_01 questions
foreach ($q in $hot05Questions) { $kept.Add($q) }
foreach ($q in $hot01Questions) { $kept.Add($q) }

$data.questions = $kept.ToArray()
Write-Host "Total questions after merge: $($data.questions.Count)"

# Backup exam_data.js
Copy-Item "js/exam_data.js" "js/exam_data.js.bak_hot" -Force

# Serialize to json
$newJson = $data | ConvertTo-Json -Depth 20
$newJsContent = "window.EXAM_DATA = " + $newJson + ";"
[System.IO.File]::WriteAllText("js/exam_data.js", $newJsContent, $utf8NoBom)
Write-Host "Successfully updated js/exam_data.js!"
