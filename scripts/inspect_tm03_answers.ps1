$txt = [System.IO.File]::ReadAllText('scripts/tm03_ans_full.txt', [System.Text.Encoding]::UTF8)
$pages = $txt -split '=== PAGE \d+ ==='
Write-Host "Page 1:"
Write-Host $pages[1]
