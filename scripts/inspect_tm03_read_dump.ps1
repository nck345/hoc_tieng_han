$ans = [System.IO.File]::ReadAllText("scripts/tm03_ans_full.txt", [System.Text.Encoding]::UTF8)
$readChunk = $ans.Substring(38543)
Write-Host $readChunk.Substring(0, [Math]::Min(1500, $readChunk.Length))
