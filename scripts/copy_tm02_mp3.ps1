$folder = (Get-ChildItem -Path "de/TOPIK MASTER" | Where-Object { $_.Name -like "*02*" })[0]
$mp3 = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*.mp3" })[0]
Write-Host "Copying $($mp3.FullName) -> scripts/tm02.mp3 ..."
Copy-Item $mp3.FullName "scripts/tm02.mp3" -Force
Get-Item "scripts/tm02.mp3" | Select-Object Name, Length
