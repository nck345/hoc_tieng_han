$txt = Get-Content -Raw -Encoding UTF8 scripts/hot01_ans_full.txt
$idx = $txt.IndexOf([regex]::Unescape("\uC77D\uAE30 (1"))
if ($idx -lt 0) { $idx = $txt.IndexOf([regex]::Unescape("\uC77D\uAE30")) }
Write-Host "Index of 읽기 in hot01_ans_full.txt: $idx"
if ($idx -ge 0) {
    Write-Host $txt.Substring($idx, [Math]::Min(2500, $txt.Length - $idx))
}
