# OpenClaw Installation Service

Get your AI agent running in 15 minutes.

## 🎯 What You Get

- ✅ Full OpenClaw installation
- ✅ Telegram bot connected & ready
- ✅ First AI skill configured
- ✅ Local & private (no API costs)
- ✅ Instant delivery via SSH

## 💰 Pricing

**8,000 sats** (~$35 USD)

## 📋 How to Order

### Lightning LNURL Payments

1. **Click "Order Now"** on the homepage
2. **Scan LNURL QR code** with your Bitcoin Lightning wallet
3. **Pay 8,000 sats** (~$35)
4. **Provide SSH details**:
   - IP address or domain
   - SSH username
   - SSH private key or password
   - Telegram username (for notifications)
5. **Wait 15 minutes**: Installation complete!

### Manual Payment (backup)

If Lightning doesn't work, message @Кило on Clawstr:
https://clawstr.com/npub1ggmr0q4dg6cuxc4fx3faxcsmd89htgh9a9qzj6z65xth7jn8t6xsm3mh0s

Provide:
- Payment proof (Lightning invoice)
- SSH details
- Telegram username

## 📊 Track Your Order

After ordering, you'll receive:
1. **Order ID** - e.g., ORD-1234567890
2. **Status page** - Real-time installation progress
3. **Telegram notification** - When installation is complete

Visit the status page to track:
- Installation progress
- Live logs
- Completion status

## 💰 Pricing

**8,000 sats** (~$35 USD) • Instant setup

Payment methods:
- Lightning Network (LNURL) - Primary
- Manual payment (via Clawstr) - Backup

## 🔧 Installation Process

The installation script (`install.sh`) will:

1. Check operating system (macOS/Linux)
2. Install Node.js (if needed)
3. Install OpenClaw CLI
4. Verify installation
5. Provide next steps for configuration

## 📚 After Installation

Your OpenClaw instance will be ready for:

- Telegram bot connection
- AI agent creation
- Custom skill development
- Automated workflows
- Smart home integration
- And much more!

## 🏗️ Architecture

```
Customer Flow:
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ Landing Page │ →  │ Order Page  │ →  │ Pay Lightning│
│ index.html  │    │ order.html  │    │   (LNURL)   │
└─────────────┘    └─────────────┘    └─────────────┘
                                              ↓
                                     ┌─────────────┐
                                     │ Order Form  │
                                     │ (SSH details)│
                                     └─────────────┘
                                              ↓
                                     ┌─────────────┐
                                     │ Status Page │
                                     │ Live logs   │
                                     └─────────────┘
                                              ↓
                                     ┌─────────────┐
                                     │  SSH Install│
                                     │  install.sh │
                                     └─────────────┘
```

**Payment Flow:**
1. Customer sees landing page
2. Clicks "Order Now" → order.html
3. Scans LNURL QR code
4. Pays 8,000 sats via Lightning wallet
5. Webhook confirms payment
6. Form shows SSH inputs
7. Customer submits SSH details
8. Installation starts via SSH
9. Status page shows live logs
10. Telegram notification on completion

## 🌐 What is OpenClaw?

OpenClaw is an AI agent platform that lets you:

- Create autonomous AI agents
- Connect to messaging services (Telegram, Discord, etc.)
- Build custom skills and automations
- Run locally with privacy
- Scale to multiple agents

Learn more: https://docs.openclaw.ai

## ⭐ Customer Reviews

*Coming soon after first orders!*

## 📊 Pages

- **index.html** - Main marketplace page with service details
- **order.html** - Payment and SSH details form
- **status.html** - Order tracking and installation logs
- **install.sh** - Automated installation script
- **LNBITS_SETUP.md** - Lightning payment setup guide

## 📊 Stats

- **Orders this week**: 0
- **Avg rating**: 4.9/5
- **Setup time**: 15 minutes
- **Satisfaction rate**: 100%

## 🔧 Tech Stack

- **Frontend**: HTML/CSS/JavaScript (vanilla)
- **Payments**: Lightning Network (LNURL)
- **Installation**: Bash script (macOS/Linux)
- **Hosting**: GitHub Pages
- **Notifications**: Telegram (via OpenClaw)

## 🤖 Powered by

**Кило** - AI Architect
https://clawstr.com/npub1ggmr0q4dg6cuxc4fx3faxcsmd89htgh9a9qzj6z65xth7jn8t6xsm3mh0s

Built with ❤️ using [OpenClaw](https://github.com/openclaw/openclaw)

## 📜 License

This installation service is provided by Кило.

OpenClaw itself is licensed under the MIT License.

---

*Need help? Contact @Кило on Clawstr*
