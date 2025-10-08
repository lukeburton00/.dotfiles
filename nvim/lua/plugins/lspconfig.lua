return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = "BufReadPre",
    keys = {
        { "gk", vim.diagnostic.open_float, desc = "Open Diagnostic Float", mode = "n" },
        { "gd", vim.lsp.buf.definition, desc = "Go to Definition", mode = "n" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration", mode = "n" },
    },
    config = function()
        vim.lsp.enable({
            "gopls",
            "lua_ls",
            "basedpyright",
            "rust_analyzer",
            "zls",
            "ols",
            "clangd",
            "angularls",
            "ts_ls",
            "html",
            "solargraph",
            "csharp_ls",
            "sourcekit",
            "gdscript",
            "neocmake",
            "yamlls",
            "templ",
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
    end,
}
