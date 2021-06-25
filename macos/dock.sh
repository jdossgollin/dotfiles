#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/System Preferences.app"
dockutil --no-restart --add "/System/Applications/Photos.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/System/Applications/Music.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/System/Applications/FaceTime.app"
dockutil --no-restart --add "/Applications/zoom.us.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Zotero.app"
dockutil --no-restart --add "/System/Applications/Books.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/GitHub Desktop.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Notion.app"
dockutil --no-restart --add "~/Insync/jd82@rice.edu/Google Drive/"
dockutil --no-restart --add "~/Documents/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
