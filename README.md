# DeepCool Digital Linux Display for CH170

This project runs the DeepCool Digital Linux display software for the CH170 case, showing CPU and GPU information on the LCD screen.

## Features

- Displays CPU temperature and usage
- Displays NVIDIA GPU temperature and usage (tested on RTX 3070 Ti)
- Supports auto-rotating display mode
- Runs on Arch Linux (should work on other distros with Rust toolchain)

## Setup

### Build from source

```bash
git clone https://github.com/Saltyfunnel/deepcool-digital-linux.git
cd deepcool-digital-linux
cargo build --release
```

### Install binary and setup

Run the provided install script:

```bash
sudo ./install.sh
```

This will:

- Create `/opt/deepcool-digital`
- Copy the built binary there
- Set executable permissions
- Create and enable a systemd service that runs the software at startup

### Manual service setup (if needed)

The `install.sh` script sets up the systemd service automatically, but if you want to do it manually:

Create `/etc/systemd/system/deepcool.service` with:

```ini
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
```

Then enable and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable deepcool.service
sudo systemctl start deepcool.service
```

## Troubleshooting

- Ensure `nvidia-smi` is installed and in your PATH for GPU info.
- Make sure kernel module `k10temp` is loaded for CPU temperature.
- Run the program with `sudo` to access USB device permissions.

---

## .gitignore example for Rust

```
/target
**/*.rs.bk
Cargo.lock
```
---
