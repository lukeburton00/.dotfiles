return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "igorlfs/nvim-dap-view",
        "leoluz/nvim-dap-go",
    },

    keys = {
        {
            "<leader>dd",
            "<cmd>DapViewToggle<cr>",
            desc = "Dap View Toggle",
        },
        {
            "<leader>dc",
            "<cmd>DapContinue<cr>",
            desc = "Dap Continue",
        },
        {
            "<leader>db",
            "<cmd>DapToggleBreakpoint<cr>",
            desc = "Dap Toggle Breakpoint",
        },
        {
            "<leader>do",
            "<cmd>DapStepOver<cr>",
            desc = "Dap Step Over",
        },
        {
            "<leader>di",
            "<cmd>DapStepInto<cr>",
            desc = "Dap Step Into",
        },
        {
            "<leader>dO",
            "<cmd>DapStepOut<cr>",
            desc = "Dap Step Out",
        },
    },

    config = function()
        require("dap-view").setup()
        require("dap-go").setup()
        local dap, dv = require("dap"), require("dap-view")
        dap.listeners.before.attach["dap-view-config"] = function()
            dv.open()
        end
        dap.listeners.before.launch["dap-view-config"] = function()
            dv.open()
        end
        dap.listeners.before.event_terminated["dap-view-config"] = function()
            dv.close()
        end
        dap.listeners.before.event_exited["dap-view-config"] = function()
            dv.close()
        end

        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
            callback = function(evt)
                vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf })
            end,
        })
    end,
}
