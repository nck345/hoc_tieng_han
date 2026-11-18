[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Read existing exam_data.js lines
$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\exam_data.js", $utf8)

# 2. Update real_96 questionCount in categories (around line 139)
for ($i = 130; $i -lt 150; $i++) {
    if ($lines[$i] -match '"id":\s*"real_96"') {
        for ($j = $i; $j -lt $i + 10; $j++) {
            if ($lines[$j] -match '"questionCount":\s*100') {
                $lines[$j] = $lines[$j] -replace '100', '104'
                Write-Host "Updated questionCount at line $($j+1)"
            }
        }
    }
}

# 3. Lines before old real_96 questions: line 1 to 311 (index 0 to 310)
$headerLines = $lines[0..310]

# 4. Lines after old real_96 questions: line 1149 to end (index 1148 to end)
$footerLines = $lines[1148..($lines.Length - 1)]

# 5. Load and combine the 104 new questions
function Get-ArrayInnerJson($filePath) {
    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8).Trim()
    if ($raw.StartsWith("[") -and $raw.EndsWith("]")) {
        $inner = $raw.Substring(1, $raw.Length - 2).Trim()
        return $inner
    } else {
        throw "File $filePath is not a JSON array"
    }
}

$partFiles = @(
    "scripts\topik96_data\listening_part1.json",
    "scripts\topik96_data\listening_part2.json",
    "scripts\topik96_data\writing.json",
    "scripts\topik96_data\reading_part1.json",
    "scripts\topik96_data\reading_part2.json"
)

$combinedParts = @()
foreach ($f in $partFiles) {
    $combinedParts += (Get-ArrayInnerJson $f)
}
$newQuestionsBody = ($combinedParts -join ",`n") + ","

# 6. Assemble into js/exam_data_test.js
$headerText = ($headerLines -join "`n")
$footerText = ($footerLines -join "`n")

$fullContent = $headerText + "`n" + $newQuestionsBody + "`n" + $footerText
[System.IO.File]::WriteAllText("js\exam_data_test.js", $fullContent, (New-Object System.Text.UTF8Encoding $false))

Write-Host "Wrote js\exam_data_test.js. Total size: $( (Get-Item 'js\exam_data_test.js').Length ) bytes"

# 7. Validate that it can be parsed as JSON (by stripping window.EXAM_DATA = ... ;)
$rawTest = [System.IO.File]::ReadAllText("js\exam_data_test.js", $utf8)
$jsonTest = $rawTest -replace '^\s*window\.EXAM_DATA\s*=\s*', '' -replace ';\s*$', ''
$dataTest = $jsonTest | ConvertFrom-Json

Write-Host "Validation SUCCESS!"
Write-Host "Categories: $($dataTest.categories.Count)"
Write-Host "Packs: $($dataTest.packs.Count)"
Write-Host "Total questions: $($dataTest.questions.Count)"

$cat96 = ($dataTest.categories | Where-Object { $_.id -eq "de_thi_that" }).exams | Where-Object { $_.id -eq "real_96" }
Write-Host "Kỳ thi 96 questionCount: $($cat96.questionCount)"

$q96 = @($dataTest.questions | Where-Object { $_.examId -eq "real_96" })
Write-Host "Questions for real_96: $($q96.Count)"

$qTm = @($dataTest.questions | Where-Object { $_.examId -eq "tm_01" })
Write-Host "Questions for tm_01: $($qTm.Count)"

$qHot = @($dataTest.questions | Where-Object { $_.examId -eq "hot_05" })
Write-Host "Questions for hot_05: $($qHot.Count)"
