vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-lint" },
})

require("lint").linters_by_ft = {
	go = { "golangcilint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
