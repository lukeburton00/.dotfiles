return {
	"RRethy/base16-nvim",
	lazy = false,
	priority = 1000,

	config = function()
		require("base16-colorscheme").setup({
			base00 = "#101117",
			base01 = "#465272",
			base02 = "#4f5880",
			base03 = "#5c669a",
			base04 = "#f0f5fa",
			base05 = "#fbffff",
			base06 = "#ffffff",
			base07 = "#a9d9d9",
			base08 = "#f97081",
			base09 = "#ffb877",
			base0A = "#ffe07a",
			base0B = "#c3eeb8",
			base0C = "#acf2ff",
			base0D = "#84b8f3",
			base0E = "#e698e1",
			base0F = "#72a5f3",
		})
		local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
		local bg = hl.bg
		if bg then
			vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = string.format("#%06x", bg) })
		end
	end,
}
