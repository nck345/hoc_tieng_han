param([string]$pdfPath)
Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
$asTaskVoid = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncAction' })[0]
function AwaitOp($op, $t) { $m = $asTaskGeneric.MakeGenericMethod($t); $task = $m.Invoke($null, @($op)); $task.Wait(); return $task.Result }

[Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfPageRenderOptions, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Media.Ocr.OcrEngine, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Globalization.Language, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Graphics.Imaging.BitmapDecoder, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.Streams.InMemoryRandomAccessStream, Windows.Storage.Streams, ContentType = WindowsRuntime] | Out-Null

$storageFile = AwaitOp ([Windows.Storage.StorageFile]::GetFileFromPathAsync((Resolve-Path $pdfPath).Path)) ([Windows.Storage.StorageFile])
$pdfDoc = AwaitOp ([Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)) ([Windows.Data.Pdf.PdfDocument])
$lang = New-Object Windows.Globalization.Language("ko")
$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang)
$page = $pdfDoc.GetPage(0)
$stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
$opts = New-Object Windows.Data.Pdf.PdfPageRenderOptions
$opts.DestinationWidth = [uint32]2000
$action = $page.RenderToStreamAsync($stream, $opts)
$asTaskVoid.Invoke($null, @($action)).Wait()
$decoder = AwaitOp ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)) ([Windows.Graphics.Imaging.BitmapDecoder])
$bitmap = AwaitOp ($decoder.GetSoftwareBitmapAsync()) ([Windows.Graphics.Imaging.SoftwareBitmap])
$ocrResult = AwaitOp ($ocrEngine.RecognizeAsync($bitmap)) ([Windows.Media.Ocr.OcrResult])

function Parse-CharToAns($txt) {
    if ($txt -match '[\u2463\u2779\u3263\u3268@4]|\(4\)|\(9|\(\uACFC|\(\uC384') { return 4 }
    if ($txt -match '[\u2462\u2778\u3262\u3266\u326D3]|\(3\)|3\)|31') { return 3 }
    if ($txt -match '[\u2461\u2777\u32612]|\(2\)|2\)|21|\(\uC774|\(\uAE30') { return 2 }
    if ($txt -match '[\u2460\u2776\u32601]|\(1\)|\(0\)|\uC804\)|1\)') { return 1 }
    return 0
}

$words = @()
foreach ($l in $ocrResult.Lines) {
    foreach ($w in $l.Words) {
        $words += [PSCustomObject]@{
            X = [double]$w.BoundingRect.X
            Y = [double]$w.BoundingRect.Y
            Text = $w.Text
        }
    }
}

# Find answers for listening: rows around Y: 2142, 2315, 2484, 2657, 2826 (+- 50)
$lRows = @(2142, 2315, 2484, 2657, 2826)
$rRows = @(5010, 5179, 5348, 5521, 5690)
$ansCols = @(631, 981, 1315, 1657, 1995, 2337, 2679, 3017, 3355, 3696)

$lAnswers = @()
for ($r = 0; $r -lt 5; $r++) {
    for ($c = 0; $c -lt 10; $c++) {
        $q = $r * 10 + $c + 1
        $targetY = $lRows[$r]
        $targetX = $ansCols[$c]
        $candidate = $words | Where-Object { [Math]::Abs($_.Y - $targetY) -lt 80 -and [Math]::Abs($_.X - $targetX) -lt 110 }
        $found = 0
        foreach ($cd in $candidate) {
            $a = Parse-CharToAns $cd.Text
            if ($a -gt 0) { $found = $a; break }
        }
        $lAnswers += $found
    }
}

$rAnswers = @()
for ($r = 0; $r -lt 5; $r++) {
    for ($c = 0; $c -lt 10; $c++) {
        $q = $r * 10 + $c + 1
        $targetY = $rRows[$r]
        $targetX = $ansCols[$c]
        $candidate = $words | Where-Object { [Math]::Abs($_.Y - $targetY) -lt 80 -and [Math]::Abs($_.X - $targetX) -lt 110 }
        $found = 0
        foreach ($cd in $candidate) {
            $a = Parse-CharToAns $cd.Text
            if ($a -gt 0) { $found = $a; break }
        }
        $rAnswers += $found
    }
}

Write-Host "Listening ($($lAnswers.Count)): $($lAnswers -join ', ')"
Write-Host "Reading ($($rAnswers.Count)): $($rAnswers -join ', ')"
