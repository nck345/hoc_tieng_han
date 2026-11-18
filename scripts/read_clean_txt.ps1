$txt = Get-Content -Raw -Encoding UTF8 scripts/tm01_listening_clean.txt
Write-Host "Length: $($txt.Length)"
Write-Host $txt.Substring(0, [Math]::Min(3000, $txt.Length))
