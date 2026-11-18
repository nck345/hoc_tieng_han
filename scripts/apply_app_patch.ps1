$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.Collections.Generic.List[string]]([System.IO.File]::ReadAllLines("js\app.js", $utf8))

# 1. Update audioFile check in renderExamCategoryDetail
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains("ex.audioFile?")) {
        $lines[$i] = $lines[$i].Replace("ex.audioFile?", "ex.audioFile||ex.hasSeparatedAudio?")
        Write-Host "Updated audioFile check at line $($i+1)"
        break
    }
}

# 2. Update startExamFromItem
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains("startExamFromItem(cat,ex){")) {
        $inject = @(
            "`t`tconst directQuestions=(this.examData.questions||[]).filter(q=>q.examId===ex.id);",
            "`t`tif(directQuestions.length>0){",
            "`t`t`tthis.currentExamPack=null;",
            "`t`t`tthis.activeExamQuestions=directQuestions;",
            "`t`t`tthis.activeExamQuestionIndex=0;",
            "`t`t`tthis.openExamPlayer(`${ex.name} (${directQuestions.length} c" + [char]0x00E2 + "u)`);",
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
    if ($lines[$i].Contains("this.examEls.qInstruction.textContent=") -and $lines[$i].Contains("q.section===")) {
        $secLabelLine = "`t`tconst secLabel=q.section===""listening""?""K" + [char]0x1EF9 + " n" + [char]0x0103 + "ng Nghe"":(q.section===""writing""?""K" + [char]0x1EF9 + " n" + [char]0x0103 + "ng Vi" + [char]0x1EBF + "t"":""K" + [char]0x1EF9 + " n" + [char]0x0103 + "ng " + [char]0x0110 + [char]0x1ECD + "c"");"
        $newQInst = "`t`tthis.examEls.qInstruction.textContent=`[${secLabel}] ${q.instruction||""""}`;"
        $lines[$i] = $secLabelLine
        $lines.Insert($i + 1, $newQInst)
        Write-Host "Updated qInstruction at line $($i+1)"
        break
    }
}

# 4. Update btnNextQ completion label
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i].Contains("btnNextQ.textContent") -and $lines[$i].Contains("total-1")) {
        $lines[$i] = "`t`tthis.examEls.btnNextQ.textContent=this.activeExamQuestionIndex===total-1?(this.currentExamPack?""Ho" + [char]0x00E0 + "n th" + [char]0x00E0 + "nh g" + [char]0x00F3 + "i " + [char]0x0111 + [char]0x1EC1 + """:""Ho" + [char]0x00E0 + "n th" + [char]0x00E0 + "nh " + [char]0x0111 + [char]0x1EC1 + " thi""):(""C" + [char]0x00E2 + "u ti" + [char]0x1EBF + "p theo " + [char]0x2192 + """);"
        Write-Host "Updated btnNextQ at line $($i+1)"
        break
    }
}

[System.IO.File]::WriteAllLines("js\app.js", $lines, $utf8)
Write-Host "Successfully patched js\app.js!"
