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
