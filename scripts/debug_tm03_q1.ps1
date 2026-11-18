$txt = [System.IO.File]::ReadAllText('scripts/tm03_ans_full.txt', [System.Text.Encoding]::UTF8)
$m = [regex]::Match($txt, '1\.\s*[\uAC00-\uD7A3]+[\s\S]*?(?=2\.\s*[\uAC00-\uD7A3]+)')
Write-Host "Success:" $m.Success
if ($m.Success) {
    Write-Host "Length:" $m.Value.Length
    Write-Host $m.Value
}
