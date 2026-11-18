$files = @(
  'hot01_de_full.txt', 'hot02_de_full.txt', 'hot03_de_full.txt', 'hot04_de_full.txt',
  'tm03_de_full.txt', 'tm04_de_full.txt', 'tm05_de_full.txt'
)

foreach ($f in $files) {
    $txt = [System.IO.File]::ReadAllText("scripts/$f", [System.Text.Encoding]::UTF8)
    $m = [regex]::Match($txt, "\[4~8\][\s\S]*?(?=\[9~|$)")
    Write-Host "================ $f ================"
    if ($m.Success) {
        $val = $m.Value
        if ($val.Length -gt 400) { $val = $val.Substring(0, 400) }
        Write-Host $val
    } else {
        Write-Host "NOT FOUND"
    }
}
