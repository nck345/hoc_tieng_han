$txt = [System.IO.File]::ReadAllText('js/exam_data.js', [System.Text.Encoding]::UTF8)
Write-Host "Total length: $($txt.Length)"
$matches = [regex]::Matches($txt, '["'']?examId["'']?\s*:\s*["'']([^"'']+)["'']')
$groups = $matches | Group-Object { $_.Groups[1].Value }
foreach ($g in $groups) {
    Write-Host "$($g.Name) => $($g.Count) questions"
}
