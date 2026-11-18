param(
    [string]$pdfPath,
    [int]$pageIndex = 1
)

Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
$asTaskVoid = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncAction' })[0]

function AwaitOperation($asyncOp, $type) {
    $m = $asTaskGeneric.MakeGenericMethod($type)
    $task = $m.Invoke($null, @($asyncOp))
    $task.Wait()
    return $task.Result
}

[Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfPageRenderOptions, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Media.Ocr.OcrEngine, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Globalization.Language, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Graphics.Imaging.BitmapDecoder, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.Streams.InMemoryRandomAccessStream, Windows.Storage.Streams, ContentType = WindowsRuntime] | Out-Null

$fullPath = (Resolve-Path $pdfPath).Path
$storageFile = AwaitOperation ([Windows.Storage.StorageFile]::GetFileFromPathAsync($fullPath)) ([Windows.Storage.StorageFile])
$pdfDoc = AwaitOperation ([Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)) ([Windows.Data.Pdf.PdfDocument])

$lang = New-Object Windows.Globalization.Language("ko")
$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang)

$page = $pdfDoc.GetPage([uint32]$pageIndex)
$stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
$opts = New-Object Windows.Data.Pdf.PdfPageRenderOptions
$opts.DestinationWidth = [uint32]2400
$action = $page.RenderToStreamAsync($stream, $opts)
$asTaskVoid.Invoke($null, @($action)).Wait()

$decoder = AwaitOperation ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)) ([Windows.Graphics.Imaging.BitmapDecoder])
$bitmap = AwaitOperation ($decoder.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
$ocrResult = AwaitOperation ($ocrEngine.RecognizeAsync($bitmap)) ([Windows.Media.Ocr.OcrResult])

function Parse-CharToAns($txt) {
    if ($txt -match '[\u2463\u2779\u3263\u3268@4]|\(4\)|\(9|\(\uACFC|\(\uC384') { return 4 }
    if ($txt -match '[\u2462\u2778\u3262\u3266\u326D3]|\(3\)') { return 3 }
    if ($txt -match '[\u2461\u2777\u32612]|\(2\)|2\)|21|\(\uC774') { return 2 }
    if ($txt -match '[\u2460\u2776\u32601]|\(1\)|\(0\)|\(\uAE30|\uC804\)|1\)') { return 1 }
    return 0
}

$lAnswers = @{}
$rAnswers = @{}

foreach ($line in $ocrResult.Lines) {
    foreach ($w in $line.Words) {
        $x = $w.BoundingRect.X
        $y = $w.BoundingRect.Y
        $t = $w.Text
        
        # Check if Listening (Y between 1400 and 2600)
        if ($y -ge 1400 -and $y -le 2600 -and $x -ge 650 -and $x -le 4800) {
            $row = [Math]::Floor(($y - 1420) / 215.0)
            $col = [Math]::Floor(($x - 650) / 395.0)
            if ($row -ge 0 -and $row -le 4 -and $col -ge 0 -and $col -le 9) {
                $q = [int]($row * 10 + $col + 1)
                $ans = Parse-CharToAns $t
                if ($ans -gt 0) {
                    $lAnswers[$q] = $ans
                }
            }
        }
        
        # Check if Reading (Y between 3050 and 4350)
        if ($y -ge 3050 -and $y -le 4350 -and $x -ge 650 -and $x -le 4800) {
            $row = [Math]::Floor(($y - 3080) / 215.0)
            $col = [Math]::Floor(($x - 650) / 395.0)
            if ($row -ge 0 -and $row -le 4 -and $col -ge 0 -and $col -le 9) {
                $q = [int]($row * 10 + $col + 1)
                $ans = Parse-CharToAns $t
                if ($ans -gt 0) {
                    $rAnswers[$q] = $ans
                }
            }
        }
    }
}

$lArr = 1..50 | ForEach-Object { if ($lAnswers[$_]) { $lAnswers[$_] } else { 0 } }
$rArr = 1..50 | ForEach-Object { if ($rAnswers[$_]) { $rAnswers[$_] } else { 0 } }

$lMissing = (1..50 | Where-Object { -not $lAnswers[$_] })
$rMissing = (1..50 | Where-Object { -not $rAnswers[$_] })

Write-Host "Listening answers found: $($lAnswers.Count)/50 (Missing: $($lMissing -join ', '))"
Write-Host "Reading answers found: $($rAnswers.Count)/50 (Missing: $($rMissing -join ', '))"
Write-Host "L: $($lArr -join ' ')"
Write-Host "R: $($rArr -join ' ')"
