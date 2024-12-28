#!/bin/bash
echo "Running setup.sh..."

# Step 1: Install prerequisites
echo "Installing prerequisites..."
apt-get update && apt-get install -y build-essential manpages-dev curl || { echo "Failed to install prerequisites"; exit 1; }

# Step 2: Download and build GLIBC 2.38
echo "Downloading and building GLIBC 2.38..."
mkdir /tmp/glibc_install && cd /tmp/glibc_install
curl -O http://ftp.gnu.org/gnu/libc/glibc-2.38.tar.gz
tar -xvzf glibc-2.38.tar.gz
cd glibc-2.38

# Configure and compile
mkdir build && cd build
../configure --prefix=/opt/glibc-2.38
make -j$(nproc) || { echo "Failed to build GLIBC"; exit 1; }
make install || { echo "Failed to install GLIBC"; exit 1; }

# Step 3: Update the library path to use the new GLIBC
echo "Updating library path..."
export LD_LIBRARY_PATH=/opt/glibc-2.38/lib:$LD_LIBRARY_PATH

# Verify the GLIBC version
echo "Verifying GLIBC version..."
ldd --version || { echo "GLIBC upgrade failed"; exit 1; }

# Step 4: Proceed with Node.js and Appium installation
echo "Installing Node.js and Appium..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs || { echo "Node.js installation failed"; exit 1; }
npm install -g appium@2.12.1 || { echo "Appium installation failed"; exit 1; }

# Add npm global bin to PATH
export PATH=$PATH:$(npm bin -g)

# Verify Appium installation
which appium || { echo "Appium installation failed"; exit 1; }

# Install Appium drivers
echo "Installing Appium drivers..."
appium driver install uiautomator2@3.8.1
appium driver install flutter@2.9.2
appium driver install chromium@1.4.4

echo "Setup completed successfully."