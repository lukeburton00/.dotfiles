vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" }
})

local parsers = require("nvim-treesitter.parsers")
local log = vim.log.levels

local function start_after_install(buf, lang)
	vim.notify(("[treesitter] installing %s..."):format(lang), log.INFO)
	require("nvim-treesitter").install({ lang })

	local attempts, max_attempts, delay = 0, 60, 500

	local function try_start()
		if pcall(vim.treesitter.language.inspect, lang) then
			vim.notify(("[treesitter] installed %s"):format(lang), log.INFO)
			vim.treesitter.start(buf, lang)
		else
			attempts = attempts + 1
			if attempts <= max_attempts then
				vim.defer_fn(try_start, delay)
			else
				vim.notify(("[treesitter] timed out installing %s"):format(lang), log.WARN)
			end
		end
	end

	try_start()
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(event)
		local ft = event.match
		local lang = vim.treesitter.language.get_lang(ft) or ft

		if not parsers[lang] then return end

		if pcall(vim.treesitter.language.inspect, lang) then
			vim.treesitter.start(event.buf, lang)
		else
			start_after_install(event.buf, lang)
		end
	end,
})
