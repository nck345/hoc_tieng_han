$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

Get-ChildItem $de01.FullName | ForEach-Object {
    Write-Host "Name: $($_.Name)"
}
