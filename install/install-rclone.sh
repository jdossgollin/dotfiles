#!/usr/bin/env bash

# Install rclone on Linux (macOS: installed via Homebrew in install-brew.sh)
if is-linux; then
    if command -v rclone >/dev/null 2>&1; then
        echo "rclone: already installed"
    else
        echo "Installing rclone via official install script..."
        curl https://rclone.org/install.sh | sudo bash
    fi
fi

# Create local sync directories
echo "Creating cloud sync directories..."
for dir in "$HOME/gdrive-work" "$HOME/gdrive-personal" "$HOME/box"; do
    if [[ ! -d "$dir" ]]; then
        echo "  Creating $dir"
        mkdir -p "$dir"
    else
        echo "  $dir already exists"
    fi
done

# Set up scheduled sync
if is-macos; then
    PLIST_NAME="com.user.rclone-sync"
    PLIST_DEST="$HOME/Library/LaunchAgents/$PLIST_NAME.plist"
    SCRIPT_PATH="$HOME/.dotfiles/bin/sync-cloud"

    if [[ ! -f "$PLIST_DEST" ]]; then
        echo "Setting up launchd scheduled sync (hourly)..."
        mkdir -p "$HOME/Library/LaunchAgents"
        cat > "$PLIST_DEST" << PLIST_EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${PLIST_NAME}</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>${SCRIPT_PATH}</string>
    </array>
    <key>StartInterval</key>
    <integer>3600</integer>
    <key>RunAtLoad</key>
    <false/>
    <key>StandardOutPath</key>
    <string>/tmp/rclone-sync.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/rclone-sync.err</string>
</dict>
</plist>
PLIST_EOF
        launchctl load "$PLIST_DEST" 2>/dev/null \
            || echo "Note: launchctl load failed — you may need to run it manually"
        echo "Scheduled sync: every hour via launchd"
    else
        echo "launchd sync already configured"
    fi

elif is-linux; then
    CRON_JOB="0 * * * * $HOME/.dotfiles/bin/sync-cloud >> /tmp/rclone-sync.log 2>&1"
    if ! crontab -l 2>/dev/null | grep -q "sync-cloud"; then
        echo "Setting up cron scheduled sync (hourly)..."
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
        echo "Scheduled sync: every hour via cron"
    else
        echo "Cron sync job already configured"
    fi
fi

echo ""
echo "rclone setup complete!"
echo ""
echo "Next steps:"
echo "  1. Run 'rclone config' to configure these remotes:"
echo "       gdrive-work      (Google Drive)"
echo "       gdrive-personal  (Google Drive)"
echo "       box              (Box)"
echo "  2. Run 'sync-init-gdrive-work', 'sync-init-gdrive-personal', 'sync-init-box'"
echo "     once per remote to do the first bisync"
echo "  3. After that, use 'sync-all' for on-demand sync"
