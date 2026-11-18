$ans = [System.IO.File]::ReadAllText("scripts/tm03_ans_full.txt", [System.Text.Encoding]::UTF8)
$idx = $ans.IndexOf("21. ")
if ($idx -ge 0) {
    Write-Host $ans.Substring($idx, [Math]::Min(1500, $ans.Length - $idx))
}
