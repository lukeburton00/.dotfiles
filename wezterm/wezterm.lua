local wezterm = require "wezterm"

local config = {
    font = wezterm.font("JetBrains Mono"),
    color_scheme = "vague",
    force_reverse_video_cursor = true,
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 18,

    window_frame = {
        active_titlebar_bg = "#141415",
        inactive_titlebar_bg = "#141415",
    },

    colors = {
        tab_bar = {
            background = "#141415",
            active_tab = {
                bg_color = "#252530",
                fg_color = "#cdcdcd",
                intensity = "Normal",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab = {
                bg_color = "#141415",
                fg_color = "#606079",
                intensity = "Normal",
                underline = "None",
                italic = false,
                strikethrough = false,
            },
            inactive_tab_hover = {
                bg_color = "#252530",
                fg_color = "#cdcdcd",
                italic = false,
            },
            new_tab = {
                bg_color = "#141415",
                fg_color = "#6e94b2",
            },
            new_tab_hover = {
                bg_color = "#252530",
                fg_color = "#8ba9c1",
                italic = false,
            },
            inactive_tab_edge = "#252530",
        },
    },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "pwsh.exe" }
end

return config
