#!/bin/bash
echo "Running setup.sh..."

# Step 1: Install Node.js (includes npm)
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs || { echo "Node.js installation failed!"; exit 1; }

# Verify Node.js and npm installation
node -v || { echo "Node.js is not installed!"; exit 1; }
npm -v || { echo "npm is not installed!"; exit 1; }
echo "Node.js and npm installed successfully."

# Step 2: Install Appium globally if not installed
echo "Installing Appium..."
npm install -g appium@2.12.1 || { echo "Appium installation failed!"; exit 1; }

# Step 3: Add npm global bin to PATH
export PATH=$PATH:$(npm bin -g)

# Verify appium installation
which appium || { echo "Appium installation failed!"; exit 1; }

# Step 4: Install Appium drivers
echo "Installing Appium drivers..."
appium driver install uiautomator2@3.8.1
appium driver install flutter@2.9.2
appium driver install chromium@1.4.4

echo "Setup completed successfully."