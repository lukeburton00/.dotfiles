return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        { "igorlfs/nvim-dap-view", opts = { winbar = { controls = { enabled = true } } } }
    },

    keys = {
        {
            "<leader>db",
            mode = { "n", "v" },
            "<cmd>DapToggleBreakpoint<cr>"
        },
        {
            "<leader>dv",
            mode = { "n", "v" },
            "<cmd>DapViewToggle<cr>"
        },
    },

    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup({
            handlers = {},
            ensure_installed = {},
            automatic_installation = false
        })
    end
}
