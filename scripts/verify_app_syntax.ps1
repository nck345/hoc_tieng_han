[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$appJs = [System.IO.File]::ReadAllText("js\app.js", [System.Text.Encoding]::UTF8)

# Check braces match
$openBraces = ($appJs.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($appJs.ToCharArray() | Where-Object { $_ -eq '}' }).Count
Write-Host "Braces: $openBraces open, $closeBraces close"
if ($openBraces -ne $closeBraces) {
    Write-Host "ERROR: Mismatched braces!" -ForegroundColor Red
} else {
    Write-Host "Braces match perfectly!" -ForegroundColor Green
}

# Check brackets match
$openBrackets = ($appJs.ToCharArray() | Where-Object { $_ -eq '[' }).Count
$closeBrackets = ($appJs.ToCharArray() | Where-Object { $_ -eq ']' }).Count
Write-Host "Brackets: $openBrackets open, $closeBrackets close"
if ($openBrackets -ne $closeBrackets) {
    Write-Host "ERROR: Mismatched brackets!" -ForegroundColor Red
} else {
    Write-Host "Brackets match perfectly!" -ForegroundColor Green
}

# Check parentheses match
$openParens = ($appJs.ToCharArray() | Where-Object { $_ -eq '(' }).Count
$closeParens = ($appJs.ToCharArray() | Where-Object { $_ -eq ')' }).Count
Write-Host "Parentheses: $openParens open, $closeParens close"
if ($openParens -ne $closeParens) {
    Write-Host "ERROR: Mismatched parentheses!" -ForegroundColor Red
} else {
    Write-Host "Parentheses match perfectly!" -ForegroundColor Green
}
