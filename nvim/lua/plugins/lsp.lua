return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp"
    },

    event = "VeryLazy",

    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup {
            automatic_installation = false,
            ensure_installed = {
                "lua_ls",
            },
        }

        local lspconfig = require("lspconfig")
        require("mason-lspconfig").setup_handlers {
            function(server)
                local opts = {
                    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
                }

                if server == "angularls" then
                    local util = require('lspconfig.util')
                    opts.root_dir = util.root_pattern('angular.json', 'project.json')
                end

                lspconfig[server].setup(opts)
            end
        }

        if jit.os == "OSX" then
            lspconfig.sourcekit.setup{
                capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
                cmd = { "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" }
            }
        end

    end
}
