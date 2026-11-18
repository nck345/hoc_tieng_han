param(
    [string]$mp3File = "tm02.mp3",
    [string]$outJson = "scripts/tm02_gaps.json"
)

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

$url = "file:///" + (Get-Location).Path.Replace('\', '/') + "/scripts/detect_audio_gaps.html?file=" + $mp3File
$errFile = "temp_gaps.log"
if (Test-Path $errFile) { Remove-Item $errFile -Force -ErrorAction SilentlyContinue }

Write-Host "Running gap detection for $mp3File via Edge headless..."
$proc = Start-Process -FilePath $edgePath -ArgumentList @(
    "--headless=new",
    "--disable-gpu",
    "--allow-file-access-from-files",
    "--enable-logging=stderr",
    "--v=1",
    "`"$url`""
) -PassThru -NoNewWindow -RedirectStandardError $errFile

$found = $false
$sw = [System.Diagnostics.Stopwatch]::StartNew()
while ($sw.ElapsedMilliseconds -lt 40000 -and -not $found) {
    Start-Sleep -Milliseconds 1500
    if (Test-Path $errFile) {
        try {
            $stream = [System.IO.File]::Open($errFile, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
            $reader = New-Object System.IO.StreamReader($stream)
            $content = $reader.ReadToEnd()
            $reader.Dispose()
            $stream.Dispose()
            if ($content -match 'GAPS_JSON_START([\s\S]*?)GAPS_JSON_END') {
                $found = $true
                $json = $matches[1]
                [System.IO.File]::WriteAllText($outJson, $json)
                Write-Host "Success! Saved $outJson ($($json.Length) chars) in $($sw.Elapsed.TotalSeconds)s"
                break
            }
        } catch {
            # continue waiting
        }
    }
}

Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
Start-Sleep -Milliseconds 500

if (-not $found) {
    Write-Host "Timed out waiting for gaps JSON."
    if (Test-Path $errFile) {
        Get-Content $errFile | Where-Object { $_ -match "LOG" -or $_ -match "FOUND" }
    }
}
Remove-Item $errFile -Force -ErrorAction SilentlyContinue
