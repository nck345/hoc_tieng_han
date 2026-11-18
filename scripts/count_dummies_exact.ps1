$files = @(
  'tm01_master_questions.json', 'tm02_master_questions.json', 'tm03_master_questions.json', 'tm04_master_questions.json', 'tm05_master_questions.json',
  'hot01_master_questions.json', 'hot02_master_questions.json', 'hot03_master_questions.json', 'hot04_master_questions.json', 'hot05_master_questions.json'
)

$targetPattern = [regex]::Unescape("\uC120\uD0DD\uC9C0") # 선택지

foreach ($f in $files) {
    $path = Join-Path 'scripts' $f
    $json = Get-Content -Raw -Encoding UTF8 $path | ConvertFrom-Json
    $dummyL = 0
    $dummyR = 0
    foreach ($q in $json.listening) {
        $joined = $q.options -join ' '
        if ($joined -match $targetPattern) { $dummyL++ }
    }
    foreach ($q in $json.reading) {
        $joined = $q.options -join ' '
        if ($joined -match $targetPattern) { $dummyR++ }
    }
    Write-Host ('{0,-30} Dummy Options -> Listening: {1,2}/50, Reading: {2,2}/50' -f $f, $dummyL, $dummyR)
}
