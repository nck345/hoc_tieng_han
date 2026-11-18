$ewha = Get-ChildItem "F:\ewha" | Where-Object { $_.Name -match "ti.*ng h.*n" }
$chucNangDeThi = Get-ChildItem $ewha.FullName | Where-Object { $_.Name -match "Ch.*c n.*ng .* thi" }
$srcTopikMaster = Get-ChildItem $chucNangDeThi.FullName | Where-Object { $_.Name -match "TOPIK MASTER" }

$destTopikMaster = "F:\github\hoc_tieng_han\de\TOPIK MASTER"

Write-Host "Copying from $($srcTopikMaster.FullName) to $destTopikMaster ..."

# Copy files in root of TOPIK MASTER
Get-ChildItem -Path $srcTopikMaster.FullName -File | ForEach-Object {
    $dest = Join-Path $destTopikMaster $_.Name
    if (-not (Test-Path $dest)) {
        Copy-Item -Path $_.FullName -Destination $dest -Force
        Write-Host "Copied root file: $($_.Name)"
    }
}

# Copy files in subfolders (TOPIK MASTER_ĐỀ 01 to 10)
Get-ChildItem -Path $srcTopikMaster.FullName -Directory | ForEach-Object {
    $subDirName = $_.Name
    $destSubDir = Join-Path $destTopikMaster $subDirName
    if (-not (Test-Path $destSubDir)) {
        New-Item -ItemType Directory -Path $destSubDir -Force | Out-Null
    }
    Get-ChildItem -Path $_.FullName -File | ForEach-Object {
        $destFile = Join-Path $destSubDir $_.Name
        if (-not (Test-Path $destFile)) {
            Copy-Item -Path $_.FullName -Destination $destFile -Force
            Write-Host "Copied: $subDirName / $($_.Name)"
        }
    }
}

Write-Host "Copy complete!"
