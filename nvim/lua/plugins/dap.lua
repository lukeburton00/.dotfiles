return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		{ "igorlfs/nvim-dap-view", opts = { winbar = { controls = { enabled = true } } } },
	},

    event = "VeryLazy",

	keys = {
		{
			"<leader>db",
			mode = { "n", "v" },
			"<cmd>DapToggleBreakpoint<cr>",
		},
		{
			"<leader>dv",
			mode = { "n", "v" },
			"<cmd>DapViewToggle<cr>",
		},
	},

	config = function()
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = {
                "debugpy",
                "delve",
            },
            automatic_installation = false,
			handlers = {},
		})
	end,
}
