return {
    "nvim-mini/mini.nvim",
    config = function()
        local mini_pick = require("mini.pick")
        mini_pick.setup()
        vim.ui.select = mini_pick.ui_select

        require("mini.icons").setup()
        MiniIcons.tweak_lsp_kind()

        require("mini.pairs").setup()
        require("mini.move").setup()
        require("mini.cmdline").setup()
        require("mini.completion").setup()
        require("mini.surround").setup()

        vim.keymap.set("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
        vim.keymap.set("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })
        vim.keymap.set("i", "<CR>", function()
            return vim.fn.pumvisible() == 1 and "\25" or "\r"
        end, { expr = true })
        vim.keymap.set("i", "<Esc>", function()
            return vim.fn.pumvisible() == 1 and "\5\27" or "\27"
        end, { expr = true })
    end,
}
