function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$exams = @(
    @{ p = "de/TOPIK MASTER"; n = "01" },
    @{ p = "de/TOPIK MASTER"; n = "02" },
    @{ p = "de/TOPIK MASTER"; n = "03" },
    @{ p = "de/TOPIK MASTER"; n = "04" },
    @{ p = "de/TOPIK MASTER"; n = "05" },
    @{ p = "de/Hot topik"; n = "01" },
    @{ p = "de/Hot topik"; n = "02" },
    @{ p = "de/Hot topik"; n = "03" },
    @{ p = "de/Hot topik"; n = "04" },
    @{ p = "de/Hot topik"; n = "05" }
)

foreach ($e in $exams) {
    $f = Get-RealFolder $e.p $e.n
    $aud = Join-Path $f "audio"
    if (Test-Path $aud) {
        $files = Get-ChildItem -Path $aud -Filter "*.mp3"
        Write-Host "$($e.p) $($e.n) => $($files.Count) audio files"
    } else {
        Write-Host "$($e.p) $($e.n) => NO AUDIO DIR"
    }
}
