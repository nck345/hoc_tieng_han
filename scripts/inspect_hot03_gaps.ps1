$gaps = Get-Content "scripts/hot03_gaps.json" -Raw | ConvertFrom-Json
Write-Host "hot03 gap 47: start=$($gaps[47].start) end=$($gaps[47].end)"
Write-Host "hot03 gap 48: start=$($gaps[48].start) end=$($gaps[48].end)"
