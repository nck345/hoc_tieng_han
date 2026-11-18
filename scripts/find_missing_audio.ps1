function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$folder = Get-RealFolder "de/Hot topik" "03"
$files = Get-ChildItem (Join-Path $folder "audio") -Filter "*.mp3"
for ($i = 1; $i -le 50; $i++) {
    $numStr = "{0:D2}" -f $i
    $found = $files | Where-Object { $_.Name -eq "q$numStr.mp3" }
    if (-not $found) {
        Write-Host "Missing: q$numStr.mp3"
    }
}
