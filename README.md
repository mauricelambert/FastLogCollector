# FastLogCollector

Event collector for Linux (python) and Windows (powershell). I write theses scripts in KOTH (King of the Hill) to detect any intrusion by monitoring only one file.

> It's a POC (i write it in less than 2 hours for the KOTH), connection are not secure, there is no authentication, it's not recommended for production (you can use it in incident response if you don't have any other solution but you should consider logs as untrust, because it's very easy for an attacker to send fake/crafted logs, to sniff the network connection, to block it or to modify logs between client and server).

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

In a KOTH we know that an attack is going to happen but we don't know how, we don't know the precise minute and we don't know the attacker's skills. The use of this project in KOTH is relatively simple since it requires to read a file only continuously, when a process creation log occurs, the attack is successful, when an outgoing connection occurs the attacker tries to establish a means of communication for an easier to use takeover (reverse shell, C&C agent)...

It's possible with this project to monitor all your machines at the same time (manually, a SOC analyst should wait for a new event in the unique console) and when an attack occurs go to the compromised machine before the attacker exploits privileges escalation vulnerability and block the IP address used or the compromised user and fix the exploited vulnerability (sometime the vulnerability should be difficult to found, you should restrict access to the service used to get more time to find the vulnerability).

```bash
tail -f /root/received_logs.txt
```

## Licence

Licensed under the [GPL, version 3](https://www.gnu.org/licenses/).
