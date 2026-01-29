local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font: MesloLGS NF (required for Powerlevel10k)
config.font = wezterm.font("MesloLGS NF")
config.font_size = 13.0

-- Color scheme: MaterialDark
config.color_scheme = "MaterialDark"

-- Window
config.window_decorations = "RESIZE"
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.hide_tab_bar_if_only_one_tab = true

-- Scrollback
config.scrollback_lines = 10000

-- Cursor
config.default_cursor_style = "BlinkingBar"

-- Bell
config.audible_bell = "Disabled"

-- Keys: use macOS-native option-as-alt for terminal shortcuts
if wezterm.target_triple:find("darwin") then
	config.send_composed_key_when_left_alt_is_pressed = false
	config.send_composed_key_when_right_alt_is_pressed = true
end

-- Fix Shift+Enter to send CSI u escape sequence (only for this specific key)
config.keys = {
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\x1b[13;2u"),
	},
}

return config
