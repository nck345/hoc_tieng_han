$pdfPath = "de\TOPIK MASTER\TOPIK MASTER_ĐỀ 01\TOPIK MASTER_ĐỀ 01_Đọc chi tiết.pdf"
Write-Host "Checking: $pdfPath"
if (Test-Path $pdfPath) {
    $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
    Write-Host "File size: $($bytes.Length) bytes"
    
    # Search for text streams
    $content = [System.Text.Encoding]::ASCII.GetString($bytes)
    $objMatches = [regex]::Matches($content, "stream\r?\n([\s\S]*?)\r?\nendstream")
    Write-Host "Found $($objMatches.Count) streams"
}
