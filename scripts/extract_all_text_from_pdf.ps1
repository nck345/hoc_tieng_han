function Extract-PdfText($pdfPath) {
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
                    $cmapText = [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())
                    $cmaps[$objNum] = $cmapText
                } catch {}
            }
        }
    }
    
    # Parse CMaps to character lookup tables
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
                    $dst = [Convert]::ToInt32($matches[2], 16)
                    $map[$src] = [char]$dst
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
    
    # Map Font Resource names (e.g. /F1, /F3) to CMap
    $fontToCmap = @{}
    $fontMatches = [regex]::Matches($str, "/([A-Za-z0-9_]+)\s+<<\s*/Type\s*/Font\b([\s\S]*?)>>")
    foreach ($fm in $fontMatches) {
        $fontName = $fm.Groups[1].Value
        $fBody = $fm.Groups[2].Value
        if ($fBody -match "/ToUnicode\s+(\d+)\s+0\s+R") {
            $cmapObj = $matches[1]
            if ($charMaps.ContainsKey($cmapObj)) {
                $fontToCmap[$fontName] = $charMaps[$cmapObj]
            }
        }
    }
    
    # 2. Extract and decode all text streams
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
                # Parse BT ... ET blocks
                $btMatches = [regex]::Matches($streamText, "BT([\s\S]*?)ET")
                foreach ($bt in $btMatches) {
                    $btContent = $bt.Groups[1].Value
                    # Detect current font
                    $currentFont = ""
                    if ($btContent -match "/([A-Za-z0-9_]+)\s+[\d\.]+\s+Tf") {
                        $currentFont = $matches[1]
                    }
                    $activeMap = $null
                    if ($fontToCmap.ContainsKey($currentFont)) {
                        $activeMap = $fontToCmap[$currentFont]
                    }
                    
                    # Extract Tj and TJ
                    $tjMatches = [regex]::Matches($btContent, "(\[[\s\S]*?\]|\([^\)]*\)|<[0-9A-Fa-f]+>)\s*T[jJ]")
                    foreach ($tm in $tjMatches) {
                        $tok = $tm.Groups[1].Value
                        # Hex string <1E56...>
                        $hexMatches = [regex]::Matches($tok, "<([0-9A-Fa-f]+)>")
                        foreach ($hm in $hexMatches) {
                            $hex = $hm.Groups[1].Value
                            for ($c = 0; $c -lt $hex.Length; $c += 4) {
                                if ($c + 4 -le $hex.Length) {
                                    $cid = [Convert]::ToInt32($hex.Substring($c, 4), 16)
                                    if ($activeMap -and $activeMap.ContainsKey($cid)) {
                                        [void]$fullText.Append($activeMap[$cid])
                                    } elseif ($cid -ge 32 -and $cid -le 126) {
                                        [void]$fullText.Append([char]$cid)
                                    }
                                }
                            }
                        }
                        # Parentheses string (text)
                        $parenMatches = [regex]::Matches($tok, "\(([^\)]*)\)")
                        foreach ($pm in $parenMatches) {
                            [void]$fullText.Append($pm.Groups[1].Value)
                        }
                    }
                    [void]$fullText.AppendLine()
                }
            }
        } catch {}
    }
    return $fullText.ToString()
}

$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }

$nghePdf = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }
Write-Host "Extracting Listening from: $($nghePdf.Name)"
$textL = Extract-PdfText $nghePdf.FullName
Write-Host "Total extracted text length: $($textL.Length)"
[System.IO.File]::WriteAllText("f:\github\hoc_tieng_han\scripts\extracted_tm01_listening.txt", $textL, [System.Text.Encoding]::UTF8)

$docPdf = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Đọc chi ti|Doc chi ti" }
Write-Host "Extracting Reading from: $($docPdf.Name)"
$textR = Extract-PdfText $docPdf.FullName
Write-Host "Total extracted text length: $($textR.Length)"
[System.IO.File]::WriteAllText("f:\github\hoc_tieng_han\scripts\extracted_tm01_reading.txt", $textR, [System.Text.Encoding]::UTF8)

Write-Host "`nPreview of extracted Listening (first 1000 chars):"
Write-Host $textL.Substring(0, [Math]::Min(1000, $textL.Length))
