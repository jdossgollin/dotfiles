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
add_app "/System/Applications/Calendar.app"

# Messaging
add_app "/System/Applications/Messages.app"
add_app "/Applications/Signal.app"
add_app "/Applications/Slack.app"
add_app "/Applications/zoom.us.app"

# Reading
add_app "/Applications/Zotero.app"

# Code
add_app "/Applications/WezTerm.app"
add_app "/Applications/VSCodium.app"
add_app "/Applications/SourceGit.app"
add_app "/System/Applications/Utilities/Activity Monitor.app"

# Folders
dockutil --no-restart --add '' --type small-spacer --section apps

dockutil --no-restart --add "~/Documents/"
dockutil --no-restart --add "~/Desktop/"
dockutil --no-restart --add "~/Downloads/"

killall Dock
