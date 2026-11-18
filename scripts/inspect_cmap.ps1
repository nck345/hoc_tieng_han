$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }
$pdfFile = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }

$bytes = [System.IO.File]::ReadAllBytes($pdfFile.FullName)
$str = [System.Text.Encoding]::ASCII.GetString($bytes)

# Find ToUnicode objects
$matches = [regex]::Matches($str, "/ToUnicode\s+(\d+)\s+0\s+R")
Write-Host "Found $($matches.Count) /ToUnicode references"

$cmaps = @{}

foreach ($m in $matches) {
    $objNum = $m.Groups[1].Value
    if ($cmaps.ContainsKey($objNum)) { continue }
    
    # locate "objNum 0 obj"
    $objTag = "$objNum 0 obj"
    $objIdx = $str.IndexOf($objTag)
    if ($objIdx -ge 0) {
        $streamTag = "stream"
        $streamIdx = $str.IndexOf($streamTag, $objIdx)
        if ($streamIdx -ge 0) {
            $streamStart = $streamIdx + 6
            if ($str[$streamStart] -eq 13 -and $str[$streamStart+1] -eq 10) { $streamStart += 2 }
            elseif ($str[$streamStart] -eq 10) { $streamStart += 1 }
            
            $endstreamIdx = $str.IndexOf("endstream", $streamStart)
            $len = $endstreamIdx - $streamStart
            
            $sBytes = New-Object byte[] $len
            [System.Array]::Copy($bytes, $streamStart, $sBytes, 0, $len)
            
            try {
                $ms = [System.IO.MemoryStream]::new($sBytes)
                if ($sBytes.Length -gt 2 -and $sBytes[0] -eq 0x78) {
                    $ms.Seek(2, [System.IO.SeekOrigin]::Begin) | Out-Null
                }
                $ds = [System.IO.Compression.DeflateStream]::new($ms, [System.IO.Compression.CompressionMode]::Decompress)
                $outMs = [System.IO.MemoryStream]::new()
                $ds.CopyTo($outMs)
                $cmapText = [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())
                $cmaps[$objNum] = $cmapText
                Write-Host "Extracted CMap obj $objNum ($($cmapText.Length) chars)"
                Write-Host $cmapText.Substring(0, [Math]::Min(500, $cmapText.Length))
            } catch {
                Write-Host "Failed to decompress CMap obj $objNum : $($_.Exception.Message)"
            }
        }
    }
}
