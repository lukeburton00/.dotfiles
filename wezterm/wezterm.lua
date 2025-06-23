local wezterm = require "wezterm"

local config = {}
config.force_reverse_video_cursor = true
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

local vague = {
    foreground = "#cdcdcd",
    background = "#141415",

    cursor_bg = "#cdcdcd",
    cursor_fg = "#141415",
    cursor_border = "#cdcdcd",

    selection_fg = "#cdcdcd",
    selection_bg = "#252530",

    scrollbar_thumb = "#252530",
    split = "#252530",

    ansi = {
        "#252530",
        "#d8647e",
        "#7fa563",
        "#f3be7c",
        "#6e94b2",
        "#bb9dbd",
        "#aeaed1",
        "#cdcdcd",
    },
    brights = {
        "#606079",
        "#e08398",
        "#99b782",
        "#f5cb96",
        "#8ba9c1",
        "#c9b1ca",
        "#bebeda",
        "#d7d7d7",
    },
}

config.color_schemes = { ["vague"] = vague }
config.color_scheme = "vague"

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.max_fps = 240
config.font_size = 18

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
end

return config
