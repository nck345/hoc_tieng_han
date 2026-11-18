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

$folder = (Get-ChildItem -Path "de/TOPIK MASTER" | Where-Object { $_.Name -like "*03*" })[0]
$pdfItem = (Get-ChildItem -Path $folder.FullName | Where-Object { $_.Name -like "*Transcript*.pdf" })[0]

$fileOp = [Windows.Storage.StorageFile]::GetFileFromPathAsync($pdfItem.FullName)
$storageFile = AwaitOperation $fileOp ([Windows.Storage.StorageFile])

$docOp = [Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)
$pdfDoc = AwaitOperation $docOp ([Windows.Data.Pdf.PdfDocument])
$lang = New-Object Windows.Globalization.Language("ko")
$ocrEngine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage($lang)

for ($p = 3; $p -le 5; $p++) {
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

    Write-Host "=== PAGE $p (Chars: $($ocrResult.Text.Length)) ==="
    Write-Host ($ocrResult.Text.Substring(0, [Math]::Min(500, $ocrResult.Text.Length)))
}
