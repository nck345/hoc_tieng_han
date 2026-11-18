if (Test-Path scripts/tm01_dapan_clean.txt) {
    $info = Get-Item scripts/tm01_dapan_clean.txt
    Write-Host "dapan length: $($info.Length) bytes"
}
if (Test-Path scripts/tm01_de_clean.txt) {
    $info = Get-Item scripts/tm01_de_clean.txt
    Write-Host "de length: $($info.Length) bytes"
}
if (Test-Path scripts/tm01_reading_clean.txt) {
    $info = Get-Item scripts/tm01_reading_clean.txt
    Write-Host "reading length: $($info.Length) bytes"
}
