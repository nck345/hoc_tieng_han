$dirs = Get-ChildItem -Path "de" -Recurse -Directory
foreach ($d in $dirs) {
    if ($d.Name -like "*Ä*") {
        Write-Host "Removing: $($d.FullName)"
        Remove-Item $d.FullName -Recurse -Force
    }
}
