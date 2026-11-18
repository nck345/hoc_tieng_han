$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines("js\app.js", $utf8))

# 1. Update audioFile check in renderExamCategoryDetail
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains('ex.audioFile?')) {
        $lines[$i] = $lines[$i].Replace('ex.audioFile?', 'ex.audioFile||ex.hasSeparatedAudio?')
        Write-Host "Updated audioFile check at line $($i+1)"
        break
    }
}

# 2. Update startExamFromItem
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains('startExamFromItem(cat,ex){')) {
        $inject = @(
            "`t`tconst directQuestions=(this.examData.questions||[]).filter(q=>q.examId===ex.id);",
            "`t`tif(directQuestions.length>0){",
            "`t`t`tthis.currentExamPack=null;",
            "`t`t`tthis.activeExamQuestions=directQuestions;",
            "`t`t`tthis.activeExamQuestionIndex=0;",
            "`t`t`tthis.openExamPlayer(ex.name + ' (' + directQuestions.length + ' c' + String.fromCharCode(226) + 'u)');",
            "`t`t`treturn;",
            "`t`t}"
        )
        for ($k = $inject.Length - 1; $k -ge 0; $k--) {
            $lines.Insert($i + 1, $inject[$k])
        }
        Write-Host "Injected directQuestions check after line $($i+1)"
        break
    }
}

# 3. Update qInstruction with secLabel
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains('this.examEls.qInstruction.textContent=') -and $lines[$i].Contains('q.section===')) {
        $secLabelLine = "`t`tconst secLabel=q.section==='listening'?'K' + String.fromCharCode(7929) + ' n' + String.fromCharCode(259) + 'ng Nghe':(q.section==='writing'?'K' + String.fromCharCode(7929) + ' n' + String.fromCharCode(259) + 'ng Vi' + String.fromCharCode(7871) + 't':'K' + String.fromCharCode(7929) + ' n' + String.fromCharCode(259) + 'ng ' + String.fromCharCode(272) + String.fromCharCode(7885) + 'c');"
        $newQInst = "`t`tthis.examEls.qInstruction.textContent='[' + secLabel + '] ' + (q.instruction||'');"
        $lines[$i] = $secLabelLine
        $lines.Insert($i + 1, $newQInst)
        Write-Host "Updated qInstruction at line $($i+1)"
        break
    }
}

# 4. Update btnNextQ completion label
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains('btnNextQ.textContent') -and $lines[$i].Contains('total-1')) {
        $lines[$i] = "`t`tthis.examEls.btnNextQ.textContent=this.activeExamQuestionIndex===total-1?(this.currentExamPack?'Ho' + String.fromCharCode(224) + 'n th' + String.fromCharCode(224) + 'nh g' + String.fromCharCode(243) + 'i ' + String.fromCharCode(273) + String.fromCharCode(7873):'Ho' + String.fromCharCode(224) + 'n th' + String.fromCharCode(224) + 'nh ' + String.fromCharCode(273) + String.fromCharCode(7873) + ' thi'):('C' + String.fromCharCode(226) + 'u ti' + String.fromCharCode(7871) + 'p theo \u2192');"
        Write-Host "Updated btnNextQ at line $($i+1)"
        break
    }
}

[System.IO.File]::WriteAllLines("js\app.js", $lines, $utf8)
Write-Host "Successfully patched js\app.js!"
