vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.diagnostic.config({ virtual_text = true })

vim.opt.showmode = false

vim.opt.showtabline = 0
vim.opt.winborder = "rounded"

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
            vim.g.clipboard = {
                copy = {
                    ["+"] = "win32yank.exe -i --crlf",
                    ["*"] = "win32yank.exe -i --crlf",
                },
                paste = {
                    ["+"] = "win32yank.exe -o --lf",
                    ["*"] = "win32yank.exe -o --lf",
                },
            }
        elseif vim.fn.has("unix") == 1 then
            if vim.fn.executable("xclip") == 1 then
                vim.g.clipboard = {
                    copy = {
                        ["+"] = "xclip -selection clipboard",
                        ["*"] = "xclip -selection clipboard",
                    },
                    paste = {
                        ["+"] = "xclip -selection clipboard -o",
                        ["*"] = "xclip -selection clipboard -o",
                    },
                }
            elseif vim.fn.executable("xsel") == 1 then
                vim.g.clipboard = {
                    copy = {
                        ["+"] = "xsel --clipboard --input",
                        ["*"] = "xsel --clipboard --input",
                    },
                    paste = {
                        ["+"] = "xsel --clipboard --output",
                        ["*"] = "xsel --clipboard --output",
                    },
                }
            end
        end

        vim.opt.clipboard = "unnamedplus"
    end,
    desc = "Lazy load clipboard",
})
