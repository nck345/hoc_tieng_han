$path = "C:\Users\Nguyen Thao\Downloads\TOPIK (1).pdf"
$stream = [System.IO.File]::OpenRead($path)
$reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII)

$chunkSize = 65536
$buffer = New-Object char[] $chunkSize
$read = $reader.Read($buffer, 0, $chunkSize)
$str = [string]::new($buffer, 0, $read)
$idx = $str.IndexOf("3 0 obj")
if ($idx -ge 0) {
    Write-Host "Found '3 0 obj':"
    Write-Host $str.Substring($idx, [Math]::Min(1000, $str.Length - $idx))
}
$stream.Close()
