return {
	"ibhagwan/fzf-lua",
	opts = {
		grep = {
			hidden = true,
		},
		keymap = {
			fzf = {
				["tab"] = "down",
				["btab"] = "up",
				["ctrl-q"] = "select-all+accept",
			},
		},
	},

	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
			desc = "Find files",
		},
		{
			"<leader>l",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>r",
			function()
				require("fzf-lua").lsp_references()
			end,
			desc = "LSP references",
		},
	},
}
