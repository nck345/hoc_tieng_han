$expectedL = @(
    1, 2, 2, 3, 1, 2, 4, 3, 4, 2,
    4, 2, 3, 2, 4, 4, 3, 1, 4, 1,
    4, 2, 4, 2, 1, 1, 2, 3, 1, 2,
    4, 3, 3, 1, 1, 4, 3, 2, 4, 3,
    3, 2, 1, 4, 4, 3, 3, 3, 4, 1
)

$expectedR = @(
    4, 1, 1, 4, 2, 4, 1, 1, 3, 2,
    4, 4, 2, 3, 1, 1, 3, 1, 4, 2,
    2, 3, 2, 1, 3, 3, 4, 4, 2, 4,
    3, 3, 1, 2, 3, 4, 3, 1, 1, 3,
    2, 3, 1, 2, 4, 2, 2, 3, 4, 4
)

$l1 = Get-Content "scripts\topik96_data\listening_part1.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$l2 = Get-Content "scripts\topik96_data\listening_part2.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$listening = @($l1) + @($l2)

$r1 = Get-Content "scripts\topik96_data\reading_part1.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$r2 = Get-Content "scripts\topik96_data\reading_part2.json" -Raw -Encoding UTF8 | ConvertFrom-Json
$reading = @($r1) + @($r2)

$w = Get-Content "scripts\topik96_data\writing.json" -Raw -Encoding UTF8 | ConvertFrom-Json

$mismatch = 0
for ($i = 0; $i -lt 50; $i++) {
    $q = $listening[$i]
    $exp = $expectedL[$i]
    if ([int]$q.correctAnswer -ne $exp) {
        Write-Host "Listening Q$($i+1) mismatch: got $($q.correctAnswer), expected $exp"
        $mismatch++
    }
}

for ($i = 0; $i -lt 50; $i++) {
    $q = $reading[$i]
    $exp = $expectedR[$i]
    if ([int]$q.correctAnswer -ne $exp) {
        Write-Host "Reading Q$($i+1) mismatch: got $($q.correctAnswer), expected $exp"
        $mismatch++
    }
}

foreach ($q in $w) {
    if ([int]$q.correctAnswer -ne 1) {
        Write-Host "Writing Q$($q.questionNumber) mismatch: got $($q.correctAnswer), expected 1"
        $mismatch++
    }
}

if ($mismatch -eq 0) {
    Write-Host "ALL 104 official answers matched 100%!"
} else {
    Write-Host "$mismatch answer mismatches found."
}
