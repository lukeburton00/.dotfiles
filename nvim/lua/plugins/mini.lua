vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.pairs").setup()
require("mini.icons").setup()

require("mini.pick").setup()

-- Ensure mini.pick is used for vim.ui.select
vim.ui.select = require("mini.pick").ui_select

require("mini.diff").setup()
require("mini.move").setup()
require("mini.cmdline").setup()

-- Keymaps
vim.keymap.set("n", "<leader>f", function()
    require("mini.pick").builtin.files()
end)

vim.keymap.set("n", "<leader>l", function()
    require("mini.pick").builtin.grep_live()
end)
