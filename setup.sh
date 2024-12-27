#!/bin/bash
# Install Node.js and Appium globally
echo "Running setup.sh..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs
npm install -g appium@2.12.1
appium driver install uiautomator2@3.8.1
appium driver install flutter@2.9.2
appium driver install chromium@1.4.4
echo "Appium setup completed."