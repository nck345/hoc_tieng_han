$files = @(
  'tm01_master_questions.json', 'tm02_master_questions.json', 'tm03_master_questions.json', 'tm04_master_questions.json', 'tm05_master_questions.json',
  'hot01_master_questions.json', 'hot02_master_questions.json', 'hot03_master_questions.json', 'hot04_master_questions.json', 'hot05_master_questions.json'
)
foreach ($f in $files) {
    $path = Join-Path 'scripts' $f
    if (Test-Path $path) {
        $json = Get-Content -Raw -Encoding UTF8 $path | ConvertFrom-Json
        $lCount = if ($json.listening) { $json.listening.Count } else { 0 }
        $rCount = if ($json.reading) { $json.reading.Count } else { 0 }
        $tot = $lCount + $rCount
        Write-Host ('{0,-30} Total: {1,3} (L: {2,2}, R: {3,2})' -f $f, $tot, $lCount, $rCount)
    } else {
        Write-Host ('{0,-30} MISSING' -f $f)
    }
}
