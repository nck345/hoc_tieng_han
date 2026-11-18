$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$haesol = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "해설집" }

Write-Host "Found 해설집: $($haesol.FullName) ($($haesol.Length) bytes)"
