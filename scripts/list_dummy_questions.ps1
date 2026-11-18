$files = @(
  'hot01_master_questions.json', 'hot02_master_questions.json', 'hot03_master_questions.json', 'hot04_master_questions.json',
  'tm03_master_questions.json', 'tm04_master_questions.json', 'tm05_master_questions.json'
)

$targetPattern = [regex]::Unescape("\uC120\uD0DD\uC9C0") # 선택지

foreach ($f in $files) {
    $path = Join-Path 'scripts' $f
    $json = Get-Content -Raw -Encoding UTF8 $path | ConvertFrom-Json
    $dummyL = @()
    $dummyR = @()
    foreach ($q in $json.listening) {
        $joined = $q.options -join ' '
        if ($joined -match $targetPattern) { $dummyL += $q.questionNumber }
    }
    foreach ($q in $json.reading) {
        $joined = $q.options -join ' '
        if ($joined -match $targetPattern) { $dummyR += $q.questionNumber }
    }
    Write-Host "================ $f ================"
    Write-Host ("Listening Dummies (" + $dummyL.Count + "): " + ($dummyL -join ", "))
    Write-Host ("Reading Dummies   (" + $dummyR.Count + "): " + ($dummyR -join ", "))
}
