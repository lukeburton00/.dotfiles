return {
	"nvim-treesitter/nvim-treesitter",

    event = 'VeryLazy',

    config = function ()
        require'nvim-treesitter.configs'.setup{
            auto_install = true,
            highlight = {
                enable = true,
            }
        }

        require ('nvim-treesitter.install').compilers = { 'zig' }
    end
}
