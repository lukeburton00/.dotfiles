return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-mini/mini.nvim",
    },
    cmd = "DiffviewOpen",
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
        vim.api.nvim_create_user_command("DiffReview", function()
            local main_branch = vim.fn
                .system("git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'")
                :gsub("\n", "")
            vim.cmd("DiffviewOpen " .. main_branch .. "...HEAD")
        end, {})
    end,
}
