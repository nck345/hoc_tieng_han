$utf8 = [System.Text.Encoding]::UTF8
$css = [System.IO.File]::ReadAllText("css\main.css", $utf8)

$target = ".exam-items-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:14px;}"
$replace = @'
.exam-items-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:16px;}
.exam-part-box{background:var(--surface-card);border:1px solid var(--border);border-radius:var(--radius-sm);padding:10px 12px;display:flex;align-items:center;justify-content:space-between;gap:8px;transition:all 0.2s;}
.exam-part-box:hover{border-color:var(--border-light);background:rgba(255,255,255,0.03);}
.exam-part-box.listening{border-left:3px solid #3b82f6;}
.exam-part-box.reading{border-left:3px solid #10b981;}
.exam-part-box.writing{border-left:3px solid #8b5cf6;}
'@

if ($css.Contains($target)) {
    $css = $css.Replace($target, $replace)
    [System.IO.File]::WriteAllText("css\main.css", $css, (New-Object System.Text.UTF8Encoding $false))
    Write-Host "Updated css/main.css successfully!"
} else {
    Write-Host "Target not found in css/main.css"
}
