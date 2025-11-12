local M = {
    separator = " ",
    setup = function()
        local parts = {
            [[ %{luaeval("vim.api.nvim_get_mode().mode")}]],
            [[ %{luaeval("require'config.statusline'.separator")}]],
            [[%t %m%r %=]],
        }

        vim.schedule(function()
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
        end)

        return table.concat(parts, "")
    end,
}

return M
