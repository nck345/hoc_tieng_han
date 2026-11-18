$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$testHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
    <iframe id="appFrame" src="../index.html" style="width:1200px;height:800px;"></iframe>
    <pre id="results">RUNNING</pre>
    <script>
    window.addEventListener('load', () => {
        setTimeout(async () => {
            const results = [];
            const doc = document.getElementById('appFrame').contentDocument;
            const win = document.getElementById('appFrame').contentWindow;
            const app = win.app;
            
            try {
                // Test 1: Category & Questions in Data
                const cat = win.EXAM_DATA.categories.find(c => c.id === 'hot_topik');
                results.push('Test 1 - Category found: ' + (cat ? 'PASS (' + cat.name + ')' : 'FAIL'));
                
                const hotQs = win.EXAM_DATA.questions.filter(q => q.examId === 'hot_05');
                const hotL = hotQs.filter(q => q.section === 'listening');
                const hotR = hotQs.filter(q => q.section === 'reading');
                results.push('Test 2 - Questions count hot_05: Total=' + hotQs.length + ' L=' + hotL.length + ' R=' + hotR.length + 
                    (hotL.length === 50 && hotR.length === 50 ? ' PASS' : ' FAIL'));
                
                const hot01Qs = win.EXAM_DATA.questions.filter(q => q.examId === 'hot_01');
                results.push('Test 2b - Questions count hot_01: Total=' + hot01Qs.length + 
                    (hot01Qs.length === 100 ? ' PASS' : ' FAIL'));
                
                // Test 3: Check authentic Hot Topik Listening content
                const q1 = hotL[0];
                const isJiMin = q1.passage.includes('김지민');
                results.push('Test 3 - Authentic Hot Topik Listening Q1 (Kim Ji-min): ' + (isJiMin ? 'PASS' : 'FAIL'));
                results.push('Test 3b - Audio exists: ' + (q1.audioUrl.includes('Hot topik') ? 'PASS (' + q1.audioUrl + ')' : 'FAIL'));
                results.push('Test 3c - Correct Answer Q1: ' + (q1.correctAnswer === 2 ? 'PASS (ans=2)' : 'FAIL'));
                
                const q29 = hotL[28];
                const isCoach = q29.options.includes('축구 감독');
                results.push('Test 3d - Authentic Hot Topik Listening Q29 (soccer coach): ' + (isCoach && q29.correctAnswer === 3 ? 'PASS' : 'FAIL'));
                
                // Test 4: Check authentic Hot Topik Reading content
                const rq1 = hotR[0];
                const isGojah = rq1.passage.includes('도착') || rq1.options.includes('도착하고자');
                results.push('Test 4 - Authentic Hot Topik Reading Q1 (-고자): ' + (isGojah && rq1.correctAnswer === 3 ? 'PASS' : 'FAIL'));
                
                const rq42 = hotR[41];
                const isSoonam = rq42.passage.includes('수남') || rq42.options.includes('섭섭하다');
                results.push('Test 4b - Authentic Hot Topik Reading Q42 (Soonam): ' + (isSoonam && rq42.correctAnswer === 1 ? 'PASS' : 'FAIL'));
                
                // Test 5: Switch to Exam View & Select Hot Topik Category
                app.switchView('exam');
                app.currentExamCategory = cat;
                app.renderExamView();
                
                const folderTitle = doc.getElementById('exam-folder-detail-title');
                results.push('Test 5 - Folder detail title: ' + (folderTitle && folderTitle.textContent.includes('HOT TOPIK') ? 'PASS' : 'FAIL'));
                
                // Test 6: Check Part 1 Nghe and Part 2 Doc buttons in detail grid
                const card = doc.querySelector('.exam-card');
                const listenBtn = card ? card.querySelector('.btn-part-listen') : null;
                const readBtn = card ? card.querySelector('.btn-part-read') : null;
                results.push('Test 6 - Part buttons rendered: ' + (listenBtn && readBtn ? 'PASS' : 'FAIL'));
                
                // Test 7: Start Listening Part
                listenBtn.click();
                results.push('Test 7 - Active player displayed: ' + (app.examEls.activePlayer.style.display !== 'none' ? 'PASS' : 'FAIL'));
                results.push('Test 7b - Questions loaded in active exam: ' + (app.activeExamQuestions.length === 50 ? 'PASS (50 questions)' : 'FAIL (' + app.activeExamQuestions.length + ')'));
                
                // Test 8: Subtitle visibility before answer
                const subBox = doc.getElementById('exam-subtitles-box');
                const subHiddenBefore = subBox && (subBox.style.display === 'none' || subBox.classList.contains('hidden'));
                results.push('Test 8 - Subtitles hidden before answer submission: ' + (subHiddenBefore ? 'PASS' : 'FAIL'));
                
                // Test 9: Answer Question 1 (Select option 2)
                const optBtn = doc.querySelectorAll('.exam-option-btn')[1]; // option 2
                if (optBtn) {
                    optBtn.click();
                    const subHiddenAfter = subBox && (subBox.style.display === 'none' || subBox.classList.contains('hidden'));
                    results.push('Test 9 - Subtitles revealed after answer: ' + (!subHiddenAfter ? 'PASS' : 'FAIL'));
                } else {
                    results.push('Test 9 - Option button not found: FAIL');
                }
                
                // Test 10: Exit exam (No progress saved)
                const exitBtn = doc.getElementById('btn-exit-exam');
                if (exitBtn) exitBtn.click();
                results.push('Test 10 - In-progress discarded on exit (activeExam=null): ' + (app.activeExam === null ? 'PASS' : 'FAIL'));
                
                // Test 11: Final Score on Finish
                // Start Reading part
                const cardAfter = doc.querySelector('.exam-card');
                const readBtnAfter = cardAfter ? cardAfter.querySelector('.btn-part-read') : null;
                if (readBtnAfter) {
                    readBtnAfter.click();
                    // Answer all questions quickly to trigger complete
                    for (let i = 0; i < app.activeExamQuestions.length; i++) {
                        app.userAnswers[app.activeExamQuestions[i].id] = 1;
                    }
                    app.submitExam();
                    
                    const saved = JSON.parse(win.localStorage.getItem('topik_exam_results') || '[]');
                    const hasResult = saved.some(s => s.examId.startsWith('hot_'));
                    results.push('Test 11 - Final score stored in localStorage: ' + (hasResult ? 'PASS' : 'FAIL'));
                    
                    const modal = doc.getElementById('exam-result-modal');
                    const modalVisible = modal && modal.classList.contains('active');
                    results.push('Test 12 - Result modal displayed with score: ' + (modalVisible ? 'PASS' : 'FAIL'));
                }
                
            } catch(e) {
                results.push('EXCEPTION: ' + e.message + ' ' + e.stack);
            }
            
            document.getElementById('results').textContent = results.join('\n');
            console.error('VERIFY_SUMMARY:\n' + results.join('\n'));
        }, 1500);
    });
    </script>
