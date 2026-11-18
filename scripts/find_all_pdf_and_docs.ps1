Write-Host "=== Project Files non-mp3 non-git ==="
Get-ChildItem -Path . -Recurse -File | Where-Object { $_.FullName -notmatch '\\.git' -and $_.Extension -ne '.mp3' -and $_.Extension -ne '.png' -and $_.Extension -ne '.svg' } | Select-Object FullName, Length | Format-Table -AutoSize

Write-Host "=== Search parent folder for TOPIK MASTER ==="
if (Test-Path "..\") {
    Get-ChildItem -Path ".." -Depth 2 | Where-Object { $_.Name -match "topik|master|de|han" } | Select-Object FullName
}

Write-Host "=== Search Downloads folder for TOPIK MASTER ==="
$dl = "C:\Users\Nguyen Thao\Downloads"
if (Test-Path $dl) {
    Get-ChildItem -Path $dl | Where-Object { $_.Name -match "topik|master|de" } | Select-Object FullName
}
