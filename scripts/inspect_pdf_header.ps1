$path = "C:\Users\Nguyen Thao\Downloads\TOPIK (1).pdf"
$stream = [System.IO.File]::OpenRead($path)
$bytes = New-Object byte[] 4000
$count = $stream.Read($bytes, 0, 4000)
$header = [System.Text.Encoding]::ASCII.GetString($bytes)
Write-Host "=== Header ==="
Write-Host $header

# Read trailer
$stream.Seek(-4000, [System.IO.SeekOrigin]::End)
$count = $stream.Read($bytes, 0, 4000)
$trailer = [System.Text.Encoding]::ASCII.GetString($bytes)
$stream.Close()

Write-Host "=== Trailer ==="
Write-Host $trailer
