$txt = Get-Content -Raw -Encoding UTF8 scripts/tm03_de_full.txt
$idxListen = $txt.IndexOf([regex]::Unescape("\uB4E3\uAE30(1\uBC88~50\uBC88)"))
if ($idxListen -lt 0) { $idxListen = $txt.IndexOf([regex]::Unescape("\uB4E3\uAE30")) }
$idxRead = $txt.IndexOf([regex]::Unescape("\uC77D\uAE30(1\uBC88~50\uBC88)"))
if ($idxRead -lt 0) { $idxRead = $txt.IndexOf([regex]::Unescape("\uC77D\uAE30")) }

$deListen = $txt.Substring($idxListen, $idxRead - $idxListen)
$deRead = $txt.Substring($idxRead)

Write-Host "deListen length: $($deListen.Length), deRead length: $($deRead.Length)"

$m4 = [regex]::Match($deListen, "4\.\s*([\s\S]*?)5\.\s*")
if ($m4.Success) {
    Write-Host "=== RAW Q4 in deListen ==="
    $raw = $m4.Groups[1].Value
    $raw -split "[\r\n]+" | ForEach-Object { Write-Host "LINE: [$_]" }
}
$m5 = [regex]::Match($deListen, "5\.\s*([\s\S]*?)6\.\s*")
if ($m5.Success) {
    Write-Host "=== RAW Q5 in deListen ==="
    $raw = $m5.Groups[1].Value
    $raw -split "[\r\n]+" | ForEach-Object { Write-Host "LINE: [$_]" }
}
