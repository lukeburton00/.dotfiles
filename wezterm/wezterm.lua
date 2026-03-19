local wezterm = require "wezterm"

local config = {
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    color_scheme = "oldtale",

    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 14,
}

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple:find("linux") ~= nil then
    config.enable_wayland = false
elseif wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 18
end

return config
