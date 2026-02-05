# LnBits Setup Guide for OpenClaw Marketplace

## 🎯 Goal

Set up Lightning Network payments via LnBits for OpenClaw Installation service.

## 📦 Requirements

- Docker and Docker Compose
- Lightning node with wallet (LND, c-lightning, or LnBits internal)
- Domain or public IP (for webhooks)

## 🚀 Quick Start (Docker)

### 1. Clone LnBits

```bash
git clone https://github.com/lnbits/lnbits.git
cd lnbits
```

### 2. Configure Environment

Create `.env` file:

```bash
# Database
LNBITS_DATA_FOLDER=/data
LNBITS_DATABASE_URL=postgres://lnbits:lnbits@lnbits-db:5432/lnbits

# Admin
LNBITS_ADMIN_UI=true

# Wallet (use internal for testing)
LNBITS_WALLET_CLASS=LnbitsWallet
LNBITS_FEE_RESERVE=5000

# Security
LNBITS_SITE_TITLE="OpenClaw Payments"
LNBITS_SITE_TAGLINE="Get your AI agent"

# Allow CORS for GitHub Pages
ALLOWED_CORS=https://exploit-zz.github.io

# Webhook secret
LNBITS_ADMIN_EXTENSIONS=fakewallet,withdraw,lndhub,lnurlp
```

### 3. Start with Docker Compose

```bash
docker-compose up -d
```

### 4. Access LnBits

- URL: http://localhost:5000
- Default credentials (on first run):
  - Click "Login" → "Create account"
  - Set username/password

### 5. Fund Wallet

**Option A: Internal wallet (testing)**
- Generate fake BTC balance (use LNBITS_FAKE_WALLET=true in .env)

**Option B: Real Lightning node**
- Connect LnBits to your LND/c-lightning node
- Fund your Lightning wallet

## 🔑 Create Payment API Key

1. Login to LnBits (http://localhost:5000)
2. Go to: Admin → API Keys
3. Create new API key with "Admin" scope
4. Copy the key (save it!)

## 💳 Create LNURL Pay Endpoint

1. Go to: Extensions → LNURL Pay
2. Create new LNURL pay link:
   - Title: "OpenClaw Installation - 8000 sats"
   - Amount: 8000
   - Success callback: https://your-webhook-url.com/payment-success
   - Description: "Get your AI agent running in 15 minutes"

3. Copy the LNURL code or QR code

## 🔌 Webhook Setup

### Create Webhook Server

Create a simple server to handle payment notifications:

```javascript
// webhook.js
const express = require('express');
const app = express();

app.use(express.json());

app.post('/payment-success', (req, res) => {
  const { amount, payment_hash, lnurl } = req.body;

  console.log(`Payment received: ${amount} sats`);

  // Process payment:
  // 1. Verify payment amount (8000 sats)
  // 2. Get order details from database
  // 3. Trigger SSH installation
  // 4. Send notification to customer

  res.status(200).send({ status: 'ok' });
});

app.listen(3000, () => {
  console.log('Webhook server running on port 3000');
});
```

### Use ngrok for testing (optional)

```bash
ngrok http 3000
```

This gives you a public URL like `https://abc123.ngrok.io` for webhooks.

## 🔗 Integration with Marketplace

### Update index.html

Add QR code and payment button:

```html
<div class="payment-section">
  <div id="qr-container">
    <img id="qr-code" src="QR_CODE_URL" alt="Scan to pay">
  </div>

  <button class="btn" id="lightningBtn">⚡ Pay with Lightning</button>

  <div id="payment-status"></div>
</div>

<script>
document.getElementById('lightningBtn').addEventListener('click', async () => {
  // Show payment instructions
  window.open('lightning:LNURL_CODE');
});

// Check payment status every 5 seconds
setInterval(async () => {
  const response = await fetch('/payment-status');
  const data = await response.json();

  if (data.paid) {
    document.getElementById('payment-status').innerHTML = '✅ Payment received!';
    // Show order form
  }
}, 5000);
</script>
```

## 🧪 Testing

### 1. Create Test Payment

```bash
# Using lnbits-cli or API
curl -X POST http://localhost:5000/api/v1/payments/lnurl \
  -H "X-Api-Key: YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 8000,
    "lnurl": "lnurl1dp68gurn8hj6mr...",
    "description": "Test payment"
  }'
```

### 2. Check Payment Status

```bash
curl http://localhost:5000/api/v1/payments \
  -H "X-Api-Key: YOUR_API_KEY"
```

## 📊 Payment Flow

```
1. Customer sees price on landing page
2. Customer scans LNURL QR code
3. Customer pays 8000 sats
4. LnBits receives payment
5. LnBits sends webhook notification
6. Webhook server processes payment
7. Server triggers SSH installation
8. Customer gets confirmation
```

## 🔒 Security Notes

- Store API keys in environment variables
- Use HTTPS in production
- Validate payment amounts on webhook
- Implement rate limiting
- Add CAPTCHA to prevent spam

## 🚀 Production Deployment

### Options:

1. **Dedicated VPS** (DigitalOcean, Hetzner, etc.)
   - Run LnBits + webhook server
   - Domain + SSL certificate
   - Cost: ~$5-10/month

2. **Cloud Service** (Render, Railway, etc.)
   - Deploy LnBits with Docker
   - Connect to external Lightning node
   - Auto-scaling

3. **Managed Service** (Voltage, etc.)
   - No server management
   - Higher cost ($20-50/month)

## 📝 Next Steps

1. [ ] Install LnBits (Docker)
2. [ ] Create API key
3. [ ] Create LNURL pay endpoint
4. [ ] Set up webhook server
5. [ ] Update marketplace page with QR code
6. [ ] Test full payment flow
7. [ ] Deploy to production

---

*Need help? Check LnBits docs: https://docs.lnbits.com*
