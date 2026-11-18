$de = [System.IO.File]::ReadAllText("scripts/tm03_de_full.txt", [System.Text.Encoding]::UTF8)
$pages = $de -split "=== PAGE \d+ ==="

$bulletRegex = "(?:^|\s)(?:[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩㉭@]|\([0-9가-힣A-Za-z\.]+\)|[1-4]\s*[\)\.]|0\s+)\s*"

function Get-Page-Options($pageText) {
    # Remove header line like "6. 7. 8. 9. 10." or "TOPIK MASTER"
    $t = $pageText -replace "(?m)^\s*(?:\d+\.\s*)+\s*$", ""
    $t = $t -replace "TOPIK MASTER.*", ""
    $t = $t -replace "-\s*실전\s*모의고사.*", ""
    $t = $t -replace "\[\d+~\d+\][^\n\r]*", ""
    
    # Split by bullets or sentence ends
    $parts = [regex]::Split($t, $bulletRegex)
    $sents = @()
    foreach ($p in $parts) {
        $clean = ($p -replace "[\r\n]+", " ").Trim()
        # Sub-split on sentence endings if merged
        $subs = $clean -split "(?<=[다요죠까][\.\,])\s+"
        foreach ($s in $subs) {
            $st = $s.Trim()
            $st = $st -replace "^[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩㉭@\(\)0-9가-힣a-zA-Z\.\,\s]+(?<=[①②③④❶❷❸❹㉠㉡㉢㉣㉤㉥㉦㉧㉨㉩㉭@\.\)])\s*", ""
            $st = $st.Trim()
            if ($st.Length -gt 2 -and -not ($st -match "^(?:\d+\.|\※|\[\d|다음을|남자의|들은|여자가|이 글의)")) {
                $sents += $st
            }
        }
    }
    return $sents
}

Write-Host ">>> Testing Page 5 (expected 20 options for Q6..Q10):"
$opts5 = Get-Page-Options $pages[5]
Write-Host "Found $($opts5.Count) options:"
for ($i = 0; $i -lt $opts5.Count; $i++) {
    $qNum = 6 + [Math]::Floor($i / 4)
    $optNum = ($i % 4) + 1
    Write-Host ("Q{0,2} [{1}]: {2}" -f $qNum, $optNum, $opts5[$i])
}

Write-Host "`n>>> Testing Page 6 (expected 20 options for Q11..Q15):"
$opts6 = Get-Page-Options $pages[6]
Write-Host "Found $($opts6.Count) options:"
for ($i = 0; $i -lt $opts6.Count; $i++) {
    $qNum = 11 + [Math]::Floor($i / 4)
    $optNum = ($i % 4) + 1
    Write-Host ("Q{0,2} [{1}]: {2}" -f $qNum, $optNum, $opts6[$i])
}
