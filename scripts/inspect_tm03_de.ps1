$txt = [System.IO.File]::ReadAllText('scripts/tm03_de_full.txt', [System.Text.Encoding]::UTF8)
$pages = $txt -split '=== PAGE \d+ ==='
Write-Host "Total de pages: $($pages.Count)"
for ($i = 1; $i -le 5; $i++) {
    Write-Host "--- PAGE $i ---"
    Write-Host $pages[$i].Substring(0, [Math]::Min(400, $pages[$i].Length))
}
