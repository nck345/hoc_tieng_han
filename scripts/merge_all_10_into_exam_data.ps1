# Pure ASCII script to merge all questions into js/exam_data.js

Write-Host "Reading categories.json ..."
$catJson = [System.IO.File]::ReadAllText((Resolve-Path "scripts/categories.json").Path, [System.Text.Encoding]::UTF8)

Write-Host "Loading master exam questions..."
$allQuestions = @()

$all10 = @('hot01', 'hot02', 'hot03', 'hot04', 'hot05', 'tm01', 'tm02', 'tm03', 'tm04', 'tm05')
foreach ($ex in $all10) {
    $path = "scripts/${ex}_master_questions.json"
    $obj = [System.IO.File]::ReadAllText((Resolve-Path $path).Path, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
    $allQuestions += $obj.listening
    $allQuestions += $obj.reading
    Write-Host "  Loaded $ex : 100 questions"
}

Write-Host "Loading real_96 questions..."
$r96Files = @(
    "scripts/topik96_data/listening_part1.json",
    "scripts/topik96_data/listening_part2.json",
    "scripts/topik96_data/reading_part1.json",
    "scripts/topik96_data/reading_part2.json",
    "scripts/topik96_data/writing.json"
)
$r96Count = 0
foreach ($f in $r96Files) {
    $sub = [System.IO.File]::ReadAllText((Resolve-Path $f).Path, [System.Text.Encoding]::UTF8) | ConvertFrom-Json
    foreach ($q in $sub) {
        if ($q.audioUrl -and $q.audioUrl -match '2-(\d+)\.mp3') {
            $num = $matches[1]
            $q.audioUrl = "de/" + [char]0x0110 + [char]0x1EC1 + " thi th" + [char]0x1EAD + "t/K" + [char]0x1EF3 + " thi s" + [char]0x1ED1 + " 96/" + [char]0xC81C + "96" + [char]0xD68C + " TOPIK II " + [char]0xB4E3 + [char]0xAE30 + [char]0xD30C + [char]0xC77C + "/2-$num.mp3"
        }
        $allQuestions += $q
        $r96Count++
    }
}
Write-Host "  Loaded real_96 : $r96Count questions"
Write-Host "Total questions to write: $($allQuestions.Count)"

Write-Host "Serializing questions to JSON..."
$qsJson = $allQuestions | ConvertTo-Json -Depth 10

$finalContent = "window.EXAM_DATA = {" + [Environment]::NewLine + "  categories: " + $catJson.Trim() + "," + [Environment]::NewLine + "  questions: " + $qsJson + [Environment]::NewLine + "};"

$destFile = "js/exam_data.js"
[System.IO.File]::WriteAllText((Resolve-Path $destFile).Path, $finalContent, [System.Text.Encoding]::UTF8)

Write-Host "`nWrote $($finalContent.Length) characters to $destFile"
