# rclone Cloud Sync

Manage rclone cloud storage remotes for this dotfiles setup.

## Remotes

| Remote | Local path | Service |
|--------|-----------|---------|
| `gdrive-work` | `~/gdrive-work` | Google Drive (work) |
| `gdrive-personal` | `~/gdrive-personal` | Google Drive (personal) |
| `box` | `~/box` | Box |

## Day-to-Day Commands

```bash
# Sync individual remotes
sync-gdrive-work
sync-gdrive-personal
sync-box

# Sync all remotes at once
sync-all

# Check configured remotes
rclone-status

# View scheduled sync log
rclone-log
```

## First-Time Setup (new machine)

After running `install.sh`:

1. **Configure remotes** (interactive OAuth flow):
   ```bash
   rclone config
   ```
   For each remote, choose:
   - Type: `drive` (Google Drive) or `box` (Box)
   - Name: exactly `gdrive-work`, `gdrive-personal`, or `box`
   - Follow the prompts for OAuth

2. **Initialize bisync** (run once per remote):
   ```bash
   sync-init-gdrive-work
   sync-init-gdrive-personal
   sync-init-box
   ```
   This seeds the state files rclone needs to track changes.

3. **Verify scheduled sync** is running:
   ```bash
   # macOS
   launchctl list | grep rclone

   # Linux
   crontab -l | grep sync-cloud
   ```

## Adding a New Remote

1. Configure it: `rclone config`
2. Create local dir: `mkdir ~/newremote`
3. Add to `bin/sync-cloud` (add a `sync_remote` call)
4. Add aliases to `system/.alias` (copy existing pattern)
5. Init: `rclone bisync ~/newremote newremote: --resync --create-empty-src-dirs`

## Scheduled Sync

Runs hourly automatically:
- **macOS**: launchd plist at `~/Library/LaunchAgents/com.user.rclone-sync.plist`
- **Linux**: crontab entry (`0 * * * *`)

To reload launchd after changes:
```bash
launchctl unload ~/Library/LaunchAgents/com.user.rclone-sync.plist
launchctl load   ~/Library/LaunchAgents/com.user.rclone-sync.plist
```

## Troubleshooting

**"Bisync not initialized" error** → Run the `sync-init-*` alias for that remote.

**Conflict on sync** → rclone keeps the newer file (`--resync-mode newer`).

**Force a full resync** (use carefully — overwrites with newer file):
```bash
rclone bisync ~/gdrive-work gdrive-work: --resync --create-empty-src-dirs
```

**Check what would sync without doing it**:
```bash
rclone bisync ~/gdrive-work gdrive-work: --resync-mode newer --create-empty-src-dirs --dry-run
```

**Logs** (when run from launchd/cron):
```bash
cat /tmp/rclone-sync.log
cat /tmp/rclone-sync.err
```
