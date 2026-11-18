$extractScript = Get-Content -Raw -Encoding UTF8 scripts/extract_all_tm01_pdfs.ps1

$code = @"
`$tmDir = Get-ChildItem "de" | Where-Object { `$_.Name -match "TOPIK MASTER" }
`$de01 = Get-ChildItem `$tmDir.FullName | Where-Object { `$_.Name -match "01" }
`$files = Get-ChildItem `$de01.FullName

# [1] Đáp Án_Transcript.pdf
Extract-PdfToCleanText `$files[1].FullName "scripts\tm01_dapan_clean.txt"

# [2] Đề.pdf
Extract-PdfToCleanText `$files[2].FullName "scripts\tm01_de_clean.txt"

# [4] Đọc chi tiết.pdf
Extract-PdfToCleanText `$files[4].FullName "scripts\tm01_reading_clean.txt"
"@

# Replace bottom part of extract_all_tm01_pdfs.ps1
$funcOnly = $extractScript.Substring(0, $extractScript.IndexOf("`$tmDir = Get-ChildItem"))
$finalScript = $funcOnly + "`n" + $code

[System.IO.File]::WriteAllText("f:\github\hoc_tieng_han\scripts\extract_all_tm01_pdfs.ps1", $finalScript, [System.Text.Encoding]::UTF8)
Write-Host "Updated script!"
