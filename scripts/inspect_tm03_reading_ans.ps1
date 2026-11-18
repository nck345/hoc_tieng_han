$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_ans_full.txt
$idx = $txt.IndexOf("2교시: 읽기")
if ($idx -lt 0) { $idx = $txt.IndexOf("Reading") }
Write-Host "Index of Reading in tm03_ans: $idx"
$pRead = $txt.Substring($idx)
Write-Host $pRead.Substring(0, [Math]::Min(3000, $pRead.Length))
