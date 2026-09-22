return {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
        auto_install = true,
    },
    config = function(_, opts)
        require("tree-sitter-manager").setup(opts)

        local util = require("tree-sitter-manager.util")
        local runtime = vim.fs.joinpath(util.PLUGIN_ROOT, "runtime")
        if vim.uv.fs_stat(runtime) then
            vim.opt.rtp:prepend(runtime)
        end
    end,
}
