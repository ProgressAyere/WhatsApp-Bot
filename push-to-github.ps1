# GitHub Push Script with Safety Checks
# Run this to safely push your bot to GitHub

Write-Host "🔒 GitHub Security Check & Push Script" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in the right directory
if (!(Test-Path "bot.js")) {
    Write-Host "❌ Error: bot.js not found. Are you in the right directory?" -ForegroundColor Red
    exit 1
}

# Safety Check 1: Verify .env is gitignored
Write-Host "🔍 Checking if .env is protected..." -ForegroundColor Yellow
$envIgnored = git check-ignore .env 2>$null
if ($envIgnored -eq ".env") {
    Write-Host "✅ .env is protected (won't be pushed)" -ForegroundColor Green
} else {
    Write-Host "⚠️  WARNING: .env might not be protected!" -ForegroundColor Red
    $continue = Read-Host "Continue anyway? (yes/no)"
    if ($continue -ne "yes") {
        Write-Host "Aborted." -ForegroundColor Red
        exit 1
    }
}

# Safety Check 2: Verify auth_info is gitignored
Write-Host "🔍 Checking if auth_info/ is protected..." -ForegroundColor Yellow
$authIgnored = git check-ignore auth_info/ 2>$null
if ($authIgnored -eq "auth_info/") {
    Write-Host "✅ auth_info/ is protected (won't be pushed)" -ForegroundColor Green
} else {
    Write-Host "⚠️  WARNING: auth_info/ might not be protected!" -ForegroundColor Red
    $continue = Read-Host "Continue anyway? (yes/no)"
    if ($continue -ne "yes") {
        Write-Host "Aborted." -ForegroundColor Red
        exit 1
    }
}

# Safety Check 3: Search for potential API keys in staged files
Write-Host "🔍 Searching for potential secrets in code..." -ForegroundColor Yellow
$secretPatterns = @(
    "AIza[0-9A-Za-z-_]{35}",  # Google API Key pattern
    "sk-[a-zA-Z0-9]{48}",      # OpenAI key pattern
    "[0-9]{10,15}@s\.whatsapp\.net"  # Phone numbers
)

$foundSecrets = $false
foreach ($pattern in $secretPatterns) {
    $results = git grep -i $pattern 2>$null | Where-Object { $_ -notmatch "\.md:" }
    if ($results) {
        Write-Host "⚠️  Potential secret found: $results" -ForegroundColor Red
        $foundSecrets = $true
    }
}

if ($foundSecrets) {
    Write-Host ""
    Write-Host "⚠️  WARNING: Potential secrets detected!" -ForegroundColor Red
    $continue = Read-Host "Continue anyway? (yes/no)"
    if ($continue -ne "yes") {
        Write-Host "Aborted. Please remove secrets from code." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "✅ All safety checks passed!" -ForegroundColor Green
Write-Host ""

# Show what will be committed
Write-Host "📝 Files to be committed:" -ForegroundColor Cyan
git status --short

Write-Host ""
$proceed = Read-Host "Proceed with commit and push? (yes/no)"

if ($proceed -eq "yes") {
    # Get commit message
    Write-Host ""
    $commitMsg = Read-Host "Enter commit message (or press Enter for default)"
    
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $commitMsg = "Update bot: secure env vars, fix Ctrl+C exit, prepare for Render"
    }
    
    # Stage all files
    Write-Host ""
    Write-Host "📦 Staging files..." -ForegroundColor Yellow
    git add .
    
    # Commit
    Write-Host "💾 Committing..." -ForegroundColor Yellow
    git commit -m $commitMsg
    
    # Push
    Write-Host "🚀 Pushing to GitHub..." -ForegroundColor Yellow
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
        Write-Host ""
        Write-Host "🎉 Next steps:" -ForegroundColor Cyan
        Write-Host "1. Go to https://dashboard.render.com" -ForegroundColor White
        Write-Host "2. Create a new Web Service" -ForegroundColor White
        Write-Host "3. Connect your GitHub repository" -ForegroundColor White
        Write-Host "4. Add environment variables (see RENDER-DEPLOYMENT.md)" -ForegroundColor White
        Write-Host ""
        Write-Host "📖 Read GITHUB-RENDER-READY.md for complete instructions" -ForegroundColor Yellow
    } else {
        Write-Host ""
        Write-Host "❌ Push failed. Check the error above." -ForegroundColor Red
    }
} else {
    Write-Host "Aborted." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
