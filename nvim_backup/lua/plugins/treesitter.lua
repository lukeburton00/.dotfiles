return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    branch = "master",
    config = function()
        require("nvim-treesitter.configs").setup({
            auto_install = true,
            highlight = {
                enable = true,
            },
        })
        if jit.os == "Windows" then
            require("nvim-treesitter.install").compilers = { "zig" }
        end
    end,
}
