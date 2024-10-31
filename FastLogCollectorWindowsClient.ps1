# C:\Users\Administrator\services\FastLogCollectorWindowsClient.ps1

$logSource = "Microsoft-Windows-Sysmon/Operational"

$query = [System.Diagnostics.Eventing.Reader.EventLogQuery]::new($logSource, [System.Diagnostics.Eventing.Reader.PathType]::LogName) #, "*[System[(EventID=$eventId) and Provider[@Name='Microsoft-Windows-Kernel-Power']]]")
$watcher = [System.Diagnostics.Eventing.Reader.EventLogWatcher]::new($query)
$watcher.Enabled = $true

$action = {
    $log = $EventArgs.EventRecord.ToXml()
    if ($log.Contains("<Data Name='ProcessId'>$PID</Data>")) {return}
    $jsonData = @{"log" = $log} | ConvertTo-Json -Compress
    $jsonData = $jsonData -replace '[^\x00-\x7F]', ''
    try {
        Invoke-RestMethod -Uri "http://192.168.56.1:8080" -Method POST -Body $jsonData -ContentType "application/json"
    } catch {
        Write-Host "Error sending log: $_"
    }
}

$job = Register-ObjectEvent -InputObject $watcher -EventName 'EventRecordWritten' -Action $action

while ($true) { Start-Sleep 1 }
