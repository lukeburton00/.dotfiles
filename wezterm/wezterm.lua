local wezterm = require "wezterm"
local theme = require("lua/vague")

local config = {
    color_scheme = "vague",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    colors = theme.colors(),
    window_frame = theme.window_frame(),

    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 16,
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "pwsh.exe" }
end

return config
