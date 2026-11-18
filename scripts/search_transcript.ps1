$logPath = Join-Path 'C:\Users\Nguyen Thao\.gemini\antigravity\brain\d9fa18f1-7b4c-4b46-a307-0c6816523f2a\.system_generated\logs' 'transcript.jsonl'
Select-String -Path $logPath -Pattern 'detect_hot05' -Context 2, 5 | Select-Object -First 3
