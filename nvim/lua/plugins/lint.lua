return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},

    event = "VeryLazy",

	config = function()
		require("lint").linters_by_ft = {
			go = { "golangcilint" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			python = { "ruff" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
		}

		require("mason-nvim-lint").setup()

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
