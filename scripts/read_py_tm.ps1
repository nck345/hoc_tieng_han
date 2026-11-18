$py = Get-Content -Raw -Encoding UTF8 scripts/build_comprehensive_exam_data.py
$idx = $py.IndexOf("def parse_topik_master_doc")
Write-Host "Index: $idx"
if ($idx -ge 0) {
    Write-Host $py.Substring($idx, [Math]::Min(4000, $py.Length - $idx))
}
