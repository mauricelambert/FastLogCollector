$SysmonUrl = "\\live.sysinternals.com\tools\Sysmon64.exe"
$ConfigUrl = "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml"
$ConfigPath = "$env:TEMP\sysmonconfig.xml"
$LogPath = "$env:TEMP\sysmon_install.log"

Invoke-WebRequest -Uri $ConfigUrl -OutFile $ConfigPath
$SysmonArgs = "-accepteula -i `"$ConfigPath`""
Start-Process -FilePath $SysmonUrl -ArgumentList $SysmonArgs -Wait -NoNewWindow

if (Get-Service -Name Sysmon64 -ErrorAction SilentlyContinue) {
    Write-Host "Sysmon running."
} else {
    Write-Error "Sysmon not running."
}

Remove-Item $ConfigPath -Force
