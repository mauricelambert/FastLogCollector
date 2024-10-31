# FastLogCollector

Event collector for Linux (python) and Windows (powershell). I write theses scripts in KOTH (King of the Hill) to detect any intrusion by monitoring only one file.

> It's a POC (i write it in less than 2 hours for the KOTH), connection are not secure, there is no authentication, it's not recommended for production (you can use it in incident response if you don't have any other solution but you should consider logs as untrust, because it's very easy for an attacker to send fake/crafted logs).

## Install

### Linux

1. Change IP and port in `FastLogCollectorServer.py` and `FastLogCollectorLinuxClient.py`.
2. Write or copy the `FastLogCollectorServer.py` in `/root` directory (as `/root/FastLogCollectorServer.py`).
3. Write or copy the `FastLogCollectorLinuxClient.py` in `/root` directory (as `/root/FastLogCollectorLinuxClient.py`).
4. Write or copy the `FastLogCollectorServer.service` in `/etc/systemd/system` directory (as `/etc/systemd/system/FastLogCollectorServer.service`).
5. Write or copy the `FastLogCollectorLinuxClient.service` in `/etc/systemd/system` directory (as `/etc/systemd/system/FastLogCollectorLinuxClient.service`).
6. Run the script: `InstallAndConfigureAuditAndFirewall.sh` with root privileges (`sudo bash InstallAndConfigureAuditAndFirewall.sh`).

### Windows

1. Change IP and port in `FastLogCollectorWindowsClient.ps1`.
2. Write or copy the `FastLogCollectorWindowsClient.ps1` in `C:\Users\Administrator\services` directory (as `C:\Users\Administrator\services\FastLogCollectorWindowsClient.ps1`).
3. Run the script: `SysmonInstallAndConfigure.ps1` as Administrator.
4. Run the script: `InstallServiceWindows.ps1` as Administrator.

## Usages

## Licence

Licensed under the [GPL, version 3](https://www.gnu.org/licenses/).
