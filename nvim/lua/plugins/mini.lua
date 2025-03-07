return {
    'echasnovski/mini.nvim',
    version = '*',

    config = function ()
        -- Modules
        require("mini.ai").setup()
        require("mini.surround").setup()
        require("mini.move").setup()
        require("mini.pairs").setup()

        require("mini.icons").setup()
        MiniIcons.mock_nvim_web_devicons()

        require("mini.statusline").setup()
        require("mini.cursorword").setup()
    end
}
