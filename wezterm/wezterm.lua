local wezterm = require "wezterm"

local config = {}
config.force_reverse_video_cursor = true
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.color_scheme = "Default Dark (base16)"
local custom_nord = {
    foreground = "#C5C9C7",
    background = "#090E13",

    cursor_bg = "#090E13",
    cursor_fg = "#C5C9C7",
    cursor_border = "#C5C9C7",

    selection_fg = "#C5C9C7",
    selection_bg = "#24262D",

    scrollbar_thumb = "#24262D",
    split = "#24262D",

    ansi = {
        "#090E13",
        "#C4746E",
        "#8A9A7B",
        "#C4B28A",
        "#8BA4B0",
        "#A292A3",
        "#8EA4A2",
        "#A4A7A4",
    },
    brights = {
        "#A4A7A4",
        "#E46876",
        "#87A987",
        "#E6C384",
        "#7FB4CA",
        "#938AA9",
        "#7AA89F",
        "#C5C9C7",
    },
}

config.color_schemes = { ["Custom Nord"] = custom_nord }
config.color_scheme = "Custom Nord"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240

config.font_size = 14

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
end

return config
