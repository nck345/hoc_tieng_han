$files = @(
    'scripts/hot01_ans_full.txt', 'scripts/hot01_de_full.txt',
    'scripts/hot02_ans_full.txt', 'scripts/hot02_de_full.txt',
    'scripts/hot03_ans_full.txt', 'scripts/hot03_de_full.txt',
    'scripts/hot04_ans_full.txt', 'scripts/hot04_de_full.txt',
    'scripts/tm03_ans_full.txt',  'scripts/tm03_de_full.txt',
    'scripts/tm04_ans_full.txt',  'scripts/tm04_de_full.txt',
    'scripts/tm05_ans_full.txt',  'scripts/tm05_de_full.txt'
)

foreach ($f in $files) {
    if (Test-Path $f) {
        $t = Get-Content -Raw -Encoding UTF8 $f
        $hasListen = $t -match [regex]::Unescape("\uB4E3\uAE30")
        $hasRead = $t -match [regex]::Unescape("\uC77D\uAE30")
        Write-Host ('{0,-28} Len: {1,6} | HasListen: {2,-5} | HasRead: {3,-5}' -f $f, $t.Length, $hasListen, $hasRead)
    } else {
        Write-Host ('{0,-28} MISSING' -f $f)
    }
}
