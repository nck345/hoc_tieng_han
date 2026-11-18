$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/index.html"
$errLog = "edge_err_" + [guid]::NewGuid().ToString("N") + ".log"
$outLog = "edge_out_" + [guid]::NewGuid().ToString("N") + ".log"

Write-Host "Testing URL: $url"

# Run headless edge
$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new", "--disable-gpu", "--enable-logging=stderr", "--v=1", "--dump-dom", "`"$url`"" -PassThru -NoNewWindow -RedirectStandardError $errLog -RedirectStandardOutput $outLog

$finished = $proc.WaitForExit(6000)
if (-not $finished) {
    try {
        Get-CimInstance Win32_Process | Where-Object { $_.Name -eq "msedge.exe" -and $_.CommandLine -match $url } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
    } catch {}
}

Start-Sleep -Milliseconds 800

function Read-FileShared($path) {
    if (-not (Test-Path $path)) { return "" }
    try {
        $stream = [System.IO.FileStream]::new($path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
        $reader = [System.IO.StreamReader]::new($stream)
        $content = $reader.ReadToEnd()
        $reader.Close()
        $stream.Close()
        return $content
    } catch {
        return ""
    }
}

$errs = Read-FileShared $errLog
$out = Read-FileShared $outLog

Remove-Item $errLog, $outLog -Force -ErrorAction SilentlyContinue

Write-Host "`n=== ERRORS / CONSOLE LOGS ==="
$hasJsError = $false
foreach ($line in ($errs -split "`r?`n")) {
    if ($line -match 'CONSOLE' -or $line -match 'SyntaxError' -or $line -match 'Uncaught' -or $line -match 'ReferenceError') {
        Write-Host $line
        $hasJsError = $true
    }
}
if (-not $hasJsError) {
    Write-Host "SUCCESS: Zero JavaScript console errors or syntax errors found!"
}

Write-Host "`n=== DOM RENDER PREVIEW (First 200 chars) ==="
if ($out.Length -gt 200) {
    Write-Host $out.Substring(0, 200)
} else {
    Write-Host $out
}
