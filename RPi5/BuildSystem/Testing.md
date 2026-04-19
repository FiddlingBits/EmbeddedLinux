# Testing
## Custom Application
```
# hello-world
```
## Launch Application On Boot
### Set Up
```
# cat << 'EOF' > /etc/systemd/system/hello-world.service
[Install]
WantedBy=multi-user.target
[Service]
ExecStart=/usr/bin/hello-world
[Unit]
Description=Hello World System
EOF
# systemctl daemon-reload
# systemctl --now enable hello-world # Load Service When System Boots
# journalctl -u hello-world # Confirm Service Successfully Started
```
