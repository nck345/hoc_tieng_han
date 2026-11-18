function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$tm04 = Get-RealFolder "de/TOPIK MASTER" "04"
$tm04Ans = (Get-ChildItem -Path $tm04 | Where-Object { $_.Name -like "*Transcript*.pdf" })[0].FullName
$tm04De = (Get-ChildItem -Path $tm04 | Where-Object { $_.Name -like "*.pdf" -and $_.Name -notlike "*Transcript*" })[0].FullName

Write-Host "Running OCR on TM04 Đáp Án..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $tm04Ans -outTextPath "scripts/tm04_ans_full.txt"

Write-Host "Running OCR on TM04 Đề..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $tm04De -outTextPath "scripts/tm04_de_full.txt"

$tm05 = Get-RealFolder "de/TOPIK MASTER" "05"
$tm05Ans = (Get-ChildItem -Path $tm05 | Where-Object { $_.Name -like "*Transcript*.pdf" })[0].FullName
$tm05De = (Get-ChildItem -Path $tm05 | Where-Object { $_.Name -like "*.pdf" -and $_.Name -notlike "*Transcript*" })[0].FullName

Write-Host "Running OCR on TM05 Đáp Án..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $tm05Ans -outTextPath "scripts/tm05_ans_full.txt"

Write-Host "Running OCR on TM05 Đề..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $tm05De -outTextPath "scripts/tm05_de_full.txt"

Write-Host "TM04 & TM05 OCR COMPLETED!"
