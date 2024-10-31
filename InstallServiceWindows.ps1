Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install nssm

$NSSMPath = (Get-Command "nssm.exe").Source
$NewServiceName = "FastLogCollectorWindowsClient"
$PoShPath= (Get-Command powershell).Source
$PoShScriptPath = "C:\Users\Administrator\services\FastLogCollectorWindowsClient.ps1"
$args = '-ExecutionPolicy Bypass -NoProfile -File "{0}"' -f $PoShScriptPath
& $NSSMPath install $NewServiceName $PoShPath $args
& $NSSMPath status $NewServiceName

Start-Service $NewServiceName
Get-Service $NewServiceName