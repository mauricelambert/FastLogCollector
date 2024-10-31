sudo apt install -y auditd
sudo wget https://raw.githubusercontent.com/Neo23x0/auditd/refs/heads/master/audit.rules -O /etc/audit/rules.d/audit.rules
sudo chown root:root /etc/audit/rules.d/audit.rules
sudo chmod 640 /etc/audit/rules.d/audit.rules
sudo apt install -y ufw
sudo ufw enable
sudo ufw logging on
sudo systemctl restart auditd.service
sudo systemctl daemon-reload
sudo systemctl start FastLogCollectorLinuxClient
sudo systemctl start FastLogCollectorServer