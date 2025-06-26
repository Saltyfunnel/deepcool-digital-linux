#!/bin/bash
set -e

echo "Building deepcool-digital-linux..."
cargo build --release

echo "Installing binary to /opt/deepcool-digital/"
sudo mkdir -p /opt/deepcool-digital
sudo cp target/release/deepcool-digital-linux /opt/deepcool-digital/
sudo chmod +x /opt/deepcool-digital/deepcool-digital-linux

echo "Creating systemd service..."
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

echo "Reloading systemd daemon and enabling service..."
sudo systemctl daemon-reload
sudo systemctl enable deepcool.service
sudo systemctl start deepcool.service

echo "Installation complete!"
