function Get-RealFolder($parent, $numStr) {
    $matches = Get-ChildItem -Path $parent -Directory | Where-Object { 
        $_.Name.EndsWith($numStr) -or $_.Name.Contains(" $numStr")
    }
    return ($matches | Where-Object { (Get-ChildItem $_.FullName -File).Count -gt 0 })[0].FullName
}

$hotNums = @("01", "02", "03", "04")

foreach ($num in $hotNums) {
    $folder = Get-RealFolder "de/Hot topik" $num
    Write-Host "=== OCR FOR HOT TOPIK $num ($folder) ==="
    
    $ansPdf = (Get-ChildItem -Path $folder | Where-Object { $_.Name -like "*Transcript*.pdf" })[0].FullName
    $dePdf = (Get-ChildItem -Path $folder | Where-Object { $_.Name -like "*.pdf" -and $_.Name -notlike "*Transcript*" })[0].FullName
    
    $ansOut = "scripts/hot${num}_ans_full.txt"
    $deOut = "scripts/hot${num}_de_full.txt"
    
    if (-not (Test-Path $ansOut)) {
        Write-Host "Running OCR on Hot $num Đáp Án..."
        & ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $ansPdf -outTextPath $ansOut
    }
    
    if (-not (Test-Path $deOut)) {
        Write-Host "Running OCR on Hot $num Đề..."
        & ".\scripts\ocr_pdf_to_text.ps1" -pdfPath $dePdf -outTextPath $deOut
    }
}

Write-Host "HOT TOPIK 01 to 04 OCR COMPLETED!"
