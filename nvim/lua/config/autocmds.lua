-- Periodically check for changes every 2 seconds
local autoread_timer = assert(vim.uv.new_timer())
autoread_timer:start(
    2000,
    2000,
    vim.schedule_wrap(function()
        -- Only check when Neovim has focus and you're not in command mode
        if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
            pcall(vim.cmd.checktime)
        end
    end)
)

-- Notify only when reload actually happened
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    callback = function()
        vim.notify("File reloaded from disk", vim.log.levels.INFO, { title = "AutoRead" })
    end,
})
