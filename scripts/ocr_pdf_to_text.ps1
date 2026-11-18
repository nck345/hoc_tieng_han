param(
    [string]$pdfPath,
    [string]$outTextPath
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
[Windows.Media.Ocr.OcrEngine, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Globalization.Language, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null
[Windows.Graphics.Imaging.BitmapDecoder, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime] | Out-Null

$fullPath = (Resolve-Path $pdfPath).Path
Write-Host "Opening PDF: $fullPath ..."

$fileOp = [Windows.Storage.StorageFile]::GetFileFromPathAsync($fullPath)
$storageFile = AwaitOperation $fileOp ([Windows.Storage.StorageFile])

$docOp = [Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)
$pdfDoc = AwaitOperation $docOp ([Windows.Data.Pdf.PdfDocument])
$lang = New-Object Windows.Globalization.Language("ko")
$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang)

$sb = New-Object System.Text.StringBuilder
$total = $pdfDoc.PageCount
Write-Host "Total pages: $total. Starting OCR..."

for ($p = 0; $p -lt $total; $p++) {
    try {
        $page = $pdfDoc.GetPage($p)
        $stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
        $renderOp = $page.RenderToStreamAsync($stream)
        $taskVoid = $asTaskVoid.Invoke($null, @($renderOp))
        $taskVoid.Wait()

        $stream.Seek(0)
        $decoderOp = [Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream)
        $decoder = AwaitOperation $decoderOp ([Windows.Graphics.Imaging.BitmapDecoder])
        $bitmapOp = $decoder.GetSoftwareBitmapAsync()
        $softwareBitmap = AwaitOperation $bitmapOp ([Windows.Graphics.Imaging.SoftwareBitmap])

        $ocrOp = $ocrEngine.RecognizeAsync($softwareBitmap)
        $ocrResult = AwaitOperation $ocrOp ([Windows.Media.Ocr.OcrResult])

        $null = $sb.AppendLine("=== PAGE $($p + 1) ===")
        $null = $sb.AppendLine($ocrResult.Text)
    } catch {
        Write-Host "Warning on page $($p + 1): $($_.Exception.Message)"
    }
    if (($p + 1) % 10 -eq 0 -or ($p + 1) -eq $total) {
        Write-Host "Processed page $($p + 1) / $total"
    }
}

[System.IO.File]::WriteAllText($outTextPath, $sb.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "Finished OCR: $outTextPath ($($sb.Length) chars)"
