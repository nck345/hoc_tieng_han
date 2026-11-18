if (-not (Test-Path "scripts\lib")) {
    New-Item -ItemType Directory -Path "scripts\lib" | Out-Null
}

$pdfJsUrl = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"
$workerUrl = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js"

Write-Host "Downloading pdf.min.js ..."
Invoke-WebRequest -Uri $pdfJsUrl -OutFile "scripts\lib\pdf.min.js"
Write-Host "Downloading pdf.worker.min.js ..."
Invoke-WebRequest -Uri $workerUrl -OutFile "scripts\lib\pdf.worker.min.js"

Write-Host "Done! Files saved in scripts\lib"
