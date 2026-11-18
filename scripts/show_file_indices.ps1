$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

$files = Get-ChildItem $de01.FullName
for ($i = 0; $i -lt $files.Count; $i++) {
    Write-Host "[$i] $($files[$i].Name)"
}
