[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$utf8 = [System.Text.Encoding]::UTF8
$content = [System.IO.File]::ReadAllText("js\app.js", $utf8)

# 1. Update renderExamCategoryDetail audio badge
$target1 = '${ex.audioFile?`<span>🔊 Có file nghe mp3</span>`:""}'
$replace1 = '${ex.audioFile||ex.hasSeparatedAudio?`<span>🔊 Có file nghe mp3</span>`:""}'
if ($content.Contains($target1)) {
    $content = $content.Replace($target1, $replace1)
    Write-Host "Replaced target1"
} else {
    Write-Host "Target1 not found"
}

# 2. Update startExamFromItem
$target2 = '	startExamFromItem(cat,ex){
		let qList=[];'
$replace2 = '	startExamFromItem(cat,ex){
		const directQuestions=(this.examData.questions||[]).filter(q=>q.examId===ex.id);
		if(directQuestions.length>0){
			this.currentExamPack=null;
			this.activeExamQuestions=directQuestions;
			this.activeExamQuestionIndex=0;
			this.openExamPlayer(`${ex.name} (${directQuestions.length} câu)`);
			return;
		}
		let qList=[];'

# Normalize newlines for replacement matching
$contentNorm = $content -replace "`r`n", "`n"
$target2Norm = $target2 -replace "`r`n", "`n"
$replace2Norm = $replace2 -replace "`r`n", "`n"

if ($contentNorm.Contains($target2Norm)) {
    $contentNorm = $contentNorm.Replace($target2Norm, $replace2Norm)
    Write-Host "Replaced target2"
} else {
    Write-Host "Target2 not found"
}

# 3. Update section label in renderActiveExamQuestion
$target3Norm = 'this.examEls.qInstruction.textContent=`[${q.section==="listening"?"Kỹ năng Nghe":"Kỹ năng Đọc"}] ${q.instruction||""}`;'
$replace3Norm = 'const secLabel=q.section==="listening"?"Kỹ năng Nghe":(q.section==="writing"?"Kỹ năng Viết":"Kỹ năng Đọc");`n		this.examEls.qInstruction.textContent=`[${secLabel}] ${q.instruction||""}`;'

if ($contentNorm.Contains($target3Norm)) {
    $contentNorm = $contentNorm.Replace($target3Norm, $replace3Norm)
    Write-Host "Replaced target3"
} else {
    Write-Host "Target3 not found"
}

# 4. Update button text for exam finish
$target4Norm = 'this.examEls.btnNextQ.textContent=this.activeExamQuestionIndex===total-1?"Hoàn thành gói đề":"Câu tiếp theo →";'
$replace4Norm = 'this.examEls.btnNextQ.textContent=this.activeExamQuestionIndex===total-1?(this.currentExamPack?"Hoàn thành gói đề":"Hoàn thành đề thi"):"Câu tiếp theo →";'

if ($contentNorm.Contains($target4Norm)) {
    $contentNorm = $contentNorm.Replace($target4Norm, $replace4Norm)
    Write-Host "Replaced target4"
} else {
    Write-Host "Target4 not found"
}

# Backup app.js
Copy-Item "js\app.js" "js\app.js.bak" -Force

# Write updated file
$finalContent = $contentNorm -replace "`n", "`r`n"
[System.IO.File]::WriteAllText("js\app.js", $finalContent, (New-Object System.Text.UTF8Encoding $false))
Write-Host "Successfully updated js\app.js!"
