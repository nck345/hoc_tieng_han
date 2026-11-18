function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$tasks = @(
    @{ folder = Get-RealFolder "de/TOPIK MASTER" "04"; name = "tm04"; q1 = 45.0 },
    @{ folder = Get-RealFolder "de/TOPIK MASTER" "05"; name = "tm05"; q1 = 45.0 },
    @{ folder = Get-RealFolder "de/Hot topik" "01"; name = "hot01"; q1 = 45.0 },
    @{ folder = Get-RealFolder "de/Hot topik" "02"; name = "hot02"; q1 = 45.0 },
    @{ folder = Get-RealFolder "de/Hot topik" "03"; name = "hot03"; q1 = 45.0 },
    @{ folder = Get-RealFolder "de/Hot topik" "04"; name = "hot04"; q1 = 45.0 }
)

foreach ($t in $tasks) {
    Write-Host "=========================================="
    Write-Host "=== SLICING $($t.name) in $($t.folder) ==="
    Write-Host "=========================================="
    & ".\scripts\slice_generic_exam_audio.ps1" -examFolder $t.folder -shortName $t.name -q1Start $t.q1
}

Write-Host "ALL 6 EXAMS SLICED SUCCESSFULLY!"
