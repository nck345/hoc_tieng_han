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
                const cat = win.EXAM_DATA.categories.find(c => c.id === 'topik_master');
                results.push('Test 1 - Category found: ' + (cat ? 'PASS (' + cat.name + ')' : 'FAIL'));
                
                const tmQs = win.EXAM_DATA.questions.filter(q => q.examId === 'tm_01');
                const tmL = tmQs.filter(q => q.section === 'listening');
                const tmR = tmQs.filter(q => q.section === 'reading');
                results.push('Test 2 - Questions count: Total=' + tmQs.length + ' L=' + tmL.length + ' R=' + tmR.length + 
                    (tmL.length === 50 && tmR.length === 50 ? ' PASS' : ' FAIL'));
                
                // Test 3: Check Topik Master content not Topik 96 melon
                const q1 = tmL[0];
                const isNotMelon = !q1.passage.includes('수박') && (q1.passage.includes('비가') || q1.passage.includes('우산'));
                results.push('Test 3 - Authentic Topik Master Listening Q1 (rain/umbrella): ' + (isNotMelon ? 'PASS' : 'FAIL'));
                results.push('Test 3b - Audio exists: ' + (q1.audioUrl.includes('TOPIK MASTER') ? 'PASS (' + q1.audioUrl + ')' : 'FAIL'));
                
                const rq1 = tmR[0];
                const isNotGrammarMelon = rq1.passage.includes('비가') && rq1.options[0].includes('오더니');
                results.push('Test 4 - Authentic Topik Master Reading Q1 (-더니): ' + (isNotGrammarMelon ? 'PASS' : 'FAIL'));
                
                // Test 5: Switch to Exam View & Select TOPIK MASTER
                app.switchView('exam');
                app.currentExamCategory = cat;
                app.renderExamView();
                
                const folderTitle = doc.getElementById('exam-folder-detail-title');
                results.push('Test 5 - Folder detail title: ' + (folderTitle && folderTitle.textContent.includes('TOPIK MASTER') ? 'PASS' : 'FAIL'));
                
                // Test 6: Check Part 1 Nghe and Part 2 Doc buttons in detail grid
                const card = doc.querySelector('.exam-card');
                const listenBtn = card ? card.querySelector('.btn-part-listen') : null;
                const readBtn = card ? card.querySelector('.btn-part-read') : null;
                results.push('Test 6 - Part buttons rendered: ' + (listenBtn && readBtn ? 'PASS' : 'FAIL'));
                
                // Test 7: Start Listening Part
                listenBtn.click();
                results.push('Test 7 - Active player displayed: ' + (app.examEls.activePlayer.style.display !== 'none' ? 'PASS' : 'FAIL'));
                results.push('Test 7b - Active question is Listening Q1: ' + (app.activeExamQuestions[0].id === 'tm01_l_01' ? 'PASS' : 'FAIL'));
                
                // Test 8: Subtitle/Passage is HIDDEN before submission
                const passageBox = doc.getElementById('exam-q-passage-box');
                const isPassageHidden = !passageBox || passageBox.style.display === 'none' || passageBox.innerHTML.trim() === '';
                results.push('Test 8 - Subtitle/Passage hidden before answering: ' + (isPassageHidden ? 'PASS' : 'FAIL'));
                
                // Test 9: Audio play button exists
                const btnPlay = doc.getElementById('btn-exam-audio-play');
                results.push('Test 9 - Audio play button visible: ' + (btnPlay && btnPlay.offsetParent !== null ? 'PASS' : 'FAIL'));
                
                // Test 10: Submit Answer and verify Subtitle/Passage is REVEALED
                // Q1 answer is 3
                app.selectedExamOption = 3;
                app.submitExamAnswer();
                
                const solPanel = doc.getElementById('exam-solution-panel');
                const isSolVisible = solPanel && solPanel.style.display !== 'none';
                const hasTranscript = solPanel && (solPanel.textContent.includes('비가') || solPanel.textContent.includes('우산') || solPanel.textContent.includes('mưa'));
                results.push('Test 10 - Subtitle & explanation revealed after submit: ' + (isSolVisible && hasTranscript ? 'PASS' : 'FAIL'));
                
                // Test 11: Exit midway -> Progress NOT saved
                app.examEls.btnPlayerBack.click();
                const storedMidway = localStorage.getItem('topik_app_exam_progress');
                results.push('Test 11 - Progress discarded on exit: ' + (!storedMidway ? 'PASS' : 'FAIL'));
                
                // Test 12: Start Reading Part
                app.currentExamCategory = cat;
                app.renderExamView();
                const cardAfter = doc.querySelector('.exam-card');
                const readBtnAfter = cardAfter ? cardAfter.querySelector('.btn-part-read') : null;
                readBtnAfter.click();
                results.push('Test 12 - Reading part starts on Q1 (-더니): ' + 
                    (app.activeExamQuestions[0].id === 'tm01_r_01' && app.activeExamQuestions[0].passage.includes('비가') ? 'PASS' : 'FAIL'));
                
                // Finish reading part artificially to verify result saving & modal
                app.activeExamQuestionIndex = 49;
                app.currentSessionAnswers = {};
                for (let i = 0; i < 50; i++) {
                    const q = app.activeExamQuestions[i];
                    app.currentSessionAnswers[q.id] = { userAnswer: q.correctAnswer, isCorrect: true };
                }
                app.nextExamQuestion();
                
                const savedScore = app.storage.getExamScore('tm_01', 'reading');
                const isModalActive = doc.getElementById('exam-result-modal').classList.contains('active');
                results.push('Test 13 - Final score saved in storage: ' + (savedScore && savedScore.correctCount === 50 ? 'PASS (50/50 đúng)' : 'FAIL'));
                results.push('Test 14 - Result modal shown: ' + (isModalActive ? 'PASS' : 'FAIL'));
                
                document.getElementById('results').textContent = results.join('\n');
            } catch(e) {
                document.getElementById('results').textContent = 'ERROR: ' + e.message + '\n' + e.stack;
            }
        }, 1500);
    });
    </script>
</body>
</html>
"@

[System.IO.File]::WriteAllText("scripts/test_tm01_flow.html", $testHtml, [System.Text.Encoding]::UTF8)

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/test_tm01_flow.html"
$outLog = "tm01_flow.log"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--dump-dom",
    "--virtual-time-budget=10000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardOutput $outLog

$proc.WaitForExit(15000)

if (Test-Path $outLog) {
    Get-Content $outLog -Raw
    Remove-Item $outLog -Force -ErrorAction SilentlyContinue
}
Remove-Item "scripts/test_tm01_flow.html" -Force -ErrorAction SilentlyContinue
