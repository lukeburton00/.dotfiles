return {
    "nvim-mini/mini.nvim",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    version = "*",
    event = "BufReadPre",
    config = function()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.pairs").setup()
        require("mini.diff").setup()
        require("mini.statusline").setup()
        require("mini.cursorword").setup()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
        require("mini.icons").tweak_lsp_kind()
        require("mini.snippets").setup()
        require("mini.completion").setup()
        vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
        vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
        vim.keymap.set("i", "<CR>", function()
            if vim.fn.pumvisible() == 0 then
                return require("mini.pairs").cr()
            elseif vim.fn.complete_info()["selected"] ~= -1 then
                return vim.api.nvim_replace_termcodes("<C-y>", true, true, true)
            else
                return vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true)
            end
        end, { expr = true })
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function(args)
                local ft = vim.bo[args.buf].filetype
                local bt = vim.bo[args.buf].buftype

                if bt == "prompt" or ft == "snacks_picker" then
                    vim.b.minicompletion_disable = true
                else
                    vim.b.minicompletion_disable = false
                end
            end,
        })
    end,
}
