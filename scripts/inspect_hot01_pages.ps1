$de = [System.IO.File]::ReadAllText("scripts/hot01_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="

Write-Host "Total de pages: $($pages.Count)"
for ($p = 1; $p -lt $pages.Count; $p++) {
    $firstLine = ($pages[$p].Trim() -split "[\r\n]+")[0]
    if ($firstLine.Length -gt 80) { $firstLine = $firstLine.Substring(0, 80) }
    Write-Host ("Page {0,2}: {1}" -f $p, $firstLine)
}
