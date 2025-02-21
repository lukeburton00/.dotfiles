return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },

    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })
        require("telescope").load_extension("fzf")
    end,

    keys = function()
        local builtin = require("telescope.builtin")
        return {
            { "<leader>f", builtin.find_files, desc = "Find Files" },
            { "<leader>en", function() builtin.find_files { cwd = vim.fn.stdpath("config") } end, desc = "Edit Neovim" },
            { "<C-p>", builtin.lsp_document_symbols, desc = "Document Symbols" },
            { "<leader>l", builtin.live_grep, desc = "Live Grep" },
            { "<leader>hh", builtin.help_tags, desc = "Help Tags" },
            { "<leader>hk", builtin.keymaps, desc = "Keymaps" },
        }
    end
}
