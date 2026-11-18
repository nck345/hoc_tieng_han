function Parse-CMap($cmapText) {
    $charMap = @{}
    
    # 1. Parse beginbfchar ... endbfchar
    $bfcharMatches = [regex]::Matches($cmapText, "beginbfchar\r?\n([\s\S]*?)endbfchar")
    foreach ($m in $bfcharMatches) {
        $lines = $m.Groups[1].Value -split "`r?`n"
        foreach ($line in $lines) {
            if ($line -match "<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>") {
                $src = [Convert]::ToInt32($matches[1], 16)
                $dst = [Convert]::ToInt32($matches[2], 16)
                $charMap[$src] = [char]$dst
            }
        }
    }
    
    # 2. Parse beginbfrange ... endbfrange
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
                    $charMap[$s] = [char]$d
                }
            }
        }
    }
    return $charMap
}

# Let's test on obj 1569 (Korean CMap)
$tmDir = Get-ChildItem "de" | Where-Object { $_.Name -match "TOPIK MASTER" }
$de01 = Get-ChildItem $tmDir.FullName | Where-Object { $_.Name -match "01" }
$pdfFile = Get-ChildItem $de01.FullName | Where-Object { $_.Name -match "Nghe chi ti" }
$bytes = [System.IO.File]::ReadAllBytes($pdfFile.FullName)
$str = [System.Text.Encoding]::ASCII.GetString($bytes)

# Extract CMap 1569
$objTag = "1569 0 obj"
$objIdx = $str.IndexOf($objTag)
$streamTag = "stream"
$streamIdx = $str.IndexOf($streamTag, $objIdx)
$streamStart = $streamIdx + 6
if ($str[$streamStart] -eq 13 -and $str[$streamStart+1] -eq 10) { $streamStart += 2 }
elseif ($str[$streamStart] -eq 10) { $streamStart += 1 }
$endstreamIdx = $str.IndexOf("endstream", $streamStart)
$len = $endstreamIdx - $streamStart
$sBytes = New-Object byte[] $len
[System.Array]::Copy($bytes, $streamStart, $sBytes, 0, $len)

$ms = [System.IO.MemoryStream]::new($sBytes)
if ($sBytes[0] -eq 0x78) { $ms.Seek(2, [System.IO.SeekOrigin]::Begin) | Out-Null }
$ds = [System.IO.Compression.DeflateStream]::new($ms, [System.IO.Compression.CompressionMode]::Decompress)
$outMs = [System.IO.MemoryStream]::new()
$ds.CopyTo($outMs)
$cmapText = [System.Text.Encoding]::UTF8.GetString($outMs.ToArray())

$map1569 = Parse-CMap $cmapText
Write-Host "Mapped $($map1569.Count) CIDs in CMap 1569!"
Write-Host "CID 0x1E56 -> $($map1569[0x1E56])"
Write-Host "CID 0x1E57 -> $($map1569[0x1E57])"
Write-Host "CID 0x1E5A -> $($map1569[0x1E5A])"
