$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

Write-Host "DE 01 folder: $($de01.FullName)"
$files = Get-ChildItem $de01.FullName
foreach ($f in $files) {
    Write-Host "  File: $($f.Name) ($($f.Length) bytes)"
}
