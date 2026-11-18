$files = @(
  'tm01_master_questions.json', 'tm02_master_questions.json', 'tm03_master_questions.json', 'tm04_master_questions.json', 'tm05_master_questions.json',
  'hot01_master_questions.json', 'hot02_master_questions.json', 'hot03_master_questions.json', 'hot04_master_questions.json', 'hot05_master_questions.json'
)

foreach ($f in $files) {
    $path = Join-Path 'scripts' $f
    $json = Get-Content -Raw -Encoding UTF8 $path | ConvertFrom-Json
    $dummyL = 0
    $dummyR = 0
    foreach ($q in $json.listening) {
        $joined = $q.options -join ' '
        if ($joined -match '선택지' -or $joined -match 'Option') { $dummyL++ }
    }
    foreach ($q in $json.reading) {
        $joined = $q.options -join ' '
        if ($joined -match '선택지' -or $joined -match 'Option') { $dummyR++ }
    }
    Write-Host ('{0,-30} Dummy Options -> Listening: {1,2}/50, Reading: {2,2}/50' -f $f, $dummyL, $dummyR)
}
