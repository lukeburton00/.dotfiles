return {
    "cbochs/grapple.nvim",
    dependencies = {
        "echasnovski/mini.nvim",
    },
    opts = {
        scope = "git",
    },
    keys = {
        { "<leader>e", "<cmd>Grapple toggle_tags<cr>",    desc = "Open Grapple menu" },
        { "<leader>a", "<cmd>Grapple tag<cr>",            desc = "Add Grapple tag" },
        { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Go to Grapple tag 1" },
        { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Go to Grapple tag 2" },
        { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Go to Grapple tag 3" },
        { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Go to Grapple tag 4" },
    },
}
