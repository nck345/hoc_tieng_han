$txt = [System.IO.File]::ReadAllText('scripts/tm03_de_full.txt', [System.Text.Encoding]::UTF8)
$pages = $txt -split '=== PAGE \d+ ==='
Write-Host "Page 21:"
Write-Host $pages[21]
Write-Host "Page 22:"
Write-Host $pages[22]
