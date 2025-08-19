local wezterm = require "wezterm"
local act = wezterm.action
local action_callback = wezterm.action_callback

local config = {
    color_scheme = "vague",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,

    max_fps = 240,
    font_size = 18,

    use_fancy_tab_bar = false,

    window_decorations = "RESIZE",

    -- Use tmux-style leader with Ctrl-a
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

    -- Tmux-like key bindings using the leader
    keys = {
        -- Send literal Ctrl-a when pressing the leader twice
        { key = "a", mods = "LEADER", action = act.SendKey { key = "a", mods = "CTRL" } },

        -- Split panes: '"' horizontal (top/bottom), '%' vertical (left/right)
        { key = '%', mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
        { key = '"', mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },

        -- Pane navigation (vim-style)
        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },

        -- Pane navigation with arrows
        { key = "LeftArrow", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
        { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection "Right" },
        { key = "UpArrow", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
        { key = "DownArrow", mods = "LEADER", action = act.ActivatePaneDirection "Down" },

        -- Resize panes (Shift + H/J/K/L)
        { key = "H", mods = "LEADER", action = act.AdjustPaneSize { "Left", 5 } },
        { key = "J", mods = "LEADER", action = act.AdjustPaneSize { "Down", 5 } },
        { key = "K", mods = "LEADER", action = act.AdjustPaneSize { "Up", 5 } },
        { key = "L", mods = "LEADER", action = act.AdjustPaneSize { "Right", 5 } },

        -- Zoom and close pane
        { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
        { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },

        -- Tabs (tmux "windows")
        { key = "c", mods = "LEADER", action = act.SpawnTab "CurrentPaneDomain" },
        { key = "&", mods = "LEADER", action = act.CloseCurrentTab { confirm = true } },
        { key = ",", mods = "LEADER", action = act.PromptInputLine {
            description = "Rename tab",
            action = action_callback(function(window, _pane, line)
              if line and #line > 0 then
                window:active_tab():set_title(line)
              end
            end),
        } },
        { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
        { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
        { key = "{", mods = "LEADER", action = act.MoveTabRelative(-1) },
        { key = "}", mods = "LEADER", action = act.MoveTabRelative(1) },

        -- Direct tab selection like tmux (prefix + 1..9, 0)
        { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
        { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
        { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
        { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
        { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
        { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
        { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
        { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
        { key = "9", mods = "LEADER", action = act.ActivateTab(8) },
        { key = "0", mods = "LEADER", action = act.ActivateTab(9) },

        -- Copy mode and paste (tmux: prefix + [ / ])
        { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
        { key = "]", mods = "LEADER", action = act.PasteFrom "Clipboard" },

        -- Quick navigator (similar to choose-tree)
        { key = "s", mods = "LEADER", action = act.ShowTabNavigator },
    },
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.default_prog = { "pwsh.exe" }
end

return config
