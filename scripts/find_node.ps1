$nodePaths = @(
    "C:\Program Files\nodejs\node.exe",
    "C:\Program Files (x86)\nodejs\node.exe",
    "C:\Users\Nguyen Thao\AppData\Roaming\npm\*",
    "C:\Users\Nguyen Thao\AppData\Local\Programs\*"
)
foreach ($p in $nodePaths) {
    Get-ChildItem -Path $p -Filter "node.exe" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Found Node: $($_.FullName)"
    }
}
