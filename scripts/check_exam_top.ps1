$js = [System.IO.File]::ReadAllText("js/exam_data.js", [System.Text.Encoding]::UTF8)
$lines = $js -split "[\r\n]+"
$lines[0..30] | ForEach-Object { Write-Host $_ }
