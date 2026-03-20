local wezterm = require "wezterm"

local config = {
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    max_fps = 240,
    font_size = 14,

    hide_tab_bar_if_only_one_tab = true,
}

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple:find("linux") ~= nil then
    config.enable_wayland = false
elseif wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 18
end
config.color_schemes = config.color_schemes or {}
config.color_schemes["dustyrose"] = {
    foreground = "#c8c0d0",
    background = "#1a1b2a",
    cursor_fg = "#c8c0d0",
    cursor_bg = "#e8a0b0",
    cursor_border = "#e8a0b0",
    selection_fg = "#c8c0d0",
    selection_bg = "#c8c0d0",

    ansi = {
        "#6e606a",
        "#d08890",
        "#8cc080",
        "#c8c0d0",
        "#e8a0b0",
        "#b86878",
        "#b8a0d0",
        "#c8c0d0",
    },

    brights = {
        "#6e606a",
        "#d08890",
        "#8cc080",
        "#c8c0d0",
        "#e8a0b0",
        "#b86878",
        "#b8a0d0",
        "#c8c0d0",
    },
}

config.color_scheme = "dustyrose"

return config
