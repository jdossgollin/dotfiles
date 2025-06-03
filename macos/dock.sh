#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Photos.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/zoom.us.app"
dockutil --no-restart --add "/Applications/Rambox.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Zotero.app"
dockutil --no-restart --add "/Applications/Raindrop.io.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/Applications/GitHub Desktop.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "~/Insync/jd82@rice.edu/Google Drive/"
dockutil --no-restart --add "~/Documents/"
dockutil --no-restart --add "~/Desktop/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
