function Extract-PdfToCleanText($pdfPath, $outTxtPath) {
    Write-Host "Extracting from $pdfPath ..."
    $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
    $str = [System.Text.Encoding]::ASCII.GetString($bytes)
    
    # 1. Extract all CMaps
    $cmaps = @{}
    $cmapMatches = [regex]::Matches($str, "/ToUnicode\s+(\d+)\s+0\s+R")
    foreach ($cm in $cmapMatches) {
        $objNum = $cm.Groups[1].Value
        if ($cmaps.ContainsKey($objNum)) { continue }
        
        $objTag = "$objNum 0 obj"
        $objIdx = $str.IndexOf($objTag)
        if ($objIdx -ge 0) {
            $streamTag = "stream"
            $streamIdx = $str.IndexOf($streamTag, $objIdx)
            if ($streamIdx -ge 0) {
                $start = $streamIdx + 6
                if ($str[$start] -eq 13 -and $str[$start+1] -eq 10) { $start += 2 }
                elseif ($str[$start] -eq 10) { $start += 1 }
                $end = $str.IndexOf("endstream", $start)
                $len = $end - $start
                $sBytes = New-Object byte[] $len
                [System.Array]::Copy($bytes, $start, $sBytes, 0, $len)
                
                try {
                    $ms = [System.IO.MemoryStream]::new($sBytes)
                    if ($sBytes[0] -eq 0x78) { $ms.Seek(2, [System.IO.SeekOrigin]::Begin) | Out-Null }
                    $ds = [System.IO.Compression.DeflateStream]::new($ms, [System.IO.Compression.CompressionMode]::Decompress)
                    $outMs = [System.IO.MemoryStream]::new()
                    $ds.CopyTo($outMs)
                    $cmaps[$objNum] = [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())
                } catch {}
            }
        }
    }
    
    # 2. Parse CMaps
    $charMaps = @{}
    foreach ($k in $cmaps.Keys) {
        $cmapText = $cmaps[$k]
        $map = @{}
        
        $bfcharMatches = [regex]::Matches($cmapText, "beginbfchar\r?\n([\s\S]*?)endbfchar")
        foreach ($m in $bfcharMatches) {
            $lines = $m.Groups[1].Value -split "`r?`n"
            foreach ($line in $lines) {
                if ($line -match "<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>") {
                    $src = [Convert]::ToInt32($matches[1], 16)
                    $dstHex = $matches[2]
                    $dstBytes = New-Object byte[] ($dstHex.Length / 2)
                    for ($b = 0; $b -lt $dstBytes.Length; $b++) {
                        $dstBytes[$b] = [Convert]::ToByte($dstHex.Substring($b * 2, 2), 16)
                    }
                    $map[$src] = [System.Text.Encoding]::BigEndianUnicode.GetString($dstBytes)
                }
            }
        }
        
        $bfrangeMatches = [regex]::Matches($cmapText, "beginbfrange\r?\n([\s\S]*?)endbfrange")
        foreach ($m in $bfrangeMatches) {
            $lines = $m.Groups[1].Value -split "`r?`n"
            foreach ($line in $lines) {
                if ($line -match "<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>") {
                    $srcStart = [Convert]::ToInt32($matches[1], 16)
                    $srcEnd = [Convert]::ToInt32($matches[2], 16)
                    $dstStart = [Convert]::ToInt32($matches[3], 16)
                    for ($s = $srcStart; $s -le $srcEnd; $s++) {
                        $d = $dstStart + ($s - $srcStart)
                        $map[$s] = [char]$d
                    }
                }
            }
        }
        $charMaps[$k] = $map
    }
    
    # Combined master map
    $allMap = @{}
    foreach ($k in $charMaps.Keys) {
        foreach ($cid in $charMaps[$k].Keys) {
            $allMap[$cid] = $charMaps[$k][$cid]
        }
    }
    
    # 3. Extract all text
    $fullText = [System.Text.StringBuilder]::new()
    $streamMatches = [regex]::Matches($str, "stream\r?\n")
    
    for ($i = 0; $i -lt $streamMatches.Count; $i++) {
        $startIdx = $streamMatches[$i].Index + $streamMatches[$i].Length
        $endIdx = $str.IndexOf("endstream", $startIdx)
        if ($endIdx -le $startIdx) { continue }
        $len = $endIdx - $startIdx
        $sBytes = New-Object byte[] $len
        [System.Array]::Copy($bytes, $startIdx, $sBytes, 0, $len)
        
        try {
            $ms = [System.IO.MemoryStream]::new($sBytes)
            if ($sBytes[0] -eq 0x78) { $ms.Seek(2, [System.IO.SeekOrigin]::Begin) | Out-Null }
            $ds = [System.IO.Compression.DeflateStream]::new($ms, [System.IO.Compression.CompressionMode]::Decompress)
            $outMs = [System.IO.MemoryStream]::new()
            $ds.CopyTo($outMs)
            $streamText = [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())
            
            if ($streamText.Contains("BT")) {
                $btMatches = [regex]::Matches($streamText, "BT([\s\S]*?)ET")
                foreach ($bt in $btMatches) {
                    $btContent = $bt.Groups[1].Value
                    
                    # Match all text chunks in BT block
                    $chunks = [regex]::Matches($btContent, "(\[[\s\S]*?\]|\([^\)]*\)|<[0-9A-Fa-f]+>)\s*T[jJ]")
                    foreach ($chk in $chunks) {
                        $raw = $chk.Groups[1].Value
                        # Hex tokens inside
                        $hexMatches = [regex]::Matches($raw, "<([0-9A-Fa-f]+)>")
                        foreach ($hm in $hexMatches) {
                            $hex = $hm.Groups[1].Value
                            for ($c = 0; $c -lt $hex.Length; $c += 4) {
                                if ($c + 4 -le $hex.Length) {
                                    $cid = [Convert]::ToInt32($hex.Substring($c, 4), 16)
                                    if ($allMap.ContainsKey($cid)) {
                                        [void]$fullText.Append($allMap[$cid])
                                    } elseif ($cid -ge 32 -and $cid -le 126) {
                                        [void]$fullText.Append([char]$cid)
                                    }
                                }
                            }
                        }
                        # Paren tokens inside
                        $parenMatches = [regex]::Matches($raw, "\(([^\)]*)\)")
                        foreach ($pm in $parenMatches) {
                            $pStr = $pm.Groups[1].Value
                            [void]$fullText.Append($pStr)
                        }
                    }
                    [void]$fullText.AppendLine()
                }
            }
        } catch {}
    }
    
    $result = $fullText.ToString()
    [System.IO.File]::WriteAllText($outTxtPath, $result, [System.Text.Encoding]::UTF8)
    Write-Host "Wrote $($result.Length) characters to $outTxtPath"
    return $result
}

$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

$nghePdf = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }
$resL = Extract-PdfToCleanText $nghePdf.FullName "scripts\tm01_listening_clean.txt"

$docPdf = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Đọc chi ti|Doc chi ti" }
$resR = Extract-PdfToCleanText $docPdf.FullName "scripts\tm01_reading_clean.txt"

$dapAnPdf = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Đáp Án|Dap An" }
$resD = Extract-PdfToCleanText $dapAnPdf.FullName "scripts\tm01_dapan_clean.txt"

Write-Host "All 3 PDFs extracted!"
