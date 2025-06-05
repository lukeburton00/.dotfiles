return {
    "folke/lazydev.nvim",
    ft = "lua", -- Load only for Lua files
    enabled = true,
    opts = {
        library = {
            -- Load luvit types when 'vim.uv' is detected
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
