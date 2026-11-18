$folder = (Get-ChildItem -Path "de/TOPIK MASTER" | Where-Object { $_.Name -like "*03*" })[0]
$ansPdf = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*Transcript*.pdf" })[0].FullName
$dePdf = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*.pdf" -and $_.Name -notlike "*Transcript*" })[0].FullName

Write-Host "Running OCR on TM03 Đáp Án..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $ansPdf -outTextPath "scripts/tm03_ans_full.txt"

Write-Host "Running OCR on TM03 Đề..."
& ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $dePdf -outTextPath "scripts/tm03_de_full.txt"
