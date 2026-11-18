$utf8 = [System.Text.Encoding]::UTF8
$content = [System.IO.File]::ReadAllText("index.html", $utf8)

$target1 = '<div class="exam-items-grid" id="exam-folder-items-grid"></div>'
$replace1 = @"
					<div class="folder-section-filter-bar" id="exam-folder-section-filter" style="display:flex;gap:8px;padding:10px 0 4px 0;flex-wrap:wrap;">
						<button class="filter-pill active" data-filter="all">📁 Tất cả các phần</button>
						<button class="filter-pill" data-filter="listening">🎧 Chỉ Phần Nghe (듣기)</button>
						<button class="filter-pill" data-filter="reading">📖 Chỉ Phần Đọc (읽기)</button>
						<button class="filter-pill" data-filter="writing">✍️ Chỉ Phần Viết (쓰기)</button>
					</div>
					<div class="exam-items-grid" id="exam-folder-items-grid"></div>
"@

if ($content.Contains($target1)) {
    $content = $content.Replace($target1, $replace1)
    Write-Host "Injected filter bar in index.html"
} else {
    Write-Host "Target1 not found in index.html"
}

$target2 = "<span>K" + [char]0x1ECB + "ch b" + [char]0x1EA3 + "n nghe (Transcript) " + [char]0x2022 + " B" + [char]0x1EA5 + "m v" + [char]0x00E0 + "o c" + [char]0x00E2 + "u " + [char]0x0111 + [char]0x1EC3 + " nghe ri" + [char]0x00EA + "ng:</span>"
$replace2 = "<span>Ph" + [char]0x1EE5 + " " + [char]0x0111 + [char]0x1EC1 + " & K" + [char]0x1ECB + "ch b" + [char]0x1EA3 + "n nghe (Transcript) " + [char]0x2022 + " B" + [char]0x1EA5 + "m v" + [char]0x00E0 + "o c" + [char]0x00E2 + "u " + [char]0x0111 + [char]0x1EC3 + " nghe ri" + [char]0x00EA + "ng:</span>"

if ($content.Contains($target2)) {
    $content = $content.Replace($target2, $replace2)
    Write-Host "Updated transcript title in index.html"
} else {
    Write-Host "Target2 not found in index.html"
}

Copy-Item "index.html" "index.html.bak" -Force
[System.IO.File]::WriteAllText("index.html", $content, (New-Object System.Text.UTF8Encoding $false))
Write-Host "Saved index.html successfully!"
