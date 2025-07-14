#!/bin/bash

# This script installs mkcert on a Debian-based system.

# Install dependencies
sudo apt-get update && sudo apt-get install -y libnss3-tools curl

# Download and install mkcert
curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
chmod +x mkcert-v*-linux-amd64
sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
rm mkcert-v*-linux-amd64
