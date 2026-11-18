Get-ChildItem -Path "C:\" -Filter "node.exe" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName
Get-ChildItem -Path "C:\" -Filter "python.exe" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName
Get-ChildItem -Path "F:\" -Filter "node.exe" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName
Get-ChildItem -Path "F:\" -Filter "python.exe" -Recurse -Depth 4 -ErrorAction SilentlyContinue | Select-Object FullName
