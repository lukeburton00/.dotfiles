return {
	"shortcuts/no-neck-pain.nvim",

	keys = {
		{
			"<leader>z",
			"<cmd>NoNeckPain<CR>",
		},
	},

	config = function()
		require("no-neck-pain").setup({
			width = 150,

			buffers = {
				wo = {
					fillchars = "eob: ",
				},
			},

			autocmds = {
				enableOnVimEnter = true,
				enableOnTabEnter = true,
				skipEnteringNoNeckPainBuffer = true,
			},
		})
	end,
}
