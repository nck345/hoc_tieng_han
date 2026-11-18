$ewha = Get-ChildItem "F:\ewha" | Where-Object { $_.Name -match "ti.*ng h.*n" }
$chucNangDeThi = Get-ChildItem $ewha.FullName | Where-Object { $_.Name -match "Ch.*c n.*ng .* thi" }
$topikMaster = Get-ChildItem $chucNangDeThi.FullName | Where-Object { $_.Name -match "TOPIK MASTER" }

Write-Host "Found TOPIK MASTER folder: $($topikMaster.FullName)"
$items = Get-ChildItem $topikMaster.FullName
foreach ($item in $items) {
    Write-Host "$($item.Name) - $($item.Length) bytes - isDir: $($item.PSIsContainer)"
    if ($item.PSIsContainer) {
        Get-ChildItem $item.FullName | ForEach-Object {
            Write-Host "    $($_.Name) - $($_.Length) bytes"
        }
    }
}
