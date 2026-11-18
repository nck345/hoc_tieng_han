$js = [System.IO.File]::ReadAllText("js/exam_data.js", [System.Text.Encoding]::UTF8)
$jsonStr = $js -replace "^\s*window\.EXAM_DATA\s*=\s*", ""
# remove trailing semicolon if any
$jsonStr = $jsonStr.TrimEnd(" ;`r`n")
$data = $jsonStr | ConvertFrom-Json

Write-Host "Total questions in exam_data.js: $($data.questions.Count)"
$groups = $data.questions | Group-Object examId
foreach ($g in $groups) {
    Write-Host ('ExamId: {0,-10} Count: {1,4}' -f $g.Name, $g.Count)
}
