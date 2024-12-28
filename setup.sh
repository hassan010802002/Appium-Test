#!/bin/bash
echo "Running setup.sh..."

# Step 1: Download and extract precompiled GLIBC 2.38
echo "Downloading and installing precompiled GLIBC 2.38..."
mkdir -p /opt/glibc-2.38
curl -L -o glibc-2.38.tar.gz http://ftp.gnu.org/gnu/libc/glibc-2.38.tar.gz || { echo "Failed to download GLIBC"; exit 1; }
tar -xvzf glibc-2.38.tar.gz -C /opt/glibc-2.38 --strip-components=1 || { echo "Failed to extract GLIBC"; exit 1; }

# Update LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/glibc-2.38/lib:$LD_LIBRARY_PATH
echo "GLIBC installation complete. Version:"
ldd --version || { echo "GLIBC setup failed"; exit 1; }

# Step 2: Install Node.js and Appium
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash - || { echo "Failed to setup Node.js"; exit 1; }
apt-get install -y nodejs || { echo "Failed to install Node.js"; exit 1; }

echo "Installing Appium..."
npm install -g appium@2.12.1 || { echo "Failed to install Appium"; exit 1; }

# Add npm global bin to PATH
export PATH=$PATH:$(npm bin -g)

# Step 3: Install Appium drivers
echo "Installing Appium drivers..."
appium driver install uiautomator2@3.8.1 || { echo "Failed to install uiautomator2 driver"; exit 1; }
appium driver install flutter@2.9.2 || { echo "Failed to install flutter driver"; exit 1; }
appium driver install chromium@1.4.4 || { echo "Failed to install chromium driver"; exit 1; }

echo "Setup completed successfully."