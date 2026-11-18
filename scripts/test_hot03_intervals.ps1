function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$folder = Get-RealFolder "de/Hot topik" "03"
$audioFile = (Get-ChildItem $folder | Where-Object { $_.Name -like "*.mp3" })[0].FullName
$bytes = [System.IO.File]::ReadAllBytes($audioFile)
$frameDur = 1152.0 / 44100.0
$gaps = Get-Content "scripts/hot03_gaps.json" -Raw | ConvertFrom-Json

$pairPairs = @(
    @(21, 22, 19, 20),
    @(23, 24, 21, 22),
    @(25, 26, 23, 24),
    @(27, 28, 25, 26),
    @(29, 30, 27, 28),
    @(31, 32, 29, 30),
    @(33, 34, 31, 32),
    @(35, 36, 33, 34),
    @(37, 38, 35, 36),
    @(39, 40, 37, 38),
    @(41, 42, 39, 40),
    @(43, 44, 41, 42),
    @(45, 46, 43, 44),
    @(47, 48, 45, 46),
    @(49, 50, 47, 48)
)

foreach ($p in $pairPairs) {
    $qA = $p[0]
    $qB = $p[1]
    $prev = $p[2]
    $curr = $p[3]
    Write-Host "Pair Q${qA}-Q${qB}: prevGapIdx=$prev (end=$($gaps[$prev].end)) currGapIdx=$curr (start=$($gaps[$curr].start)) diff=$($gaps[$curr].start - $gaps[$prev].end)"
}
