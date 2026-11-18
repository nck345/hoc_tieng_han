function Parse-CMapRobust($cmapText) {
    $charMap = @{}
    
    # 1. Parse beginbfchar
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
                $dstStr = [System.Text.Encoding]::BigEndianUnicode.GetString($dstBytes)
                $charMap[$src] = $dstStr
            }
        }
    }
    
    # 2. Parse beginbfrange
    $bfrangeMatches = [regex]::Matches($cmapText, "beginbfrange\r?\n([\s\S]*?)endbfrange")
    foreach ($m in $bfrangeMatches) {
        $lines = $m.Groups[1].Value -split "`r?`n"
        foreach ($line in $lines) {
            # Type A: <start> <end> <destStart>
            if ($line -match "<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>") {
                $srcStart = [Convert]::ToInt32($matches[1], 16)
                $srcEnd = [Convert]::ToInt32($matches[2], 16)
                $dstStart = [Convert]::ToInt32($matches[3], 16)
                for ($s = $srcStart; $s -le $srcEnd; $s++) {
                    $d = $dstStart + ($s - $srcStart)
                    $charMap[$s] = [char]$d
                }
            }
            # Type B: <start> <end> [ <dest1> <dest2> ... ]
            elseif ($line -match "<([0-9A-Fa-f]+)>\s+<([0-9A-Fa-f]+)>\s+\[([\s\S]*?)\]") {
                $srcStart = [Convert]::ToInt32($matches[1], 16)
                $srcEnd = [Convert]::ToInt32($matches[2], 16)
                $destTokens = [regex]::Matches($matches[3], "<([0-9A-Fa-f]+)>")
                for ($t = 0; $t -lt $destTokens.Count -and ($srcStart + $t) -le $srcEnd; $t++) {
                    $dHex = $destTokens[$t].Groups[1].Value
                    $dBytes = New-Object byte[] ($dHex.Length / 2)
                    for ($b = 0; $b -lt $dBytes.Length; $b++) {
                        $dBytes[$b] = [Convert]::ToByte($dHex.Substring($b * 2, 2), 16)
                    }
                    $charMap[$srcStart + $t] = [System.Text.Encoding]::BigEndianUnicode.GetString($dBytes)
                }
            }
        }
    }
    return $charMap
}

Write-Host "Parse-CMapRobust defined successfully!"
