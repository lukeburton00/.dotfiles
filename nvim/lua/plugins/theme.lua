return {
    "RRethy/base16-nvim",
    priority = 1000,
    lazy = false,

    config = function ()
        vim.cmd.colorscheme("base16-catppuccin-mocha")

        -- Hide end of buffer characters
        local hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
        local bg = hl.bg
        if bg then
            vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = string.format("#%06x", bg) })
        end
    end
}
