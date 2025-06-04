local wezterm = require 'wezterm'
local remaps = require 'remaps'

local config = {}
config.font = wezterm.font('JetBrains Mono')
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.color_scheme = 'Default Dark (base16)'
local custom_nord = {
    foreground = "#fbffff",
    background = "#101117",
    cursor_bg = "#fbffff",
    cursor_border = "#fbffff",
    cursor_fg = "#101117",
    selection_bg = "#465272",
    selection_fg = "#fbffff",
    ansi = {
        "#101117",
        "#f97081",
        "#c3eeb8",
        "#ffe07a",
        "#84b8f3",
        "#e698e1",
        "#acf2ff",
        "#fbffff",
    },
    brights = {
        "#465272",
        "#f97081",
        "#c3eeb8",
        "#ffe07a",
        "#84b8f3",
        "#e698e1",
        "#72a5f3",
        "#ffffff",
    },
    tab_bar = {
        background = "#465272",
        inactive_tab_edge = "#4f5880",
    },
}

config.color_schemes = { ["Custom Nord"] = custom_nord }
config.color_scheme = "Custom Nord"

config.keys = remaps.keys

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240

config.font_size = 14

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { 'pwsh.exe' }
end

return config
