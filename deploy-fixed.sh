#!/bin/bash

# Exit on any error
set -e

echo "Starting post-deploy script..."

# Function to source environment files
source_env() {
    # Try to source NVM first (most common cause of the issue)
    if [ -f ~/.nvm/nvm.sh ]; then
        echo "Sourcing NVM..."
        source ~/.nvm/nvm.sh
        # Use default node version if available
        if command -v nvm &> /dev/null; then
            nvm use default 2>/dev/null || nvm use node 2>/dev/null || true
        fi
    fi
    
    # Source other common environment files
    [ -f ~/.bashrc ] && source ~/.bashrc
    [ -f ~/.profile ] && source ~/.profile
    [ -f ~/.bash_profile ] && source ~/.bash_profile
}

# Source environment
source_env

# Verify that we can find npm and pm2
echo "Checking for required tools..."
if ! command -v npm &> /dev/null; then
    echo "ERROR: npm not found in PATH after sourcing environment"
    echo "Current PATH: $PATH"
    exit 1
fi

if ! command -v pm2 &> /dev/null; then
    echo "ERROR: pm2 not found in PATH after sourcing environment"
    echo "Current PATH: $PATH" 
    exit 1
fi

echo "Found npm at: $(which npm)"
echo "Found pm2 at: $(which pm2)"

# Set NODE_ENV
export NODE_ENV=production

# Install dependencies
echo "Installing dependencies..."
npm install --production

# Reload PM2 application
echo "Reloading PM2 application..."
pm2 reload ecosystem.config.js --env production

echo "Post-deploy completed successfully!"