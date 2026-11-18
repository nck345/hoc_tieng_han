$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_de_full.txt
$m4 = [regex]::Match($txt, "4\.\s*([\s\S]*?)5\.\s*")
if ($m4.Success) {
    Write-Host "=== RAW Q4 BLOCK ==="
    $raw = $m4.Groups[1].Value
    $raw -split "[\r\n]+" | ForEach-Object { Write-Host "LINE: [$_]" }
}
$m5 = [regex]::Match($txt, "5\.\s*([\s\S]*?)6\.\s*")
if ($m5.Success) {
    Write-Host "=== RAW Q5 BLOCK ==="
    $raw = $m5.Groups[1].Value
    $raw -split "[\r\n]+" | ForEach-Object { Write-Host "LINE: [$_]" }
}
