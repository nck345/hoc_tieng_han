Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipFile = (Get-ChildItem -Path "F:\ewha" -Filter "*.zip")[0].FullName
$zip = [System.IO.Compression.ZipFile]::OpenRead($zipFile)
$entries = $zip.Entries | Where-Object { $_.FullName -like '*chi ti*' }
Write-Host "Found chi tiet entries in zip: $($entries.Count)"
foreach ($e in $entries) {
    Write-Host $e.FullName
}
$zip.Dispose()
