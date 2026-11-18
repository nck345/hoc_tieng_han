$pyPaths = @(
    "C:\Python*",
    "C:\Users\Nguyen Thao\AppData\Local\Programs\Python\*",
    "C:\ProgramData\anaconda3\*",
    "C:\ProgramData\miniconda3\*",
    "C:\Users\Nguyen Thao\anaconda3\*",
    "C:\Users\Nguyen Thao\miniconda3\*"
)
foreach ($p in $pyPaths) {
    Get-ChildItem -Path $p -Filter "python.exe" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Host "Found Python: $($_.FullName)"
    }
}
