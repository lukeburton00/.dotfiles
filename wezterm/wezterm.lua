local wezterm = require "wezterm"
local theme = require("lua/vague")

local config = {
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    font = wezterm.font("JetBrains Mono", { weight = "Bold", style = "Normal" }),

    colors = theme.colors(),
    window_frame = theme.window_frame(),

    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 16,
}

if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
elseif wezterm.target_triple:find("linux") ~= nil then
    config.enable_wayland = false
elseif wezterm.target_triple:find("darwin") ~= nil then
    config.font_size = 20
end

return config
