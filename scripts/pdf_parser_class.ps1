class PdfParser {
    [hashtable]$cmaps = @{}
    [hashtable]$fontToCmap = @{}
    
    PdfParser($pdfPath) {
        $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
        $str = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        # 1. Parse font objects and find /ToUnicode
        $fontMatches = [regex]::Matches($str, "<<\s*/Type\s*/Font\b[\s\S]*?>>")
        foreach ($fm in $fontMatches) {
            $fText = $fm.Value
            if ($fText -match "/ToUnicode\s+(\d+)\s+0\s+R") {
                $cmapObjNum = $matches[1]
                # Extract font name if present
                if ($fText -match "/BaseFont\s*/([A-Za-z0-9_\-\+]+)") {
                    # e.g. /F1 or font tag
                }
            }
        }
    }
}

Write-Host "Ready to build full CMap-based PDF extractor"
