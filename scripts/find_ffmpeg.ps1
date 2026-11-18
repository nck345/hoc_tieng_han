$ffmpeg = Get-Command ffmpeg -ErrorAction SilentlyContinue
if ($ffmpeg) {
    Write-Host "ffmpeg found: $($ffmpeg.Source)"
} else {
    Write-Host "ffmpeg not in PATH. Searching common locations..."
    $paths = @("C:\ffmpeg*", "C:\Program Files\ffmpeg*", "C:\tools\*", "C:\Users\Nguyen Thao\AppData\Local\*")
    foreach ($p in $paths) {
        Get-ChildItem -Path $p -Filter "ffmpeg.exe" -Recurse -Depth 3 -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Host "Found ffmpeg: $($_.FullName)"
        }
    }
}
