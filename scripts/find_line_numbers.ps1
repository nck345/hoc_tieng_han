$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

Write-Host "Checking target lines:"
for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ($line.Contains("startExamFromItem(cat,ex){")) {
        Write-Host "startExamFromItem at line $($i+1)"
    }
    if ($line.Contains("qInstruction.textContent")) {
        Write-Host "qInstruction at line $($i+1)"
    }
    if ($line.Contains("hasSeparatedAudio") -or $line.Contains("ex.audioFile")) {
        Write-Host "audioFile check at line $($i+1)"
    }
    if ($line.Contains("btnNextQ.textContent") -and $line.Contains("total-1")) {
        Write-Host "btnNextQ at line $($i+1)"
    }
}
