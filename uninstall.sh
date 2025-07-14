#!/bin/bash

set -e

APP_NAME="deepcool-digital-linux"
INSTALL_PATH="/usr/local/bin/$APP_NAME"
SERVICE_PATH="/etc/systemd/system/$APP_NAME.service"

echo "Stopping and disabling $APP_NAME service..."
sudo systemctl stop $APP_NAME.service
sudo systemctl disable $APP_NAME.service

echo "Removing systemd service file..."
sudo rm -f $SERVICE_PATH

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "Removing installed binary..."
sudo rm -f $INSTALL_PATH

echo "$APP_NAME has been uninstalled successfully."
