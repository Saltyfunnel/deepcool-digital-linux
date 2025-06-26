#!/bin/bash
set -e

echo "Installing DeepCool Digital Linux Display..."

# Create target directory
sudo mkdir -p /opt/deepcool-digital

# Copy the built binary
sudo cp target/release/deepcool-digital-linux /opt/deepcool-digital/

# Set permissions
sudo chmod +x /opt/deepcool-digital/deepcool-digital-linux

# Create systemd service file
sudo tee /etc/systemd/system/deepcool.service > /dev/null <<EOF
[Unit]
Description=DeepCool CH170 Display Service
After=multi-user.target

[Service]
Type=simple
ExecStart=/opt/deepcool-digital/deepcool-digital-linux --mode auto
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
sudo systemctl enable deepcool.service
sudo systemctl start deepcool.service

echo "Installation complete! Service started."
