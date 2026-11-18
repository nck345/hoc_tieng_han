$dirs = Get-ChildItem -Path "de" -Recurse -Directory
foreach ($d in $dirs) {
    $items = Get-ChildItem -Path $d.FullName
    if ($items.Count -eq 0) {
        Write-Host "Removing empty dir:" $d.FullName
        Remove-Item -Path $d.FullName -Force -Recurse
    }
}
