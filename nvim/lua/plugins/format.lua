return {
	"zapling/mason-conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		{ "stevearc/conform.nvim", opts = {} },
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt" },
				ruby = { "rubocop" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", require("conform").format, { desc = "Format file" })

		require("mason-conform").setup({
			ignore_install = {
				"rubocop",
			},
		})
	end,
}
