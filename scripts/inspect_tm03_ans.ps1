$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_ans_full.txt
$m4 = [regex]::Match($txt, "4\.\s*([\s\S]*?)5\.\s*")
if ($m4.Success) {
    Write-Host "=== RAW Q4 in tm03_ans_full ==="
    Write-Host $m4.Groups[1].Value
}
$m5 = [regex]::Match($txt, "5\.\s*([\s\S]*?)6\.\s*")
if ($m5.Success) {
    Write-Host "=== RAW Q5 in tm03_ans_full ==="
    Write-Host $m5.Groups[1].Value
}
