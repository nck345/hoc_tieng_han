$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$url = "file:///f:/github/hoc_tieng_han/scripts/test_app_full_flow.html"
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $edge
$psi.Arguments = "--headless=new --disable-gpu --allow-file-access-from-files --virtual-time-budget=8000 --dump-dom " + $url
$psi.RedirectStandardOutput = $true
$psi.UseShellExecute = $false
$p = [System.Diagnostics.Process]::Start($psi)
$out = $p.StandardOutput.ReadToEnd()
$p.WaitForExit(10000)

if ($out -match 'TESTS_DONE[\s\S]*?(?=</div>)') {
    Write-Output $matches[0]
} elseif ($out -match 'ERR:[\s\S]*?(?=</div>)') {
    Write-Output $matches[0]
} else {
    Write-Output "Full output snippet:"
    Write-Output $out.Substring(0, [Math]::Min(1000, $out.Length))
}
