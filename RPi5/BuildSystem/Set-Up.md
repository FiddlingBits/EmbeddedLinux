# Set Up
## Windows
### Share Internet Over Ethernet
1. Press `Windows + R`
2. Type `ncpa.cpl` And Press Enter
3. Right-Click On WiFi Adapter And Select `Properties`
4. Select `Sharing` Tab
5. Select `Allow other network users to connect through this computer's Internet connection`
6. In Dropdown Select `Ethernet`
7. Press `OK`
8. Run `ipconfig`
9. Ethernet Port Connected To Pi Should Show `192.168.137.1`
### SSH
```
$ ssh-keygen # If SSH Key Not Already Present
$ cat ~/.ssh/id_ed25519.pub # Copy This To Raspberry Pi
$ ssh root@192.168.137.50
```
## Raspberry Pi
### IP Address
```
# cat << 'EOF' > /etc/systemd/network/10-eth0.network
[Match]
Name=eth0
[Network]
Address=192.168.137.50/24
Gateway=192.168.137.1
EOF
# systemctl enable systemd-networkd
# systemctl start systemd-networkd
```
### SSH
```
# mkdir -p ~/.ssh/
# chmod 700 ~/.ssh
# echo [HOST_PUBLIC_KEY] >> ~/.ssh/authorized_keys
# chmod 600 ~/.ssh/authorized_keys
```
