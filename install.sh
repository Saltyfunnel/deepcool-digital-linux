#!/bin/bash

APP_NAME="deepcool-digital-linux"
INSTALL_PATH="/usr/local/bin/$APP_NAME"
SERVICE_NAME="deepcool.service"
SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME"

# Make sure script is run as root
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Please run as root (e.g. sudo ./install.sh)"
  exit 1
fi

# Check for binary
if [[ ! -f "$APP_NAME" ]]; then
  echo "❌ $APP_NAME binary not found in the current directory."
  echo "Make sure the compiled binary is named '$APP_NAME' and in this folder."
  exit 1
fi

# Copy binary
cp "$APP_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"
echo "✅ Installed $APP_NAME to $INSTALL_PATH"

# Create systemd service
cat <<EOF > "$SERVICE_PATH"
[Unit]
Description=Deepcool Display Monitor
After=network.target

[Service]
ExecStart=$INSTALL_PATH --mode auto
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd, enable and start the service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable "$SERVICE_NAME"
systemctl start "$SERVICE_NAME"

echo "✅ Service '$SERVICE_NAME' enabled and started."
echo "ℹ️ It will run on boot and display CPU/GPU info in --mode auto."
