param(
    [string]$examFolder,
    [string]$shortName,
    [double]$q1Start = 45.0
)

$mp3 = (Get-ChildItem -Path $examFolder | Where-Object { $_.Name -like "*.mp3" })[0]
$audioOutDir = Join-Path $examFolder "audio"
if (-not (Test-Path $audioOutDir)) {
    New-Item -ItemType Directory -Path $audioOutDir | Out-Null
}

$tempMp3Name = "${shortName}_temp.mp3"
$tempMp3Path = Join-Path "scripts" $tempMp3Name
Copy-Item $mp3.FullName $tempMp3Path -Force

$gapsJsonPath = Join-Path "scripts" "${shortName}_gaps.json"

Write-Host "Detecting audio gaps for $shortName ($($mp3.Name))..."
& ".\scripts\run_detect_gaps.ps1" -mp3File $tempMp3Name -outJson $gapsJsonPath

if (-not (Test-Path $gapsJsonPath)) {
    Write-Host "ERROR: Gap file not created!"
    return
}

$gaps = Get-Content $gapsJsonPath -Raw | ConvertFrom-Json
Write-Host "Found $($gaps.Count) gaps. Reading MP3 frames..."

$bytes = [System.IO.File]::ReadAllBytes($mp3.FullName)
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

$frameDur = 1152.0 / 44100.0

function Slice-AudioFile($startSec, $endSec, $targetFile) {
    $startF = [Math]::Max(0, [Math]::Min($frames.Count - 1, [Math]::Round($startSec / $frameDur)))
    $endF = [Math]::Max(0, [Math]::Min($frames.Count - 1, [Math]::Round($endSec / $frameDur)))
    $startB = $frames[$startF]
    $endB = if ($endF -lt $frames.Count - 1) { $frames[$endF] } else { $bytes.Length }
    if ($endB -le $startB) {
        $endB = [Math]::Min($bytes.Length, $startB + 4000)
    }
    $len = $endB - $startB
    $slice = New-Object byte[] $len
    [System.Array]::Copy($bytes, $startB, $slice, 0, $len)
    [System.IO.File]::WriteAllBytes($targetFile, $slice)
}

$qIntervals = @()
$actualQ1Start = [Math]::Min($q1Start, [Math]::Max(10.0, $gaps[0].start - 15.0))
$qIntervals += @{ q = 1; start = $actualQ1Start; end = $gaps[0].start }

for ($n = 2; $n -le 20; $n++) {
    $start = $gaps[$n - 2].end
    $end = $gaps[$n - 1].start
    $qIntervals += @{ q = $n; start = $start; end = $end }
}

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
    $end = if ($currGapIdx -lt $gaps.Count) { $gaps[$currGapIdx].start } else { $frames.Count * $frameDur }
    $qIntervals += @{ q = $qA; start = $start; end = $end }
    $qIntervals += @{ q = $qB; start = $start; end = $end }
}

$qIntervals = $qIntervals | Sort-Object { $_.q }

Write-Host "Slicing $($qIntervals.Count) questions into $audioOutDir ..."
foreach ($qi in $qIntervals) {
    $numStr = "{0:D2}" -f $qi.q
    $outPath = Join-Path $audioOutDir "q$numStr.mp3"
    Slice-AudioFile $qi.start $qi.end $outPath
}

Write-Host "SUCCESS! Sliced all 50 questions for $shortName!"
Remove-Item $tempMp3Path -Force -ErrorAction SilentlyContinue
