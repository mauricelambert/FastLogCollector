# /root/FastLogCollectorLinuxClient.py

from urllib.request import urlopen, Request
from threading import Thread
from base64 import b16decode
from time import sleep
from json import dumps
from os import getpid

audit_log_path = "/var/log/audit/audit.log"
ufw_log_path = "/var/log/ufw.log"

ip = "192.168.56.1"
port = 8080

command_line = open("/proc/self/cmdline", "rb").read().strip(b"\0")
protocol = (2).to_bytes(2, 'little')
port_bytes = (port).to_bytes(2)
ip_bytes = bytes([int(x) for x in ip.split(".")])

exclude_string = f" pid={getpid()} "
exclude_end1 = f" proctitle={b16encode(command_line).decode()}\n"
exclude_end2 = f" saddr={b16encode(protocol + port_bytes + ip_bytes).decode()}0000000000000000\n"

url = f"http://{ip}:{port}"


def tail(filepath):
    """
    Generator function to read new lines from a file as they are written.
    """

    with open(filepath, 'r') as file:
        file.seek(0, 2)
        while True:
            line = file.readline()
            if not line:
                sleep(1)
                continue
            yield line

def send_log_to_server(log):
    """
    Send log data to the server using POST request.
    """

    if exclude_string in log or log.endswith(exclude_end1) or log.endswith(exclude_end2):
        return

    try:
        response = urlopen(Request(url, headers={'Content-Type': 'application/json'}, data=dumps({"log": log}).encode()))
        # print(f"Sent log: {log.strip()} - Status Code: {response.status}")
    except Exception as e:
        print(f"Error sending log: {e}")

def monitor_log(file):
    """
    Monitor a log file and send new entries to the server. 
    """

    while True:
        for log_line in tail(file):
            send_log_to_server(log_line)

def monitor_logs():
    """
    Monitor both logs and send new entries to the server.
    """

    audit_log_tail = Thread(target=monitor_log, args=(audit_log_path,)).start()
    ufw_log_tail = monitor_log(ufw_log_path)

if __name__ == '__main__':
    monitor_logs()
