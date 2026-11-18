$d = (Get-ChildItem "de/TOPIK MASTER")[0]
$audioFile = (Get-ChildItem $d.FullName | Where-Object { $_.Name -like "*.mp3" })[0].FullName
$outDir = Join-Path $d.FullName "audio"
if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

$bytes = [System.IO.File]::ReadAllBytes($audioFile)
Write-Host "Read $($bytes.Length) bytes from $audioFile"

$frames = New-Object System.Collections.Generic.List[int]
$i = 0
while ($i -lt $bytes.Length - 4) {
    if ($bytes[$i] -eq 0xFF -and ($bytes[$i+1] -band 0xE0) -eq 0xE0) {
        $frames.Add($i)
        $padding = ($bytes[$i+2] -shr 1) -band 0x01
        $frameLen = [Math]::Floor(144 * 32000 / 44100) + $padding
        if ($frameLen -gt 0) {
            $i += $frameLen
            continue
        }
    }
    $i++
}
Write-Host "Found $($frames.Count) frames"

$frameDur = 1152.0 / 44100.0

function Slice-AudioFile($startSec, $endSec, $targetFile) {
    $startF = [Math]::Max(0, [Math]::Min($frames.Count - 1, [Math]::Round($startSec / $frameDur)))
    $endF = [Math]::Max(0, [Math]::Min($frames.Count - 1, [Math]::Round($endSec / $frameDur)))
    $startB = $frames[$startF]
    $endB = if ($endF -lt $frames.Count - 1) { $frames[$endF] } else { $bytes.Length }
    $len = $endB - $startB
    $slice = New-Object byte[] $len
    [System.Array]::Copy($bytes, $startB, $slice, 0, $len)
    [System.IO.File]::WriteAllBytes($targetFile, $slice)
}

$gaps = Get-Content "scripts/gaps.json" -Raw | ConvertFrom-Json

# Build intervals for 50 questions
$qIntervals = @()

# Q1
$qIntervals += @{ q = 1; start = 82.5; end = $gaps[0].start }
# Q2 - Q20
for ($n = 2; $n -le 20; $n++) {
    $start = $gaps[$n - 2].end
    $end = $gaps[$n - 1].start
    $qIntervals += @{ q = $n; start = $start; end = $end }
}

# Paired questions Q21-22, 23-24, ... 49-50
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
    $prevGapIdx = $p[2]
    $currGapIdx = $p[3]
    
    $start = $gaps[$prevGapIdx].end
    $end = $gaps[$currGapIdx].start
    $qIntervals += @{ q = $qA; start = $start; end = $end }
    $qIntervals += @{ q = $qB; start = $start; end = $end }
}

# Sort by q
$qIntervals = $qIntervals | Sort-Object { $_.q }

Write-Host "Slicing $($qIntervals.Count) questions into $outDir ..."
foreach ($qi in $qIntervals) {
    $numStr = "{0:D2}" -f $qi.q
    $outPath = Join-Path $outDir "q$numStr.mp3"
    Slice-AudioFile $qi.start $qi.end $outPath
}

Write-Host "All 50 audio files successfully sliced!"
Get-ChildItem $outDir | Measure-Object -Property Length -Sum | Select-Object Count, @{Name="TotalMB";Expression={[Math]::Round($_.Sum / 1MB, 2)}}
