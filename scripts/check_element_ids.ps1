$utf8 = [System.Text.Encoding]::UTF8
$indexHtml = [System.IO.File]::ReadAllText("index.html", $utf8)
$appJs = [System.IO.File]::ReadAllText("js\app.js", $utf8)

$matches = [regex]::Matches($appJs, 'getElementById\("([^"]+)"\)')
$ids = @()
foreach ($m in $matches) {
    $id = $m.Groups[1].Value
    if (-not $ids.Contains($id)) {
        $ids += $id
    }
}

Write-Host "Total getElementById IDs found in app.js: $($ids.Count)"
$missing = @()
foreach ($id in $ids) {
    if (-not $indexHtml.Contains("id=`"$id`"") -and -not $indexHtml.Contains("id='$id'")) {
        Write-Host "MISSING ID in index.html: $id" -ForegroundColor Red
        $missing += $id
    }
}

if ($missing.Count -eq 0) {
    Write-Host "All element IDs exist in index.html!" -ForegroundColor Green
} else {
    Write-Host "$($missing.Count) element IDs are MISSING from index.html!" -ForegroundColor Red
}
