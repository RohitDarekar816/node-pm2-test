#!/bin/bash

echo "=== DEPLOYMENT ENVIRONMENT DIAGNOSTICS ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Current PATH: $PATH"
echo ""

echo "=== SHELL INFORMATION ==="
echo "Shell: $SHELL"
echo "Login shell: $(getent passwd $(whoami) | cut -d: -f7)"
echo ""

echo "=== NODE.JS DETECTION ==="
# Check common Node.js installation locations
for location in /usr/bin/node /usr/local/bin/node ~/.nvm/current/bin/node /opt/node/bin/node $(which node 2>/dev/null); do
    if [ -x "$location" ]; then
        echo "Node.js found at: $location"
        echo "Version: $($location --version 2>/dev/null || echo 'Failed to get version')"
        break
    fi
done

echo ""
echo "=== NPM DETECTION ==="
# Check common npm installation locations  
for location in /usr/bin/npm /usr/local/bin/npm ~/.nvm/current/bin/npm /opt/node/bin/npm $(which npm 2>/dev/null); do
    if [ -x "$location" ]; then
        echo "npm found at: $location"
        echo "Version: $($location --version 2>/dev/null || echo 'Failed to get version')"
        break
    fi
done

echo ""
echo "=== PM2 DETECTION ==="
# Check common pm2 installation locations
for location in /usr/bin/pm2 /usr/local/bin/pm2 ~/.nvm/current/bin/pm2 /opt/node/bin/pm2 $(which pm2 2>/dev/null); do
    if [ -x "$location" ]; then
        echo "PM2 found at: $location"
        echo "Version: $($location --version 2>/dev/null || echo 'Failed to get version')"
        break
    fi
done

echo ""
echo "=== ENVIRONMENT FILES CHECK ==="
for file in ~/.bashrc ~/.profile ~/.bash_profile ~/.nvm/nvm.sh; do
    if [ -f "$file" ]; then
        echo "$file exists"
        if grep -q "nvm\|node\|npm" "$file" 2>/dev/null; then
            echo "  - Contains Node.js/npm/nvm references"
        fi
    fi
done

echo ""
echo "=== TRYING TO SOURCE COMMON ENVIRONMENT FILES ==="
# Try to source common environment files
if [ -f ~/.nvm/nvm.sh ]; then
    echo "Sourcing ~/.nvm/nvm.sh"
    source ~/.nvm/nvm.sh
    echo "After sourcing NVM - Node: $(which node 2>/dev/null || echo 'not found')"
    echo "After sourcing NVM - npm: $(which npm 2>/dev/null || echo 'not found')"
    echo "After sourcing NVM - pm2: $(which pm2 2>/dev/null || echo 'not found')"
fi

if [ -f ~/.profile ]; then
    echo "Sourcing ~/.profile"
    source ~/.profile
    echo "After sourcing profile - Node: $(which node 2>/dev/null || echo 'not found')"
    echo "After sourcing profile - npm: $(which npm 2>/dev/null || echo 'not found')"  
    echo "After sourcing profile - pm2: $(which pm2 2>/dev/null || echo 'not found')"
fi