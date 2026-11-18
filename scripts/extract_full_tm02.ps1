$folder = (Get-ChildItem -Path "de/TOPIK MASTER" | Where-Object { $_.Name -like "*02*" })[0]
$nghePdf = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*Nghe chi ti*" })[0].FullName
$docPdf = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*Đọc chi ti*" -or ($_.Name -like "*chi ti*" -and $_.Name -notlike "*Nghe*") })[0].FullName

function ExtractWithPdfJs($pdfPath, $outPath) {
    Write-Host "Extracting $pdfPath -> $outPath ..."
    $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
    $b64 = [System.Convert]::ToBase64String($bytes)

    $html = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="lib/pdf.min.js"></script>
</head>
<body>
    <pre id="output">LOADING</pre>
    <script>
        pdfjsLib.GlobalWorkerOptions.workerSrc = 'lib/pdf.worker.min.js';
        
        async function run() {
            try {
                const b64 = "$b64";
                const binaryString = atob(b64);
                const bytes = new Uint8Array(binaryString.length);
                for (let i = 0; i < binaryString.length; i++) {
                    bytes[i] = binaryString.charCodeAt(i);
                }
                
                const loadingTask = pdfjsLib.getDocument({ data: bytes });
                const pdf = await loadingTask.promise;
                let fullText = "";
                for(let p = 1; p <= pdf.numPages; p++) {
                    const page = await pdf.getPage(p);
                    const textContent = await page.getTextContent();
                    const text = textContent.items.map(item => item.str).join(' ');
                    fullText += "\n=== PAGE " + p + " ===\n" + text;
                }
                document.getElementById("output").textContent = fullText;
            } catch(e) {
                document.getElementById("output").textContent = "ERROR: " + e.message;
            }
        }
        run();
    </script>
</body>
</html>
"@

    $tempHtml = "scripts/temp_tm02_extract.html"
    [System.IO.File]::WriteAllText($tempHtml, $html, [System.Text.Encoding]::UTF8)

    $edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    if (-not (Test-Path $edgePath)) {
        $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
    }

    $url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/" + $tempHtml
    $outFile = "temp_dump_tm02.txt"

    $proc = Start-Process -FilePath $edgePath -ArgumentList @(
        "--headless=new",
        "--disable-gpu",
        "--dump-dom",
        "--virtual-time-budget=30000",
        "`"$url`""
    ) -PassThru -NoNewWindow -RedirectStandardOutput $outFile

    $proc.WaitForExit(35000)

    if (Test-Path $outFile) {
        $raw = Get-Content -Raw -Encoding UTF8 $outFile
        if ($raw -match '<pre id="output">([\s\S]*?)</pre>') {
            $extracted = $matches[1]
            $extracted = $extracted.Replace('&lt;', '<').Replace('&gt;', '>').Replace('&amp;', '&').Replace('&quot;', '"')
            [System.IO.File]::WriteAllText($outPath, $extracted, [System.Text.Encoding]::UTF8)
            Write-Host "Success! Extracted $($extracted.Length) chars to $outPath"
        } else {
            Write-Host "Failed to find pre#output"
        }
        Remove-Item $outFile -Force -ErrorAction SilentlyContinue
    }
    Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
}

ExtractWithPdfJs $nghePdf "scripts/tm02_listening_full.txt"
ExtractWithPdfJs $docPdf "scripts/tm02_reading_full.txt"

Write-Host "TM02 extraction complete!"
