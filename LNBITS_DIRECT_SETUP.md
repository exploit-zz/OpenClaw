# LnBits Direct Installation Guide (No Docker)

## 🎯 Goal

Install LnBits directly via pip for Lightning payments.

## 📦 Prerequisites

- Python 3.8+
- pip (Python package manager)
- 500MB free space

## 🚀 Quick Install

### 1. Run Installation Script

```bash
cd /Users/bot/.openclaw/workspace/marketplace
./install-lnbits.sh
```

This will:
- Install Python 3 (if needed)
- Create virtual environment
- Install LnBits
- Create configuration file

### 2. Start LnBits

```bash
# Activate virtual environment
source lnbits-env/bin/activate

# Run database migrations
lnbits migrate

# Start LnBits server
lnbits run
```

### 3. Access LnBits

Open browser: http://localhost:5000

## 🔑 First-Time Setup

### Create Admin Account

1. Go to http://localhost:5000
2. Click "Login" or "Create account"
3. Create your admin account
4. Save credentials securely

### Configure Wallet

**For Testing (Fake Wallet):**
- Already configured in `.lnbits.env`
- `LNBITS_FAKE_WALLET=true`
- Generate fake BTC balance

**For Production (Real Lightning):**
1. Edit `.lnbits.env`:
   ```bash
   LNBITS_FAKE_WALLET=false
   ```
2. Connect to real Lightning node (LND, c-lightning, etc.)
3. Or use external Lightning service (Voltage, etc.)

## 💳 Create LNURL Pay Endpoint

### 1. Go to Extensions

http://localhost:5000/extensions/lnurlp

### 2. Create LNURL Pay Link

Click "Create" and configure:
- **Title:** "OpenClaw Installation - 8000 sats"
- **Amount:** 8000
- **Description:** "Get your AI agent running in 15 minutes"
- **Success callback:** (optional) webhook URL

### 3. Copy LNURL Code

Click "Copy" or scan QR code
- Save this code for the marketplace page
- Format: `lnurl1dp68gurn8hj6mr...`

## 🔗 Update Marketplace Page

### Update order.html

Replace the placeholder QR code with real LNURL:

```html
<div class="qr-container">
  <img src="YOUR_REAL_QR_CODE_URL" alt="Scan to pay" id="qr-code">
  <div class="hint">Scan with Bitcoin Lightning wallet</div>
</div>

<script>
// Your real LNURL code
const LNURL_CODE = "lnurl1dp68gurn8hj6mr...";

// Generate QR code
const qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=${LNURL_CODE}`;
document.getElementById('qr-code').src = qrUrl;

// Or use LnBits API to generate QR
fetch('http://localhost:5000/api/v1/lnurlp/YOUR_LINK_ID/qrcode')
  .then(response => response.blob())
  .then(blob => {
    document.getElementById('qr-code').src = URL.createObjectURL(blob);
  });
</script>
```

## 🧪 Testing

### Create Test Payment

```bash
# Using LnBits API (after creating API key)
curl -X POST http://localhost:5000/api/v1/payments/lnurl \
  -H "X-Api-Key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 8000,
    "lnurl": "lnurl1dp68gurn8hj6mr...",
    "description": "Test payment"
  }'
```

### Check Payments

Go to: http://localhost:5000/wallet

Or via API:
```bash
curl http://localhost:5000/api/v1/payments \
  -H "X-Api-Key: YOUR_API_KEY"
```

## 🔑 Create API Key

### 1. Go to Admin

http://localhost:500.com/admin

### 2. API Keys Section

Click "API Keys" → "Create new key"

### 3. Configure Key

- **Name:** "OpenClaw Marketplace"
- **Scope:** "Admin" (full access)
- **Copy key:** Save securely

Use this key in marketplace backend for payment verification.

## 🌐 Public Access (Production)

### Localhost Only

By default, LnBits runs on localhost only.

### Public Access Options

**Option A: SSH Tunnel (Quick)**
```bash
ssh -R 5000:localhost:5000 user@your-server.com
```

**Option B: Reverse Proxy (Nginx)**
```nginx
location /lnbits {
    proxy_pass http://localhost:5000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}
```

**Option C: Cloud Service (Render, Railway)**
- Deploy LnBits code to cloud
- Connect to external Lightning node
- Automatic SSL

## 📊 Architecture

```
Marketplace (GitHub Pages)
    ↓
Customer clicks "Order Now"
    ↓
Order Page (order.html)
    ↓
Customer scans LNURL QR
    ↓
Customer pays 8000 sats
    ↓
Lightning Network
    ↓
LnBits (localhost:5000)
    ↓
Webhook (optional)
    ↓
Backend API
    ↓
SSH Installation
    ↓
Status Page (status.html)
```

## 🔧 Configuration Files

### .lnbits.env

Environment configuration:
- Database URL (SQLite)
- Admin UI settings
- CORS settings
- Wallet class
- Extensions

### lnbits-data/

Data directory:
- lnbits.db (SQLite database)
- Wallet data
- Transaction history

## 🔒 Security Notes

- Change default admin password
- Use HTTPS in production
- Store API keys in environment variables
- Limit CORS to specific domains
- Enable rate limiting
- Add CAPTCHA to prevent spam

## 🚀 Production Deployment

### For Production (VPS)

1. **Get a VPS** (DigitalOcean, Hetzner, etc.)
2. **Install dependencies**
3. **Run LnBits with systemd**
4. **Configure Nginx reverse proxy**
5. **Get SSL certificate** (Let's Encrypt)
6. **Set up firewall**

### Systemd Service

Create `/etc/systemd/system/lnbits.service`:

```ini
[Unit]
Description=LnBits Lightning Wallet
After=network.target

[Service]
Type=simple
User=lnbits
WorkingDirectory=/home/lnbits/lnbits
Environment="PATH=/home/lnbits/lnbits/lnbits-env/bin"
ExecStart=/home/lnbits/lnbits/lnbits-env/bin/lnbits run
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Start service:
```bash
sudo systemctl enable lnbits
sudo systemctl start lnbits
sudo systemctl status lnbits
```

## 📝 Next Steps

1. [ ] Run `./install-lnbits.sh`
2. [ ] Start LnBits: `source lnbits-env/bin/activate && lnbits migrate && lnbits run`
3. [ ] Create admin account
4. [ ] Create LNURL pay endpoint (8000 sats)
5. [ ] Copy LNURL code
6. [ ] Update marketplace page with real LNURL
7. [ ] Test payment flow
8. [ ] Set up production (VPS, SSL, etc.)

---

*Need help? Check LnBits docs: https://docs.lnbits.com*
