#!/bin/bash

# OpenClaw Installation Script
# Version: 1.0
# Target: macOS & Linux

set -e

echo "🦾 OpenClaw Installation Script"
echo "================================"
echo ""

# Check if running as root (optional, but good for certain operations)
if [ "$EUID" -eq 0 ]; then
    echo "⚠️  Running as root. Some steps may require manual configuration."
    echo ""
fi

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "📦 Detected OS: $MACHINE"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "📥 Installing Node.js..."

    if [ "$MACHINE" = "Mac" ]; then
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo "🍺 Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install node
    elif [ "$MACHINE" = "Linux" ]; then
        # Detect Linux distribution
        if [ -f /etc/debian_version ]; then
            # Debian/Ubuntu
            curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif [ -f /etc/redhat-release ]; then
            # RHEL/CentOS/Fedora
            sudo dnf install -y nodejs || sudo yum install -y nodejs
        else
            echo "❌ Unsupported Linux distribution. Please install Node.js manually."
            exit 1
        fi
    else
        echo "❌ Unsupported OS. Please install Node.js manually."
        exit 1
    fi

    echo "✅ Node.js installed"
else
    NODE_VERSION=$(node -v)
    echo "✅ Node.js already installed: $NODE_VERSION"
fi

# Check Node.js version (minimum 18.x)
NODE_MAJOR_VERSION=$(node -v | cut -d'.' -f1 | sed 's/v//')
if [ "$NODE_MAJOR_VERSION" -lt 18 ]; then
    echo "❌ Node.js version 18 or higher is required. Current: $(node -v)"
    exit 1
fi

echo ""
echo "📥 Installing OpenClaw..."

# Install OpenClaw
if [ "$MACHINE" = "Mac" ]; then
    # macOS
    brew install openclaw/openclaw/openclaw
elif [ "$MACHINE" = "Linux" ]; then
    # Linux - use npm
    sudo npm install -g @openclaw/cli
else
    echo "❌ Unsupported OS for automatic installation"
    exit 1
fi

echo "✅ OpenClaw installed"
echo ""

# Verify installation
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw installation failed. Please add to PATH or install manually."
    exit 1
fi

echo "📦 OpenClaw version:"
openclaw --version
echo ""

echo ""
echo "⚙️  Initializing OpenClaw..."
echo ""

# Run openclaw configure (non-interactive mode would be better, but this is a simple version)
# For production, this should be automated with pre-configured settings
echo "⚠️  Manual configuration required. Run 'openclaw configure' to set up your instance."
echo ""

echo "📝 Next steps:"
echo "1. Run: openclaw configure"
echo "2. Create your Telegram bot via BotFather (https://t.me/botfather)"
echo "3. Connect your bot token: openclaw channel configure telegram"
echo "4. Start the gateway: openclaw gateway start"
echo ""

echo "✅ Installation complete!"
echo ""
echo "🎉 Your AI agent is ready to be configured!"
echo ""
echo "📚 Documentation: https://docs.openclaw.ai"
echo "💬 Support: https://discord.com/invite/clawd"