</body>
</html>
"@

$htmlPath = "scripts/test_verify_hot_topik.html"
[System.IO.File]::WriteAllText($htmlPath, $testHtml, [System.Text.Encoding]::UTF8)

$logPath = "scripts/verify_hot_topik.log"
if (Test-Path $logPath) { Remove-Item $logPath -Force }

$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--allow-file-access-from-files", "--enable-logging=stderr", "--v=1", "file:///$((Get-Item $htmlPath).FullName -replace '\\', '/')" -PassThru -NoNewWindow -RedirectStandardError $logPath

$timeout = 15
$timer = [System.Diagnostics.Stopwatch]::StartNew()
while ($timer.Elapsed.TotalSeconds -lt $timeout) {
    Start-Sleep -Milliseconds 600
    if (Test-Path $logPath) {
        $content = Get-Content $logPath -Raw -ErrorAction SilentlyContinue
        if ($content -and $content.Contains("VERIFY_SUMMARY:")) {
            break
        }
    }
}

if (-not $proc.HasExited) {
    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
}

$logContent = Get-Content $logPath -Raw -ErrorAction SilentlyContinue
$summaryIdx = $logContent.IndexOf("VERIFY_SUMMARY:")
if ($summaryIdx -ge 0) {
    Write-Host "`n=== HOT TOPIK VERIFICATION RESULTS ==="
    Write-Host ($logContent.Substring($summaryIdx + 16).Trim())
} else {
    Write-Host "Verification timed out or log missing. Raw log:"
    Write-Host $logContent
}
