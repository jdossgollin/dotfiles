#!/bin/sh

# Helper: add app to Dock only if it exists
add_app() {
	if [ -d "$1" ]; then
		dockutil --no-restart --add "$1"
	fi
}

dockutil --no-restart --remove all

# Web
add_app "/Applications/Firefox.app"

dockutil --no-restart --add '' --type small-spacer --section apps

# Messaging
add_app "/System/Applications/Messages.app"
add_app "/Applications/Slack.app"
add_app "/Applications/zoom.us.app"
add_app "/System/Applications/Calendar.app"

dockutil --no-restart --add '' --type small-spacer --section apps

# Reading
add_app "/Applications/Zotero.app"
add_app "$HOME/Applications/Inoreader.app"

dockutil --no-restart --add '' --type small-spacer --section apps

# Code
add_app "/Applications/iTerm.app"
add_app "/Applications/VSCodium.app"
add_app "/Applications/GitHub Desktop.app"
add_app "/System/Applications/Utilities/Activity Monitor.app"

# Folders
dockutil --no-restart --add "~/Insync/jd82@rice.edu/Google Drive/"
dockutil --no-restart --add "~/Documents/"
dockutil --no-restart --add "~/Desktop/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
