$files = Get-ChildItem -Path "de" -Recurse -Filter "*.pdf"

foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
    $hasFont = $ascii.Contains("/Font")
    $hasToUnicode = $ascii.Contains("/ToUnicode")
    $pages = ([regex]::Matches($ascii, "/Type\s*/Page\b")).Count
    Write-Host "$($f.FullName) => Length: $($bytes.Length), Pages: $pages, Font: $hasFont, ToUnicode: $hasToUnicode"
}
