local wezterm = require "wezterm"

local config = {
    color_schemes = { ["custom"] = require("theme") },
    color_scheme = "custom",
    font = wezterm.font("JetBrains Mono"),

    force_reverse_video_cursor = true,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 18,
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "pwsh.exe" }
end

return config
