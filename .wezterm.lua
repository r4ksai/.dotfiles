local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 30
config.term = "xterm-256color"
config.force_reverse_video_cursor = true

config.default_prog = { "/bin/zsh", "-l" }

config.font_size = 12
config.font = wezterm.font("JetBrains Mono")

return config
