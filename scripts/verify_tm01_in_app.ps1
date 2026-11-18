$html = @"
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><script src="../js/exam_data.js"></script></head>
<body>
<pre id="output">RUNNING</pre>
<script>
try {
    const qs = window.EXAM_DATA.questions.filter(q => q.examId === "tm_01");
    const lQs = qs.filter(q => q.section === "listening");
    const rQs = qs.filter(q => q.section === "reading");
    
    const res = {
        total: qs.length,
        listeningCount: lQs.length,
        readingCount: rQs.length,
        lQ1: {
            id: lQs[0].id,
            passage: lQs[0].passage,
            correctAnswer: lQs[0].correctAnswer,
            audioUrl: lQs[0].audioUrl
        },
        lQ4: {
            id: lQs[3].id,
            passage: lQs[3].passage,
            correctAnswer: lQs[3].correctAnswer,
            options: lQs[3].options
        },
        rQ1: {
            id: rQs[0].id,
            passage: rQs[0].passage,
            correctAnswer: rQs[0].correctAnswer,
            options: rQs[0].options
        },
        rQ50: {
            id: rQs[49].id,
            passage: rQs[49].passage,
            correctAnswer: rQs[49].correctAnswer,
            options: rQs[49].options
        }
    };
    document.getElementById("output").textContent = JSON.stringify(res, null, 2);
} catch(e) {
    document.getElementById("output").textContent = "ERR: " + e.message;
}
</script>
</body>
</html>
"@

[System.IO.File]::WriteAllText("scripts/test_tm_data.html", $html, [System.Text.Encoding]::UTF8)

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/test_tm_data.html"
$out = "test_tm_res.txt"

$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--dump-dom",
    "--virtual-time-budget=10000",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardOutput $out

$proc.WaitForExit(12000)

if (Test-Path $out) {
    Get-Content $out
    Remove-Item $out -Force -ErrorAction SilentlyContinue
}
Remove-Item "scripts/test_tm_data.html" -Force -ErrorAction SilentlyContinue
