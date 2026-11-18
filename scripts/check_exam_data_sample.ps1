$js = [System.IO.File]::ReadAllText("js/exam_data.js", [System.Text.Encoding]::UTF8)
$qStart = $js.IndexOf("questions:")
if ($qStart -ge 0) {
    Write-Host $js.Substring($qStart, 800)
}
