return {
    "echasnovski/mini.nvim",
    version = "*",
    event = "BufReadPre",
    config = function()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.pairs").setup()
        require("mini.diff").setup()
        require("mini.statusline").setup()
        require("mini.cursorword").setup()
        require("mini.icons").setup()
        require("mini.icons").mock_nvim_web_devicons()
    end,
}
