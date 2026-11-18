$ewha = Get-ChildItem "F:\ewha"
foreach ($f in $ewha) {
    Write-Host "$($f.FullName)"
    Get-ChildItem $f.FullName | ForEach-Object {
        Write-Host "  $($_.FullName)"
        Get-ChildItem $_.FullName | ForEach-Object {
            Write-Host "    $($_.FullName)"
        }
    }
}
