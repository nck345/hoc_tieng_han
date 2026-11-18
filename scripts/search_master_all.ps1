Write-Host "Searching F:\ ..."
Get-ChildItem -Path "F:\" -Filter "*topik*master*" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName, Length | Format-Table -AutoSize
Get-ChildItem -Path "F:\" -Filter "*TOPIK*MASTER*" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName, Length | Format-Table -AutoSize

Write-Host "Searching C:\Users\Nguyen Thao ..."
Get-ChildItem -Path "C:\Users\Nguyen Thao" -Filter "*topik*master*" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName, Length | Format-Table -AutoSize
Get-ChildItem -Path "C:\Users\Nguyen Thao" -Filter "*TOPIK*MASTER*" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName, Length | Format-Table -AutoSize
