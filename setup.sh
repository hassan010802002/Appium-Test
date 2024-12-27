#!/bin/bash
echo "Running setup.sh..."

# Ensure we're in the correct directory (if package.json is not in /app)
cd /app

# Install dependencies if package.json is present
if [ -f "package.json" ]; then
    npm install --omit=dev
else
    echo "package.json not found, skipping npm install."
fi

# Install Appium globally if not installed
npm list -g appium || npm install -g appium@2.12.1

# Add the npm global bin directory to the PATH
export PATH=$PATH:$(npm bin -g)

# Verify appium installation
appium --version 

# Install necessary Appium drivers
appium driver install uiautomator2@3.8.1
appium driver install flutter@2.9.2
appium driver install chromium@1.4.4

echo "Appium setup completed."