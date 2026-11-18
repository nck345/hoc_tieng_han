$ans = [System.IO.File]::ReadAllText("scripts/tm03_ans_full.txt", [System.Text.Encoding]::UTF8)
$readChunk = $ans.Substring(38543)
$m21 = [regex]::Match($readChunk, "21\.\s*([\s\S]*?)22\.")
if ($m21.Success) {
    Write-Host "=== ANS Q21 ==="
    Write-Host $m21.Groups[1].Value
}
$m22 = [regex]::Match($readChunk, "22\.\s*([\s\S]*?)23\.")
if ($m22.Success) {
    Write-Host "=== ANS Q22 ==="
    Write-Host $m22.Groups[1].Value
}
