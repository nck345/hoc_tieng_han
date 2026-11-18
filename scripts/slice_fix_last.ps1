function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$tasks = @(
    @{ folder = Get-RealFolder "de/Hot topik" "03"; name = "hot03"; q1 = 30.0 },
    @{ folder = Get-RealFolder "de/Hot topik" "04"; name = "hot04"; q1 = 30.0 }
)

foreach ($t in $tasks) {
    Write-Host "Slicing fix for $($t.name)..."
    & ".\scripts\slice_generic_exam_audio.ps1" -examFolder $t.folder -shortName $t.name -q1Start $t.q1
}

Write-Host "ALL EXAMS FIXED!"
