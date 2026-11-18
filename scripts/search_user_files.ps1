$locations = @(
    "C:\Users\Nguyen Thao\Downloads",
    "C:\Users\Nguyen Thao\Desktop",
    "C:\Users\Nguyen Thao\Documents",
    "f:\github"
)

foreach ($loc in $locations) {
    if (Test-Path $loc) {
        Write-Host "=== Searching in $loc ==="
        Get-ChildItem -Path $loc -Recurse -Depth 3 -ErrorAction SilentlyContinue | Where-Object { 
            $_.Name -match "topik|master|TOPIK|MASTER"
        } | Select-Object FullName, Length | Format-Table -AutoSize
    }
}
