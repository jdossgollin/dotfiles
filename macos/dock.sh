#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications/Photos.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/News.app"
dockutil --no-restart --add "/Applications/Kiwi for Gmail.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Zotero.app"
dockutil --no-restart --add "/Applications/GitHub Desktop.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Users/james/Documents/"
dockutil --no-restart --add "/Users/james/Downloads/"

killall Dock