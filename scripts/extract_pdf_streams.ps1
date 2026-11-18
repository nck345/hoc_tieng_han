$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

$pdfFile = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }
Write-Host "Target PDF: $($pdfFile.FullName)"

# Read all bytes
$bytes = [System.IO.File]::ReadAllBytes($pdfFile.FullName)
$str = [System.Text.Encoding]::ASCII.GetString($bytes)

# Find stream ... endstream blocks
$streamMatches = [regex]::Matches($str, "stream\r?\n")
Write-Host "Total stream tags: $($streamMatches.Count)"

$extractedTexts = [System.Collections.Generic.List[string]]::new()

for ($i = 0; $i -lt $streamMatches.Count; $i++) {
    $startIdx = $streamMatches[$i].Index + $streamMatches[$i].Length
    # find endstream after startIdx
    $endIdx = $str.IndexOf("endstream", $startIdx)
    if ($endIdx -gt $startIdx) {
        $streamLen = $endIdx - $startIdx
        $streamBytes = New-Object byte[] $streamLen
        [System.Array]::Copy($bytes, $startIdx, $streamBytes, 0, $streamLen)
        
        # Try flatedecode (skip first 2 bytes if zlib header 0x78 0x9c or 0x78 0xda)
        try {
            $ms = [System.IO.MemoryStream]::new($streamBytes)
            # check zlib header
            if ($streamBytes.Length -gt 2 -and $streamBytes[0] -eq 0x78) {
                $ms.Seek(2, [System.IO.SeekOrigin]::Begin) | Out-Null
            }
            $ds = [System.IO.Compression.DeflateStream]::new($ms, [System.IO.Compression.CompressionMode]::Decompress)
            $outMs = [System.IO.MemoryStream]::new()
            $ds.CopyTo($outMs)
            $decomp = $outMs.ToArray()
            $ds.Close()
            $ms.Close()
            
            $text = [System.Text.Encoding]::UTF8.GetString($decomp)
            if ($text -match "BT" -or $text -match "Tj" -or $text -match "TJ") {
                $extractedTexts.Add($text)
            }
        } catch {
            # not a valid deflate stream
        }
    }
}

Write-Host "Extracted text streams count: $($extractedTexts.Count)"
if ($extractedTexts.Count -gt 0) {
    Write-Host "Preview of first text stream:"
    Write-Host $extractedTexts[0].Substring(0, [Math]::Min(1500, $extractedTexts[0].Length))
}
