-- Disable auto comment continuation
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Highlight on yank
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        pcall(vim.highlight.on_yank, { timeout = 200 })
    end,
})

-- Trim trailing whitespace on save (except for some filetypes)
local trim_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = trim_group,
    callback = function(evt)
        local filetype = vim.bo[evt.buf].filetype
        if filetype == "markdown" or filetype == "gitcommit" then
            return
        end
        local view = vim.fn.winsaveview()
        vim.api.nvim_buf_call(evt.buf, function()
            vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
        end)
        vim.fn.winrestview(view)
    end,
})

-- Auto create missing parent directories on save
local mkdir_group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = mkdir_group,
    callback = function(evt)
        local file_path = vim.api.nvim_buf_get_name(evt.buf)
        if file_path == "" then
            return
        end
        local dir = vim.fn.fnamemodify(file_path, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- Restore last cursor location when opening files
local lastloc_group = vim.api.nvim_create_augroup("LastLocation", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastloc_group,
    callback = function(evt)
        -- Do not apply to commit messages
        if vim.bo[evt.buf].filetype == "gitcommit" then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(evt.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(evt.buf)
        local lnum = mark[1]
        if lnum > 0 and lnum <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, { lnum, mark[2] })
        end
    end,
})

-- Press 'q' to close common transient buffers
local qclose_group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = qclose_group,
    pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
    callback = function(evt)
        vim.bo[evt.buf].buflisted = false
        vim.keymap.set("n", "q", "<C-w>q", { buffer = evt.buf, silent = true })
    end,
})

-- Equalize splits when resizing Neovim window
local resize_group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
    group = resize_group,
    command = "wincmd =",
})

-- Enable spell checking for markdown and git commit messages
local spell_group = vim.api.nvim_create_augroup("SpellForText", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = spell_group,
    pattern = { "markdown", "gitcommit" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelloptions = "camel"
    end,
})

-- Tweak terminal buffers
local term_group = vim.api.nvim_create_augroup("TerminalSetup", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = term_group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.cmd([[startinsert]])
    end,
})

-- Periodically check for changes every 2 seconds
local autoread_timer = vim.loop.new_timer()

autoread_timer:start(
    2000,
    2000,
    vim.schedule_wrap(function()
        -- Only check when Neovim has focus and you're not in command mode
        if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
            pcall(vim.cmd, "checktime")
        end
    end)
)

-- Notify only when reload actually happened
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    callback = function()
        vim.notify("File reloaded from disk", vim.log.levels.INFO, { title = "AutoRead" })
    end,
})
