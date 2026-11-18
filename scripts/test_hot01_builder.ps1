# Parser test for HOT TOPIK 01
$ansRaw = Get-Content "scripts/hot01_ans_full.txt" -Raw -Encoding UTF8
$deRaw = Get-Content "scripts/hot01_de_full.txt" -Raw -Encoding UTF8

$idxAnsRead = $ansRaw.IndexOf("읽기 (1번~50번)")
$ansListen = $ansRaw.Substring(0, $idxAnsRead)
$ansRead = $ansRaw.Substring($idxAnsRead)

$idxDeRead = $deRaw.IndexOf("읽기 (1번~50번)")
$deListen = $deRaw.Substring(0, $idxDeRead)
$deRead = $deRaw.Substring($idxDeRead)

Write-Host "AnsListen: $($ansListen.Length), DeListen: $($deListen.Length)"
Write-Host "AnsRead: $($ansRead.Length), DeRead: $($deRead.Length)"
