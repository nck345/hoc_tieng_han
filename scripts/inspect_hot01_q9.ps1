$txt = Get-Content -Raw -Encoding UTF8 scripts/hot01_ans_full.txt
$idx = $txt.IndexOf("9. ")
if ($idx -ge 0) {
    Write-Host $txt.Substring($idx, [Math]::Min(3000, $txt.Length - $idx))
}
