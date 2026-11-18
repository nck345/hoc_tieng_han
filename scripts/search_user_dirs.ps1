$dirs = @('C:\Users\Nguyen Thao\Downloads', 'C:\Users\Nguyen Thao\Desktop', 'C:\Users\Nguyen Thao\Documents')
foreach ($d in $dirs) {
    if (Test-Path $d) {
        Write-Host "Checking $d"
        Get-ChildItem -Path $d -Filter '*TOPIK*' -Recurse -Depth 2 -ErrorAction SilentlyContinue | Select-Object -First 20 FullName, Length | Format-Table -AutoSize
        Get-ChildItem -Path $d -Filter '*chi ti*' -Recurse -Depth 2 -ErrorAction SilentlyContinue | Select-Object -First 20 FullName, Length | Format-Table -AutoSize
    }
}
