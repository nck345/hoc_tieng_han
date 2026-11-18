function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

Write-Host "TM 04:" (Get-RealFolder "de/TOPIK MASTER" "04")
Write-Host "TM 05:" (Get-RealFolder "de/TOPIK MASTER" "05")
Write-Host "Hot 01:" (Get-RealFolder "de/Hot topik" "01")
Write-Host "Hot 02:" (Get-RealFolder "de/Hot topik" "02")
Write-Host "Hot 03:" (Get-RealFolder "de/Hot topik" "03")
Write-Host "Hot 04:" (Get-RealFolder "de/Hot topik" "04")
