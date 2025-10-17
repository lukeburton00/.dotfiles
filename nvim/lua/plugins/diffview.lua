return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    cmd = {
        "DiffviewOpen",
        "DiffReview",
    },
    keys = {
        {
            "<leader>dv",
            function()
                local lib = require("diffview.lib")
                local view = lib.get_current_view()
                if view then
                    vim.cmd("DiffviewClose")
                else
                    vim.cmd("DiffviewOpen")
                end
            end,
            desc = "Toggle Diffview",
        },
    },
    opts = {},
    config = function()
        -- compare current branch to main
        vim.api.nvim_create_user_command("DiffReview", function()
            vim.cmd("DiffviewOpen origin/HEAD...HEAD --imply-local")
        end, {})
    end,
}
