$g3 = (Get-Content "scripts/hot03_gaps.json" -Raw | ConvertFrom-Json)[0]
$g4 = (Get-Content "scripts/hot04_gaps.json" -Raw | ConvertFrom-Json)[0]
Write-Host "Hot03 gap 0: start=$($g3.start) end=$($g3.end)"
Write-Host "Hot04 gap 0: start=$($g4.start) end=$($g4.end)"
