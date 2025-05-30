return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},

	opts = {},

    event = "VeryLazy",

	config = function()
		require("mason").setup()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt" },
				ruby = { "rubocop" },
                c = { "clang-format" },
                cpp = { "clang-format" },
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
