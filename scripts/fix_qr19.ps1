$utf8 = [System.Text.Encoding]::UTF8

# Fix in scripts\topik96_data\reading_part1.json
$p1 = [System.IO.File]::ReadAllText("scripts\topik96_data\reading_part1.json", $utf8)
$p1Fixed = $p1.Replace("`"반면`",`r`n`t`t`t`"반면에`"", "`"반면`"")
$p1Fixed = $p1Fixed.Replace("`"반면`",`n`t`t`t`"반면에`"", "`"반면`"")
[System.IO.File]::WriteAllText("scripts\topik96_data\reading_part1.json", $p1Fixed, (New-Object System.Text.UTF8Encoding $false))
Write-Host "Fixed reading_part1.json"

# Fix in js\exam_data.js
$examData = [System.IO.File]::ReadAllText("js\exam_data.js", $utf8)
$examDataFixed = $examData.Replace("`"반면`",`r`n`t`t`t`"반면에`"", "`"반면`"")
$examDataFixed = $examDataFixed.Replace("`"반면`",`n`t`t`t`"반면에`"", "`"반면`"")
[System.IO.File]::WriteAllText("js\exam_data.js", $examDataFixed, (New-Object System.Text.UTF8Encoding $false))
Write-Host "Fixed js\exam_data.js"
