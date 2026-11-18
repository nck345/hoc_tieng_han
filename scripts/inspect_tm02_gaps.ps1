$gaps = Get-Content "scripts/tm02_gaps.json" -Raw | ConvertFrom-Json
for ($i = 18; $i -lt [Math]::Min(30, $gaps.Count); $i++) {
    Write-Host "Gap $i : start=$($gaps[$i].start), end=$($gaps[$i].end), dur=$($gaps[$i].dur)"
}
