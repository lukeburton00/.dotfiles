vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.enable({
    "lua_ls",
    "ols",
    "gopls",
})

vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME .. "/lua",
                    vim.env.VIMRUNTIME .. "/lua/vim/lsp",
                    "${3rd}/luv/library",
                    "${3rd}/busted/library",
                },
            },
        })
    end,
    settings = {
        Lua = {},
    },
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gk", vim.diagnostic.open_float)
