#!/bin/bash
# Install Node.js and Appium globally
echo "Running setup.sh..."

# Install Appium globally if it's not already installed
npm list -g appium || npm install -g appium@2.12.1

# Install necessary Appium drivers
appium driver install uiautomator2@3.8.1
appium driver install flutter@2.9.2
appium driver install chromium@1.4.4

echo "Appium setup completed."
