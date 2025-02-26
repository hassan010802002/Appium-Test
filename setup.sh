#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "Running setup.sh..."

# Step 1: Check and install GLIBC 2.38 if needed
echo "Checking GLIBC version..."
current_glibc=$(ldd --version 2>/dev/null | head -n 1 | grep -oE '[0-9]+\.[0-9]+')
if [[ "$current_glibc" == "2.38" ]]; then
    echo "GLIBC 2.38 is already installed. Skipping download."
else
    echo "Downloading and installing precompiled GLIBC 2.38..."
    mkdir -p /opt/glibc-2.38
    curl -L -o glibc-2.38.tar.gz http://ftp.gnu.org/gnu/libc/glibc-2.38.tar.gz || { echo "Failed to download GLIBC"; exit 1; }
    tar -xvzf glibc-2.38.tar.gz -C /opt/glibc-2.38 --strip-components=1 || { echo "Failed to extract GLIBC"; exit 1; }
    export LD_LIBRARY_PATH=/opt/glibc-2.38/lib:$LD_LIBRARY_PATH
    echo "GLIBC installation complete. Version:"
    ldd --version || { echo "GLIBC setup failed"; exit 1; }
fi

# Step 2: Install Node.js
echo "Installing Node.js..."
if ! command -v node &>/dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - || { echo "Failed to setup Node.js"; exit 1; }
    apt-get install -y nodejs || { echo "Failed to install Node.js"; exit 1; }
else
    echo "Node.js is already installed. Skipping installation."
fi

# Step 3: Install Appium
echo "Installing Appium..."
if ! command -v appium &>/dev/null; then
    npm install -g appium@2.12.1 || { echo "Failed to install Appium"; exit 1; }
else
    echo "Appium is already installed. Skipping installation."
fi

# Ensure Appium is in PATH
echo "Ensuring Appium is in PATH..."
npm_global_path=$(npm root -g 2>/dev/null)
if [[ -n "$npm_global_path" ]]; then
    export PATH="$PATH:$(dirname "$npm_global_path")"
    echo "Appium binary path added to PATH: $(dirname "$npm_global_path")"
else
    echo "Could not determine npm global path. Appium may not be available."
fi

if ! command -v appium &>/dev/null; then
    echo "Appium command still not found. Please check npm installation."
    exit 1
fi

# Step 4: Install Appium drivers
echo "Installing Appium drivers..."
appium driver install uiautomator2@3.8.1 || { echo "Failed to install uiautomator2 driver"; exit 1; }
appium driver install flutter@2.9.2 || { echo "Failed to install flutter driver"; exit 1; }
appium driver install chromium@1.4.4 || { echo "Failed to install chromium driver"; exit 1; }