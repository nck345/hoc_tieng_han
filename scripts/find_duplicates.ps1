$utf8 = [System.Text.Encoding]::UTF8
$lines = [System.IO.File]::ReadAllLines("js\app.js", $utf8)

$methods = @{}
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '^\s*([a-zA-Z0-9_]+)\s*\([^)]*\)\s*\{') {
        $mName = $matches[1]
        if (-not $methods.ContainsKey($mName)) {
            $methods[$mName] = @()
        }
        $methods[$mName] += ($i + 1)
    }
}

foreach ($mName in $methods.Keys) {
    if ($methods[$mName].Count -gt 1) {
        Write-Host "DUPLICATE METHOD: $mName at lines: $($methods[$mName] -join ', ')" -ForegroundColor Red
    }
}
