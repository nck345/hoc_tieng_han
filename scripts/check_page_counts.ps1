$exams = @('hot01', 'hot02', 'hot03', 'hot04', 'tm03', 'tm04', 'tm05')

foreach ($ex in $exams) {
    $dePath = "scripts/${ex}_de_full.txt"
    $ansPath = "scripts/${ex}_ans_full.txt"
    $de = [System.IO.File]::ReadAllText($dePath, [System.Text.Encoding]::UTF8)
    $ans = [System.IO.File]::ReadAllText($ansPath, [System.Text.Encoding]::UTF8)
    $dePages = ($de -split "=== PAGE \d+ ===").Count - 1
    $ansPages = ($ans -split "=== PAGE \d+ ===").Count - 1
    Write-Host ('{0,-6} de_pages: {1,2} | ans_pages: {2,2}' -f $ex, $dePages, $ansPages)
}
