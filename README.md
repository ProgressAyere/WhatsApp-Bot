# 🤖 PROGRESS AYERE WhatsApp Bot

A feature-rich WhatsApp bot built with Baileys library, featuring media unlocking, sticker creation, games, group management, and more.

## ✨ Features

- **🔓 View-Once Unlocking**: Automatically unlocks view-once media
- **🎨 Sticker Creation**: Convert images/videos to stickers
- **🎮 Games**: Wordle, Hangman, Tic Tac Toe, and more
- **🛡️ Group Protection**: Anti-spam and anti-link features
- **👥 Group Management**: Kick, ban, promote, demote users
- **🔧 Utility Commands**: Weather, crypto, password generator, etc.
- **🎯 Entertainment**: Jokes, quotes, trivia, facts
- **🔐 Sudo System**: Multi-user admin permissions

## 🚀 Deployment on Render

### Prerequisites
- GitHub account
- Render account
- WhatsApp number for the bot

### Step 1: Prepare Your Bot
1. Set your phone number in `bot.js`:
   ```javascript
   const BOT_OWNER = 'YOUR_PHONE_NUMBER@s.whatsapp.net';
   ```

2. Make sure all dependencies are in `package.json`

### Step 2: Deploy to Render
1. **Connect to GitHub**:
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New +" → "Web Service"
   - Connect your GitHub repository

2. **Configure the Service**:
   - **Name**: `whatsapp-bot` (or your preferred name)
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `node bot.js`
   - **Plan**: Free (or paid for better performance)

3. **Environment Variables** (if needed):
   - Add any API keys or configuration

4. **Deploy**:
   - Click "Create Web Service"
   - Wait for the build to complete

### Step 3: Connect Your Bot
1. **Scan QR Code**:
   - Check the Render logs for the QR code
   - Scan with your WhatsApp number
   - The bot will connect automatically

2. **Test the Bot**:
   - Send `!ping` to test connectivity
   - Send `!help` to see all commands

## 🔧 Enhanced Features for Render

### Connection Stability
- **2-minute heartbeats**: Keeps connection alive
- **5-minute pings**: Maintains active connection
- **Automatic reconnection**: Handles connection drops
- **Memory monitoring**: Prevents memory leaks
- **Graceful shutdown**: Clean process termination

### Health Monitoring
- **Health endpoint**: `https://your-app.onrender.com/health`
- **Status page**: `https://your-app.onrender.com/`
- **Real-time monitoring**: Connection status, uptime, memory usage

## 📋 Available Commands

### Utility Commands
- `!ping` - Check bot status
- `!help` - Show help information
- `!time` - Current server time
- `!weather <city>` - Weather information
- `!crypto <coin>` - Cryptocurrency prices
- `!password [length]` - Generate secure password

### Entertainment
- `!joke` - Random jokes
- `!quote` - Inspirational quotes
- `!fact` - Random facts
- `!motivate` - Motivational quotes
- `!trivia` - Trivia questions

### Games
- `!wordle [guess]` - Play Wordle
- `!hangman [letter]` - Play Hangman
- `!tictactoe <position>` - Play Tic Tac Toe
- `!rps <rock|paper|scissors>` - Rock Paper Scissors

### Media Features
- `!sticker` - Convert image/video to sticker (reply to media)
- `!vv` - Manually unlock view-once media (reply to media)

### Group Management (Group only)
- `!tagall` - Tag all members
- `!kick @user` - Kick user from group
- `!promote @user` - Promote user to admin
- `!groupinfo` - Group information
- `!antispam <on|off>` - Toggle anti-spam
- `!antilink <on|off>` - Toggle anti-link

### Admin Commands (Owner only)
- `!addsudo @user` - Add sudo user
- `!removesudo @user` - Remove sudo user
- `!listsudo` - List sudo users
- `!owner` - Check owner status

## 🛠️ Troubleshooting

### Connection Issues
1. **Bot not connecting**:
   - Check Render logs for QR code
   - Ensure phone number is correct in `bot.js`
   - Wait for automatic reconnection

2. **Frequent disconnections**:
   - The enhanced keep-alive should handle this
   - Check memory usage in health endpoint
   - Monitor Render logs for errors

3. **Commands not working**:
   - Send `!ping` to test basic connectivity
   - Check if you're authorized (owner or sudo user)
   - Use `!debug` for detailed information

### Render-Specific Issues
1. **Build failures**:
   - Check `package.json` has all dependencies
   - Ensure Node.js version is compatible
   - Review build logs for errors

2. **Service not starting**:
   - Verify start command: `node bot.js`
   - Check environment variables
   - Review startup logs

3. **Memory issues**:
   - Bot automatically restarts if memory > 500MB
   - Monitor via health endpoint
   - Consider upgrading to paid plan

## 📊 Monitoring

### Health Check Endpoint
```bash
curl https://your-app.onrender.com/health
```

Response includes:
- Connection status
- Uptime
- Memory usage
- Reconnection attempts
- Last heartbeat time

### Logs
- Check Render dashboard for real-time logs
- Monitor for connection drops and recoveries
- Watch for memory usage patterns

## 🔄 Updates

To update your bot:
1. Make changes to your code
2. Commit and push to GitHub
3. Render will automatically redeploy
4. Monitor the deployment logs

## 📞 Support

- **Creator**: PROGRESS AYERE
- **Instagram**: @progressayere
- **Website**: https://progressayere.com
- **TikTok**: @progressayere

## 📄 License

This project is created by PROGRESS AYERE. All rights reserved.

---

**Note**: This bot is designed for personal use. Please respect WhatsApp's terms of service and use responsibly. 