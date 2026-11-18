Add-Type -AssemblyName System.Runtime.WindowsRuntime
$asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
$asTaskVoid = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncAction' })[0]
function AwaitOp($op, $t) { $m = $asTaskGeneric.MakeGenericMethod($t); $task = $m.Invoke($null, @($op)); $task.Wait(); return $task.Result }

[Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Pdf.PdfPageRenderOptions, Windows.Data.Pdf, ContentType = WindowsRuntime] | Out-Null
[Windows.Storage.FileIO, Windows.Storage, ContentType = WindowsRuntime] | Out-Null

function RenderPdfPage($pdfPath, $pageIdx, $outPng) {
    $storageFile = AwaitOp ([Windows.Storage.StorageFile]::GetFileFromPathAsync((Resolve-Path $pdfPath).Path)) ([Windows.Storage.StorageFile])
    $pdfDoc = AwaitOp ([Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($storageFile)) ([Windows.Data.Pdf.PdfDocument])
    $page = $pdfDoc.GetPage($pageIdx)
    
    $outFile = AwaitOp ([Windows.Storage.StorageFolder]::GetFolderFromPathAsync((Resolve-Path "scripts").Path)) ([Windows.Storage.StorageFolder])
    $destFile = AwaitOp ($outFile.CreateFileAsync($outPng, [Windows.Storage.CreationCollisionOption]::ReplaceExisting)) ([Windows.Storage.StorageFile])
    $stream = AwaitOp ($destFile.OpenAsync([Windows.Storage.FileAccessMode]::ReadWrite)) ([Windows.Storage.Streams.IRandomAccessStream])
    
    $opts = New-Object Windows.Data.Pdf.PdfPageRenderOptions
    $opts.DestinationWidth = [uint32]2400
    $action = $page.RenderToStreamAsync($stream, $opts)
    $asTaskVoid.Invoke($null, @($action)).Wait()
    $stream.Dispose()
    Write-Host "Rendered $pdfPath page $pageIdx -> $outPng"
}

RenderPdfPage "de/TOPIK MASTER/TOPIK MASTER_ĐỀ 04/TOPIK MASTER_ĐỀ 04 Đáp Án_Transcript.pdf" 0 "tm04_ans_page.png"
RenderPdfPage "de/TOPIK MASTER/TOPIK MASTER_ĐỀ 05/TOPIK MASTER_ĐỀ 05 Đáp Án_Transcript.pdf" 0 "tm05_ans_page.png"
