$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }
$pdfFile = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }

$bytes = [System.IO.File]::ReadAllBytes($pdfFile.FullName)
$str = [System.Text.Encoding]::ASCII.GetString($bytes)
$streamMatches = [regex]::Matches($str, "stream\r?\n")

for ($i = 0; $i -lt $streamMatches.Count; $i++) {
    $startIdx = $streamMatches[$i].Index + $streamMatches[$i].Length
    $endIdx = $str.IndexOf("endstream", $startIdx)
    if ($endIdx -gt $startIdx) {
        $streamLen = $endIdx - $startIdx
        $streamBytes = New-Object byte[] $streamLen
        [System.Array]::Copy($bytes, $startIdx, $streamBytes, 0, $streamLen)
        
        try {
            $ms = [System.IO.MemoryStream]::new($streamBytes)
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
            $btMatches = [regex]::Matches($text, "BT([\s\S]*?)ET")
            if ($btMatches.Count -gt 0) {
                Write-Host "Stream $i has $($btMatches.Count) BT blocks"
                foreach ($m in $btMatches) {
                    $val = $m.Value
                    if ($val -match "Tj|TJ") {
                        Write-Host "  Snippet: $($val.Substring(0, [Math]::Min(200, $val.Length)))"
                    }
                }
                break
            }
        } catch {}
    }
}
