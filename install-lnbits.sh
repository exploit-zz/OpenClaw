#!/bin/bash

# LnBits Direct Installation Script
# Version: 1.0 - SQLite version (simplest)

set -e

echo "🚀 LnBits Installation Script"
echo "================================"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "📥 Installing Python 3..."

    if [ "$(uname)" = "Darwin" ]; then
        brew install python3
    else
        sudo apt-get install -y python3 python3-pip python3-venv
    fi
else
    PYTHON_VERSION=$(python3 --version)
    echo "✅ Python 3 installed: $PYTHON_VERSION"
fi

echo ""

# Create virtual environment
echo "📦 Creating virtual environment..."
python3 -m venv lnbits-env
source lnbits-env/bin/activate

echo "✅ Virtual environment created"
echo ""

# Install dependencies
echo "📥 Installing LnBits and dependencies..."
pip install --upgrade pip
pip install lnbits[standard]
pip install uvicorn[standard]

echo "✅ LnBits installed"
echo ""

# Create data directory
mkdir -p lnbits-data

echo "📝 Creating configuration..."

# Create .env file
cat > .lnbits.env <<EOF
# LnBits Configuration (SQLite version)

# Database (SQLite)
LNBITS_DATA_FOLDER=./lnbits-data
LNBITS_DATABASE_URL=sqlite:///./lnbits-data/lnbits.db

# Admin UI
LNBITS_ADMIN_UI=true

# Site Branding
LNBITS_SITE_TITLE="OpenClaw Payments"
LNBITS_SITE_TAGLINE="Get your AI agent running in 15 minutes"

# CORS (allow GitHub Pages)
LNBITS_ALLOWED_CORS=https://exploit-zz.github.io,https://localhost

# Wallet Settings
LNBITS_WALLET_CLASS=LnbitsWallet
LNBITS_FEE_RESERVE=5000

# Admin Extensions
LNBITS_ADMIN_EXTENSIONS=fakewallet,withdraw,lnurlp

# Fake Wallet (for testing - set to true for development)
LNBITS_FAKE_WALLET=true
EOF

echo "✅ Configuration created: .lnbits.env"
echo ""

echo "🎉 LnBits installation complete!"
echo ""
echo "📝 To start LnBits:"
echo "  source lnbits-env/bin/activate"
echo "  lnbits migrate"
echo "  lnbits run"
echo ""
echo "🌐 LnBits will be available at: http://localhost:5000"
echo ""
echo "💡 For production:"
echo "  - Set LNBITS_FAKE_WALLET=false"
echo "  - Connect to real Lightning node"
echo "  - Use gunicorn or uvicorn workers"
