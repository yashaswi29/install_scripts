#!/bin/bash
set -e

echo "Installing Tutor..."

# Install Python3 and pip
sudo apt install python3-pip -y

# Install Tutor
pip install "tutor[full]" --break-system-packages

# Make sure it's globally accessible
sudo ln -sf /home/$USER/.local/bin/tutor /usr/local/bin

echo "Tutor installed successfully!"
